" Maintainer:   Jameson Nash <vtjnash@gmail.com>

call pathogen#infect()

" source $VIMRUNTIME/defaults.vim
"" Maintainer:  Bram Moolenaar <Bram@vim.org>
"" Last change: 2017 Apr 12

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

set indentexpr=
set autoindent
" set smartindent
" set cindent

set tabstop=4
set sw=4            " shift-width
set number          " line numbers, disable with :nonumber
set expandtab       " spaces, not tabs
set spell
set history=200     " keep 200 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set wildmenu        " display completion matches in a status line
set nohlsearch      " yuck - make sure this didn't get enabled
" set display=truncate " Show @@@ in the last line if it is truncated.
set undofile

set list            " make whitespace visible
set listchars=tab:▸\ ,trail:\ ,nbsp:%

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" but only in normal and visual modes (not insert)
if has('mouse') && !has("gui_running")
  set mouse=nv
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on
  "filetype plugin on
  "augroup ft_c
  "  autocmd!
  "  autocmd FileType cpp set cindent
  "augroup END

  "" Put these in an autocmd group, so that you can revert them with:
  "" ":augroup vimStartup | au! | augroup END"
  "augroup vimStartup
  "  au!

  "  " When editing a file, always jump to the last known cursor position.
  "  " Don't do it when the position is invalid or when inside an event handler
  "  " (happens when dropping a file on gvim).
  "  autocmd BufReadPost *
  "    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  "    \   exe "normal! g`\"" |
  "    \ endif

  "augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:instant_rst_browser="open"
let g:instant_rst_forever=1
let g:riv_web_browser="open"

if has('gui_running')
set guifont=Source\ Code\ Pro:h12
" set guifont=Monoid\ Regular:h12
set macligatures
else
"let g:solarized_termcolors=256
end
let g:solarized_contrast = "high"
set background=dark
colorscheme solarized

" airblade/vim-gitgutter
set updatetime=500
