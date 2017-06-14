Received: from eggs.gnu.org ([2001:4830:134:3::10]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3sA-0000cA-UX
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3s7-0007bD-J2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3s7-0007at-A2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 10:41:47 +0200
Message-Id: <20170614084149.31314-3-kraxel@redhat.com>
In-Reply-To: <20170614084149.31314-1-kraxel@redhat.com>
References: <20170614084149.31314-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] egl-headless: use framebuffer helper
 functions.
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
 ui/egl-headless.c | 67 ++++++++++++++-----------------------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index d8d800f8a6..809bfde99c 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -8,14 +8,13 @@
 typedef struct egl_dpy {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
-    int width, height;
-    GLuint texture;
-    GLuint framebuffer;
-    GLuint blit_texture;
-    GLuint blit_framebuffer;
+    egl_fb guest_fb;
+    egl_fb blit_fb;
     bool y_0_top;
 } egl_dpy;
 
+/* ------------------------------------------------------------------ */
+
 static void egl_refresh(DisplayChangeListener *dcl)
 {
     graphic_hw_update(dcl->con);
@@ -38,8 +37,8 @@ static void egl_scanout_disable(DisplayChangeListener *dcl)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
-    edpy->texture = 0;
-    /* XXX: delete framebuffers here ??? */
+    egl_fb_destroy(&edpy->guest_fb);
+    egl_fb_destroy(&edpy->blit_fb);
 }
 
 static void egl_scanout_texture(DisplayChangeListener *dcl,
@@ -52,34 +51,17 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
-    edpy->texture = backing_id;
     edpy->y_0_top = backing_y_0_top;
 
     /* source framebuffer */
-    if (!edpy->framebuffer) {
-        glGenFramebuffers(1, &edpy->framebuffer);
-    }
-    glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->framebuffer);
-    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-                              GL_TEXTURE_2D, edpy->texture, 0);
+    egl_fb_create_for_tex(&edpy->guest_fb,
+                          backing_width, backing_height, backing_id);
 
     /* dest framebuffer */
-    if (!edpy->blit_framebuffer) {
-        glGenFramebuffers(1, &edpy->blit_framebuffer);
-        glGenTextures(1, &edpy->blit_texture);
-        edpy->width = 0;
-        edpy->height = 0;
-    }
-    if (edpy->width != backing_width || edpy->height != backing_height) {
-        edpy->width   = backing_width;
-        edpy->height  = backing_height;
-        glBindTexture(GL_TEXTURE_2D, edpy->blit_texture);
-        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
-                     edpy->width, edpy->height,
-                     0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
-        glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->blit_framebuffer);
-        glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-                                  GL_TEXTURE_2D, edpy->blit_texture, 0);
+    if (edpy->blit_fb.width  != backing_width ||
+        edpy->blit_fb.height != backing_height) {
+        egl_fb_destroy(&edpy->blit_fb);
+        egl_fb_create_new_tex(&edpy->blit_fb, backing_width, backing_height);
     }
 }
 
@@ -88,32 +70,17 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t w, uint32_t h)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
-    GLuint y1, y2;
 
-    if (!edpy->texture || !edpy->ds) {
+    if (!edpy->guest_fb.texture || !edpy->ds) {
         return;
     }
-    assert(surface_width(edpy->ds)  == edpy->width);
-    assert(surface_height(edpy->ds) == edpy->height);
+    assert(surface_width(edpy->ds)  == edpy->guest_fb.width);
+    assert(surface_height(edpy->ds) == edpy->guest_fb.height);
     assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
 
-    /* blit framebuffer, flip if needed */
-    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->framebuffer);
-    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, edpy->blit_framebuffer);
-    glViewport(0, 0, edpy->width, edpy->height);
-    y1 = edpy->y_0_top ? edpy->height : 0;
-    y2 = edpy->y_0_top ? 0 : edpy->height;
-    glBlitFramebuffer(0, y1, edpy->width, y2,
-                      0, 0, edpy->width, edpy->height,
-                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
+    egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
+    egl_fb_read(surface_data(edpy->ds), &edpy->blit_fb);
 
-    /* read pixels to surface */
-    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->blit_framebuffer);
-    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
-    glReadPixels(0, 0, edpy->width, edpy->height,
-                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(edpy->ds));
-
-    /* notify about updates */
     dpy_gfx_update(edpy->dcl.con, x, y, w, h);
 }
 
-- 
2.9.3
