Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdbZ-0005eq-UH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdbY-0001at-TY
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqdbY-0001aY-NF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 460D317CEDA
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:39:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 12:39:29 +0100
Message-Id: <20180227113929.17170-5-kraxel@redhat.com>
In-Reply-To: <20180227113929.17170-1-kraxel@redhat.com>
References: <20180227113929.17170-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] gtk-egl: add cursor_dmabuf support
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

Add support for cursor dmabufs to gtk-egl.  Just blend in the cursor
(if we have one) when rendering the dmabuf.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  8 ++++++++
 ui/gtk-egl.c     | 40 +++++++++++++++++++++++++++++++++++++++-
 ui/gtk.c         |  2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 84c992c227..2922fc64b2 100644
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
@@ -115,6 +118,11 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t w, uint32_t h);
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf);
+void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf, bool have_hot,
+                          uint32_t hot_x, uint32_t hot_y);
+void gd_egl_cursor_position(DisplayChangeListener *dcl,
+                            uint32_t pos_x, uint32_t pos_y);
 void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf);
 void gd_egl_scanout_flush(DisplayChangeListener *dcl,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 2c83c22d04..9390c6762e 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -19,6 +19,7 @@
 #include "ui/console.h"
 #include "ui/gtk.h"
 #include "ui/egl-helpers.h"
+#include "ui/shader.h"
 
 #include "sysemu/sysemu.h"
 
@@ -209,6 +210,35 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 #endif
 }
 
+void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
+                          QemuDmaBuf *dmabuf, bool have_hot,
+                          uint32_t hot_x, uint32_t hot_y)
+{
+#ifdef CONFIG_OPENGL_DMABUF
+    VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+
+    if (dmabuf) {
+        egl_dmabuf_import_texture(dmabuf);
+        if (!dmabuf->texture) {
+            return;
+        }
+        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->height,
+                             dmabuf->texture, false);
+    } else {
+        egl_fb_destroy(&vc->gfx.cursor_fb);
+    }
+#endif
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
 void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf)
 {
@@ -237,7 +267,15 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     gdk_drawable_get_size(window, &ww, &wh);
     egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
-    egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
+    if (vc->gfx.cursor_fb.texture) {
+        egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
+                         vc->gfx.y0_top);
+        egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
+                          vc->gfx.y0_top,
+                          vc->gfx.cursor_x, vc->gfx.cursor_y);
+    } else {
+        egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
+    }
 
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 3edb9b2dde..6e18d4b4ab 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -745,6 +745,8 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_scanout_disable  = gd_egl_scanout_disable,
     .dpy_gl_scanout_texture  = gd_egl_scanout_texture,
     .dpy_gl_scanout_dmabuf   = gd_egl_scanout_dmabuf,
+    .dpy_gl_cursor_dmabuf    = gd_egl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = gd_egl_cursor_position,
     .dpy_gl_release_dmabuf   = gd_egl_release_dmabuf,
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
-- 
2.9.3
