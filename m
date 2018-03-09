Received: from eggs.gnu.org ([2001:4830:134:3::10]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euI8F-0001x5-PH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euI8C-0006BE-Jt
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:32:23 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euI8C-0006Ac-9N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:32:20 -0500
Received: by mail-wr0-x241.google.com with SMTP id h2so1746644wre.12
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:32:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180308161803.6152-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2900440-a0a6-43e6-2763-afd93c72fe7b@amsat.org>
Date: Fri, 9 Mar 2018 14:32:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180308161803.6152-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vnc: deal with surface NULL pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

On 03/08/2018 05:18 PM, Gerd Hoffmann wrote:
> Secondary displays in multihead setups are allowed to have a NULL
> DisplaySurface.  Typically user interfaces handle this by hiding the
> window which shows the display in question.
> 
> This isn't an option for vnc though because it simply hasn't a concept
> of windows or outputs.  So handle the situation by showing a placeholder
> DisplaySurface instead.  Also check in console_select whenever a surface
> is preset in the first place before requesting an update.
> 
> This fixes a segfault which can be triggered by switching to an unused
> display (via vtrl-alt-<nr>) in a multihead setup, for example using
> -device virtio-vga,max_outputs=2.
> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/ui/console.h |  2 ++
>  ui/console.c         | 10 ++++++----
>  ui/vnc.c             | 10 ++++++++++
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index aae9e44cb3..5fca9afcbc 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -260,6 +260,8 @@ DisplaySurface *qemu_create_displaysurface_guestmem(int width, int height,
>                                                      pixman_format_code_t format,
>                                                      int linesize,
>                                                      uint64_t addr);
> +DisplaySurface *qemu_create_message_surface(int w, int h,
> +                                            const char *msg);
>  PixelFormat qemu_default_pixelformat(int bpp);
>  
>  DisplaySurface *qemu_create_displaysurface(int width, int height);
> diff --git a/ui/console.c b/ui/console.c
> index 6ab4ff3baf..348610dd43 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1039,8 +1039,10 @@ void console_select(unsigned int index)
>                      dcl->ops->dpy_gfx_switch(dcl, s->surface);
>                  }
>              }
> -            dpy_gfx_update(s, 0, 0, surface_width(s->surface),
> -                           surface_height(s->surface));
> +            if (s->surface) {
> +                dpy_gfx_update(s, 0, 0, surface_width(s->surface),
> +                               surface_height(s->surface));
> +            }
>          }
>          if (ds->have_text) {
>              dpy_text_resize(s, s->width, s->height);
> @@ -1370,8 +1372,8 @@ DisplaySurface *qemu_create_displaysurface_guestmem(int width, int height,
>      return surface;
>  }
>  
> -static DisplaySurface *qemu_create_message_surface(int w, int h,
> -                                                   const char *msg)
> +DisplaySurface *qemu_create_message_surface(int w, int h,
> +                                            const char *msg)
>  {
>      DisplaySurface *surface = qemu_create_displaysurface(w, h);
>      pixman_color_t bg = color_table_rgb[0][QEMU_COLOR_BLACK];
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 13c28cabb0..e164eb798c 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -746,9 +746,19 @@ static void vnc_update_server_surface(VncDisplay *vd)
>  static void vnc_dpy_switch(DisplayChangeListener *dcl,
>                             DisplaySurface *surface)
>  {
> +    static const char placeholder_msg[] =
> +        "Display output is not active.";
> +    static DisplaySurface *placeholder;
>      VncDisplay *vd = container_of(dcl, VncDisplay, dcl);
>      VncState *vs;
>  
> +    if (surface == NULL) {
> +        if (placeholder == NULL) {
> +            placeholder = qemu_create_message_surface(640, 480, placeholder_msg);
> +        }
> +        surface = placeholder;
> +    }
> +
>      vnc_abort_display_jobs(vd);
>      vd->ds = surface;
>  
> 
