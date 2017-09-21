Received: from eggs.gnu.org ([2001:4830:134:3::10]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XR-0003AH-Cy
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XP-0003E0-Gq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XP-0003AT-7N
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XN-0005BQ-W0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:30 +0100
Message-Id: <1506012099-13605-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 22/31] hw/gpio/omap_gpio.c: Don't use old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Drop the use of old_mmio in the omap2_gpio memory ops.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505580378-9044-3-git-send-email-peter.maydell@linaro.org
---
 hw/gpio/omap_gpio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 1df394e..17891e2 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -525,17 +525,23 @@ static void omap2_gpio_module_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint32_t omap2_gpio_module_readp(void *opaque, hwaddr addr)
+static uint64_t omap2_gpio_module_readp(void *opaque, hwaddr addr,
+                                        unsigned size)
 {
     return omap2_gpio_module_read(opaque, addr & ~3) >> ((addr & 3) << 3);
 }
 
 static void omap2_gpio_module_writep(void *opaque, hwaddr addr,
-                uint32_t value)
+                                     uint64_t value, unsigned size)
 {
     uint32_t cur = 0;
     uint32_t mask = 0xffff;
 
+    if (size == 4) {
+        omap2_gpio_module_write(opaque, addr, value);
+        return;
+    }
+
     switch (addr & ~3) {
     case 0x00:	/* GPIO_REVISION */
     case 0x14:	/* GPIO_SYSSTATUS */
@@ -581,18 +587,10 @@ static void omap2_gpio_module_writep(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps omap2_gpio_module_ops = {
-    .old_mmio = {
-        .read = {
-            omap2_gpio_module_readp,
-            omap2_gpio_module_readp,
-            omap2_gpio_module_read,
-        },
-        .write = {
-            omap2_gpio_module_writep,
-            omap2_gpio_module_writep,
-            omap2_gpio_module_write,
-        },
-    },
+    .read = omap2_gpio_module_readp,
+    .write = omap2_gpio_module_writep,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
