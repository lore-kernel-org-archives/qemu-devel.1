Received: from eggs.gnu.org ([2001:4830:134:3::10]:42117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006ad-Rf
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cve-0007N4-Sx
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cve-0007Mh-Mq
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7973C04BD25
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:17:01 +0200
Message-Id: <20170424121708.31953-7-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] vga: add vga_scanline_invalidated helper
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

Add vga_scanline_invalidated helper to check whenever a scanline was
invalidated.  Add a sanity check to fix OOB read access for display
heights larger than 2048.

Only cirrus uses this, for hardware cursor rendering, so having this
work properly for the first 2048 scanlines only shouldn't be a problem
as the cirrus can't handle large resolutions anyway.  Also changing the
invalidated_y_table size would break live migration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170421091632.30900-4-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 69c3e1d674..3991b88aac 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1434,6 +1434,14 @@ void vga_invalidate_scanlines(VGACommonState *s, int y1, int y2)
     }
 }
 
+static bool vga_scanline_invalidated(VGACommonState *s, int y)
+{
+    if (y >= VGA_MAX_HEIGHT) {
+        return false;
+    }
+    return s->invalidated_y_table[y >> 5] & (1 << (y & 0x1f));
+}
+
 void vga_sync_dirty_bitmap(VGACommonState *s)
 {
     memory_region_sync_dirty_bitmap(&s->vram);
@@ -1638,8 +1646,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         page1 = addr + bwidth - 1;
         update |= memory_region_get_dirty(&s->vram, page0, page1 - page0,
                                           DIRTY_MEMORY_VGA);
-        /* explicit invalidation for the hardware cursor */
-        update |= (s->invalidated_y_table[y >> 5] >> (y & 0x1f)) & 1;
+        /* explicit invalidation for the hardware cursor (cirrus only) */
+        update |= vga_scanline_invalidated(s, y);
         if (update) {
             if (y_start < 0)
                 y_start = y;
@@ -1686,7 +1694,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
                                   page_max - page_min,
                                   DIRTY_MEMORY_VGA);
     }
-    memset(s->invalidated_y_table, 0, ((height + 31) >> 5) * 4);
+    memset(s->invalidated_y_table, 0, sizeof(s->invalidated_y_table));
 }
 
 static void vga_draw_blank(VGACommonState *s, int full_update)
-- 
2.9.3
