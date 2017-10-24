Received: from eggs.gnu.org ([2001:4830:134:3::10]:60810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p6l-0006V0-IP
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p6h-0002Ub-Ku
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:38:23 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:51625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p6h-0002UJ-Ga
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:38:19 -0400
Received: by mail-qk0-x232.google.com with SMTP id 17so24486993qkq.8
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:38:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-4-makovick@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8fd3ada-8f06-eb10-c5f3-cee3d9ef0c17@amsat.org>
Date: Mon, 23 Oct 2017 23:38:16 -0300
MIME-Version: 1.0
In-Reply-To: <20171023210803.20998-4-makovick@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] sdl2: Do not hide the cursor on
 auxilliary windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Hi Jindrich,

This looks like 2 different patches, can you split?

On 10/23/2017 06:07 PM, Jindrich Makovicka wrote:
> ---
>  ui/sdl2.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index aa37b39547..685e4fabec 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -169,10 +169,10 @@ static void sdl_hide_cursor(void)
>          return;
>      }
>  
> -    if (qemu_input_is_absolute()) {
> -        SDL_ShowCursor(1);
> -        SDL_SetCursor(sdl_cursor_hidden);
> -    } else {
> +    SDL_ShowCursor(SDL_DISABLE);
> +    SDL_SetCursor(sdl_cursor_hidden);
> +
> +    if (!qemu_input_is_absolute()) {
>          SDL_SetRelativeMouseMode(SDL_TRUE);
>      }
>  }
> @@ -185,14 +185,16 @@ static void sdl_show_cursor(void)
>  
>      if (!qemu_input_is_absolute()) {
>          SDL_SetRelativeMouseMode(SDL_FALSE);
> -        SDL_ShowCursor(1);
> -        if (guest_cursor &&
> -            (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
> -            SDL_SetCursor(guest_sprite);
> -        } else {
> -            SDL_SetCursor(sdl_cursor_normal);
> -        }
>      }
> +
> +    if (guest_cursor &&
> +        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
> +        SDL_SetCursor(guest_sprite);
> +    } else {
> +        SDL_SetCursor(sdl_cursor_normal);
> +    }
> +
> +    SDL_ShowCursor(SDL_ENABLE);
>  }

first patch:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---

second patch:

>  
>  static void sdl_grab_start(struct sdl2_console *scon)
> @@ -463,6 +465,10 @@ static void handle_mousemotion(SDL_Event *ev)
>      int max_x, max_y;
>      struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
>  
> +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> +        return;
> +    }
> +    
>      if (qemu_input_is_absolute() || absolute_enabled) {
>          int scr_w, scr_h;
>          SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
> @@ -490,6 +496,10 @@ static void handle_mousebutton(SDL_Event *ev)
>      SDL_MouseButtonEvent *bev;
>      struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
>  
> +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> +        return;
> +    }
> +    
>      bev = &ev->button;
>      if (!gui_grab && !qemu_input_is_absolute()) {
>          if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
> @@ -512,6 +522,10 @@ static void handle_mousewheel(SDL_Event *ev)
>      SDL_MouseWheelEvent *wev = &ev->wheel;
>      InputButton btn;
>  
> +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> +        return;
> +    }
> +    
>      if (wev->y > 0) {
>          btn = INPUT_BUTTON_WHEEL_UP;
>      } else if (wev->y < 0) {
> @@ -651,6 +665,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
>                             int x, int y, int on)
>  {
>      struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
> +
> +    if (!qemu_console_is_graphic(scon->dcl.con)) {
> +        return;
> +    }
> +    
>      if (on) {
>          if (!guest_cursor) {
>              sdl_show_cursor();
> 

Regards,

Phil.
