Received: from eggs.gnu.org ([2001:4830:134:3::10]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEG-0008Fv-RB
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEF-0007AW-Ua
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:14 +0100
Message-Id: <1505580378-9044-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] hw/gpio/omap_gpio.c: Don't use old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Drop the use of old_mmio in the omap2_gpio memory ops.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
