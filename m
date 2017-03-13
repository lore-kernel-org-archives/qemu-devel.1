Received: from eggs.gnu.org ([2001:4830:134:3::10]:40474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cnMRf-000329-FE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cnMRc-00063n-Sp
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:39:15 -0400
Received: from mx6-phx2.redhat.com ([209.132.183.39]:47168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cnMRc-00062s-K9
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:39:12 -0400
Date: Mon, 13 Mar 2017 05:39:10 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1376895221.1392101.1489397950418.JavaMail.zimbra@redhat.com>
In-Reply-To: <cf298d66-cc10-0cf5-b5d1-b36c20fb05f7@redhat.com>
References: <20170220095055.4234-1-fziglio@redhat.com>
	<cf298d66-cc10-0cf5-b5d1-b36c20fb05f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Support newer MESA versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

> 
> <resend with some more people added to the Cc>
> 
> Hi,
> 
> On 20-02-17 10:50, Frediano Ziglio wrote:
> > According to
> > https://www.khronos.org/registry/EGL/extensions/MESA/EGL_MESA_platform_gbm.txt
> > if MESA_platform_gbm is supported display should be initialized
> > from a GBM handle using eglGetPlatformDisplayEXT.
> >
> > Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> > ---
> > This should fix
> > http://www.spinics.net/linux/fedora/libvir/msg142837.html
> >
> > Tested on Fedora rawhide.
> > ---
> >  ui/egl-helpers.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > index cd24568..964c5a5 100644
> > --- a/ui/egl-helpers.c
> > +++ b/ui/egl-helpers.c
> > @@ -219,7 +219,11 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool
> > gles, bool debug)
> >      }
> >
> >      egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
> > +#ifdef EGL_MESA_platform_gbm
> > +    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA,
> > dpy, NULL);
> > +#else
> >      qemu_egl_display = eglGetDisplay(dpy);
> > +#endif
> >      if (qemu_egl_display == EGL_NO_DISPLAY) {
> >          error_report("egl: eglGetDisplay failed");
> >          return -1;
> >
> 
> That fix is incomplete, you need some magic to work properly on older libGL
> versions.
> 
> Attached is a (compile tested only) proper patch. I do not have a qemu git
> clone
> handy atm, so this is not a git format-patch patch, it is against the Fedora
> Rawhide
> srpm. I've a test build with these patches here:
> 
> https://fedorapeople.org/~jwrdegoede/qemu-glvnd/
> 
> I was planning on doing a git clone qemu and send a proper patch after I got
> some
> testing feedback. Feel free to use this as a base for a v2 of your patch.
> 
> Regards,
> 
> Hans
> 

Wouldn't be easier to call the "old" eglGetDisplay if eglGetPlatformDisplayEXT
returns EGL_NO_DISPLAY ? Kind of

     egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
-    qemu_egl_display = eglGetDisplay(dpy);
+#ifdef EGL_MESA_platform_gbm
+    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, dpy, NULL);
+#else
+    qemu_egl_display = EGL_NO_DISPLAY;
+#endif
+    if (qemu_egl_display == EGL_NO_DISPLAY)
+        qemu_egl_display = eglGetDisplay(dpy);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
         error_report("egl: eglGetDisplay failed");
         return -1;

Your patch should not even compile on older system which does not define
EGL_PLATFORM_GBM_MESA.

I tested my patch and works on both rawhide and FC25 (with very recent Mesa version)

Frediano
