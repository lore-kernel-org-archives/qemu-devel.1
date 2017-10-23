Received: from eggs.gnu.org ([2001:4830:134:3::10]:41972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSV-0006nb-Da
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSU-0000FW-18
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6bST-0000Ep-Q1
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB23C356D1
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 12:03:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 14:03:17 +0200
Message-Id: <20171023120317.8296-5-kraxel@redhat.com>
In-Reply-To: <20171023120317.8296-1-kraxel@redhat.com>
References: <20171023120317.8296-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] gtk-egl: add dmabuf support
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

Add support for the new dmabuf interface.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h | 11 ++++++++++
 ui/gtk-egl.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 ui/gtk.c         |  6 ++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index f6dafc5961..5d61e69b49 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -54,6 +54,9 @@ typedef struct VirtualGfxConsole {
     int x, y, w, h;
     egl_fb guest_fb;
     egl_fb win_fb;
+    egl_fb cursor_fb;
+    int cursor_x;
+    int cursor_y;
     bool y0_top;
     bool scanout_mode;
 #endif
@@ -113,6 +116,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
                             uint32_t w, uint32_t h);
+void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
+void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf);
+void gd_egl_cursor_position(DisplayChangeListener *dcl,
+                            uint32_t pos_x, uint32_t pos_y);
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf);
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void gtk_egl_init(void);
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index eb86c26a1d..30c121c50c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -7,6 +7,9 @@
  * This code handles opengl support on older gtk versions, using egl
  * to get a opengl context for the X11 window.
  *
+ * Also needed on newer gtk versions because the GtkGLArea X11 backend
+ * uses glx not egl, but for dma-buf imports we need a egl context.
+ *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
@@ -194,6 +197,52 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                          backing_id, false);
 }
 
+#ifdef CONFIG_OPENGL_DMABUF
+
+void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    gd_egl_scanout_texture(dcl, dmabuf->texture,
+                           false, dmabuf->width, dmabuf->height,
+                           0, 0, dmabuf->width, dmabuf->height);
+}
+
+void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf)
+{
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->height,
+                         dmabuf->texture, false);
+}
+
+void gd_egl_cursor_position(DisplayChangeListener *dcl,
+                            uint32_t pos_x, uint32_t pos_y)
+{
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
+    vc->gfx.cursor_x = pos_x;
+    vc->gfx.cursor_y = pos_y;
+}
+
+void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
+                           QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_release_texture(dmabuf);
+}
+
+#endif
+
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
@@ -213,8 +262,19 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     gdk_drawable_get_size(window, &ww, &wh);
-    egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
-    egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
+    if (vc->gfx.cursor_fb.texture) {
+        /* have cursor -> render using textures */
+        egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
+        egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
+                         vc->gfx.y0_top);
+        egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
+                          vc->gfx.y0_top,
+                          vc->gfx.cursor_x, vc->gfx.cursor_y);
+    } else {
+        /* no cursor -> use simple framebuffer blit */
+        egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
+        egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
+    }
 
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index d794fb7fa9..41753184b8 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -692,6 +692,12 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
     .dpy_gl_scanout_disable  = gd_egl_scanout_disable,
     .dpy_gl_scanout_texture  = gd_egl_scanout_texture,
+#ifdef CONFIG_OPENGL_DMABUF
+    .dpy_gl_scanout_dmabuf   = gd_egl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    = gd_egl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = gd_egl_cursor_position,
+    .dpy_gl_release_dmabuf   = gd_egl_release_dmabuf,
+#endif
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
 
-- 
2.9.3
