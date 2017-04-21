Received: from eggs.gnu.org ([2001:4830:134:3::10]:49864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1aWD-0001SG-2K
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1aW9-0007pV-Ap
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:30:44 -0400
Message-Id: <187c9e4e09d9bc2967b2454b36bb088ceef0b8bc.1492787889.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1492787889.git.balaton@eik.bme.hu>
References: <cover.1492787889.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 21 Apr 2017 17:18:09 +0200
Subject: [Qemu-devel] [PATCH v7 09/13] sm501: Misc clean ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

- Rename a variable
- Move variable declarations out of loop to the beginning in draw_hwc_line

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/display/sm501.c          | 10 +++++-----
 hw/display/sm501_template.h | 10 ++++------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 72e86ba..3974821 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1313,7 +1313,7 @@ static void sm501_draw_crt(SM501State *s)
     uint32_t *palette = (uint32_t *)&s->dc_palette[SM501_DC_CRT_PALETTE -
                                                    SM501_DC_PANEL_PALETTE];
     uint8_t hwc_palette[3 * 3];
-    int ds_depth_index = get_depth_index(surface);
+    int dst_depth_index = get_depth_index(surface);
     draw_line_func *draw_line = NULL;
     draw_hwc_line_func *draw_hwc_line = NULL;
     int full_update = 0;
@@ -1325,13 +1325,13 @@ static void sm501_draw_crt(SM501State *s)
     /* choose draw_line function */
     switch (src_bpp) {
     case 1:
-        draw_line = draw_line8_funcs[ds_depth_index];
+        draw_line = draw_line8_funcs[dst_depth_index];
         break;
     case 2:
-        draw_line = draw_line16_funcs[ds_depth_index];
+        draw_line = draw_line16_funcs[dst_depth_index];
         break;
     case 4:
-        draw_line = draw_line32_funcs[ds_depth_index];
+        draw_line = draw_line32_funcs[dst_depth_index];
         break;
     default:
         printf("sm501 draw crt : invalid DC_CRT_CONTROL=%x.\n",
@@ -1343,7 +1343,7 @@ static void sm501_draw_crt(SM501State *s)
     /* set up to draw hardware cursor */
     if (is_hwc_enabled(s, 1)) {
         /* choose cursor draw line function */
-        draw_hwc_line = draw_hwc_line_funcs[ds_depth_index];
+        draw_hwc_line = draw_hwc_line_funcs[dst_depth_index];
         hwc_src = get_hwc_address(s, 1);
         c_x = get_hwc_x(s, 1);
         c_y = get_hwc_y(s, 1);
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index fa0d6a9..a60abad 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -96,7 +96,7 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(uint8_t *d, const uint8_t *s,
                  int width, const uint8_t *palette, int c_x, int c_y)
 {
     int i;
-    uint8_t bitset = 0;
+    uint8_t r, g, b, v, bitset = 0;
 
     /* get cursor position */
     assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
@@ -104,8 +104,6 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(uint8_t *d, const uint8_t *s,
     d += c_x * BPP;
 
     for (i = 0; i < SM501_HWC_WIDTH && c_x + i < width; i++) {
-        uint8_t v;
-
         /* get pixel value */
         if (i % 4 == 0) {
             bitset = ldub_p(s);
@@ -117,9 +115,9 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(uint8_t *d, const uint8_t *s,
         /* write pixel */
         if (v) {
             v--;
-            uint8_t r = palette[v * 3 + 0];
-            uint8_t g = palette[v * 3 + 1];
-            uint8_t b = palette[v * 3 + 2];
+            r = palette[v * 3 + 0];
+            g = palette[v * 3 + 1];
+            b = palette[v * 3 + 2];
             *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
         }
         d += BPP;
-- 
2.7.4
