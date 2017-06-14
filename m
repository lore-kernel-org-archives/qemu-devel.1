Received: from eggs.gnu.org ([2001:4830:134:3::10]:60228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3sA-0000cD-Uv
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3s7-0007bO-Ll
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3s7-0007ax-Di
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 10:41:49 +0200
Message-Id: <20170614084149.31314-5-kraxel@redhat.com>
In-Reply-To: <20170614084149.31314-1-kraxel@redhat.com>
References: <20170614084149.31314-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] gtk: use framebuffer helper functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  4 ++--
 ui/gtk-egl.c     | 36 +++++++-----------------------------
 ui/gtk-gl-area.c | 26 +++++++-------------------
 3 files changed, 16 insertions(+), 50 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index ca9a2268de..2f7b720358 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -52,8 +52,8 @@ typedef struct VirtualGfxConsole {
     EGLSurface esurface;
     int glupdates;
     int x, y, w, h;
-    GLuint tex_id;
-    GLuint fbo_id;
+    egl_fb guest_fb;
+    egl_fb win_fb;
     bool y0_top;
     bool scanout_mode;
 #endif
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index cf48cca259..0d5cab2bc8 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -30,14 +30,7 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
-        if (vc->gfx.fbo_id) {
-            glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
-                                      GL_COLOR_ATTACHMENT0_EXT,
-                                      GL_TEXTURE_2D, 0, 0);
-            glBindFramebuffer(GL_FRAMEBUFFER_EXT, 0);
-            glDeleteFramebuffers(1, &vc->gfx.fbo_id);
-            vc->gfx.fbo_id = 0;
-        }
+        egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
@@ -176,7 +169,6 @@ void gd_egl_scanout_disable(DisplayChangeListener *dcl)
 
     vc->gfx.w = 0;
     vc->gfx.h = 0;
-    vc->gfx.tex_id = 0;
     gtk_egl_set_scanout_mode(vc, false);
 }
 
@@ -192,20 +184,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     vc->gfx.y = y;
     vc->gfx.w = w;
     vc->gfx.h = h;
-    vc->gfx.tex_id = backing_id;
     vc->gfx.y0_top = backing_y_0_top;
 
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     gtk_egl_set_scanout_mode(vc, true);
-    if (!vc->gfx.fbo_id) {
-        glGenFramebuffers(1, &vc->gfx.fbo_id);
-    }
-
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, vc->gfx.fbo_id);
-    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-                              GL_TEXTURE_2D, vc->gfx.tex_id, 0);
+    egl_fb_create_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                          backing_id);
 }
 
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
@@ -213,30 +199,22 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
-    int ww, wh, y1, y2;
+    int ww, wh;
 
     if (!vc->gfx.scanout_mode) {
         return;
     }
-    if (!vc->gfx.fbo_id) {
+    if (!vc->gfx.guest_fb.framebuffer) {
         return;
     }
 
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
-    glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.fbo_id);
-    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
-
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     gdk_drawable_get_size(window, &ww, &wh);
-    glViewport(0, 0, ww, wh);
-    y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
-    y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
-    glBlitFramebuffer(0, y1, vc->gfx.w, y2,
-                      0, 0, ww, wh,
-                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, vc->gfx.fbo_id);
+    egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
+    egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
 
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index b05c665cbb..18b298fc21 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -26,14 +26,7 @@ static void gtk_gl_area_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
-        if (vc->gfx.fbo_id) {
-            glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
-                                      GL_COLOR_ATTACHMENT0_EXT,
-                                      GL_TEXTURE_2D, 0, 0);
-            glBindFramebuffer(GL_FRAMEBUFFER_EXT, 0);
-            glDeleteFramebuffers(1, &vc->gfx.fbo_id);
-            vc->gfx.fbo_id = 0;
-        }
+        egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
@@ -56,11 +49,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
     wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
 
     if (vc->gfx.scanout_mode) {
-        if (!vc->gfx.fbo_id) {
+        if (!vc->gfx.guest_fb.framebuffer) {
             return;
         }
 
-        glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.fbo_id);
+        glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
         /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
 
         glViewport(0, 0, ww, wh);
@@ -181,24 +174,19 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
     vc->gfx.y = y;
     vc->gfx.w = w;
     vc->gfx.h = h;
-    vc->gfx.tex_id = backing_id;
     vc->gfx.y0_top = backing_y_0_top;
 
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
-    if (vc->gfx.tex_id == 0 || vc->gfx.w == 0 || vc->gfx.h == 0) {
+    if (vc->gfx.guest_fb.framebuffer  == 0 ||
+        vc->gfx.w == 0 || vc->gfx.h == 0) {
         gtk_gl_area_set_scanout_mode(vc, false);
         return;
     }
 
     gtk_gl_area_set_scanout_mode(vc, true);
-    if (!vc->gfx.fbo_id) {
-        glGenFramebuffers(1, &vc->gfx.fbo_id);
-    }
-
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, vc->gfx.fbo_id);
-    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-                              GL_TEXTURE_2D, vc->gfx.tex_id, 0);
+    egl_fb_create_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                          backing_id);
 }
 
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
-- 
2.9.3
