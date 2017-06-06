Received: from eggs.gnu.org ([2001:4830:134:3::10]:38192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICIV-00050n-2K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICIT-0002iw-Bt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dICIT-0002ie-42
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 318EABDD4
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 11:05:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 13:04:58 +0200
Message-Id: <20170606110459.9771-4-kraxel@redhat.com>
In-Reply-To: <20170606110459.9771-1-kraxel@redhat.com>
References: <20170606110459.9771-1-kraxel@redhat.com>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/sdl2.h |  8 ++++++--
 ui/sdl2-gl.c      | 38 ++++++++------------------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

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
index 1cd77e2c16..6640d0a9c8 100644
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
-    SDL_GetWindowSize(scon->real_window, &ww, &wh);
-    glViewport(0, 0, ww, wh);
-    y1 = scon->y0_top ? 0 : scon->h;
-    y2 = scon->y0_top ? scon->h : 0;
-    glBlitFramebuffer(0, y1, scon->w, y2,
-                      0, 0, ww, wh,
-                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, scon->fbo_id);
+    SDL_GetWindowSize(scon->real_window,
+                      &scon->win_fb.width,
+                      &scon->win_fb.height);
+    egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
     SDL_GL_SwapWindow(scon->real_window);
 }
-- 
2.9.3
