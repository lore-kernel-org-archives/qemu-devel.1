Received: from eggs.gnu.org ([2001:4830:134:3::10]:33437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgv-0003GJ-8W
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCgr-00080M-3e
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:12:45 -0400
Message-Id: <14abe12e75bf3f6665876faccaaa583c3e53a0b9.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 11/11] sm501: Fix support for non-zero frame
 buffer start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

Display updates and drawing hardware cursor did not work when frame
buffer address was non-zero. Fix this by taking the frame buffer
address into account in these cases. This fixes screen dragging on
AmigaOS. Based on patch by Sebastian Bauer.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index ad518ce..55d8193 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -578,6 +578,11 @@ static uint32_t get_local_mem_size_index(uint32_t size)
     return index;
 }
 
+static ram_addr_t get_fb_addr(SM501State *s, int crt)
+{
+    return crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr;
+}
+
 static inline int get_width(SM501State *s, int crt)
 {
     int width = crt ? s->dc_crt_h_total : s->dc_panel_h_total;
@@ -680,7 +685,8 @@ static inline void hwc_invalidate(SM501State *s, int crt)
     start *= w * bpp;
     end *= w * bpp;
 
-    memory_region_set_dirty(&s->local_mem_region, start, end - start);
+    memory_region_set_dirty(&s->local_mem_region,
+                            get_fb_addr(s, crt) + start, end - start);
 }
 
 static void sm501_2d_operation(SM501State *s)
@@ -1577,7 +1583,7 @@ static void sm501_update_display(void *opaque)
     draw_hwc_line_func *draw_hwc_line = NULL;
     int full_update = 0;
     int y_start = -1;
-    ram_addr_t offset = 0;
+    ram_addr_t offset;
     uint32_t *palette;
     uint8_t hwc_palette[3 * 3];
     uint8_t *hwc_src = NULL;
@@ -1634,9 +1640,10 @@ static void sm501_update_display(void *opaque)
     }
 
     /* draw each line according to conditions */
+    offset = get_fb_addr(s, crt);
     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
-    for (y = 0, offset = 0; y < height; y++, offset += width * src_bpp) {
+    for (y = 0; y < height; y++, offset += width * src_bpp) {
         int update, update_hwc;
 
         /* check if hardware cursor is enabled and we're within its range */
-- 
2.7.6
