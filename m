Received: from eggs.gnu.org ([2001:4830:134:3::10]:34565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfUtz-00005s-PP
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfUty-0002ox-7C
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:03:59 -0500
Message-Id: <3d2b6cd3b6200a74cd0db5122cbffb580972987b.1487522123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 19 Feb 2017 17:35:23 +0100
Subject: [Qemu-devel] [PATCH 07/10] sm501: Fix hardware cursor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c          | 169 +++++++++++++++++++++++++-------------------
 hw/display/sm501_template.h |  25 +++----
 2 files changed, 107 insertions(+), 87 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3d32a3c..1bd0303 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -550,6 +550,24 @@ static uint32_t get_local_mem_size_index(uint32_t size)
     return index;
 }
 
+static inline int get_width(SM501State *s, int crt)
+{
+    int width = crt ? s->dc_crt_h_total : s->dc_panel_h_total;
+    return (width & 0x00000FFF) + 1;
+}
+
+static inline int get_height(SM501State *s, int crt)
+{
+    int height = crt ? s->dc_crt_v_total : s->dc_panel_v_total;
+    return (height & 0x00000FFF) + 1;
+}
+
+static inline int get_bpp(SM501State *s, int crt)
+{
+    int bpp = crt ? s->dc_crt_control : s->dc_panel_control;
+    return (8 << (bpp & 3)) / 8;
+}
+
 /**
  * Check the availability of hardware cursor.
  * @param crt  0 for PANEL, 1 for CRT.
@@ -564,10 +582,10 @@ static inline int is_hwc_enabled(SM501State *state, int crt)
  * Get the address which holds cursor pattern data.
  * @param crt  0 for PANEL, 1 for CRT.
  */
-static inline uint32_t get_hwc_address(SM501State *state, int crt)
+static inline uint8_t *get_hwc_address(SM501State *state, int crt)
 {
     uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
-    return (addr & 0x03FFFFF0)/* >> 4*/;
+    return state->local_mem + (addr & 0x03FFFFF0);
 }
 
 /**
@@ -593,50 +611,48 @@ static inline uint32_t get_hwc_x(SM501State *state, int crt)
 }
 
 /**
- * Get the cursor position in x coordinate.
+ * Get the hardware cursor palette.
  * @param crt  0 for PANEL, 1 for CRT.
- * @param index  0, 1, 2 or 3 which specifies color of corsor dot.
+ * @param palette  pointer to a [3 * 3] array to store color values in
  */
-static inline uint16_t get_hwc_color(SM501State *state, int crt, int index)
+static inline void get_hwc_palette(SM501State *state, int crt, uint8_t *palette)
 {
-    uint32_t color_reg = 0;
-    uint16_t color_565 = 0;
-
-    if (index == 0) {
-        return 0;
-    }
-
-    switch (index) {
-    case 1:
-    case 2:
-        color_reg = crt ? state->dc_crt_hwc_color_1_2
-                        : state->dc_panel_hwc_color_1_2;
-        break;
-    case 3:
-        color_reg = crt ? state->dc_crt_hwc_color_3
-                        : state->dc_panel_hwc_color_3;
-        break;
-    default:
-        printf("invalid hw cursor color.\n");
-        abort();
-    }
+    int i;
+    uint32_t color_reg;
+    uint16_t rgb565;
+
+    for (i = 0; i < 3; i++) {
+        if (i + 1 == 3) {
+            color_reg = crt ? state->dc_crt_hwc_color_3
+                            : state->dc_panel_hwc_color_3;
+        } else {
+            color_reg = crt ? state->dc_crt_hwc_color_1_2
+                            : state->dc_panel_hwc_color_1_2;
+        }
 
-    switch (index) {
-    case 1:
-    case 3:
-        color_565 = (uint16_t)(color_reg & 0xFFFF);
-        break;
-    case 2:
-        color_565 = (uint16_t)((color_reg >> 16) & 0xFFFF);
-        break;
+        if (i + 1 == 2) {
+            rgb565 = (color_reg >> 16) & 0xFFFF;
+        } else {
+            rgb565 = color_reg & 0xFFFF;
+        }
+        palette[i * 3 + 0] = (rgb565 << 3) & 0xf8; /* red */
+        palette[i * 3 + 1] = (rgb565 >> 3) & 0xfc; /* green */
+        palette[i * 3 + 2] = (rgb565 >> 8) & 0xf8; /* blue */
     }
-    return color_565;
 }
 
-static int within_hwc_y_range(SM501State *state, int y, int crt)
+static inline void hwc_invalidate(SM501State *s, int crt)
 {
-    int hwc_y = get_hwc_y(state, crt);
-    return (hwc_y <= y && y < hwc_y + SM501_HWC_HEIGHT);
+    int w = get_width(s, crt);
+    int h = get_height(s, crt);
+    int bpp = get_bpp(s, crt);
+    int start = get_hwc_y(s, crt);
+    int end = MIN(h, start + SM501_HWC_HEIGHT) + 1;
+
+    start *= w * bpp;
+    end *= w * bpp;
+
+    memory_region_set_dirty(&s->local_mem_region, start, end - start);
 }
 
 static void sm501_2d_operation(SM501State *s)
@@ -1017,10 +1033,18 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         break;
 
     case SM501_DC_PANEL_HWC_ADDR:
-        s->dc_panel_hwc_addr = value & 0x8FFFFFF0;
+        value &= 0x8FFFFFF0;
+        if (value != s->dc_panel_hwc_addr) {
+            hwc_invalidate(s, 0);
+            s->dc_panel_hwc_addr = value;
+        }
         break;
     case SM501_DC_PANEL_HWC_LOC:
-        s->dc_panel_hwc_location = value & 0x0FFF0FFF;
+        value &= 0x0FFF0FFF;
+        if (value != s->dc_panel_hwc_location) {
+            hwc_invalidate(s, 0);
+            s->dc_panel_hwc_location = value;
+        }
         break;
     case SM501_DC_PANEL_HWC_COLOR_1_2:
         s->dc_panel_hwc_color_1_2 = value;
@@ -1052,10 +1076,18 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
         break;
 
     case SM501_DC_CRT_HWC_ADDR:
-        s->dc_crt_hwc_addr = value & 0x8FFFFFF0;
+        value &= 0x8FFFFFF0;
+        if (value != s->dc_crt_hwc_addr) {
+            hwc_invalidate(s, 1);
+            s->dc_crt_hwc_addr = value;
+        }
         break;
     case SM501_DC_CRT_HWC_LOC:
-        s->dc_crt_hwc_location = value & 0x0FFF0FFF;
+        value &= 0x0FFF0FFF;
+        if (value != s->dc_crt_hwc_location) {
+            hwc_invalidate(s, 1);
+            s->dc_crt_hwc_location = value;
+        }
         break;
     case SM501_DC_CRT_HWC_COLOR_1_2:
         s->dc_crt_hwc_color_1_2 = value;
@@ -1178,8 +1210,9 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
 typedef void draw_line_func(uint8_t *d, const uint8_t *s,
                             int width, const uint32_t *pal);
 
-typedef void draw_hwc_line_func(SM501State *s, int crt, uint8_t *palette,
-                                int c_y, uint8_t *d, int width);
+typedef void draw_hwc_line_func(uint8_t *d, const uint8_t *s,
+                                int width, const uint8_t *palette,
+                                int c_x, int c_y);
 
 #define DEPTH 8
 #include "sm501_template.h"
@@ -1267,12 +1300,11 @@ static inline int get_depth_index(DisplaySurface *surface)
 static void sm501_draw_crt(SM501State *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->con);
-    int y;
-    int width = (s->dc_crt_h_total & 0x00000FFF) + 1;
-    int height = (s->dc_crt_v_total & 0x00000FFF) + 1;
-
-    uint8_t  *src = s->local_mem;
-    int src_bpp = 0;
+    int y, c_x, c_y;
+    uint8_t *hwc_src, *src = s->local_mem;
+    int width = get_width(s, 1);
+    int height = get_height(s, 1);
+    int src_bpp = get_bpp(s, 1);
     int dst_bpp = surface_bytes_per_pixel(surface);
     uint32_t *palette = (uint32_t *)&s->dc_palette[SM501_DC_CRT_PALETTE -
                                                    SM501_DC_PANEL_PALETTE];
@@ -1287,17 +1319,14 @@ static void sm501_draw_crt(SM501State *s)
     ram_addr_t offset = 0;
 
     /* choose draw_line function */
-    switch (s->dc_crt_control & 3) {
-    case SM501_DC_CRT_CONTROL_8BPP:
-        src_bpp = 1;
+    switch (src_bpp) {
+    case 1:
         draw_line = draw_line8_funcs[ds_depth_index];
         break;
-    case SM501_DC_CRT_CONTROL_16BPP:
-        src_bpp = 2;
+    case 2:
         draw_line = draw_line16_funcs[ds_depth_index];
         break;
-    case SM501_DC_CRT_CONTROL_32BPP:
-        src_bpp = 4;
+    case 4:
         draw_line = draw_line32_funcs[ds_depth_index];
         break;
     default:
@@ -1309,18 +1338,12 @@ static void sm501_draw_crt(SM501State *s)
 
     /* set up to draw hardware cursor */
     if (is_hwc_enabled(s, 1)) {
-        int i;
-
-        /* get cursor palette */
-        for (i = 0; i < 3; i++) {
-            uint16_t rgb565 = get_hwc_color(s, 1, i + 1);
-            hwc_palette[i * 3 + 0] = (rgb565 & 0xf800) >> 8; /* red */
-            hwc_palette[i * 3 + 1] = (rgb565 & 0x07e0) >> 3; /* green */
-            hwc_palette[i * 3 + 2] = (rgb565 & 0x001f) << 3; /* blue */
-        }
-
         /* choose cursor draw line function */
         draw_hwc_line = draw_hwc_line_funcs[ds_depth_index];
+        hwc_src = get_hwc_address(s, 1);
+        c_x = get_hwc_x(s, 1);
+        c_y = get_hwc_y(s, 1);
+        get_hwc_palette(s, 1, hwc_palette);
     }
 
     /* adjust console size */
@@ -1335,14 +1358,16 @@ static void sm501_draw_crt(SM501State *s)
     /* draw each line according to conditions */
     memory_region_sync_dirty_bitmap(&s->local_mem_region);
     for (y = 0; y < height; y++) {
-        int update_hwc = draw_hwc_line ? within_hwc_y_range(s, y, 1) : 0;
-        int update = full_update || update_hwc;
+        int update, update_hwc;
         ram_addr_t page0 = offset;
         ram_addr_t page1 = offset + width * src_bpp - 1;
 
+        /* check if hardware cursor is enabled and we're within its range */
+        update_hwc = draw_hwc_line && c_y <= y && y < c_y + SM501_HWC_HEIGHT;
+        update = full_update || update_hwc;
         /* check dirty flags for each line */
-        update = memory_region_get_dirty(&s->local_mem_region, page0,
-                                         page1 - page0, DIRTY_MEMORY_VGA);
+        update |= memory_region_get_dirty(&s->local_mem_region, page0,
+                                          page1 - page0, DIRTY_MEMORY_VGA);
 
         /* draw line and change status */
         if (update) {
@@ -1354,7 +1379,7 @@ static void sm501_draw_crt(SM501State *s)
 
             /* draw hardware cursor */
             if (update_hwc) {
-                draw_hwc_line(s, 1, hwc_palette, y - get_hwc_y(s, 1), d, width);
+                draw_hwc_line(d, hwc_src, width, hwc_palette, c_x, y - c_y);
             }
 
             if (y_start < 0) {
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index 5b516d6..bd37576 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -104,29 +104,24 @@ static void glue(draw_line32_, PIXEL_NAME)(
 /**
  * Draw hardware cursor image on the given line.
  */
-static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
-                 uint8_t *palette, int c_y, uint8_t *d, int width)
+static void glue(draw_hwc_line_, PIXEL_NAME)(uint8_t *d, const uint8_t *s,
+                 int width, const uint8_t *palette, int c_x, int c_y)
 {
-    int x, i;
-    uint8_t *pixval, r, g, b, bitset = 0;
-
-    /* get hardware cursor pattern */
-    uint32_t cursor_addr = get_hwc_address(s, crt);
-    assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
-    cursor_addr += SM501_HWC_WIDTH * c_y / 4;  /* 4 pixels per byte */
-    pixval = s->local_mem + cursor_addr;
+    int i;
+    uint8_t r, g, b, bitset = 0;
 
     /* get cursor position */
-    x = get_hwc_x(s, crt);
-    d += x * BPP;
+    assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
+    s += SM501_HWC_WIDTH * c_y / 4;  /* 4 pixels per byte */
+    d += c_x * BPP;
 
-    for (i = 0; i < SM501_HWC_WIDTH && x + i < width; i++) {
+    for (i = 0; i < SM501_HWC_WIDTH && c_x + i < width; i++) {
         uint8_t v;
 
         /* get pixel value */
         if (i % 4 == 0) {
-            bitset = ldub_p(pixval);
-            pixval++;
+            bitset = ldub_p(s);
+            s++;
         }
         v = bitset & 3;
         bitset >>= 2;
-- 
2.7.4
