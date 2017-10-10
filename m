Received: from eggs.gnu.org ([2001:4830:134:3::10]:44740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHo-0007nf-PC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHk-0001eR-9D
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1vHk-0001dR-3Q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:28 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:13:21 +0200
Message-Id: <20171010141323.14049-2-kraxel@redhat.com>
In-Reply-To: <20171010141323.14049-1-kraxel@redhat.com>
References: <20171010141323.14049-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] vga: drop line_offset variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, Gerd Hoffmann <kraxel@redhat.com>

---
 hw/display/vga.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index ed24ef7076..bf774e3402 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1464,7 +1464,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
     int y1, y, update, linesize, y_start, double_scan, mask, depth;
-    int width, height, shift_control, line_offset, bwidth, bits;
+    int width, height, shift_control, bwidth, bits;
     ram_addr_t page0, page1;
     DirtyBitmapSnapshot *snap = NULL;
     int disp_width, multi_scan, multi_run;
@@ -1614,7 +1614,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->cursor_invalidate(s);
     }
 
-    line_offset = s->line_offset;
 #if 0
     printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
            width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
@@ -1629,7 +1628,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     if (!full_update) {
         ram_addr_t region_start = addr1;
-        ram_addr_t region_end = addr1 + line_offset * height;
+        ram_addr_t region_end = addr1 + s->line_offset * height;
         vga_sync_dirty_bitmap(s);
         if (s->line_compare < height) {
             /* split screen mode */
@@ -1681,7 +1680,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (!multi_run) {
             mask = (s->cr[VGA_CRTC_MODE] & 3) ^ 3;
             if ((y1 & mask) == mask)
-                addr1 += line_offset;
+                addr1 += s->line_offset;
             y1++;
             multi_run = multi_scan;
         } else {
-- 
2.9.3
