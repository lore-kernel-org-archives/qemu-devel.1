Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cotAc-0004xL-6o
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cotAa-00015X-SK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:47:58 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cotAa-000151-GK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:47:56 -0400
Received: by mail-lf0-x241.google.com with SMTP id v2so5698056lfi.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <1489738282-28383-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489738282-28383-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Mar 2017 14:47:43 +0000
Message-ID: <CAJ+F1CLOdWGW7cLFEC3V5NOJ968jo_QP58QDEp45dxt9jGu0Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/egl-helpers: fix egl 1.5 display init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: hdegoede@redhat.com, Frediano Ziglio <fziglio@redhat.com>

On Fri, Mar 17, 2017 at 12:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Unfortunaly switching to getPlatformDisplayEXT isn't as easy as
> implemented by 0ea1523fb6703aa0dcd65e66b59e96fec028e60a.  See the
> longish comment for the complete story.
>
> Cc: Frediano Ziglio <fziglio@redhat.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/egl-helpers.c | 53
> +++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 584dd1b..48686cf 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -192,6 +192,51 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx=
,
> Window win)
>
>  /* ---------------------------------------------------------------------=
-
> */
>
> +/*
> + * Taken from glamor_egl.h from the Xorg xserver, which is MIT licensed
> + *
> + * Create an EGLDisplay from a native display type. This is a little
> quirky
> + * for a few reasons.
> + *
> + * 1: GetPlatformDisplayEXT and GetPlatformDisplay are the API you want =
to
> + * use, but have different function signatures in the third argument; th=
is
> + * happens not to matter for us, at the moment, but it means epoxy won't
> alias
> + * them together.
> + *
> + * 2: epoxy 1.3 and earlier don't understand EGL client extensions, whic=
h
> + * means you can't call "eglGetPlatformDisplayEXT" directly, as the
> resolver
> + * will crash.
> + *
> + * 3: You can't tell whether you have EGL 1.5 at this point, because
> + * eglQueryString(EGL_VERSION) is a property of the display, which we
> don't
> + * have yet. So you have to query for extensions no matter what.
> Fortunately
> + * epoxy_has_egl_extension _does_ let you query for client extensions, s=
o
> + * we don't have to write our own extension string parsing.
> + *
> + * 4. There is no EGL_KHR_platform_base to complement the EXT one, thus
> one
> + * needs to know EGL 1.5 is supported in order to use the
> eglGetPlatformDisplay
> + * function pointer.
> + * We can workaround this (circular dependency) by probing for the EGL 1=
.5
> + * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't
> seem
> + * like mesa will be able to adverise these (even though it can do EGL
> 1.5).
>

 adverise -> advertise

+ */
> +static EGLDisplay qemu_egl_get_display(void *native)
> +{
> +#ifdef EGL_PLATFORM_GBM_MESA
> +    /* In practise any EGL 1.5 implementation would support the EXT
> extension */
> +    if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
> +        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =3D
> +            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
> +        if (getPlatformDisplayEXT) {
> +            return getPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, native,
> NULL);
> +        }
> +    }
> +#endif
> +
> +    /* fallback */
> +    return eglGetDisplay(native);
> +}
> +
>  int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
>  {
>      static const EGLint conf_att_gl[] =3D {
> @@ -222,12 +267,8 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool
> gles, bool debug)
>          setenv("LIBGL_DEBUG", "verbose", true);
>      }
>
> -    egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
> -#ifdef EGL_MESA_platform_gbm
> -    qemu_egl_display =3D eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA,
> dpy, NULL);
> -#else
> -    qemu_egl_display =3D eglGetDisplay(dpy);
> -#endif
> +    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
> +    qemu_egl_display =3D qemu_egl_get_display(dpy);
>      if (qemu_egl_display =3D=3D EGL_NO_DISPLAY) {
>          error_report("egl: eglGetDisplay failed");
>          return -1;
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
