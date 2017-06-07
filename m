Received: from eggs.gnu.org ([2001:4830:134:3::10]:47389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIgRm-000459-5L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIgRk-0006W2-Nw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:16:50 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIgRk-0006VT-B0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:16:48 -0400
Received: by mail-lf0-x243.google.com with SMTP id v20so1615512lfa.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 12:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20170606110459.9771-1-kraxel@redhat.com>
	<20170606110459.9771-2-kraxel@redhat.com>
In-Reply-To: <20170606110459.9771-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 07 Jun 2017 19:16:35 +0000
Message-ID: <CAJ+F1CJCnrzd4q4tGzvJoRVdRs7=BnPJ4QvUjdFmtODTesbKsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] egl-helpers: add helpers to handle
 opengl framebuffers
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

On Tue, Jun 6, 2017 at 3:06 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add a collection of egl_fb_*() helper functions to manage and use opengl
> framebuffers, which is a common pattern in UI code with opengl support.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/egl-helpers.h | 14 ++++++++++
>  ui/egl-helpers.c         | 69
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index c785d60e91..01aa45fb32 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -8,6 +8,20 @@
>  extern EGLDisplay *qemu_egl_display;
>  extern EGLConfig qemu_egl_config;
>
> +typedef struct egl_fb {
> +    int width;
> +    int height;
> +    GLuint texture;
> +    GLuint framebuffer;
> +    bool delete_texture;
> +} egl_fb;
> +
> +void egl_fb_destroy(egl_fb *fb);
> +void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint
> texture);
> +void egl_fb_create_new_tex(egl_fb *fb, int width, int height);
> +void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip);
> +void egl_fb_read(void *dst, egl_fb *src);
> +
>  #ifdef CONFIG_OPENGL_DMABUF
>
>  extern int qemu_egl_rn_fd;
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 4a4d3370ee..b14250ae62 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -24,6 +24,75 @@
>  EGLDisplay *qemu_egl_display;
>  EGLConfig qemu_egl_config;
>
> +/* ------------------------------------------------------------------ */
> +
> +void egl_fb_destroy(egl_fb *fb)
> +{
> +    if (!fb->framebuffer) {
> +        return;
> +    }
> +
> +    if (fb->delete_texture) {
> +        glDeleteTextures(1, &fb->texture);
> +        fb->delete_texture =3D false;
> +    }
> +    glDeleteFramebuffers(1, &fb->framebuffer);
> +
> +    fb->width =3D 0;
> +    fb->height =3D 0;
> +    fb->texture =3D 0;
> +    fb->framebuffer =3D 0;
> +}
> +
> +void egl_fb_create_for_tex(egl_fb *fb, int width, int height, GLuint
> texture)
> +{
> +    fb->width =3D width;
> +    fb->height =3D height;
> +    fb->texture =3D texture;
> +    if (!fb->framebuffer) {
> +        glGenFramebuffers(1, &fb->framebuffer);
> +    }
> +
> +    glBindFramebuffer(GL_FRAMEBUFFER_EXT, fb->framebuffer);
> +    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
> GL_COLOR_ATTACHMENT0_EXT,
> +                              GL_TEXTURE_2D, fb->texture, 0);
> +}
> +
> +void egl_fb_create_new_tex(egl_fb *fb, int width, int height)
> +{
> +    GLuint texture;
> +
> +    glGenTextures(1, &texture);
> +    glBindTexture(GL_TEXTURE_2D, texture);
> +    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height,
> +                 0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
> +
> +    egl_fb_create_for_tex(fb, width, height, texture);
> +    fb->delete_texture =3D true;
> +}
> +
> +void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
> +{
> +    GLuint y1, y2;
> +
> +    glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
> +    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, dst->framebuffer);
> +    glViewport(0, 0, dst->width, dst->height);
> +    y1 =3D flip ? src->height : 0;
> +    y2 =3D flip ? 0 : src->height;
> +    glBlitFramebuffer(0, y1, src->width, y2,
> +                      0, 0, dst->width, dst->height,
> +                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
>

Not much to say, except that GL_LINEAR could give better visual results for
desktop display when scaling down (if this case could happen).


> +}
> +
> +void egl_fb_read(void *dst, egl_fb *src)
> +{
> +    glBindFramebuffer(GL_READ_FRAMEBUFFER, src->framebuffer);
> +    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
> +    glReadPixels(0, 0, src->width, src->height,
> +                 GL_BGRA, GL_UNSIGNED_BYTE, dst);
> +}
> +
>  /* ---------------------------------------------------------------------=
-
> */
>
>  #ifdef CONFIG_OPENGL_DMABUF
> --
> 2.9.3
>
>

the rest looks good to me,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau
