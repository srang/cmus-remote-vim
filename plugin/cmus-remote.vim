if exists('g:loaded_cmus_remote')
  finish
endif

let g:loaded_cmus_remote = 1

function! s:trim_whitespace(target)
    let target = substitute(a:target, "^\\s\\+\\|\\s\\+$", "", "g")
    let target = substitute(target, "^\\n\\+\\|\\n\\+$", "", "g")
    return target
endfunction

function! s:get_song_info()
    let artist = system('cmus-remote -Q | grep "tag artist " | cut -d " " -f 3-')
    let album = system('cmus-remote -Q | grep "tag album " | cut -d " " -f 3-')
    let song = system('cmus-remote -Q | grep "tag title " | cut -d " " -f 3-')

    let artist = s:trim_whitespace(artist)
    let album = s:trim_whitespace(album)
    let song = s:trim_whitespace(song)

    return artist . " - " . album . " - " . song
endfunction

function! cmus#Pause()
    let result = system('cmus-remote --pause')
    echo "Pausing/resuming " . s:get_song_info()
endfunction

function! cmus#Stop()
    let result = system('cmus-remote --stop')
    echo s:get_song_info()
endfunction

function! cmus#Play()
    let result = system('cmus-remote --play')
    echo "Playing " . s:get_song_info()
endfunction

function! cmus#Next()
    let result = system('cmus-remote --next')
    echo "Playing " . s:get_song_info()
endfunction

function! cmus#Previous()
    let result = system('cmus-remote --prev')
    echo "Playing " . s:get_song_info()
endfunction

function! cmus#Current()
    echo s:get_song_info()
endfunction
if !exists(":Current")
  command Current :call cmus#Current()
endif
