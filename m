Received: from eggs.gnu.org ([209.51.188.92]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0hRX-0007K4-9o
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0hR5-00035s-EQ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:50:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h0hR3-000346-8y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:50:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
Date: Mon, 04 Mar 2019 07:44:34 +0100
In-Reply-To: <20190303104430.7692-3-samuel.thibault@ens-lyon.org> (Samuel
	Thibault's message of "Sun, 3 Mar 2019 11:44:30 +0100")
Message-ID: <87h8cjdtpp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Eddie Kohler <ekohler@gmail.com>, armbru@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

> This uses iconv to convert glyphs from the specified VGA font encoding to
> unicode, and makes use of cchar_t instead of chtype when using ncursesw,
> which allows to store all wide char as well as the WACS values.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Eddie Kohler <ekohler@gmail.com>
> ---
>  configure       |   5 +-
>  qapi/ui.json    |   4 +-
>  qemu-options.hx |   5 +-
>  ui/curses.c     | 315 ++++++++++++++++++++++++++++++++++++++++--------
>  4 files changed, 279 insertions(+), 50 deletions(-)
>
> diff --git a/configure b/configure
> index 9979ca708d..1270dc8dc0 100755
> --- a/configure
> +++ b/configure
> @@ -3449,14 +3449,17 @@ if test "$curses" != "no" ; then
>  #include <locale.h>
>  #include <curses.h>
>  #include <wchar.h>
> +#include <langinfo.h>
>  int main(void) {
> +  const char *codeset;
>    wchar_t wch = L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  return 0;
> +  codeset = nl_langinfo(CODESET);
> +  return codeset != 0;
>  }
>  EOF
>    IFS=:
> diff --git a/qapi/ui.json b/qapi/ui.json
> index c5d1d7f099..12d3a2c751 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1131,6 +1131,7 @@
>  # @full-screen:   Start user interface in fullscreen mode (default: off).
>  # @window-close:  Allow to quit qemu with window close button (default: on).
>  # @gl:            Enable OpenGL support (default: off).
> +# @charset:       Font charset used by guest (default: CP437).

Can you give brief rationale for defaulting to CP437?

>  #
>  # Since: 2.12
>  #
> @@ -1139,7 +1140,8 @@
>    'base'    : { 'type'           : 'DisplayType',
>                  '*full-screen'   : 'bool',
>                  '*window-close'  : 'bool',
> -                '*gl'            : 'DisplayGLMode' },
> +                '*gl'            : 'DisplayGLMode',
> +                '*charset'       : 'str' },
>    'discriminator' : 'type',
>    'data'    : { 'gtk'            : 'DisplayGTK',
>                  'egl-headless'   : 'DisplayEGLHeadless'} }
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1cf9aac1fe..4bc4e736bb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1216,7 +1216,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
>      "            [,window_close=on|off][,gl=on|core|es|off]\n"
>      "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
>      "-display vnc=<display>[,<optargs>]\n"
> -    "-display curses\n"
> +    "-display curses[,charset=<encoding>]\n"
>      "-display none\n"
>      "-display egl-headless[,rendernode=<file>]"
>      "                select display type\n"
> @@ -1248,6 +1248,9 @@ support a text mode, QEMU can display this output using a
>  curses/ncurses interface. Nothing is displayed when the graphics
>  device is in graphical mode or if the graphics device does not support
>  a text mode. Generally only the VGA device models support text mode.
> +The font charset used by the guest can be specified with the
> +@code{charset} option, for example @code{charset=CP850} for IBM CP850
> +encoding. The default is @code{CP437}.
>  @item none
>  Do not display video output. The guest will still see an emulated
>  graphics card, but its output will not be displayed to the QEMU
> diff --git a/ui/curses.c b/ui/curses.c
> index 1724dd57d4..203cc075d0 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
[...]
> @@ -492,6 +709,10 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
>      }
>  #endif
>  
> +    setlocale(LC_CTYPE, "");

General principles: any change to locale deserves prominent mention in
the commit message.

> +    if (opts->charset) {
> +        font_charset = opts->charset;
> +    }
>      curses_setup();
>      curses_keyboard_setup();
>      atexit(curses_atexit);
