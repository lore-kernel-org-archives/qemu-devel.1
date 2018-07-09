Received: from eggs.gnu.org ([2001:4830:134:3::10]:44246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq9-00053a-8C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq7-0002Dv-Qv
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:42 +1000
Message-Id: <20180709074350.27086-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/16] sm501: Fix support for non-zero frame
 buffer start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Display updates and drawing hardware cursor did not work when frame
buffer address was non-zero. Fix this by taking the frame buffer
address into account in these cases. This fixes screen dragging on
AmigaOS. Based on patch by Sebastian Bauer.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index ebd139006e..10ee008eb2 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -586,6 +586,11 @@ static uint32_t get_local_mem_size_index(uint32_t size)
     return index;
 }
 
+static ram_addr_t get_fb_addr(SM501State *s, int crt)
+{
+    return (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr) & 0x3FFFFF0;
+}
+
 static inline int get_width(SM501State *s, int crt)
 {
     int width = crt ? s->dc_crt_h_total : s->dc_panel_h_total;
@@ -688,7 +693,8 @@ static inline void hwc_invalidate(SM501State *s, int crt)
     start *= w * bpp;
     end *= w * bpp;
 
-    memory_region_set_dirty(&s->local_mem_region, start, end - start);
+    memory_region_set_dirty(&s->local_mem_region,
+                            get_fb_addr(s, crt) + start, end - start);
 }
 
 static void sm501_2d_operation(SM501State *s)
@@ -1213,6 +1219,9 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         break;
     case SM501_DC_PANEL_FB_ADDR:
         s->dc_panel_fb_addr = value & 0x8FFFFFF0;
+        if (value & 0x8000000) {
+            qemu_log_mask(LOG_UNIMP, "Panel external memory not supported\n");
+        }
         break;
     case SM501_DC_PANEL_FB_OFFSET:
         s->dc_panel_fb_offset = value & 0x3FF03FF0;
@@ -1273,6 +1282,9 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         break;
     case SM501_DC_CRT_FB_ADDR:
         s->dc_crt_fb_addr = value & 0x8FFFFFF0;
+        if (value & 0x8000000) {
+            qemu_log_mask(LOG_UNIMP, "CRT external memory not supported\n");
+        }
         break;
     case SM501_DC_CRT_FB_OFFSET:
         s->dc_crt_fb_offset = value & 0x3FF03FF0;
@@ -1615,7 +1627,7 @@ static void sm501_update_display(void *opaque)
     draw_hwc_line_func *draw_hwc_line = NULL;
     int full_update = 0;
     int y_start = -1;
-    ram_addr_t offset = 0;
+    ram_addr_t offset;
     uint32_t *palette;
     uint8_t hwc_palette[3 * 3];
     uint8_t *hwc_src = NULL;
@@ -1672,9 +1684,10 @@ static void sm501_update_display(void *opaque)
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
2.17.1
