Received: from eggs.gnu.org ([2001:4830:134:3::10]:53652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpsIg-00069j-Pe
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpsId-0000py-LQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpsId-0000pj-DB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B01F83640F1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:04:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 09:04:02 +0100
Message-Id: <1489997042-1824-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ui/egl-helpers: fix egl 1.5 display init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: hdegoede@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Frediano Ziglio <fziglio@redhat.com>

Unfortunaly switching to getPlatformDisplayEXT isn't as easy as
implemented by 0ea1523fb6703aa0dcd65e66b59e96fec028e60a.  See the
longish comment for the complete story.

Cc: Frediano Ziglio <fziglio@redhat.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-helpers.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 584dd1b..b7b6b2e 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -192,6 +192,56 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
 
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
+ * like mesa will be able to advertise these (even though it can do EGL 1.5).
+ */
+static EGLDisplay qemu_egl_get_display(void *native)
+{
+    EGLDisplay dpy = EGL_NO_DISPLAY;
+
+#ifdef EGL_MESA_platform_gbm
+    /* In practise any EGL 1.5 implementation would support the EXT extension */
+    if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
+        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =
+            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
+        if (getPlatformDisplayEXT) {
+            dpy = getPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, native, NULL);
+        }
+    }
+#endif
+
+    if (dpy == EGL_NO_DISPLAY) {
+        /* fallback */
+        dpy = eglGetDisplay(native);
+    }
+    return dpy;
+}
+
 int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
 {
     static const EGLint conf_att_gl[] = {
@@ -222,12 +272,8 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
         setenv("LIBGL_DEBUG", "verbose", true);
     }
 
-    egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
-#ifdef EGL_MESA_platform_gbm
-    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, dpy, NULL);
-#else
-    qemu_egl_display = eglGetDisplay(dpy);
-#endif
+    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
+    qemu_egl_display = qemu_egl_get_display(dpy);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
         error_report("egl: eglGetDisplay failed");
         return -1;
-- 
1.8.3.1
