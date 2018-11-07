Received: from eggs.gnu.org ([2001:4830:134:3::10]:56429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKIbJ-00038M-0f
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKIbE-0006Ds-H7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gKIbD-00065V-HY
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A826D308A963
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 07:49:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  7 Nov 2018 08:49:49 +0100
Message-Id: <20181107074949.13805-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ui/gtk: fix cursor in egl mode
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

In egl mode the scale_x and scale_y variables are not set, so the
scaling logic in the mouse motion event handler does not work.

Fix that.  Also scale the cursor position in gd_egl_cursor_position().

Reported-by: Chen Zhang <tgfbeta@icloud.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Chen Zhang <tgfbeta@icloud.com>
---
 ui/gtk-egl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index a77c25b490..5420c2362b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,8 +68,15 @@ void gd_egl_draw(VirtualConsole *vc)
         return;
     }
 
+    window = gtk_widget_get_window(vc->gfx.drawing_area);
+    ww = gdk_window_get_width(window);
+    wh = gdk_window_get_height(window);
+
     if (vc->gfx.scanout_mode) {
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
+
+        vc->gfx.scale_x = (double)ww / vc->gfx.w;
+        vc->gfx.scale_y = (double)wh / vc->gfx.h;
     } else {
         if (!vc->gfx.ds) {
             return;
@@ -77,13 +84,13 @@ void gd_egl_draw(VirtualConsole *vc)
         eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                        vc->gfx.esurface, vc->gfx.ectx);
 
-        window = gtk_widget_get_window(vc->gfx.drawing_area);
-        ww = gdk_window_get_width(window);
-        wh = gdk_window_get_height(window);
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
 
         eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+
+        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
+        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
     }
 }
 
@@ -232,8 +239,8 @@ void gd_egl_cursor_position(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
-    vc->gfx.cursor_x = pos_x;
-    vc->gfx.cursor_y = pos_y;
+    vc->gfx.cursor_x = pos_x * vc->gfx.scale_x;
+    vc->gfx.cursor_y = pos_y * vc->gfx.scale_y;
 }
 
 void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
-- 
2.9.3
