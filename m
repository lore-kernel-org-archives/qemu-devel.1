Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1euMOr-0000UR-Lo
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1euMOm-0000NX-JO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:05:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1euMOm-0000Md-Cj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:05:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29HxpKQ004281
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:05:42 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gkuw88sty-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:05:41 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 9 Mar 2018 18:05:40 -0000
References: <20180308161803.6152-1-kraxel@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 9 Mar 2018 19:05:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180308161803.6152-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a8eee638-c447-e851-d0a4-4cf1d0766f96@de.ibm.com>
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
> ---

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

I can see the new placeholder message and the crash is gone.


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
