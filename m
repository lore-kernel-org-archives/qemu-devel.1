Received: from eggs.gnu.org ([2001:4830:134:3::10]:44795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRxD8-0007H3-57
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRxD4-0007SP-8H
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:27:46 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:41288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cRxD4-0007QQ-1Q
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:27:42 -0500
References: <1484295285-8809-1-git-send-email-kraxel@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <24cb80e0-93bb-d4fb-0ba9-9f99397ec121@weilnetz.de>
Date: Fri, 13 Jan 2017 09:27:41 +0100
MIME-Version: 1.0
In-Reply-To: <1484295285-8809-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sdl2: fix build failure on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@gnu.org>

Am 13.01.2017 um 09:14 schrieb Gerd Hoffmann:
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Samuel Thibault <samuel.thibault@gnu.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/sdl2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 9a79b17..91fb111 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -817,9 +817,15 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
>          sdl2_console[i].dcl.con = con;
>          register_displaychangelistener(&sdl2_console[i].dcl);
>  
> +#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
>          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
> +#if defined(SDL_VIDEO_DRIVER_WINDOWS)
> +            qemu_console_set_window_id(con, (uintptr_t)info.info.win.window);
> +#elif defined(SDL_VIDEO_DRIVER_X11)
>              qemu_console_set_window_id(con, info.info.x11.window);
> +#endif
>          }
> +#endif
>      }
>  
>      /* Load a 32x32x4 image. White pixels are transparent. */


Thanks.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
