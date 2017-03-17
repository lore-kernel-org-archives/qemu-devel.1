Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cot6y-0003Uy-0E
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cot6u-0008Mn-46
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:44:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cot6t-0008M8-Rt
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:44:08 -0400
Date: Fri, 17 Mar 2017 10:44:03 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1138905803.3616945.1489761843215.JavaMail.zimbra@redhat.com>
In-Reply-To: <6a76ca9d-10cf-1de9-7430-5b3eb5e15aa2@amsat.org>
References: <1489738282-28383-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLfeZUjUUqiaeXZpUsQBcsX1Cips=HQj=5MMKbD+UxboA@mail.gmail.com>
	<6a76ca9d-10cf-1de9-7430-5b3eb5e15aa2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, hdegoede@redhat.com

>=20
> On 03/17/2017 05:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> > On Fri, Mar 17, 2017 at 12:12 PM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> >
> >> Unfortunaly switching to getPlatformDisplayEXT isn't as easy as
> >> implemented by 0ea1523fb6703aa0dcd65e66b59e96fec028e60a.  See the
> >> longish comment for the complete story.
> >>
> >> Cc: Frediano Ziglio <fziglio@redhat.com>
> >> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >
> >
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> >>  ui/egl-helpers.c | 53
> >> +++++++++++++++++++++++++++++++++++++++++++++++------
> >>  1 file changed, 47 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> >> index 584dd1b..48686cf 100644
> >> --- a/ui/egl-helpers.c
> >> +++ b/ui/egl-helpers.c
> >> @@ -192,6 +192,51 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext e=
ctx,
> >> Window win)
> >>
> >>  /* ------------------------------------------------------------------=
----
> >> */
> >>
> >> +/*
> >> + * Taken from glamor_egl.h from the Xorg xserver, which is MIT licens=
ed
> >> + *
> >> + * Create an EGLDisplay from a native display type. This is a little
> >> quirky
> >> + * for a few reasons.
> >> + *
> >> + * 1: GetPlatformDisplayEXT and GetPlatformDisplay are the API you wa=
nt
> >> to
> >> + * use, but have different function signatures in the third argument;
> >> this
> >> + * happens not to matter for us, at the moment, but it means epoxy wo=
n't
> >> alias
> >> + * them together.
> >> + *
> >> + * 2: epoxy 1.3 and earlier don't understand EGL client extensions, w=
hich
> >> + * means you can't call "eglGetPlatformDisplayEXT" directly, as the
> >> resolver
> >> + * will crash.
> >> + *
> >> + * 3: You can't tell whether you have EGL 1.5 at this point, because
> >> + * eglQueryString(EGL_VERSION) is a property of the display, which we
> >> don't
> >> + * have yet. So you have to query for extensions no matter what.
> >> Fortunately
> >> + * epoxy_has_egl_extension _does_ let you query for client extensions=
, so
> >> + * we don't have to write our own extension string parsing.
> >> + *
> >> + * 4. There is no EGL_KHR_platform_base to complement the EXT one, th=
us
> >> one
> >> + * needs to know EGL 1.5 is supported in order to use the
> >> eglGetPlatformDisplay
> >> + * function pointer.
> >> + * We can workaround this (circular dependency) by probing for the EG=
L
> >> 1.5
> >> + * platform extensions (EGL_KHR_platform_gbm and friends) yet it does=
n't
> >> seem
> >> + * like mesa will be able to adverise these (even though it can do EG=
L
> >> 1.5).
> >> + */
> >> +static EGLDisplay qemu_egl_get_display(void *native)
> >> +{
> >> +#ifdef EGL_PLATFORM_GBM_MESA
> >> +    /* In practise any EGL 1.5 implementation would support the EXT
> >> extension */
> >> +    if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {

Should not check EGL_MESA_platform_gbm instead?
What happens if package is compiled against Mesa but in the system Nvidia
OpenGL is installed? In this case EGL_PLATFORM_GBM_MESA is defines,
possibly EGL_EXT_platform_base is supported but EGL_PLATFORM_GBM_MESA
is not as Nvidia does not support it (so EGL_PLATFORM_GBM_MESA won't work).

Maybe Xorg code support also Nvidia case (that does not have gbm) ?

> >> +        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =3D
> >> +            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
> >> +        if (getPlatformDisplayEXT) {
> >> +            return getPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, nativ=
e,
> >> NULL);
> >> +        }
> >> +    }
> >> +#endif
> >> +
> >> +    /* fallback */
> >> +    return eglGetDisplay(native);
> >> +}
> >> +
> >>  int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug=
)
> >>  {
> >>      static const EGLint conf_att_gl[] =3D {
> >> @@ -222,12 +267,8 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, b=
ool
> >> gles, bool debug)
> >>          setenv("LIBGL_DEBUG", "verbose", true);
> >>      }
> >>
> >> -    egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
> >> -#ifdef EGL_MESA_platform_gbm
> >> -    qemu_egl_display =3D eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_ME=
SA,
> >> dpy, NULL);
> >> -#else
> >> -    qemu_egl_display =3D eglGetDisplay(dpy);
> >> -#endif
> >> +    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
> >> +    qemu_egl_display =3D qemu_egl_get_display(dpy);
> >>      if (qemu_egl_display =3D=3D EGL_NO_DISPLAY) {
> >>          error_report("egl: eglGetDisplay failed");
> >>          return -1;
