set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html

Plugin 'NLKNguyen/papercolor-theme'

"coding auto completion
Plugin 'Valloric/YouCompleteMe'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'octol/vim-cpp-enhanced-highlight'

Plugin 'vim-scripts/Conque-GDB'

Plugin 'tomtom/tcomment_vim'

Plugin 'mhinz/vim-startify'

Plugin 'tpope/vim-surround'

Plugin 'scrooloose/nerdtree'

Plugin 'klen/python-mode'

Plugin 'vim-scripts/AutoClose'

<<<<<<< HEAD
Plugin 'SirVer/ultisnips'

Plugin 'honza/vim-snippets' 

Plugin 'vim-scripts/c.vim'

Plugin 'danro/rename.vim'

Plugin 'sukima/xmledit'

"all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
set nohlsearch
set nospell
set tw=79
set colorcolumn=80

syntax on

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Ignore case when searching
set ignorecase

" set background=light
set background=dark
colorscheme PaperColor
set guifont=Consolas:h13
set guioptions-=T
set number
set laststatus=2

set noshowmode
set splitright
set splitbelow
set mouse=n

set nocursorline
" Sets how many lines of history VIM has to remember
set history=700
" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\/"
let g:mapleader = "\/"


map <leader>e :e! ~/.vimrc<cr>

" make copy easier
imap <c-v> <esc>"+gP
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" NOTICE: Really useful!

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press <leader>q you can search and replace the selected text
vnoremap <silent> <leader>q :call VisualSelection('replace')<CR>
" vnoremap <silent> gv :call VisualSelection('gv')<CR>

" From an idea by Michael Naumann
" 
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
   elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1

function! PythonFunction()
    " load a template based on the file extension
    " silent! 0r ~/.vim_runtime/skel/new_python_function.%:e
     silent! r ~/.vim/skel/new_python_function.%:e
 
    " This last one deletes the placeholder
    " %START% then leaves the cursor there.
    %s/%START%//g
endfunction
au FileType python map <silent>nf :call PythonFunction()<Esc>

""""""""""""""""""""""""""""""
" => c++ section
"""""""""""""""""""""""""""""""
au FileType cpp,c,h  inoremap ;w <esc>A;<return>
au FileType cpp,c,h  nnoremap ;w A;<esc>
au FileType cpp,c,h  inoremap xx ->
au FileType cpp,c,h  inoremap zz ::<esc>a
au FileType cpp,c,h  iab incl #include 

au FileType cpp,c,h  set shiftwidth=2 tabstop=2 
au FileType cpp,c,h  set cindent 
au FileType cpp,c,h  set autoindent


"pymode stuff"
let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
let g:pymode_lint_on_fly = 1
let g:pymode_lint_unmodified = 0
let g:pymode_lint_cwindow = 1
let g:pymode_options_fold = 1
let g:pymode_rope = 0
let g:pymode_run = 1
let g:pymode_lint_ignore = "E731"
au FileType python map <F5> :PymodeLint<Esc>


"ycm stuff"
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_collect_identifiers_from_tags_files = 1 
let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_config.py'
" let g:ycm_python_binary_path = "/usr/bin/python3"
nnoremap <leader>gt :YcmCompleter GoTo<CR>


"ctrlp stuff"
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
" let g:ctrlp_mruf_include = '\.py$\|\.launch$|\.cpp$|\.hpp$|\.hpp$|\.vim$|\.h$'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_open_multiple_files = '1hjr'
let g:ctrlp_open_new_file = 'v'
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 

map <leader>cf :CtrlPCurFile<cr>
map <leader>cc :CtrlPChange<cr>
map <leader>cu :CtrlPBuffer<cr>
map <leader>cm :CtrlPMRUFiles<cr>
map <leader>cx :CtrlPMixed<cr>
map <leader>cw :CtrlPCurWD<cr>
map <leader>cd :CtrlPDir<cr>
map <leader>ck :CtrlPBookmarkDir<cr>
map <leader>cl :CtrlPLine<cr>
map <leader>ct :CtrlPTag<cr>
map <leader>cr :CtrlPRoot<cr>
map <leader>cb :CtrlPBufTag<cr>
map <leader>cbb :CtrlPBufTagAll<cr>

"easytags stuff"
let g:easytags_file = '~/.vim/tags/easytags'
let g:easytags_by_filetype =  '~/.vim/tags/'
let g:easytags_dynamic_files = 1
let g:easytags_events = ['CursorHold']
let g:easytags_resolve_links = 1
let g:easytags_include_members = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


let g:airline#extensions#tabline#enabled = 1

"fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"Nerdtree stuff
map <C-n> :NERDTreeToggle<CR>

<<<<<<< HEAD
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
=======
"AutoClose stuff
" add <angular brackets> 
let g:AutoClosePairs = ("() [] {} <> ` \" '")
>>>>>>> 716bf58c5f7192f0be31b4850991b785c19f3242

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

