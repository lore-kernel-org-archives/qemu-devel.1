Received: from eggs.gnu.org ([2001:4830:134:3::10]:42034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYP-0004NB-5C
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cktYL-0007Wq-77
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cktYK-0007WQ-Uq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:23:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Mar 2017 15:23:50 +0100
Message-Id: <1488810230-31945-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
References: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] sm501: drop sm501_template.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Now that we include sm501_template.h only once there
is no need to keep this stuff in a separate file.

FIXME: as peter mentioned the TARGET_WORDS_BIGENDIAN dependency looks
       suspious.  Left as-is for now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c          | 110 +++++++++++++++++++++++++++++----
 hw/display/sm501_template.h | 145 --------------------------------------------
 2 files changed, 98 insertions(+), 157 deletions(-)
 delete mode 100644 hw/display/sm501_template.h

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6c7717c..44171c1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1170,11 +1170,101 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
 typedef void draw_line_func(uint8_t *d, const uint8_t *s,
 			    int width, const uint32_t *pal);
 
-typedef void draw_hwc_line_func(SM501State * s, int crt, uint8_t * palette,
-                                int c_y, uint8_t *d, int width);
+static void draw_line8(uint8_t *d, const uint8_t *s,
+                       int width, const uint32_t *pal)
+{
+    uint8_t v, r, g, b;
+    do {
+        v = ldub_p(s);
+        r = (pal[v] >> 16) & 0xff;
+        g = (pal[v] >>  8) & 0xff;
+        b = (pal[v] >>  0) & 0xff;
+        ((uint32_t *) d)[0] = rgb_to_pixel32(r, g, b);
+        s ++;
+        d += 4;
+    } while (-- width != 0);
+}
 
-#define DEPTH 32
-#include "sm501_template.h"
+static void draw_line16(uint8_t *d, const uint8_t *s,
+                        int width, const uint32_t *pal)
+{
+    uint16_t rgb565;
+    uint8_t r, g, b;
+
+    do {
+        rgb565 = lduw_p(s);
+        r = ((rgb565 >> 11) & 0x1f) << 3;
+        g = ((rgb565 >>  5) & 0x3f) << 2;
+        b = ((rgb565 >>  0) & 0x1f) << 3;
+        ((uint32_t *) d)[0] = rgb_to_pixel32(r, g, b);
+        s += 2;
+        d += 4;
+    } while (-- width != 0);
+}
+
+static void draw_line32(uint8_t *d, const uint8_t *s,
+                        int width, const uint32_t *pal)
+{
+    uint8_t r, g, b;
+
+    do {
+        ldub_p(s);
+#if defined(TARGET_WORDS_BIGENDIAN)
+        r = s[1];
+        g = s[2];
+        b = s[3];
+#else
+        b = s[0];
+        g = s[1];
+        r = s[2];
+#endif
+        ((uint32_t *) d)[0] = rgb_to_pixel32(r, g, b);
+        s += 4;
+        d += 4;
+    } while (-- width != 0);
+}
+
+/**
+ * Draw hardware cursor image on the given line.
+ */
+static void draw_hwc_line(SM501State * s, int crt,
+                          uint8_t * palette, int c_y, uint8_t *d, int width)
+{
+    int x, i;
+    uint8_t bitset = 0;
+
+    /* get hardware cursor pattern */
+    uint32_t cursor_addr = get_hwc_address(s, crt);
+    assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
+    cursor_addr += 64 * c_y / 4;  /* 4 pixels per byte */
+    cursor_addr += s->base;
+
+    /* get cursor position */
+    x = get_hwc_x(s, crt);
+    d += x * 4;
+
+    for (i = 0; i < SM501_HWC_WIDTH && x + i < width; i++) {
+        uint8_t v;
+
+        /* get pixel value */
+        if (i % 4 == 0) {
+            bitset = ldub_phys(&address_space_memory, cursor_addr);
+            cursor_addr++;
+        }
+        v = bitset & 3;
+        bitset >>= 2;
+
+        /* write pixel */
+        if (v) {
+            v--;
+            uint8_t r = palette[v * 3 + 0];
+            uint8_t g = palette[v * 3 + 1];
+            uint8_t b = palette[v * 3 + 2];
+            ((uint32_t *) d)[0] = rgb_to_pixel32(r, g, b);
+        }
+        d += 4;
+    }
+}
 
 static void sm501_draw_crt(SM501State * s)
 {
@@ -1190,7 +1280,6 @@ static void sm501_draw_crt(SM501State * s)
 						    - SM501_DC_PANEL_PALETTE];
     uint8_t hwc_palette[3 * 3];
     draw_line_func * draw_line = NULL;
-    draw_hwc_line_func * draw_hwc_line = NULL;
     int full_update = 0;
     int y_start = -1;
     ram_addr_t page_min = ~0l;
@@ -1201,15 +1290,15 @@ static void sm501_draw_crt(SM501State * s)
     switch (s->dc_crt_control & 3) {
     case SM501_DC_CRT_CONTROL_8BPP:
 	src_bpp = 1;
-	draw_line = draw_line8_32;
+	draw_line = draw_line8;
 	break;
     case SM501_DC_CRT_CONTROL_16BPP:
 	src_bpp = 2;
-	draw_line = draw_line16_32;
+	draw_line = draw_line16;
 	break;
     case SM501_DC_CRT_CONTROL_32BPP:
 	src_bpp = 4;
-	draw_line = draw_line32_32;
+	draw_line = draw_line32;
 	break;
     default:
 	printf("sm501 draw crt : invalid DC_CRT_CONTROL=%x.\n",
@@ -1229,9 +1318,6 @@ static void sm501_draw_crt(SM501State * s)
             hwc_palette[i * 3 + 1] = (rgb565 & 0x07e0) >> 3; /* green */
             hwc_palette[i * 3 + 2] = (rgb565 & 0x001f) << 3; /* blue */
         }
-
-        /* choose cursor draw line function */
-        draw_hwc_line = draw_hwc_line_32;
     }
 
     /* adjust console size */
@@ -1246,7 +1332,7 @@ static void sm501_draw_crt(SM501State * s)
     /* draw each line according to conditions */
     memory_region_sync_dirty_bitmap(&s->local_mem_region);
     for (y = 0; y < height; y++) {
-	int update_hwc = draw_hwc_line ? within_hwc_y_range(s, y, 1) : 0;
+	int update_hwc = is_hwc_enabled(s, 1) && within_hwc_y_range(s, y, 1);
 	int update = full_update || update_hwc;
         ram_addr_t page0 = offset;
         ram_addr_t page1 = offset + width * src_bpp - 1;
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
deleted file mode 100644
index f33e499..0000000
--- a/hw/display/sm501_template.h
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * Pixel drawing function templates for QEMU SM501 Device
- *
- * Copyright (c) 2008 Shin-ichiro KAWASAKI
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#if DEPTH == 8
-#define BPP 1
-#define PIXEL_TYPE uint8_t
-#elif DEPTH == 15 || DEPTH == 16
-#define BPP 2
-#define PIXEL_TYPE uint16_t
-#elif DEPTH == 32
-#define BPP 4
-#define PIXEL_TYPE uint32_t
-#else
-#error unsupport depth
-#endif
-
-#ifdef BGR_FORMAT
-#define PIXEL_NAME glue(DEPTH, bgr)
-#else
-#define PIXEL_NAME DEPTH
-#endif /* BGR_FORMAT */
-
-
-static void glue(draw_line8_, PIXEL_NAME)(
-                 uint8_t *d, const uint8_t *s, int width, const uint32_t *pal)
-{
-    uint8_t v, r, g, b;
-    do {
-	v = ldub_p(s);
-	r = (pal[v] >> 16) & 0xff;
-	g = (pal[v] >>  8) & 0xff;
-	b = (pal[v] >>  0) & 0xff;
-	((PIXEL_TYPE *) d)[0] = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
-	s ++;
-	d += BPP;
-    } while (-- width != 0);
-}
-
-static void glue(draw_line16_, PIXEL_NAME)(
-		 uint8_t *d, const uint8_t *s, int width, const uint32_t *pal)
-{
-    uint16_t rgb565;
-    uint8_t r, g, b;
-
-    do {
-	rgb565 = lduw_p(s);
-	r = ((rgb565 >> 11) & 0x1f) << 3;
-	g = ((rgb565 >>  5) & 0x3f) << 2;
-	b = ((rgb565 >>  0) & 0x1f) << 3;
-	((PIXEL_TYPE *) d)[0] = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
-	s += 2;
-	d += BPP;
-    } while (-- width != 0);
-}
-
-static void glue(draw_line32_, PIXEL_NAME)(
-		 uint8_t *d, const uint8_t *s, int width, const uint32_t *pal)
-{
-    uint8_t r, g, b;
-
-    do {
-	ldub_p(s);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        r = s[1];
-        g = s[2];
-        b = s[3];
-#else
-        b = s[0];
-        g = s[1];
-        r = s[2];
-#endif
-	((PIXEL_TYPE *) d)[0] = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
-	s += 4;
-	d += BPP;
-    } while (-- width != 0);
-}
-
-/**
- * Draw hardware cursor image on the given line.
- */
-static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State * s, int crt,
-                         uint8_t * palette, int c_y, uint8_t *d, int width)
-{
-    int x, i;
-    uint8_t bitset = 0;
-
-    /* get hardware cursor pattern */
-    uint32_t cursor_addr = get_hwc_address(s, crt);
-    assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
-    cursor_addr += 64 * c_y / 4;  /* 4 pixels per byte */
-    cursor_addr += s->base;
-
-    /* get cursor position */
-    x = get_hwc_x(s, crt);
-    d += x * BPP;
-
-    for (i = 0; i < SM501_HWC_WIDTH && x + i < width; i++) {
-        uint8_t v;
-
-        /* get pixel value */
-        if (i % 4 == 0) {
-            bitset = ldub_phys(&address_space_memory, cursor_addr);
-            cursor_addr++;
-        }
-        v = bitset & 3;
-        bitset >>= 2;
-
-        /* write pixel */
-        if (v) {
-            v--;
-            uint8_t r = palette[v * 3 + 0];
-            uint8_t g = palette[v * 3 + 1];
-            uint8_t b = palette[v * 3 + 2];
-            ((PIXEL_TYPE *) d)[0] = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
-        }
-        d += BPP;
-    }
-}
-
-#undef DEPTH
-#undef BPP
-#undef PIXEL_TYPE
-#undef PIXEL_NAME
-#undef BGR_FORMAT
-- 
1.8.3.1
