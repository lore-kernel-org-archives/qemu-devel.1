Received: from eggs.gnu.org ([2001:4830:134:3::10]:36584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3R-0000Bk-OI
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cfV3O-0008Pv-7L
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1cfV3N-0008P0-S9
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 12:13:42 -0500
Message-Id: <9c4f503401fa3defa5dff8b938a0bee3aa8d89d5.1487522123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1487522123.git.balaton@eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 19 Feb 2017 17:35:23 +0100
Subject: [Qemu-devel] [PATCH 06/10] sm501: Fix device endianness
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
 hw/display/sm501.c          |  6 +++---
 hw/display/sm501_template.h | 31 ++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9091bb5..3d32a3c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -846,7 +846,7 @@ static const MemoryRegionOps sm501_system_config_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
@@ -1082,7 +1082,7 @@ static const MemoryRegionOps sm501_disp_ctrl_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
@@ -1170,7 +1170,7 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 /* draw line functions for all console modes */
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index 832ee61..5b516d6 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -64,10 +64,16 @@ static void glue(draw_line16_, PIXEL_NAME)(
     uint8_t r, g, b;
 
     do {
-        rgb565 = lduw_p(s);
-        r = ((rgb565 >> 11) & 0x1f) << 3;
-        g = ((rgb565 >>  5) & 0x3f) << 2;
-        b = ((rgb565 >>  0) & 0x1f) << 3;
+        rgb565 = lduw_le_p(s);
+#if defined(TARGET_WORDS_BIGENDIAN)
+        r = (rgb565 >> 8) & 0xf8;
+        g = (rgb565 >> 3) & 0xfc;
+        b = (rgb565 << 3) & 0xf8;
+#else
+        b = (rgb565 >> 8) & 0xf8;
+        g = (rgb565 >> 3) & 0xfc;
+        r = (rgb565 << 3) & 0xf8;
+#endif
         *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
         s += 2;
         d += BPP;
@@ -80,15 +86,14 @@ static void glue(draw_line32_, PIXEL_NAME)(
     uint8_t r, g, b;
 
     do {
-        ldub_p(s);
 #if defined(TARGET_WORDS_BIGENDIAN)
+        r = s[0];
+        g = s[1];
+        b = s[2];
+#else
         r = s[1];
         g = s[2];
         b = s[3];
-#else
-        b = s[0];
-        g = s[1];
-        r = s[2];
 #endif
         *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
         s += 4;
@@ -103,7 +108,7 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
                  uint8_t *palette, int c_y, uint8_t *d, int width)
 {
     int x, i;
-    uint8_t *pixval, bitset = 0;
+    uint8_t *pixval, r, g, b, bitset = 0;
 
     /* get hardware cursor pattern */
     uint32_t cursor_addr = get_hwc_address(s, crt);
@@ -129,9 +134,9 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
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
