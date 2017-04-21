Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1aWD-0001SA-0N
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1d1aW9-0007pL-5e
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:30:44 -0400
Message-Id: <8b9605a569f8bf54074e15903620b18cd9967c89.1492787889.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1492787889.git.balaton@eik.bme.hu>
References: <cover.1492787889.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 21 Apr 2017 17:18:09 +0200
Subject: [Qemu-devel] [PATCH v7 07/13] sm501: Fix device endianness
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
as well so specify this for registers and framebuffer memory.

Note that though the Linux kernel driver has code which claims to
handle both big and little endian, it is obviously bogus for 16 bit
and cannot be trusted as a source of information on the framebuffer
pixel format. This is our best guess about device behaviour based on
the specs and testing with MorphOS that is known to work on real HW.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
---

v2: Split off small clean up to other patch
v4: Set serial part to little endian as well
v5: Make framebuffer always LE as suggested by Peter Maydell
v6: Extended commit message

 hw/display/sm501.c          |  8 ++++----
 hw/display/sm501_template.h | 19 ++++++-------------
 2 files changed, 10 insertions(+), 17 deletions(-)

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
index 832ee61..54807bd 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -64,10 +64,10 @@ static void glue(draw_line16_, PIXEL_NAME)(
     uint8_t r, g, b;
 
     do {
-        rgb565 = lduw_p(s);
-        r = ((rgb565 >> 11) & 0x1f) << 3;
-        g = ((rgb565 >>  5) & 0x3f) << 2;
-        b = ((rgb565 >>  0) & 0x1f) << 3;
+        rgb565 = lduw_le_p(s);
+        r = (rgb565 >> 8) & 0xf8;
+        g = (rgb565 >> 3) & 0xfc;
+        b = (rgb565 << 3) & 0xf8;
         *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
         s += 2;
         d += BPP;
@@ -80,16 +80,9 @@ static void glue(draw_line32_, PIXEL_NAME)(
     uint8_t r, g, b;
 
     do {
-        ldub_p(s);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        r = s[1];
-        g = s[2];
-        b = s[3];
-#else
-        b = s[0];
-        g = s[1];
         r = s[2];
-#endif
+        g = s[1];
+        b = s[0];
         *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
         s += 4;
         d += BPP;
-- 
2.7.4
