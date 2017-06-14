Received: from eggs.gnu.org ([2001:4830:134:3::10]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3sA-0000cE-VR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3s7-0007bU-RS
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3s7-0007b0-J3
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 10:41:48 +0200
Message-Id: <20170614084149.31314-4-kraxel@redhat.com>
In-Reply-To: <20170614084149.31314-1-kraxel@redhat.com>
References: <20170614084149.31314-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] sdl2: use framebuffer helper functions.
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
 include/ui/sdl2.h |  8 ++++++--
 ui/sdl2-gl.c      | 36 +++++++-----------------------------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index aaf226c2c0..454367ac84 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -7,6 +7,10 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#ifdef CONFIG_OPENGL
+# include "ui/egl-helpers.h"
+#endif
+
 struct sdl2_console {
     DisplayChangeListener dcl;
     DisplaySurface *surface;
@@ -23,8 +27,8 @@ struct sdl2_console {
     SDL_GLContext winctx;
 #ifdef CONFIG_OPENGL
     ConsoleGLState *gls;
-    GLuint tex_id;
-    GLuint fbo_id;
+    egl_fb guest_fb;
+    egl_fb win_fb;
     bool y0_top;
     bool scanout_mode;
 #endif
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 1cd77e2c16..dcad3d0d26 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -42,14 +42,7 @@ static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanout)
 
     scon->scanout_mode = scanout;
     if (!scon->scanout_mode) {
-        if (scon->fbo_id) {
-            glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT,
-                                      GL_COLOR_ATTACHMENT0_EXT,
-                                      GL_TEXTURE_2D, 0, 0);
-            glDeleteFramebuffers(1, &scon->fbo_id);
-            glBindFramebuffer(GL_FRAMEBUFFER_EXT, 0);
-            scon->fbo_id = 0;
-        }
+        egl_fb_destroy(&scon->guest_fb);
         if (scon->surface) {
             surface_gl_destroy_texture(scon->gls, scon->surface);
             surface_gl_create_texture(scon->gls, scon->surface);
@@ -191,7 +184,6 @@ void sdl2_gl_scanout_disable(DisplayChangeListener *dcl)
     assert(scon->opengl);
     scon->w = 0;
     scon->h = 0;
-    scon->tex_id = 0;
     sdl2_set_scanout_mode(scon, false);
 }
 
@@ -210,48 +202,34 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
     scon->y = y;
     scon->w = w;
     scon->h = h;
-    scon->tex_id = backing_id;
     scon->y0_top = backing_y_0_top;
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     sdl2_set_scanout_mode(scon, true);
-    if (!scon->fbo_id) {
-        glGenFramebuffers(1, &scon->fbo_id);
-    }
-
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, scon->fbo_id);
-    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-                              GL_TEXTURE_2D, scon->tex_id, 0);
+    egl_fb_create_for_tex(&scon->guest_fb, backing_width, backing_height,
+                          backing_id);
 }
 
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
-    int ww, wh, y1, y2;
+    int ww, wh;
 
     assert(scon->opengl);
     if (!scon->scanout_mode) {
         return;
     }
-    if (!scon->fbo_id) {
+    if (!scon->guest_fb.framebuffer) {
         return;
     }
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
-    glBindFramebuffer(GL_READ_FRAMEBUFFER, scon->fbo_id);
-    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
-
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
-    glViewport(0, 0, ww, wh);
-    y1 = scon->y0_top ? 0 : scon->h;
-    y2 = scon->y0_top ? scon->h : 0;
-    glBlitFramebuffer(0, y1, scon->w, y2,
-                      0, 0, ww, wh,
-                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, scon->fbo_id);
+    egl_fb_setup_default(&scon->win_fb, ww, wh);
+    egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
     SDL_GL_SwapWindow(scon->real_window);
 }
-- 
2.9.3
