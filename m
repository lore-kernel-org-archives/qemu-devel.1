Received: from eggs.gnu.org ([2001:4830:134:3::10]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6aff-0004gS-B9
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6afc-00088h-Ih
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6afc-000882-AM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BD2480466
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:41:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 May 2017 12:40:58 +0200
Message-Id: <20170505104101.30589-4-kraxel@redhat.com>
In-Reply-To: <20170505104101.30589-1-kraxel@redhat.com>
References: <20170505104101.30589-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] egl-helpers: fix display init for x11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

When running on gtk we need X11 platform not mesa platform.
Create separate functions for mesa and x11 so we can keep
the egl #ifdef mess local to egl-helpers.c

Fixes: 0ea1523fb6703aa0dcd65e66b59e96fec028e60a
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  3 ++-
 ui/egl-helpers.c         | 34 ++++++++++++++++++++++++++--------
 ui/gtk-egl.c             |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index fec7da14a5..c785d60e91 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -21,7 +21,8 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
 
 EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
 
-int qemu_egl_init_dpy(EGLNativeDisplayType dpy);
+int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy);
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy);
 EGLContext qemu_egl_init_ctx(void);
 
 #endif /* EGL_HELPERS_H */
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index a3d7c3d7f5..ec2e325e21 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -93,7 +93,7 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
 
-    qemu_egl_init_dpy((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
 
     if (!epoxy_has_egl_extension(qemu_egl_display,
                                  "EGL_KHR_surfaceless_context")) {
@@ -206,20 +206,19 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win)
  * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't seem
  * like mesa will be able to advertise these (even though it can do EGL 1.5).
  */
-static EGLDisplay qemu_egl_get_display(void *native)
+static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
+                                       EGLenum platform)
 {
     EGLDisplay dpy = EGL_NO_DISPLAY;
 
-#ifdef EGL_MESA_platform_gbm
     /* In practise any EGL 1.5 implementation would support the EXT extension */
     if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
         PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =
             (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
-        if (getPlatformDisplayEXT) {
-            dpy = getPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, native, NULL);
+        if (getPlatformDisplayEXT && platform != 0) {
+            dpy = getPlatformDisplayEXT(platform, native, NULL);
         }
     }
-#endif
 
     if (dpy == EGL_NO_DISPLAY) {
         /* fallback */
@@ -228,7 +227,8 @@ static EGLDisplay qemu_egl_get_display(void *native)
     return dpy;
 }
 
-int qemu_egl_init_dpy(EGLNativeDisplayType dpy)
+static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
+                             EGLenum platform)
 {
     static const EGLint conf_att_gl[] = {
         EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
@@ -243,7 +243,7 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy)
     EGLBoolean b;
     EGLint n;
 
-    qemu_egl_display = qemu_egl_get_display(dpy);
+    qemu_egl_display = qemu_egl_get_display(dpy, platform);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
         error_report("egl: eglGetDisplay failed");
         return -1;
@@ -270,6 +270,24 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy)
     return 0;
 }
 
+int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy)
+{
+#ifdef EGL_KHR_platform_x11
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_X11_KHR);
+#else
+    return qemu_egl_init_dpy(dpy, 0);
+#endif
+}
+
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy)
+{
+#ifdef EGL_MESA_platform_gbm
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_GBM_MESA);
+#else
+    return qemu_egl_init_dpy(dpy, 0);
+#endif
+}
+
 EGLContext qemu_egl_init_ctx(void)
 {
     static const EGLint ctx_att_gl[] = {
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 89492c0e02..cf48cca259 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -246,7 +246,7 @@ void gtk_egl_init(void)
     GdkDisplay *gdk_display = gdk_display_get_default();
     Display *x11_display = gdk_x11_display_get_xdisplay(gdk_display);
 
-    if (qemu_egl_init_dpy(x11_display) < 0) {
+    if (qemu_egl_init_dpy_x11(x11_display) < 0) {
         return;
     }
 
-- 
2.9.3
