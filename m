Received: from eggs.gnu.org ([2001:4830:134:3::10]:55661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMK-0006IE-9P
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMH-0001F4-S1
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:16 -0500
Message-Id: <a13bb1390c140d5c7cdbf13bd22b2db2a0723e2a.1488504063.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 25 Feb 2017 20:25:11 +0100
Subject: [Qemu-devel] [PATCH v3 10/13] sm501: Add support for panel layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

v2: Split off renaming a variable to separate clean up patch

 hw/display/sm501.c | 63 +++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 30b9135..607eddc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2,6 +2,7 @@
  * QEMU SM501 Device
  *
  * Copyright (c) 2008 Shin-ichiro KAWASAKI
+ * Copyright (c) 2016 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -42,8 +43,11 @@
  *   - Minimum implementation for Linux console : mmio regs and CRT layer.
  *   - 2D graphics acceleration partially supported : only fill rectangle.
  *
- * TODO:
+ * Status: 2016/12/04
+ *   - Misc fixes: endianness, hardware cursor
  *   - Panel support
+ *
+ * TODO:
  *   - Touch panel support
  *   - USB support
  *   - UART support
@@ -1301,18 +1305,16 @@ static inline int get_depth_index(DisplaySurface *surface)
     }
 }
 
-static void sm501_draw_crt(SM501State *s)
+static void sm501_update_display(void *opaque)
 {
+    SM501State *s = (SM501State *)opaque;
     DisplaySurface *surface = qemu_console_surface(s->con);
     int y, c_x, c_y;
-    uint8_t *hwc_src, *src = s->local_mem;
-    int width = get_width(s, 1);
-    int height = get_height(s, 1);
-    int src_bpp = get_bpp(s, 1);
+    int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
+    int width = get_width(s, crt);
+    int height = get_height(s, crt);
+    int src_bpp = get_bpp(s, crt);
     int dst_bpp = surface_bytes_per_pixel(surface);
-    uint32_t *palette = (uint32_t *)&s->dc_palette[SM501_DC_CRT_PALETTE -
-                                                   SM501_DC_PANEL_PALETTE];
-    uint8_t hwc_palette[3 * 3];
     int dst_depth_index = get_depth_index(surface);
     draw_line_func *draw_line = NULL;
     draw_hwc_line_func *draw_hwc_line = NULL;
@@ -1320,7 +1322,19 @@ static void sm501_draw_crt(SM501State *s)
     int y_start = -1;
     ram_addr_t page_min = ~0l;
     ram_addr_t page_max = 0l;
-    ram_addr_t offset = 0;
+    ram_addr_t offset;
+    uint32_t *palette;
+    uint8_t hwc_palette[3 * 3];
+    uint8_t *hwc_src;
+
+    if (!((crt ? s->dc_crt_control : s->dc_panel_control)
+          & SM501_DC_CRT_CONTROL_ENABLE)) {
+        return;
+    }
+
+    palette = (uint32_t *)(crt ? &s->dc_palette[SM501_DC_CRT_PALETTE -
+                                                SM501_DC_PANEL_PALETTE]
+                               : &s->dc_palette[0]);
 
     /* choose draw_line function */
     switch (src_bpp) {
@@ -1334,20 +1348,19 @@ static void sm501_draw_crt(SM501State *s)
         draw_line = draw_line32_funcs[dst_depth_index];
         break;
     default:
-        printf("sm501 draw crt : invalid DC_CRT_CONTROL=%x.\n",
-               s->dc_crt_control);
+        printf("sm501 update display : invalid control register value.\n");
         abort();
         break;
     }
 
     /* set up to draw hardware cursor */
-    if (is_hwc_enabled(s, 1)) {
+    if (is_hwc_enabled(s, crt)) {
         /* choose cursor draw line function */
         draw_hwc_line = draw_hwc_line_funcs[dst_depth_index];
-        hwc_src = get_hwc_address(s, 1);
-        c_x = get_hwc_x(s, 1);
-        c_y = get_hwc_y(s, 1);
-        get_hwc_palette(s, 1, hwc_palette);
+        hwc_src = get_hwc_address(s, crt);
+        c_x = get_hwc_x(s, crt);
+        c_y = get_hwc_y(s, crt);
+        get_hwc_palette(s, crt, hwc_palette);
     }
 
     /* adjust console size */
@@ -1361,7 +1374,7 @@ static void sm501_draw_crt(SM501State *s)
 
     /* draw each line according to conditions */
     memory_region_sync_dirty_bitmap(&s->local_mem_region);
-    for (y = 0; y < height; y++) {
+    for (y = 0, offset = 0; y < height; y++, offset += width * src_bpp) {
         int update, update_hwc;
         ram_addr_t page0 = offset;
         ram_addr_t page1 = offset + width * src_bpp - 1;
@@ -1379,7 +1392,7 @@ static void sm501_draw_crt(SM501State *s)
             d +=  y * width * dst_bpp;
 
             /* draw graphics layer */
-            draw_line(d, src, width, palette);
+            draw_line(d, s->local_mem + offset, width, palette);
 
             /* draw hardware cursor */
             if (update_hwc) {
@@ -1402,9 +1415,6 @@ static void sm501_draw_crt(SM501State *s)
                 y_start = -1;
             }
         }
-
-        src += width * src_bpp;
-        offset += width * src_bpp;
     }
 
     /* complete flush to display */
@@ -1420,15 +1430,6 @@ static void sm501_draw_crt(SM501State *s)
     }
 }
 
-static void sm501_update_display(void *opaque)
-{
-    SM501State *s = (SM501State *)opaque;
-
-    if (s->dc_crt_control & SM501_DC_CRT_CONTROL_ENABLE) {
-        sm501_draw_crt(s);
-    }
-}
-
 static const GraphicHwOps sm501_ops = {
     .gfx_update  = sm501_update_display,
 };
-- 
2.7.4
