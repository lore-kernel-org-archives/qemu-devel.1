Received: from eggs.gnu.org ([2001:4830:134:3::10]:37132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hdegoede@redhat.com>) id 1cnMGS-0000vs-IV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hdegoede@redhat.com>) id 1cnMGP-0001RN-Ah
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:27:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hdegoede@redhat.com>) id 1cnMGP-0001RI-11
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31FEF20264
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 09:27:37 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
References: <20170220095055.4234-1-fziglio@redhat.com>
Message-ID: <cf298d66-cc10-0cf5-b5d1-b36c20fb05f7@redhat.com>
Date: Mon, 13 Mar 2017 10:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170220095055.4234-1-fziglio@redhat.com>
Content-Type: multipart/mixed; boundary="------------7950B078C0A2957B2BF02C4B"
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Support newer MESA versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Cole Robinson <crobinso@redhat.com>, David Airlie <airlied@redhat.com>

This is a multi-part message in MIME format.
--------------7950B078C0A2957B2BF02C4B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

<resend with some more people added to the Cc>

Hi,

On 20-02-17 10:50, Frediano Ziglio wrote:
> According to
> https://www.khronos.org/registry/EGL/extensions/MESA/EGL_MESA_platform_gbm.txt
> if MESA_platform_gbm is supported display should be initialized
> from a GBM handle using eglGetPlatformDisplayEXT.
>
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
> This should fix
> http://www.spinics.net/linux/fedora/libvir/msg142837.html
>
> Tested on Fedora rawhide.
> ---
>  ui/egl-helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index cd24568..964c5a5 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -219,7 +219,11 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
>      }
>
>      egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
> +#ifdef EGL_MESA_platform_gbm
> +    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, dpy, NULL);
> +#else
>      qemu_egl_display = eglGetDisplay(dpy);
> +#endif
>      if (qemu_egl_display == EGL_NO_DISPLAY) {
>          error_report("egl: eglGetDisplay failed");
>          return -1;
>

That fix is incomplete, you need some magic to work properly on older libGL versions.

Attached is a (compile tested only) proper patch. I do not have a qemu git clone
handy atm, so this is not a git format-patch patch, it is against the Fedora Rawhide
srpm. I've a test build with these patches here:

https://fedorapeople.org/~jwrdegoede/qemu-glvnd/

I was planning on doing a git clone qemu and send a proper patch after I got some
testing feedback. Feel free to use this as a base for a v2 of your patch.

Regards,

Hans




--------------7950B078C0A2957B2BF02C4B
Content-Type: text/x-patch;
 name="qemu-2.8.0-glvnd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qemu-2.8.0-glvnd.patch"

diff -up qemu-2.8.0/ui/egl-helpers.c~ qemu-2.8.0/ui/egl-helpers.c
--- qemu-2.8.0/ui/egl-helpers.c~	2016-12-20 21:16:54.000000000 +0100
+++ qemu-2.8.0/ui/egl-helpers.c	2017-03-13 08:56:32.402845087 +0100
@@ -172,6 +172,50 @@ EGLSurface qemu_egl_init_surface_x11(EGL
 
 /* ---------------------------------------------------------------------- */
 
+/*
+ * Taken from glamor_egl.h from the Xorg xserver, which is MIT licensed
+ *
+ * Create an EGLDisplay from a native display type. This is a little quirky
+ * for a few reasons.
+ *
+ * 1: GetPlatformDisplayEXT and GetPlatformDisplay are the API you want to
+ * use, but have different function signatures in the third argument; this
+ * happens not to matter for us, at the moment, but it means epoxy won't alias
+ * them together.
+ *
+ * 2: epoxy 1.3 and earlier don't understand EGL client extensions, which
+ * means you can't call "eglGetPlatformDisplayEXT" directly, as the resolver
+ * will crash.
+ *
+ * 3: You can't tell whether you have EGL 1.5 at this point, because
+ * eglQueryString(EGL_VERSION) is a property of the display, which we don't
+ * have yet. So you have to query for extensions no matter what. Fortunately
+ * epoxy_has_egl_extension _does_ let you query for client extensions, so
+ * we don't have to write our own extension string parsing.
+ *
+ * 4. There is no EGL_KHR_platform_base to complement the EXT one, thus one
+ * needs to know EGL 1.5 is supported in order to use the eglGetPlatformDisplay
+ * function pointer.
+ * We can workaround this (circular dependency) by probing for the EGL 1.5
+ * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't seem
+ * like mesa will be able to adverise these (even though it can do EGL 1.5).
+ */
+static EGLDisplay qemu_egl_get_display(EGLint type, void *native)
+{
+    EGLDisplay dpy = NULL;
+
+    /* In practise any EGL 1.5 implementation would support the EXT extension */
+    if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
+        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =
+            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
+        if (getPlatformDisplayEXT)
+            return getPlatformDisplayEXT(type, native, NULL);
+    }
+
+    /* Welp, everything is awful. */
+    return eglGetDisplay(native);
+}
+
 int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
 {
     static const EGLint conf_att_gl[] = {
@@ -202,8 +246,8 @@ int qemu_egl_init_dpy(EGLNativeDisplayTy
         setenv("LIBGL_DEBUG", "verbose", true);
     }
 
-    egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
-    qemu_egl_display = eglGetDisplay(dpy);
+    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
+    qemu_egl_display = qemu_egl_get_display(EGL_PLATFORM_GBM_MESA, dpy);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
         error_report("egl: eglGetDisplay failed");
         return -1;


--------------7950B078C0A2957B2BF02C4B--
