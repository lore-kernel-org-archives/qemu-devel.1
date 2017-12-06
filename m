Received: from eggs.gnu.org ([2001:4830:134:3::10]:50165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCr-0001B0-AR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCo-0001Av-5P
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCn-0001AU-VI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFUdo011870
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:05 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epphvr3gw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:05 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:18:04 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:48 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-56-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 55/55] vga: handle cirrus vbe mode wraparounds.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Commit "3d90c62548 vga: stop passing pointers to vga_draw_line*
functions" is incomplete.  It doesn't handle the case that the vga
rendering code tries to create a shared surface, i.e. a pixman image
backed by vga video memory.  That can not work in case the guest display
wraps from end of video memory to the start.  So force shadowing in that
case.  Also adjust the snapshot region calculation.

Can trigger with cirrus only, when programming vbe modes using the bochs
api (stdvga, also qxl and virtio-vga in vga compat mode) wrap arounds
can't happen.

Fixes: CVE-2017-13672
Fixes: 3d90c6254863693a6b13d918d2b8682e08bbc681
Cc: P J P <ppandit@redhat.com>
Reported-by: David Buchanan <d@vidbuchanan.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20171010141323.14049-3-kraxel@redhat.com
(cherry picked from commit 28f77de26a4f9995458ddeb9d34bb06c0193bdc9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/vga.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 895e95c3f4..06ca3daa4c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1465,13 +1465,13 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     DisplaySurface *surface = qemu_console_surface(s->con);
     int y1, y, update, linesize, y_start, double_scan, mask, depth;
     int width, height, shift_control, bwidth, bits;
-    ram_addr_t page0, page1;
+    ram_addr_t page0, page1, region_start, region_end;
     DirtyBitmapSnapshot *snap = NULL;
     int disp_width, multi_scan, multi_run;
     uint8_t *d;
     uint32_t v, addr1, addr;
     vga_draw_line_func *vga_draw_line = NULL;
-    bool share_surface;
+    bool share_surface, force_shadow = false;
     pixman_format_code_t format;
 #ifdef HOST_WORDS_BIGENDIAN
     bool byteswap = !s->big_endian_fb;
@@ -1484,6 +1484,15 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     s->get_resolution(s, &width, &height);
     disp_width = width;
 
+    region_start = (s->start_addr * 4);
+    region_end = region_start + s->line_offset * height;
+    if (region_end > s->vbe_size) {
+        /* wraps around (can happen with cirrus vbe modes) */
+        region_start = 0;
+        region_end = s->vbe_size;
+        force_shadow = true;
+    }
+
     shift_control = (s->gr[VGA_GFX_MODE] >> 5) & 3;
     double_scan = (s->cr[VGA_CRTC_MAX_SCAN] >> 7);
     if (shift_control != 1) {
@@ -1523,7 +1532,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     format = qemu_default_pixman_format(depth, !byteswap);
     if (format) {
         share_surface = dpy_gfx_check_format(s->con, format)
-            && !s->force_shadow;
+            && !s->force_shadow && !force_shadow;
     } else {
         share_surface = false;
     }
@@ -1627,8 +1636,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     y1 = 0;
 
     if (!full_update) {
-        ram_addr_t region_start = addr1;
-        ram_addr_t region_end = addr1 + s->line_offset * height;
         vga_sync_dirty_bitmap(s);
         if (s->line_compare < height) {
             /* split screen mode */
@@ -1651,10 +1658,17 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             addr = (addr & ~0x8000) | ((y1 & 2) << 14);
         }
         update = full_update;
-        page0 = addr;
-        page1 = addr + bwidth - 1;
+        page0 = addr & s->vbe_size_mask;
+        page1 = (addr + bwidth - 1) & s->vbe_size_mask;
         if (full_update) {
             update = 1;
+        } else if (page1 < page0) {
+            /* scanline wraps from end of video memory to the start */
+            assert(force_shadow);
+            update = memory_region_snapshot_get_dirty(&s->vram, snap,
+                                                      page0, 0);
+            update |= memory_region_snapshot_get_dirty(&s->vram, snap,
+                                                       page1, 0);
         } else {
             update = memory_region_snapshot_get_dirty(&s->vram, snap,
                                                       page0, page1 - page0);
-- 
2.11.0
