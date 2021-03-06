class MP3Importer
  attr_accessor :path, :files
  def initialize(path)
    @path = path
    @files = []
  end

  def files
    Dir.entries(@path).reject {|f| File.directory?(f) || f[0].include?('.')}.each do |file|
      @files << file
    end
  end

  def import
    self.files
    @files.each do |file|
      song = Song.new(file.split(" - ")[1])
      artist = Artist.find_or_create_by_name(file.split(" - ")[0])
      artist.add_song(song)
      song
    end
  end
end
