Received: from eggs.gnu.org ([2001:4830:134:3::10]:53166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eNF1g-0003QL-Tn
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eNF1d-00042q-Ni
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:33:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:9950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1eNF1d-00040t-E4
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:32:57 -0500
From: Tina Zhang <tina.zhang@intel.com>
Date: Fri,  8 Dec 2017 17:32:37 +0800
Message-Id: <1512725557-9729-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [Rfc PATCH] ui: Enable SDL to use dma-buf for direct
 guest framebuffer rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Tina Zhang <tina.zhang@intel.com>, zhenyuw@linux.intel.com, intel-gvt-dev@lists.freedesktop.org, zhi.a.wang@intel.com, hang.yuan@intel.com, zhiyuan.lv@intel.com

This RFC patch is based on Qemu UI on-going work of rendering guest
framebuffer through dma-buf interface, to show a protype of SDL with
dma-buf interface.

Against branch: work/intel-vgpu

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/ui/sdl2.h | 11 ++++++++
 ui/sdl2-gl.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++---------
 ui/sdl2.c         |  6 ++--
 3 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 7811d33..e6e334c 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -29,6 +29,9 @@ struct sdl2_console {
     QemuGLShader *gls;
     egl_fb guest_fb;
     egl_fb win_fb;
+    egl_fb cursor_fb;
+    int cursor_x;
+    int cursor_y;
     bool y0_top;
     bool scanout_mode;
 #endif
@@ -76,6 +79,14 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t w, uint32_t h);
 void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
                             QemuDmaBuf *dmabuf);
+void sdl2_gl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf);
+void sdl2_gl_cursor_position(DisplayChangeListener *dcl,
+                            bool have_hot, bool have_pos,
+                            uint32_t hot_x, uint32_t hot_y,
+                            uint32_t pos_x, uint32_t pos_y);
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index ab31c5a..dbe7435 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -72,9 +72,12 @@ void sdl2_gl_update(DisplayChangeListener *dcl,
 
     assert(scon->opengl);
 
-    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-    surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
-    scon->updates++;
+    if (!scon->scanout_mode) {
+    /* Fixme: unmarking these leads to flashing issue */
+        //SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
+        surface_gl_update_texture(scon->gls, scon->surface, x, y, w, h);
+        //scon->updates++;
+    }
 }
 
 void sdl2_gl_switch(DisplayChangeListener *dcl,
@@ -116,7 +119,7 @@ void sdl2_gl_refresh(DisplayChangeListener *dcl)
     assert(scon->opengl);
 
     graphic_hw_update(dcl->con);
-    if (scon->updates && scon->surface) {
+    if (!scon->scanout_mode && scon->updates && scon->surface) {
         scon->updates = 0;
         sdl2_gl_render_surface(scon);
     }
@@ -127,8 +130,12 @@ void sdl2_gl_redraw(struct sdl2_console *scon)
 {
     assert(scon->opengl);
 
-    if (scon->surface) {
-        sdl2_gl_render_surface(scon);
+    if (scon->scanout_mode) {
+        sdl2_gl_scanout_flush(&scon->dcl, 0, 0 , 0, 0);
+    } else {
+        if (scon->surface) {
+            sdl2_gl_render_surface(scon);
+        }
     }
 }
 
@@ -208,22 +215,64 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     sdl2_set_scanout_mode(scon, true);
+
     egl_fb_setup_for_tex(&scon->guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
 
+
 void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
                             QemuDmaBuf *dmabuf)
 {
-    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
-    int tex_id = 0;
+#ifdef CONFIG_OPENGL_DMABUF
+
+    egl_dmabuf_import_texture(dmabuf);
 
-    /* TODO: import dmabuf */
+    if (!dmabuf->texture) {
+        return;
+    }
 
-    sdl2_gl_scanout_texture(dcl, tex_id,
+    sdl2_gl_scanout_texture(dcl, dmabuf->texture,
                             false, dmabuf->width, dmabuf->height,
                             0, 0, dmabuf->width, dmabuf->height);
-    scon->guest_fb.delete_texture = true;
+#endif    
+}
+
+void sdl2_gl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    egl_fb_setup_for_tex(&scon->cursor_fb, dmabuf->width, dmabuf->height,
+                         dmabuf->texture, false);
+#endif
+}
+
+void sdl2_gl_cursor_position(DisplayChangeListener *dcl,
+                            bool have_hot, bool have_pos,
+                            uint32_t hot_x, uint32_t hot_y,
+                            uint32_t pos_x, uint32_t pos_y)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    scon->cursor_x = pos_x;
+    scon->cursor_y = pos_y;
+#endif
+}
+
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    egl_dmabuf_release_texture(dmabuf);
+#endif
 }
 
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
@@ -236,15 +285,24 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
     if (!scon->scanout_mode) {
         return;
     }
+
     if (!scon->guest_fb.framebuffer) {
         return;
     }
 
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
-
     SDL_GetWindowSize(scon->real_window, &ww, &wh);
+
     egl_fb_setup_default(&scon->win_fb, ww, wh);
-    egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
 
+    if (scon->cursor_fb.texture) {
+        egl_texture_blit(scon->gls, &scon->win_fb, &scon->guest_fb,
+                         scon->y0_top);
+	egl_texture_blend(scon->gls, &scon->win_fb, &scon->cursor_fb,
+                              scon->y0_top,
+                              scon->cursor_x, scon->cursor_y);
+    } else {
+        egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
+    }
     SDL_GL_SwapWindow(scon->real_window);
 }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 71efd24..c865cba 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -84,7 +84,6 @@ void sdl2_window_create(struct sdl2_console *scon)
     if (scon->hidden) {
         flags |= SDL_WINDOW_HIDDEN;
     }
-
     scon->real_window = SDL_CreateWindow("", SDL_WINDOWPOS_UNDEFINED,
                                          SDL_WINDOWPOS_UNDEFINED,
                                          surface_width(scon->surface),
@@ -118,7 +117,6 @@ void sdl2_window_resize(struct sdl2_console *scon)
     if (!scon->real_window) {
         return;
     }
-
     SDL_SetWindowSize(scon->real_window,
                       surface_width(scon->surface),
                       surface_height(scon->surface));
@@ -740,6 +738,9 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
     .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    = sdl2_gl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = sdl2_gl_cursor_position,
+    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
 };
 #endif
@@ -835,6 +836,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
 #endif
     }
 
+    qemu_egl_init_dpy_x11(info.info.x11.display);
     /* Load a 32x32x4 image. White pixels are transparent. */
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "qemu-icon.bmp");
     if (filename) {
-- 
2.7.4
