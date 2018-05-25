Received: from eggs.gnu.org ([2001:4830:134:3::10]:57993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fMCXA-0001od-BX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fMCX5-000229-8n
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:13:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fMCX5-00021k-3T
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B68EA4022414
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:13:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 25 May 2018 15:13:18 +0200
Message-Id: <20180525131318.28437-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vga: cleanup surface handling
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

Just set the full_update flag if we need a new DisplaySurface.  Create
a new surface when the flag is set instead of having two places where
qemu_create_displaysurface_from() is called.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index a7794f6d1f..ed476e4e80 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1548,12 +1548,31 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     } else {
         share_surface = false;
     }
+
     if (s->line_offset != s->last_line_offset ||
         disp_width != s->last_width ||
         height != s->last_height ||
         s->last_depth != depth ||
         s->last_byteswap != byteswap ||
         share_surface != is_buffer_shared(surface)) {
+        /* display parameters changed -> need new display surface */
+        s->last_scr_width = disp_width;
+        s->last_scr_height = height;
+        s->last_width = disp_width;
+        s->last_height = height;
+        s->last_line_offset = s->line_offset;
+        s->last_depth = depth;
+        s->last_byteswap = byteswap;
+        full_update = 1;
+    }
+    if (surface_data(surface) != s->vram_ptr + (s->start_addr * 4)
+        && is_buffer_shared(surface)) {
+        /* base address changed (page flip) -> shared display surfaces
+         * must be updated with the new base address */
+        full_update = 1;
+    }
+
+    if (full_update) {
         if (share_surface) {
             surface = qemu_create_displaysurface_from(disp_width,
                     height, format, s->line_offset,
@@ -1563,23 +1582,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             qemu_console_resize(s->con, disp_width, height);
             surface = qemu_console_surface(s->con);
         }
-        s->last_scr_width = disp_width;
-        s->last_scr_height = height;
-        s->last_width = disp_width;
-        s->last_height = height;
-        s->last_line_offset = s->line_offset;
-        s->last_depth = depth;
-        s->last_byteswap = byteswap;
-        full_update = 1;
-    } else if (is_buffer_shared(surface) &&
-               (full_update || surface_data(surface) != s->vram_ptr
-                + (s->start_addr * 4))) {
-        pixman_format_code_t format =
-            qemu_default_pixman_format(depth, !byteswap);
-        surface = qemu_create_displaysurface_from(disp_width,
-                height, format, s->line_offset,
-                s->vram_ptr + (s->start_addr * 4));
-        dpy_gfx_replace_surface(s->con, surface);
     }
 
     if (shift_control == 0) {
-- 
2.9.3
