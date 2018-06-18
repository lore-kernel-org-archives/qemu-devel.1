Received: from eggs.gnu.org ([2001:4830:134:3::10]:60207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUsEH-00016O-67
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUsEC-0001O1-6i
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:21:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fUsEC-0001Nn-1B
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:21:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 13:21:41 +0200
Message-Id: <20180618112141.23398-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] Add gles support to egl-helpers,
 wire up in egl-headless and gtk.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Add support for OpenGL ES to egl-helpers.  Wire up the new option for
egl-headless and gtk UIs.  egl-headless actually works fine.  gtk hits a
not-yet implemented code path in libEGL when trying to use gles mode:

  libEGL warning: FIXME: egl/x11 doesn't support front buffer rendering.

(This is mesa 17.2.3).

Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/egl-helpers.h |  7 +++---
 include/ui/gtk.h         |  2 +-
 ui/egl-context.c         | 11 ++++++++--
 ui/egl-headless.c        |  3 ++-
 ui/egl-helpers.c         | 55 ++++++++++++++++++++++++++++++++++--------------
 ui/gtk-egl.c             |  4 ++--
 ui/gtk.c                 |  7 ++----
 ui/spice-core.c          |  3 ++-
 8 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 747233ce58..9db7293bdb 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -7,6 +7,7 @@
 
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
+extern DisplayGLMode qemu_egl_mode;
 
 typedef struct egl_fb {
     int width;
@@ -34,7 +35,7 @@ extern int qemu_egl_rn_fd;
 extern struct gbm_device *qemu_egl_rn_gbm_dev;
 extern EGLContext qemu_egl_rn_ctx;
 
-int egl_rendernode_init(const char *rendernode);
+int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
 int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc);
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
@@ -44,8 +45,8 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
 
 EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win);
 
-int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy);
-int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy);
+int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode);
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode);
 EGLContext qemu_egl_init_ctx(void);
 
 #endif /* EGL_HELPERS_H */
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 2922fc64b2..a79780afc7 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -127,7 +127,7 @@ void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf);
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
-void gtk_egl_init(void);
+void gtk_egl_init(DisplayGLMode mode);
 int gd_egl_make_current(DisplayChangeListener *dcl,
                         QEMUGLContext ctx);
 
diff --git a/ui/egl-context.c b/ui/egl-context.c
index 2161969abe..78e6c7ab7c 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -6,15 +6,22 @@ QEMUGLContext qemu_egl_create_context(DisplayChangeListener *dcl,
                                       QEMUGLParams *params)
 {
    EGLContext ctx;
-   EGLint ctx_att[] = {
+   EGLint ctx_att_core[] = {
        EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT,
        EGL_CONTEXT_CLIENT_VERSION, params->major_ver,
        EGL_CONTEXT_MINOR_VERSION_KHR, params->minor_ver,
        EGL_NONE
    };
+   EGLint ctx_att_gles[] = {
+       EGL_CONTEXT_CLIENT_VERSION, params->major_ver,
+       EGL_CONTEXT_MINOR_VERSION_KHR, params->minor_ver,
+       EGL_NONE
+   };
+   bool gles = (qemu_egl_mode == DISPLAYGL_MODE_ES);
 
    ctx = eglCreateContext(qemu_egl_display, qemu_egl_config,
-                          eglGetCurrentContext(), ctx_att);
+                          eglGetCurrentContext(),
+                          gles ? ctx_att_gles : ctx_att_core);
    return ctx;
 }
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 7c877122d3..42a41310b0 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -171,11 +171,12 @@ static void early_egl_headless_init(DisplayOptions *opts)
 
 static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
 {
+    DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAYGL_MODE_ON;
     QemuConsole *con;
     egl_dpy *edpy;
     int idx;
 
-    if (egl_rendernode_init(NULL) < 0) {
+    if (egl_rendernode_init(NULL, mode) < 0) {
         error_report("egl: render node init failed");
         exit(1);
     }
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 16dc3ded36..71b6a97bd1 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -24,6 +24,7 @@
 
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
+DisplayGLMode qemu_egl_mode;
 
 /* ------------------------------------------------------------------ */
 
@@ -191,7 +192,7 @@ static int qemu_egl_rendernode_open(const char *rendernode)
     return fd;
 }
 
-int egl_rendernode_init(const char *rendernode)
+int egl_rendernode_init(const char *rendernode, DisplayGLMode mode)
 {
     qemu_egl_rn_fd = -1;
     int rc;
@@ -208,7 +209,8 @@ int egl_rendernode_init(const char *rendernode)
         goto err;
     }
 
-    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev);
+    rc = qemu_egl_init_dpy_mesa((EGLNativeDisplayType)qemu_egl_rn_gbm_dev,
+                                mode);
     if (rc != 0) {
         /* qemu_egl_init_dpy_mesa reports error */
         goto err;
@@ -392,9 +394,10 @@ static EGLDisplay qemu_egl_get_display(EGLNativeDisplayType native,
 }
 
 static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
-                             EGLenum platform)
+                             EGLenum platform,
+                             DisplayGLMode mode)
 {
-    static const EGLint conf_att_gl[] = {
+    static const EGLint conf_att_core[] = {
         EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
         EGL_RENDERABLE_TYPE, EGL_OPENGL_BIT,
         EGL_RED_SIZE,   5,
@@ -403,9 +406,19 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
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
+    bool gles = (mode == DISPLAYGL_MODE_ES);
 
     qemu_egl_display = qemu_egl_get_display(dpy, platform);
     if (qemu_egl_display == EGL_NO_DISPLAY) {
@@ -419,50 +432,60 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
         return -1;
     }
 
-    b = eglBindAPI(EGL_OPENGL_API);
+    b = eglBindAPI(gles ?  EGL_OPENGL_ES_API : EGL_OPENGL_API);
     if (b == EGL_FALSE) {
-        error_report("egl: eglBindAPI failed");
+        error_report("egl: eglBindAPI failed (%s mode)",
+                     gles ? "gles" : "core");
         return -1;
     }
 
-    b = eglChooseConfig(qemu_egl_display, conf_att_gl,
+    b = eglChooseConfig(qemu_egl_display,
+                        gles ? conf_att_gles : conf_att_core,
                         &qemu_egl_config, 1, &n);
     if (b == EGL_FALSE || n != 1) {
-        error_report("egl: eglChooseConfig failed");
+        error_report("egl: eglChooseConfig failed (%s mode)",
+                     gles ? "gles" : "core");
         return -1;
     }
+
+    qemu_egl_mode = gles ? DISPLAYGL_MODE_ES : DISPLAYGL_MODE_CORE;
     return 0;
 }
 
-int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy)
+int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode)
 {
 #ifdef EGL_KHR_platform_x11
-    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_X11_KHR);
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_X11_KHR, mode);
 #else
-    return qemu_egl_init_dpy(dpy, 0);
+    return qemu_egl_init_dpy(dpy, 0, mode);
 #endif
 }
 
-int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy)
+int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode)
 {
 #ifdef EGL_MESA_platform_gbm
-    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_GBM_MESA);
+    return qemu_egl_init_dpy(dpy, EGL_PLATFORM_GBM_MESA, mode);
 #else
-    return qemu_egl_init_dpy(dpy, 0);
+    return qemu_egl_init_dpy(dpy, 0, mode);
 #endif
 }
 
 EGLContext qemu_egl_init_ctx(void)
 {
-    static const EGLint ctx_att_gl[] = {
+    static const EGLint ctx_att_core[] = {
         EGL_CONTEXT_OPENGL_PROFILE_MASK, EGL_CONTEXT_OPENGL_CORE_PROFILE_BIT,
         EGL_NONE
     };
+    static const EGLint ctx_att_gles[] = {
+        EGL_CONTEXT_CLIENT_VERSION, 2,
+        EGL_NONE
+    };
+    bool gles = (qemu_egl_mode == DISPLAYGL_MODE_ES);
     EGLContext ectx;
     EGLBoolean b;
 
     ectx = eglCreateContext(qemu_egl_display, qemu_egl_config, EGL_NO_CONTEXT,
-                            ctx_att_gl);
+                            gles ? ctx_att_gles : ctx_att_core);
     if (ectx == EGL_NO_CONTEXT) {
         error_report("egl: eglCreateContext failed");
         return NULL;
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9390c6762e..fb00ad12ec 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -280,12 +280,12 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 }
 
-void gtk_egl_init(void)
+void gtk_egl_init(DisplayGLMode mode)
 {
     GdkDisplay *gdk_display = gdk_display_get_default();
     Display *x11_display = gdk_x11_display_get_xdisplay(gdk_display);
 
-    if (qemu_egl_init_dpy_x11(x11_display) < 0) {
+    if (qemu_egl_init_dpy_x11(x11_display, mode) < 0) {
         return;
     }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 903f136b8f..5cce6ed42d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2485,10 +2485,6 @@ static void early_gtk_display_init(DisplayOptions *opts)
 
     assert(opts->type == DISPLAY_TYPE_GTK);
     if (opts->has_gl && opts->gl != DISPLAYGL_MODE_OFF) {
-        if (opts->gl == DISPLAYGL_MODE_ES) {
-            error_report("gtk: opengl es not supported");
-            return;
-        }
 #if defined(CONFIG_OPENGL)
 #if defined(CONFIG_GTK_GL) && defined(GDK_WINDOWING_WAYLAND)
         if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
@@ -2497,7 +2493,8 @@ static void early_gtk_display_init(DisplayOptions *opts)
         } else
 #endif
         {
-            gtk_egl_init();
+            DisplayGLMode mode = opts->has_gl ? opts->gl : DISPLAYGL_MODE_ON;
+            gtk_egl_init(mode);
         }
 #endif
     }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ae8921a201..f8c0878529 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -829,7 +829,8 @@ void qemu_spice_init(void)
                          "incompatible with -spice port/tls-port");
             exit(1);
         }
-        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode")) != 0) {
+        if (egl_rendernode_init(qemu_opt_get(opts, "rendernode"),
+                                DISPLAYGL_MODE_ON) != 0) {
             error_report("Failed to initialize EGL render node for SPICE GL");
             exit(1);
         }
-- 
2.9.3
