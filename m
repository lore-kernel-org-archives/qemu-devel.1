Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIi6B-00034J-Tp
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIi6A-0006sT-6E
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:02:39 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIi69-0006sG-PX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:02:38 -0400
Received: by mail-lf0-x22c.google.com with SMTP id v20so10632966lfa.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 14:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20170606110459.9771-1-kraxel@redhat.com>
	<20170606110459.9771-3-kraxel@redhat.com>
In-Reply-To: <20170606110459.9771-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 07 Jun 2017 21:02:24 +0000
Message-ID: <CAJ+F1CLy2nt-PgqDPNAvQBMcjMt_oTAUrSLY8trPtD-fyufd5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] egl-headless: use framebuffer helper
 functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

The patch looks good to me, but I tried to use egl-headless for the first
time, and I get a weird crash on virgl init:
(gdb) bt
#0  0x00007fffd8cd935f in rawmemchr () at /lib64/libc.so.6
#1  0x00007fffd8cc1832 in _IO_str_init_static_internal () at
/lib64/libc.so.6
#2  0x00007fffd8cb37e7 in vsscanf () at /lib64/libc.so.6
#3  0x00007ffff6e818a6 in vsscanf () at /lib64/libasan.so.3
#4  0x00007ffff6e819d3 in sscanf () at /lib64/libasan.so.3
#5  0x00007ffff6bfe239 in vrender_get_glsl_version
(glsl_version=3D0x60e00001f2b8) at vrend_renderer.c:6026
#6  0x00007ffff6bfe239 in vrend_create_context (id=3Did@entry=3D0,
nlen=3Dnlen@entry=3D0, debug_name=3Ddebug_name@entry=3D0x0) at vrend_render=
er.c:4033
#7  0x00007ffff6c04f2f in vrend_renderer_context_create_internal (handle=3D=
0,
nlen=3D0, debug_name=3D0x0) at vrend_decode.c:1066
#8  0x00007ffff6bf72a3 in vrend_renderer_init (cbs=3D<optimized out>,
flags=3D0) at vrend_renderer.c:3874
#9  0x0000555556b52cc1 in virtio_gpu_virgl_init (g=3D0x633000008d10) at
/home/elmarco/src/qemu/hw/display/virtio-gpu-3d.c:623

This doesn't happen when I use virgl/spice (gl=3Don obviously)

I guess you don't know what's going on, and I will look further later, I
just thought it was worth to report in case you had an idea.

On Tue, Jun 6, 2017 at 3:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

---
>  ui/egl-headless.c | 67
> ++++++++++++++-----------------------------------------
>  1 file changed, 17 insertions(+), 50 deletions(-)
>
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index d8d800f8a6..809bfde99c 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -8,14 +8,13 @@
>  typedef struct egl_dpy {
>      DisplayChangeListener dcl;
>      DisplaySurface *ds;
> -    int width, height;
> -    GLuint texture;
> -    GLuint framebuffer;
> -    GLuint blit_texture;
> -    GLuint blit_framebuffer;
> +    egl_fb guest_fb;
> +    egl_fb blit_fb;
>      bool y_0_top;
>  } egl_dpy;
>
> +/* ------------------------------------------------------------------ */
> +
>  static void egl_refresh(DisplayChangeListener *dcl)
>  {
>      graphic_hw_update(dcl->con);
> @@ -38,8 +37,8 @@ static void egl_scanout_disable(DisplayChangeListener
> *dcl)
>  {
>      egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
>
> -    edpy->texture =3D 0;
> -    /* XXX: delete framebuffers here ??? */
> +    egl_fb_destroy(&edpy->guest_fb);
> +    egl_fb_destroy(&edpy->blit_fb);
>  }
>
>  static void egl_scanout_texture(DisplayChangeListener *dcl,
> @@ -52,34 +51,17 @@ static void egl_scanout_texture(DisplayChangeListener
> *dcl,
>  {
>      egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
>
> -    edpy->texture =3D backing_id;
>      edpy->y_0_top =3D backing_y_0_top;
>
>      /* source framebuffer */
> -    if (!edpy->framebuffer) {
> -        glGenFramebuffers(1, &edpy->framebuffer);
> -    }
> -    glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->framebuffer);
> -    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
> GL_COLOR_ATTACHMENT0_EXT,
> -                              GL_TEXTURE_2D, edpy->texture, 0);
> +    egl_fb_create_for_tex(&edpy->guest_fb,
> +                          backing_width, backing_height, backing_id);
>
>      /* dest framebuffer */
> -    if (!edpy->blit_framebuffer) {
> -        glGenFramebuffers(1, &edpy->blit_framebuffer);
> -        glGenTextures(1, &edpy->blit_texture);
> -        edpy->width =3D 0;
> -        edpy->height =3D 0;
> -    }
> -    if (edpy->width !=3D backing_width || edpy->height !=3D backing_heig=
ht) {
> -        edpy->width   =3D backing_width;
> -        edpy->height  =3D backing_height;
> -        glBindTexture(GL_TEXTURE_2D, edpy->blit_texture);
> -        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
> -                     edpy->width, edpy->height,
> -                     0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
> -        glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->blit_framebuffer);
> -        glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
> GL_COLOR_ATTACHMENT0_EXT,
> -                                  GL_TEXTURE_2D, edpy->blit_texture, 0);
> +    if (edpy->blit_fb.width  !=3D backing_width ||
> +        edpy->blit_fb.height !=3D backing_height) {
> +        egl_fb_destroy(&edpy->blit_fb);
> +        egl_fb_create_new_tex(&edpy->blit_fb, backing_width,
> backing_height);
>      }
>  }
>
> @@ -88,32 +70,17 @@ static void egl_scanout_flush(DisplayChangeListener
> *dcl,
>                                uint32_t w, uint32_t h)
>  {
>      egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
> -    GLuint y1, y2;
>
> -    if (!edpy->texture || !edpy->ds) {
> +    if (!edpy->guest_fb.texture || !edpy->ds) {
>          return;
>      }
> -    assert(surface_width(edpy->ds)  =3D=3D edpy->width);
> -    assert(surface_height(edpy->ds) =3D=3D edpy->height);
> +    assert(surface_width(edpy->ds)  =3D=3D edpy->guest_fb.width);
> +    assert(surface_height(edpy->ds) =3D=3D edpy->guest_fb.height);
>      assert(surface_format(edpy->ds) =3D=3D PIXMAN_x8r8g8b8);
>
> -    /* blit framebuffer, flip if needed */
> -    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->framebuffer);
> -    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, edpy->blit_framebuffer);
> -    glViewport(0, 0, edpy->width, edpy->height);
> -    y1 =3D edpy->y_0_top ? edpy->height : 0;
> -    y2 =3D edpy->y_0_top ? 0 : edpy->height;
> -    glBlitFramebuffer(0, y1, edpy->width, y2,
> -                      0, 0, edpy->width, edpy->height,
> -                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
> +    egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
> +    egl_fb_read(surface_data(edpy->ds), &edpy->blit_fb);
>
> -    /* read pixels to surface */
> -    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->blit_framebuffer);
> -    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
> -    glReadPixels(0, 0, edpy->width, edpy->height,
> -                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(edpy->ds));
> -
> -    /* notify about updates */
>      dpy_gfx_update(edpy->dcl.con, x, y, w, h);
>  }
>
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
