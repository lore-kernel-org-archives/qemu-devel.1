Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0c-00041X-FL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002hW-JL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002ew-91
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:17 -0400
Message-Id: <ecee0d68066d20f01f02041ddbf499dca6308967.1530047900.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530047900.git.balaton@eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 26 Jun 2018 23:18:20 +0200
Subject: [Qemu-devel] [PATCH v2 6/7] sm501: Fix support for non-zero frame
 buffer start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

Display updates and drawing hardware cursor did not work when frame
buffer address was non-zero. Fix this by taking the frame buffer
address into account in these cases. This fixes screen dragging on
AmigaOS. Based on patch by Sebastian Bauer.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: fixed crash with Linux setting extra bits and log unimplemented case

 hw/display/sm501.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 7404035..6e78f73 100644
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
2.7.6
