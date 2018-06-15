Received: from eggs.gnu.org ([2001:4830:134:3::10]:41204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tomeu.vizoso@gmail.com>) id 1fTiWM-0007CL-IK
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tomeu.vizoso@gmail.com>) id 1fTiWJ-000770-ED
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:47:42 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:52460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tomeu.vizoso@gmail.com>)
	id 1fTiWJ-000756-4t
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:47:39 -0400
Received: by mail-wm0-x232.google.com with SMTP id p126-v6so1755347wmb.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:47:38 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Fri, 15 Jun 2018 08:47:01 +0200
Message-Id: <20180615064701.40928-1-tomeu.vizoso@collabora.com>
Subject: [Qemu-devel] [PATCH] egl-headless: Allow OpenGL ES context creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kernel@collabora.com, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Gerd Hoffmann <kraxel@redhat.com>

This will be mainly useful for automated testing of virglrenderer on ES.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 include/ui/egl-helpers.h |  6 ++---
 qemu-options.hx          |  1 +
 ui/egl-headless.c        |  2 +-
 ui/egl-helpers.c         | 56 +++++++++++++++++++++++++++++-----------
 ui/gtk-egl.c             |  2 +-
 ui/spice-core.c          |  2 +-
 6 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 747233ce5846..9c76a04a2492 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -34,7 +34,7 @@ extern int qemu_egl_rn_fd;
 extern struct gbm_device *qemu_egl_rn_gbm_dev;
 extern EGLContext qemu_egl_rn_ctx;
 
-int egl_rendernode_init(const char *rendernode);
+int egl_rendernode_init(const char *rendernode, bool gles);
 int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
@@ -45,7 +45,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
 EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
 
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy);
-int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy);
-EGLContext qemu_egl_init_ctx(void);
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, bool gles);
+EGLContext qemu_egl_init_ctx(bool gles);
 
 #endif /* EGL_HELPERS_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951e9ffd..baa320ce615d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1242,6 +1242,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
     "            [,window_close=on|off][,gl=on|core|es|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
+    "-display egl-headless[,gl=core|es]|\n"
     "-display vnc=<display>[,<optargs>]\n"
     "-display curses\n"
     "-display none"
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 7c877122d385..796bce0bfa67 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -175,7 +175,7 @@ static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
     egl_dpy *edpy;
     int idx;
 
-    if (egl_rendernode_init(NULL) < 0) {
+    if (egl_rendernode_init(NULL, opts->gl == DISPLAYGL_MODE_ES) < 0) {
         error_report("egl: render node init failed");
         exit(1);
     }
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 16dc3ded3630..a775f4ffb725 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -191,7 +191,7 @@ static int qemu_egl_rendernode_open(const char *rendernode)
     return fd;
 }
 
-int egl_rendernode_init(const char *rendernode)
+int egl_rendernode_init(const char *rendernode, bool gles)
 {
     qemu_egl_rn_fd = -1;
     int rc;
@@ -208,7 +208,8 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
 
-    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev,
+                                gles);
     if (rc != 0) {
         /* qemu_egl_init_dpy_mesa reports error */
         goto err;
@@ -225,7 +226,7 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
 
-    qemu_egl_rn_ctx = qemu_egl_init_ctx();
+    qemu_egl_rn_ctx = qemu_egl_init_ctx(gles);
     if (!qemu_egl_rn_ctx) {
         error_report("egl: egl_init_ctx failed");
         goto err;
@@ -392,7 +393,8 @@ static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
 }
 
 static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
-                             EGLenum platform)
+                             EGLenum platform,
+                             bool gles)
 {
     static const EGLint conf_att_gl[] = {
         EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
@@ -403,6 +405,15 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
         EGL_ALPHA_SIZE, 0,
         EGL_NONE,
     };
+    static const EGLint conf_att_gles[] = {
+        EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
+        EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
+        EGL_RED_SIZE,   5,
+        EGL_GREEN_SIZE, 5,
+        EGL_BLUE_SIZE,  5,
+        EGL_ALPHA_SIZE, 0,
+        EGL_NONE,
+    };
     EGLint major, minor;
     EGLBoolean b;
     EGLint n;
@@ -419,14 +430,21 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
         return -1;
     }
 
-    b = eglBindAPI(EGL_OPENGL_API);
+    if (gles)
+        b = eglBindAPI(EGL_OPENGL_ES_API);
+    else
+        b = eglBindAPI(EGL_OPENGL_API);
     if (b == EGL_FALSE) {
         error_report("egl: eglBindAPI failed");
         return -1;
     }
 
-    b = eglChooseConfig(qemu_egl_display, conf_att_gl,
-                        &qemu_egl_config, 1, &n);
+    if (gles)
+        b = eglChooseConfig(qemu_egl_display, conf_att_gles,
+                            &qemu_egl_config, 1, &n);
+    else
+        b = eglChooseConfig(qemu_egl_display, conf_att_gl,
+                            &qemu_egl_config, 1, &n);
     if (b == EGL_FALSE || n != 1) {
         error_report("egl: eglChooseConfig failed");
         return -1;
@@ -437,32 +455,40 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy)
 {
 #ifdef EGL_KHR_platform_x11
-    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_X11_KHR);
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_X11_KHR, false);
 #else
-    return qemu_egl_init_dpy(dpy, 0);
+    return qemu_egl_init_dpy(dpy, 0, false);
 #endif
 }
 
-int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy)
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, bool gles)
 {
 #ifdef EGL_MESA_platform_gbm
-    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_GBM_MESA);
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_GBM_MESA, gles);
 #else
-    return qemu_egl_init_dpy(dpy, 0);
+    return qemu_egl_init_dpy(dpy, 0, gles);
 #endif
 }
 
-EGLContext qemu_egl_init_ctx(void)
+EGLContext qemu_egl_init_ctx(bool gles)
 {
     static const EGLint ctx_att_gl[] = {
         EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT,
         EGL_NONE
     };
+    static const EGLint ctx_att_gles[] = {
+        EGL_CONTEXT_CLIENT_VERSION, 2,
+        EGL_NONE
+    };
     EGLContext ectx;
     EGLBoolean b;
 
-    ectx = eglCreateContext(qemu_egl_display, qemu_egl_config, EGL_NO_CONTEXT,
-                            ctx_att_gl);
+    if (gles)
+        ectx = eglCreateContext(qemu_egl_display, qemu_egl_config,
+                                EGL_NO_CONTEXT, ctx_att_gles);
+    else
+        ectx = eglCreateContext(qemu_egl_display, qemu_egl_config,
+                                EGL_NO_CONTEXT, ctx_att_gl);
     if (ectx == EGL_NO_CONTEXT) {
         error_report("egl: eglCreateContext failed");
         return NULL;
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9390c6762e87..9ab50a17c029 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -57,7 +57,7 @@ void gd_egl_init(VirtualConsole *vc)
         return;
     }
 
-    vc->gfx.ectx = qemu_egl_init_ctx();
+    vc->gfx.ectx = qemu_egl_init_ctx(false);
     vc->gfx.esurface = qemu_egl_init_surface_x11(vc->gfx.ectx, x11_window);
 
     assert(vc->gfx.esurface);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ae8921a201ca..6d659b64b4ce 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -829,7 +829,7 @@ void qemu_spice_init(void)
                          "incompatible with -spice port/tls-port");
             exit(1);
         }
-        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode")) != 0) {
+        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode"), false) != 0) {
             error_report("Failed to initialize EGL render node for SPICE GL");
             exit(1);
         }
-- 
2.17.0
