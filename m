Received: from eggs.gnu.org ([2001:4830:134:3::10]:53869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1cRh1I-0007Gs-GR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1cRh1F-0001H3-Ap
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:10:28 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:60340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.weil@weilnetz.de>)
	id 1cRh1F-0001Fd-4T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:10:25 -0500
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<1483967385-12891-6-git-send-email-kraxel@redhat.com>
From: Stefan Weil <stefan.weil@weilnetz.de>
Message-ID: <a277b56c-3bb9-dcb1-eafc-0844cd77b8eb@weilnetz.de>
Date: Thu, 12 Jan 2017 16:10:22 +0100
MIME-Version: 1.0
In-Reply-To: <1483967385-12891-6-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 05/11] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

This commit breaks builds for Windows. See below for details.

Regards
Stefan

Am 09.01.2017 um 14:09 schrieb Gerd Hoffmann:
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> This uses the console API to record the window ID of the SDL2 windows.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Message-id: 20161221003806.22412-4-samuel.thibault@ens-lyon.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/sdl2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 30d2a3c..9a79b17 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -761,6 +761,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
>      uint8_t data = 0;
>      char *filename;
>      int i;
> +    SDL_SysWMinfo info;
>  
>      if (no_frame) {
>          gui_noframe = 1;
> @@ -786,6 +787,8 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
>          exit(1);
>      }
>      SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
> +    memset(&info, 0, sizeof(info));
> +    SDL_VERSION(&info.version);
>  
>      for (i = 0;; i++) {
>          QemuConsole *con = qemu_console_lookup_by_index(i);
> @@ -813,6 +816,10 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
>  #endif
>          sdl2_console[i].dcl.con = con;
>          register_displaychangelistener(&sdl2_console[i].dcl);
> +
> +        if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
> +            qemu_console_set_window_id(con, info.info.x11.window);

Windows does not use X11. gcc fails:

  CC      ui/sdl2.o
/qemu/ui/sdl2.c: In function ‘sdl_display_init’:
/qemu/ui/sdl2.c:821:54: error: ‘union <anonymous>’ has no member named ‘x11’
             qemu_console_set_window_id(con, info.info.x11.window);
