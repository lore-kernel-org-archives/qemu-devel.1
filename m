Received: from eggs.gnu.org ([2001:4830:134:3::10]:37951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzu-00045P-RF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzs-0007WZ-HB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1uzs-0007VR-A1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 15:54:53 +0200
Message-Id: <20171010135453.6704-7-kraxel@redhat.com>
In-Reply-To: <20171010135453.6704-1-kraxel@redhat.com>
References: <20171010135453.6704-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] egl-headless: add dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Add support for the new dmabuf interface.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-headless.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 12ad64e995..5d50226869 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -4,13 +4,18 @@
 #include "ui/console.h"
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
+#include "ui/shader.h"
 
 typedef struct egl_dpy {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
+    QemuGLShader *gls;
     egl_fb guest_fb;
+    egl_fb cursor_fb;
     egl_fb blit_fb;
     bool y_0_top;
+    uint32_t pos_x;
+    uint32_t pos_y;
 } egl_dpy;
 
 /* ------------------------------------------------------------------ */
@@ -65,6 +70,43 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
     }
 }
 
+static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
+                               QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    egl_scanout_texture(dcl, dmabuf->texture,
+                        false, dmabuf->width, dmabuf->height,
+                        0, 0, dmabuf->width, dmabuf->height);
+}
+
+static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
+                              QemuDmaBuf *dmabuf,
+                              uint32_t pos_x, uint32_t pos_y)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+
+    edpy->pos_x = pos_x;
+    edpy->pos_y = pos_y;
+
+    egl_dmabuf_import_texture(dmabuf);
+    if (!dmabuf->texture) {
+        return;
+    }
+
+    egl_fb_setup_for_tex(&edpy->cursor_fb, dmabuf->width, dmabuf->height,
+                         dmabuf->texture, false);
+}
+
+static void egl_release_dmabuf(DisplayChangeListener *dcl,
+                               QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_release_texture(dmabuf);
+}
+
 static void egl_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y,
                               uint32_t w, uint32_t h)
@@ -78,9 +120,18 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
     assert(surface_height(edpy->ds) == edpy->guest_fb.height);
     assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
 
-    egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
+    if (edpy->cursor_fb.texture) {
+        /* have cursor -> render using textures */
+        egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
+                         !edpy->y_0_top);
+        egl_texture_blend(edpy->gls, &edpy->blit_fb, &edpy->cursor_fb,
+                          !edpy->y_0_top, edpy->pos_x, edpy->pos_y);
+    } else {
+        /* no cursor -> use simple framebuffer blit */
+        egl_fb_blit(&edpy->blit_fb, &edpy->guest_fb, edpy->y_0_top);
+    }
+
     egl_fb_read(surface_data(edpy->ds), &edpy->blit_fb);
-
     dpy_gfx_update(edpy->dcl.con, x, y, w, h);
 }
 
@@ -97,6 +148,9 @@ static const DisplayChangeListenerOps egl_ops = {
 
     .dpy_gl_scanout_disable  = egl_scanout_disable,
     .dpy_gl_scanout_texture  = egl_scanout_texture,
+    .dpy_gl_scanout_dmabuf   = egl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    = egl_cursor_dmabuf,
+    .dpy_gl_release_dmabuf   = egl_release_dmabuf,
     .dpy_gl_update           = egl_scanout_flush,
 };
 
@@ -120,6 +174,7 @@ void egl_headless_init(void)
         edpy = g_new0(egl_dpy, 1);
         edpy->dcl.con = con;
         edpy->dcl.ops = &egl_ops;
+        edpy->gls = qemu_gl_init_shader();
         register_displaychangelistener(&edpy->dcl);
     }
 }
-- 
2.9.3
