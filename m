Received: from eggs.gnu.org ([2001:4830:134:3::10]:33481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sz-0000ra-23
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sw-0006AH-L1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6sw-00069c-Cw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:26 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DB421555C
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:37:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:37:16 +0100
Message-Id: <1487669841-13668-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
References: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] console: rename dpy_gl_scanout to
 dpy_gl_scanout_texture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

We'll add a variant which accepts dmabufs soon.  Change
the name so we can easily disturgish the two variants.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 14 +++++++-------
 include/ui/console.h       | 19 +++++++++++--------
 include/ui/gtk.h           | 24 ++++++++++++++----------
 include/ui/sdl2.h          | 12 +++++++-----
 ui/console.c               | 19 +++++++++++--------
 ui/gtk-egl.c               | 10 +++++-----
 ui/gtk-gl-area.c           | 12 +++++++-----
 ui/gtk.c                   |  4 ++--
 ui/sdl2-gl.c               | 12 +++++++-----
 ui/sdl2.c                  |  2 +-
 ui/spice-display.c         | 16 ++++++++--------
 11 files changed, 80 insertions(+), 64 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index ecb09d1..b526b3f 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -177,16 +177,16 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         qemu_console_resize(g->scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
-        dpy_gl_scanout(g->scanout[ss.scanout_id].con, info.tex_id,
-                       info.flags & 1 /* FIXME: Y_0_TOP */,
-                       info.width, info.height,
-                       ss.r.x, ss.r.y, ss.r.width, ss.r.height);
+        dpy_gl_scanout_texture(g->scanout[ss.scanout_id].con, info.tex_id,
+                               info.flags & 1 /* FIXME: Y_0_TOP */,
+                               info.width, info.height,
+                               ss.r.x, ss.r.y, ss.r.width, ss.r.height);
     } else {
         if (ss.scanout_id != 0) {
             dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL);
         }
-        dpy_gl_scanout(g->scanout[ss.scanout_id].con, 0, false,
-                       0, 0, 0, 0, 0, 0);
+        dpy_gl_scanout_texture(g->scanout[ss.scanout_id].con, 0, false,
+                               0, 0, 0, 0, 0, 0);
     }
     g->scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
@@ -597,7 +597,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
         if (i != 0) {
             dpy_gfx_replace_surface(g->scanout[i].con, NULL);
         }
-        dpy_gl_scanout(g->scanout[i].con, 0, false, 0, 0, 0, 0, 0, 0);
+        dpy_gl_scanout_texture(g->scanout[i].con, 0, false, 0, 0, 0, 0, 0, 0);
     }
 }
 
diff --git a/include/ui/console.h b/include/ui/console.h
index af6350e..e6ae637 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -215,10 +215,13 @@ typedef struct DisplayChangeListenerOps {
                                    QEMUGLContext ctx);
     QEMUGLContext (*dpy_gl_ctx_get_current)(DisplayChangeListener *dcl);
 
-    void (*dpy_gl_scanout)(DisplayChangeListener *dcl,
-                           uint32_t backing_id, bool backing_y_0_top,
-                           uint32_t backing_width, uint32_t backing_height,
-                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+    void (*dpy_gl_scanout_texture)(DisplayChangeListener *dcl,
+                                   uint32_t backing_id,
+                                   bool backing_y_0_top,
+                                   uint32_t backing_width,
+                                   uint32_t backing_height,
+                                   uint32_t x, uint32_t y,
+                                   uint32_t w, uint32_t h);
     void (*dpy_gl_update)(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
@@ -284,10 +287,10 @@ bool dpy_cursor_define_supported(QemuConsole *con);
 bool dpy_gfx_check_format(QemuConsole *con,
                           pixman_format_code_t format);
 
-void dpy_gl_scanout(QemuConsole *con,
-                    uint32_t backing_id, bool backing_y_0_top,
-                    uint32_t backing_width, uint32_t backing_height,
-                    uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void dpy_gl_scanout_texture(QemuConsole *con,
+                            uint32_t backing_id, bool backing_y_0_top,
+                            uint32_t backing_width, uint32_t backing_height,
+                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void dpy_gl_update(QemuConsole *con,
                    uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 47ffddb..408e21b 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -103,11 +103,13 @@ void gd_egl_switch(DisplayChangeListener *dcl,
                    DisplaySurface *surface);
 QEMUGLContext gd_egl_create_context(DisplayChangeListener *dcl,
                                     QEMUGLParams *params);
-void gd_egl_scanout(DisplayChangeListener *dcl,
-                    uint32_t backing_id, bool backing_y_0_top,
-                    uint32_t backing_width, uint32_t backing_height,
-                    uint32_t x, uint32_t y,
-                    uint32_t w, uint32_t h);
+void gd_egl_scanout_texture(DisplayChangeListener *dcl,
+                            uint32_t backing_id,
+                            bool backing_y_0_top,
+                            uint32_t backing_width,
+                            uint32_t backing_height,
+                            uint32_t x, uint32_t y,
+                            uint32_t w, uint32_t h);
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void gtk_egl_init(void);
@@ -126,11 +128,13 @@ QEMUGLContext gd_gl_area_create_context(DisplayChangeListener *dcl,
                                         QEMUGLParams *params);
 void gd_gl_area_destroy_context(DisplayChangeListener *dcl,
                                 QEMUGLContext ctx);
-void gd_gl_area_scanout(DisplayChangeListener *dcl,
-                        uint32_t backing_id, bool backing_y_0_top,
-                        uint32_t backing_width, uint32_t backing_height,
-                        uint32_t x, uint32_t y,
-                        uint32_t w, uint32_t h);
+void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
+                                uint32_t backing_id,
+                                bool backing_y_0_top,
+                                uint32_t backing_width,
+                                uint32_t backing_height,
+                                uint32_t x, uint32_t y,
+                                uint32_t w, uint32_t h);
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void gtk_gl_area_init(void);
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 683bb6a..2de792f 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -62,11 +62,13 @@ int sdl2_gl_make_context_current(DisplayChangeListener *dcl,
                                  QEMUGLContext ctx);
 QEMUGLContext sdl2_gl_get_current_context(DisplayChangeListener *dcl);
 
-void sdl2_gl_scanout(DisplayChangeListener *dcl,
-                     uint32_t backing_id, bool backing_y_0_top,
-                     uint32_t backing_width, uint32_t backing_height,
-                     uint32_t x, uint32_t y,
-                     uint32_t w, uint32_t h);
+void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
+                             uint32_t backing_id,
+                             bool backing_y_0_top,
+                             uint32_t backing_width,
+                             uint32_t backing_height,
+                             uint32_t x, uint32_t y,
+                             uint32_t w, uint32_t h);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
diff --git a/ui/console.c b/ui/console.c
index 49d0740..22c3c7d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1735,16 +1735,19 @@ QEMUGLContext dpy_gl_ctx_get_current(QemuConsole *con)
     return con->gl->ops->dpy_gl_ctx_get_current(con->gl);
 }
 
-void dpy_gl_scanout(QemuConsole *con,
-                    uint32_t backing_id, bool backing_y_0_top,
-                    uint32_t backing_width, uint32_t backing_height,
-                    uint32_t x, uint32_t y, uint32_t width, uint32_t height)
+void dpy_gl_scanout_texture(QemuConsole *con,
+                            uint32_t backing_id,
+                            bool backing_y_0_top,
+                            uint32_t backing_width,
+                            uint32_t backing_height,
+                            uint32_t x, uint32_t y,
+                            uint32_t width, uint32_t height)
 {
     assert(con->gl);
-    con->gl->ops->dpy_gl_scanout(con->gl, backing_id,
-                                 backing_y_0_top,
-                                 backing_width, backing_height,
-                                 x, y, width, height);
+    con->gl->ops->dpy_gl_scanout_texture(con->gl, backing_id,
+                                         backing_y_0_top,
+                                         backing_width, backing_height,
+                                         x, y, width, height);
 }
 
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3f5d328..d5541c3 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -170,11 +170,11 @@ QEMUGLContext gd_egl_create_context(DisplayChangeListener *dcl,
     return qemu_egl_create_context(dcl, params);
 }
 
-void gd_egl_scanout(DisplayChangeListener *dcl,
-                    uint32_t backing_id, bool backing_y_0_top,
-                    uint32_t backing_width, uint32_t backing_height,
-                    uint32_t x, uint32_t y,
-                    uint32_t w, uint32_t h)
+void gd_egl_scanout_texture(DisplayChangeListener *dcl,
+                            uint32_t backing_id, bool backing_y_0_top,
+                            uint32_t backing_width, uint32_t backing_height,
+                            uint32_t x, uint32_t y,
+                            uint32_t w, uint32_t h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 0df5a36..b05c665 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -167,11 +167,13 @@ void gd_gl_area_destroy_context(DisplayChangeListener *dcl, QEMUGLContext ctx)
     /* FIXME */
 }
 
-void gd_gl_area_scanout(DisplayChangeListener *dcl,
-                        uint32_t backing_id, bool backing_y_0_top,
-                        uint32_t backing_width, uint32_t backing_height,
-                        uint32_t x, uint32_t y,
-                        uint32_t w, uint32_t h)
+void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
+                                uint32_t backing_id,
+                                bool backing_y_0_top,
+                                uint32_t backing_width,
+                                uint32_t backing_height,
+                                uint32_t x, uint32_t y,
+                                uint32_t w, uint32_t h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
diff --git a/ui/gtk.c b/ui/gtk.c
index f21e9e7..1dd0b53 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -669,7 +669,7 @@ static const DisplayChangeListenerOps dcl_gl_area_ops = {
     .dpy_gl_ctx_destroy      = gd_gl_area_destroy_context,
     .dpy_gl_ctx_make_current = gd_gl_area_make_current,
     .dpy_gl_ctx_get_current  = gd_gl_area_get_current_context,
-    .dpy_gl_scanout          = gd_gl_area_scanout,
+    .dpy_gl_scanout_texture  = gd_gl_area_scanout_texture,
     .dpy_gl_update           = gd_gl_area_scanout_flush,
 };
 
@@ -688,7 +688,7 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_ctx_destroy      = qemu_egl_destroy_context,
     .dpy_gl_ctx_make_current = gd_egl_make_current,
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
-    .dpy_gl_scanout          = gd_egl_scanout,
+    .dpy_gl_scanout_texture  = gd_egl_scanout_texture,
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
 
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 039645d..e25aa3b 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -184,11 +184,13 @@ QEMUGLContext sdl2_gl_get_current_context(DisplayChangeListener *dcl)
     return (QEMUGLContext)sdlctx;
 }
 
-void sdl2_gl_scanout(DisplayChangeListener *dcl,
-                     uint32_t backing_id, bool backing_y_0_top,
-                     uint32_t backing_width, uint32_t backing_height,
-                     uint32_t x, uint32_t y,
-                     uint32_t w, uint32_t h)
+void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
+                             uint32_t backing_id,
+                             bool backing_y_0_top,
+                             uint32_t backing_width,
+                             uint32_t backing_height,
+                             uint32_t x, uint32_t y,
+                             uint32_t w, uint32_t h)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 91fb111..febda80 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -733,7 +733,7 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_ctx_destroy      = sdl2_gl_destroy_context,
     .dpy_gl_ctx_make_current = sdl2_gl_make_context_current,
     .dpy_gl_ctx_get_current  = sdl2_gl_get_current_context,
-    .dpy_gl_scanout          = sdl2_gl_scanout,
+    .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
 };
 #endif
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 64e472e..b80a9f3 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -928,13 +928,13 @@ static QEMUGLContext qemu_spice_gl_create_context(DisplayChangeListener *dcl,
     return qemu_egl_create_context(dcl, params);
 }
 
-static void qemu_spice_gl_scanout(DisplayChangeListener *dcl,
-                                  uint32_t tex_id,
-                                  bool y_0_top,
-                                  uint32_t backing_width,
-                                  uint32_t backing_height,
-                                  uint32_t x, uint32_t y,
-                                  uint32_t w, uint32_t h)
+static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
+                                          uint32_t tex_id,
+                                          bool y_0_top,
+                                          uint32_t backing_width,
+                                          uint32_t backing_height,
+                                          uint32_t x, uint32_t y,
+                                          uint32_t w, uint32_t h)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint stride = 0, fourcc = 0;
@@ -993,7 +993,7 @@ static const DisplayChangeListenerOps display_listener_gl_ops = {
     .dpy_gl_ctx_make_current = qemu_egl_make_context_current,
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
 
-    .dpy_gl_scanout          = qemu_spice_gl_scanout,
+    .dpy_gl_scanout_texture  = qemu_spice_gl_scanout_texture,
     .dpy_gl_update           = qemu_spice_gl_update,
 };
 
-- 
1.8.3.1
