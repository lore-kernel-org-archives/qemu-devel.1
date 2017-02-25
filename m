Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckIO2-0003HW-3P
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckINz-0000ut-HA
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:42:50 -0500
Message-Id: <6003064214f099ab5ec9625e356543b22f01b9cf.1488665935.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 25 Feb 2017 19:46:03 +0100
Subject: [Qemu-devel] [PATCH v4 07/13] sm501: Fix device endianness
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

We only emulate the sysbus device in its default LE mode and PCI is LE
as well so specify this for registers. Colors were also off on both
SH4 and PPC which is also fixed here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---

v2: Split off small clean up to other patch
v4: Set serial part to little endian as well

 hw/display/sm501.c          |  8 ++++----
 hw/display/sm501_template.h | 23 ++++++++++++++---------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index c92a5fa..a628ef1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -850,7 +850,7 @@ static const MemoryRegionOps sm501_system_config_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
@@ -1086,7 +1086,7 @@ static const MemoryRegionOps sm501_disp_ctrl_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
@@ -1174,7 +1174,7 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 /* draw line functions for all console modes */
@@ -1510,7 +1510,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     if (s->chr_state) {
         serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
                        NULL, /* TODO : chain irq to IRL */
-                       115200, s->chr_state, DEVICE_NATIVE_ENDIAN);
+                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
     }
 }
 
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index 832ee61..6e56baf 100644
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
-- 
2.7.4
