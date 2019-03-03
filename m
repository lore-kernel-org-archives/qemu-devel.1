Received: from eggs.gnu.org ([209.51.188.92]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1h0Uem-00017G-Nz
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1h0Uel-0002bj-J3
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:12:08 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1h0Uek-0002YQ-4V
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:12:06 -0500
Received: by mail-qt1-x843.google.com with SMTP id a48so2829017qtb.4
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 09:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20190303061406.7631-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190303061406.7631-1-samuel.thibault@ens-lyon.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 3 Mar 2019 10:11:52 -0700
Message-ID: <CANCZdfpiyw32LGt5A5=V59nv3xFiVT8o1xPf6aDt3oEgPeJUmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Reduce curses escdelay from 1s to 0.2s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Sun, Mar 3, 2019, 12:45 AM Samuel Thibault <samuel.thibault@ens-lyon.org>
wrote:

> By default, curses will only report single ESC key event after 1s delay,
> since ESC is also used for keypad escape sequences. This however makes
> users
> believe that ESC is not working. Reducing to 0.2s provides good enough user
> experience, while still allowing 200ms for keypad sequences to get in,
> which
> should be more than enough.
>

How did you come up with this number? Still seems a bit long for the ESC
ESC case where the user hits ESC twice in quick succession. Even back in
the day, terminals would send the characters back to back at 1200 baud,
which is 8ms per character. 32ms is 4x that, 32x 9600 baud rates. 25 or
50ms is suggested from these figures.

Warner

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  ui/curses.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/ui/curses.c b/ui/curses.c
> index 6e0091c3b2..700315bc09 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -231,7 +231,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
>          keycode = curses2keycode[chr];
>          keycode_alt = 0;
>
> -        /* alt key */
> +        /* alt or esc key */
>          if (keycode == 1) {
>              int nextchr = getch();
>
> @@ -361,6 +361,7 @@ static void curses_setup(void)
>      initscr(); noecho(); intrflush(stdscr, FALSE);
>      nodelay(stdscr, TRUE); nonl(); keypad(stdscr, TRUE);
>      start_color(); raw(); scrollok(stdscr, FALSE);
> +    set_escdelay(200);
>
>      /* Make color pair to match color format (3bits bg:3bits fg) */
>      for (i = 0; i < 64; i++) {
> --
> 2.20.1
>
>
>
