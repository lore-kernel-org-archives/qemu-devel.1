Received: from eggs.gnu.org ([2001:4830:134:3::10]:52656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctU02-0005ni-N0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctTzy-0005cq-Pb
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctTzy-0005ao-6W
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 08:55:28 +0200
Message-Id: <1490856931-21732-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 1/4] vga: add vga_scanline_invalidated
 helper
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

Add vga_scanline_invalidated helper to check whenever a scanline was
invalidated.  Add a sanity check to fix OOB read access for display
heights larger than 2048.

Only cirrus uses this, for hardware cursor rendering, so having this
work properly for the first 2048 scanlines only shouldn't be a problem
as the cirrus can't handle large resolutions anyway.  Also changing the
invalidated_y_table size would break live migration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 69c3e1d..f320946 100644
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
+    return s->invalidated_y_table[y >> 5] |= 1 << (y & 0x1f);
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
1.8.3.1
