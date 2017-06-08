Received: from eggs.gnu.org ([2001:4830:134:3::10]:59501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIrc1-0007bS-St
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIrc0-0001eg-Cp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:12:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIrc0-0001eQ-13
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:12:08 -0400
Received: by mail-lf0-x243.google.com with SMTP id u62so2421075lfg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 00:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20170606110459.9771-1-kraxel@redhat.com>
	<20170606110459.9771-4-kraxel@redhat.com>
In-Reply-To: <20170606110459.9771-4-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 08 Jun 2017 07:11:56 +0000
Message-ID: <CAJ+F1CLAq16p4SkcsyAeLZJ3BCtQQVfiXzvgnzxfN-iVFT0RCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] sdl2: use framebuffer helper functions.
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

On Tue, Jun 6, 2017 at 3:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/sdl2.h |  8 ++++++--
>  ui/sdl2-gl.c      | 38 ++++++++------------------------------
>  2 files changed, 14 insertions(+), 32 deletions(-)
>
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index aaf226c2c0..454367ac84 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -7,6 +7,10 @@
>  #include <SDL.h>
>  #include <SDL_syswm.h>
>
> +#ifdef CONFIG_OPENGL
> +# include "ui/egl-helpers.h"
> +#endif
> +
>  struct sdl2_console {
>      DisplayChangeListener dcl;
>      DisplaySurface *surface;
> @@ -23,8 +27,8 @@ struct sdl2_console {
>      SDL_GLContext winctx;
>  #ifdef CONFIG_OPENGL
>      ConsoleGLState *gls;
> -    GLuint tex_id;
> -    GLuint fbo_id;
> +    egl_fb guest_fb;
> +    egl_fb win_fb;
>      bool y0_top;
>      bool scanout_mode;
>  #endif
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 1cd77e2c16..6640d0a9c8 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -42,14 +42,7 @@ static void sdl2_set_scanout_mode(struct sdl2_console
> *scon, bool scanout)
>
>      scon->scanout_mode =3D scanout;
>      if (!scon->scanout_mode) {
> -        if (scon->fbo_id) {
> -            glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
> -                                      GL_COLOR_ATTACHMENT0_EXT,
> -                                      GL_TEXTURE_2D, 0, 0);
> -            glDeleteFramebuffers(1, &scon->fbo_id);
> -            glBindFramebuffer(GL_FRAMEBUFFER_EXT, 0);
> -            scon->fbo_id =3D 0;
> -        }
> +        egl_fb_destroy(&scon->guest_fb);
>          if (scon->surface) {
>              surface_gl_destroy_texture(scon->gls, scon->surface);
>              surface_gl_create_texture(scon->gls, scon->surface);
> @@ -191,7 +184,6 @@ void sdl2_gl_scanout_disable(DisplayChangeListener
> *dcl)
>      assert(scon->opengl);
>      scon->w =3D 0;
>      scon->h =3D 0;
> -    scon->tex_id =3D 0;
>      sdl2_set_scanout_mode(scon, false);
>  }
>
> @@ -210,48 +202,34 @@ void sdl2_gl_scanout_texture(DisplayChangeListener
> *dcl,
>      scon->y =3D y;
>      scon->w =3D w;
>      scon->h =3D h;
> -    scon->tex_id =3D backing_id;
>      scon->y0_top =3D backing_y_0_top;
>
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>
>      sdl2_set_scanout_mode(scon, true);
> -    if (!scon->fbo_id) {
> -        glGenFramebuffers(1, &scon->fbo_id);
> -    }
> -
> -    glBindFramebuffer(GL_FRAMEBUFFER_EXT, scon->fbo_id);
> -    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
> GL_COLOR_ATTACHMENT0_EXT,
> -                              GL_TEXTURE_2D, scon->tex_id, 0);
> +    egl_fb_create_for_tex(&scon->guest_fb, backing_width, backing_height=
,
> +                          backing_id);
>  }
>
>  void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                             uint32_t x, uint32_t y, uint32_t w, uint32_t =
h)
>  {
>      struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,
> dcl);
> -    int ww, wh, y1, y2;
>
>      assert(scon->opengl);
>      if (!scon->scanout_mode) {
>          return;
>      }
> -    if (!scon->fbo_id) {
> +    if (!scon->guest_fb.framebuffer) {
>          return;
>      }
>
>      SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>
> -    glBindFramebuffer(GL_READ_FRAMEBUFFER, scon->fbo_id);
> -    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
> -
> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
> -    glViewport(0, 0, ww, wh);
> -    y1 =3D scon->y0_top ? 0 : scon->h;
> -    y2 =3D scon->y0_top ? scon->h : 0;
> -    glBlitFramebuffer(0, y1, scon->w, y2,
> -                      0, 0, ww, wh,
> -                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
> -    glBindFramebuffer(GL_FRAMEBUFFER_EXT, scon->fbo_id);
> +    SDL_GetWindowSize(scon->real_window,
> +                      &scon->win_fb.width,
> +                      &scon->win_fb.height);
>

It's a bit weird to have win_fb used without being really initialized.

Furthermore, there doesn't seem to be guarantee that glGenFramebuffers(1,
&fb->framebuffer) will make only non-0 values.

Perhaps you would also need a bool delete_fb, and a function to setup a
egl_fb from existing fb id.

+    egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
>
>      SDL_GL_SwapWindow(scon->real_window);
>  }
> --
> 2.9.3
>
>
>
Looks good otherwise.

--=20
Marc-Andr=C3=A9 Lureau
