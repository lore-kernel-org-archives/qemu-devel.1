Received: from eggs.gnu.org ([2001:4830:134:3::10]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctU02-0005nm-NK
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctTzy-0005cp-PC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctTzy-0005av-6e
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 08:55:30 +0200
Message-Id: <1490856931-21732-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 3/4] vga: make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The vga code clears the dirty bits *after* reading the framebuffer
memory.  So if the guest framebuffer updates hits the race window
between vga reading the framebuffer and vga clearing the dirty bits
vga will miss that update

Fix it by using the new memory_region_copy_and_clear_dirty()
memory_region_copy_get_dirty() functions.  That way we clear the
dirty bitmap before reading the framebuffer.  Any guest display
updates happening in parallel will be properly tracked in the
dirty bitmap then and the next display refresh will pick them up.

Problem triggers with mttcg only.  Before mttcg was merged tcg
never ran in parallel to vga emulation.  Using kvm will hide the
problem too, due to qemu operating on a userspace copy of the
kernel's dirty bitmap.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index f320946..7daccb8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1465,7 +1465,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     DisplaySurface *surface = qemu_console_surface(s->con);
     int y1, y, update, linesize, y_start, double_scan, mask, depth;
     int width, height, shift_control, line_offset, bwidth, bits;
-    ram_addr_t page0, page1, page_min, page_max;
+    ram_addr_t page0, page1;
+    DirtyCopy *copy = NULL;
     int disp_width, multi_scan, multi_run;
     uint8_t *d;
     uint32_t v, addr1, addr;
@@ -1480,9 +1481,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     full_update |= update_basic_params(s);
 
-    if (!full_update)
-        vga_sync_dirty_bitmap(s);
-
     s->get_resolution(s, &width, &height);
     disp_width = width;
 
@@ -1625,11 +1623,17 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     addr1 = (s->start_addr * 4);
     bwidth = (width * bits + 7) / 8;
     y_start = -1;
-    page_min = -1;
-    page_max = 0;
     d = surface_data(surface);
     linesize = surface_stride(surface);
     y1 = 0;
+
+    if (!full_update) {
+        vga_sync_dirty_bitmap(s);
+        copy = memory_region_copy_and_clear_dirty(&s->vram, addr1,
+                                                  bwidth * height,
+                                                  DIRTY_MEMORY_VGA);
+    }
+
     for(y = 0; y < height; y++) {
         addr = addr1;
         if (!(s->cr[VGA_CRTC_MODE] & 1)) {
@@ -1644,17 +1648,17 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         update = full_update;
         page0 = addr;
         page1 = addr + bwidth - 1;
-        update |= memory_region_get_dirty(&s->vram, page0, page1 - page0,
-                                          DIRTY_MEMORY_VGA);
+        if (full_update) {
+            update = 1;
+        } else {
+            update = memory_region_copy_get_dirty(&s->vram, copy,
+                                                  page0, page1 - page0);
+        }
         /* explicit invalidation for the hardware cursor (cirrus only) */
         update |= vga_scanline_invalidated(s, y);
         if (update) {
             if (y_start < 0)
                 y_start = y;
-            if (page0 < page_min)
-                page_min = page0;
-            if (page1 > page_max)
-                page_max = page1;
             if (!(is_buffer_shared(surface))) {
                 vga_draw_line(s, d, s->vram_ptr + addr, width);
                 if (s->cursor_draw_line)
@@ -1687,13 +1691,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         dpy_gfx_update(s->con, 0, y_start,
                        disp_width, y - y_start);
     }
-    /* reset modified pages */
-    if (page_max >= page_min) {
-        memory_region_reset_dirty(&s->vram,
-                                  page_min,
-                                  page_max - page_min,
-                                  DIRTY_MEMORY_VGA);
-    }
+    g_free(copy);
     memset(s->invalidated_y_table, 0, sizeof(s->invalidated_y_table));
 }
 
-- 
1.8.3.1
