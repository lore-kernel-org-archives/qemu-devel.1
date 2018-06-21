Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwk-0001jg-AJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwh-0004d2-4o
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:31079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fVuwg-0004cB-QE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:27:59 -0400
Message-Id: <db277399c09b9b10c3bdc97722f2fb7b0bdfc733.1529568501.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529568501.git.balaton@eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 21 Jun 2018 10:08:21 +0200
Subject: [Qemu-devel] [PATCH 5/5] sm501: Fix support for non-zero frame
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
 hw/display/sm501.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index e426d2f..acc26f6 100644
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
