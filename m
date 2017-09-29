Received: from eggs.gnu.org ([2001:4830:134:3::10]:52322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uo-0005lx-2p
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uk-0007QS-Ci
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:50274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7Uk-0007Pw-6P
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:27:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id y64so2118032oia.7
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:27:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170927103811.19249-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ebc776e0-41ad-bf88-6d54-2a4b52d1e5cd@amsat.org>
Date: Fri, 29 Sep 2017 20:44:09 -0300
MIME-Version: 1.0
In-Reply-To: <20170927103811.19249-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] console: purge curses bits from
 console.h
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
List-ID: <qemu-devel.nongnu.org>

Hi Gerd,

On 09/27/2017 07:38 AM, Gerd Hoffmann wrote:
> Handle the translation from vga chars to curses chars in curses_update()
> instead of console_write_ch().  Purge any curses support bits from
> ui/console.h include file.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/ui/console.h      | 23 ++---------------------
>   target/unicore32/helper.c |  6 ++++++
>   ui/curses.c               | 25 ++++++++++++++++++++-----
>   3 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 8024878bae..6966e4bd9d 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -336,29 +336,10 @@ static inline pixman_format_code_t surface_format(DisplaySurface *s)
>       return s->format;
>   }
>   
> -#ifdef CONFIG_CURSES
> -/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
> -#undef KEY_EVENT
> -#include <curses.h>
> -#undef KEY_EVENT
> -typedef chtype console_ch_t;
> -extern chtype vga_to_curses[];
> -#else
> -typedef unsigned long console_ch_t;
> -#endif
> +typedef uint32_t console_ch_t;
> +
>   static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
>   {
> -    uint8_t c = ch;
> -#ifdef CONFIG_CURSES
> -    if (vga_to_curses[c]) {
> -        ch &= ~(console_ch_t)0xff;
> -        ch |= vga_to_curses[c];
> -    }
> -#else
> -    if (c == '\0') {

I can't figure out why this is no more required (curses disabled),
can you enlighten me?

> -        ch |= ' ';
> -    }
> -#endif
>       *dest = ch;
>   }
>   
> diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
> index 309dcd1ae1..3393d2c020 100644
> --- a/target/unicore32/helper.c
> +++ b/target/unicore32/helper.c
> @@ -163,6 +163,12 @@ uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
>   }
>   
>   #ifdef CONFIG_CURSES
> +
> +/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
> +#undef KEY_EVENT
> +#include <curses.h>
> +#undef KEY_EVENT
> +
>   /*
>    * FIXME:
>    *     1. curses windows will be blank when switching back
> diff --git a/ui/curses.c b/ui/curses.c
> index 03cefdf470..85503876c0 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -33,6 +33,11 @@
>   #include "ui/input.h"
>   #include "sysemu/sysemu.h"
>   
> +/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
> +#undef KEY_EVENT
> +#include <curses.h>
> +#undef KEY_EVENT
> +
>   #define FONT_HEIGHT 16
>   #define FONT_WIDTH 8
>   
> @@ -42,16 +47,26 @@ static WINDOW *screenpad = NULL;
>   static int width, height, gwidth, gheight, invalidate;
>   static int px, py, sminx, sminy, smaxx, smaxy;
>   
> -chtype vga_to_curses[256];
> +static chtype vga_to_curses[256];
>   
>   static void curses_update(DisplayChangeListener *dcl,
>                             int x, int y, int w, int h)
>   {
> -    chtype *line;
> +    console_ch_t *line;
> +    chtype curses_line[width];
>   
> -    line = ((chtype *) screen) + y * width;
> -    for (h += y; y < h; y ++, line += width)
> -        mvwaddchnstr(screenpad, y, 0, line, width);
> +    line = screen + y * width;
> +    for (h += y; y < h; y ++, line += width) {
> +        for (x = 0; x < width; x++) {
> +            chtype ch = line[x] & 0xff;
> +            chtype at = line[x] & ~0xff;
> +            if (vga_to_curses[ch]) {
> +                ch = vga_to_curses[ch];
> +            }
> +            curses_line[x] = ch | at;
> +        }
> +        mvwaddchnstr(screenpad, y, 0, curses_line, width);
> +    }
>   
>       pnoutrefresh(screenpad, py, px, sminy, sminx, smaxy - 1, smaxx - 1);
>       refresh();
> 
