Received: from eggs.gnu.org ([2001:4830:134:3::10]:52752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2I-00084x-1g
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2H-00052g-2P
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2G-00050V-R1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK25-0001ki-Aa
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:43 +0000
Message-Id: <20180215135702.1340-3-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/21] hw/arm/aspeed: simplify using the
 'unimplemented device' for aspeed_soc.io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

(qemu) info mtree
 address-space: cpu-memory-0
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
-    000000001e600000-000000001e7fffff (prio -1, i/o): aspeed_soc.io
+    000000001e600000-000000001e7fffff (prio -1000, i/o): aspeed_soc.io
     000000001e620000-000000001e6200ff (prio 0, i/o): aspeed.smc.ast2500-fmc
     000000001e630000-000000001e6300ff (prio 0, i/o): aspeed.smc.ast2500-spi1
     000000001e631000-000000001e6310ff (prio 0, i/o): aspeed.smc.ast2500-spi2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180209085755.30414-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed_soc.c         | 32 +++-----------------------------
 2 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index f26914a2b9..11ec0179db 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -31,7 +31,6 @@ typedef struct AspeedSoCState {
 
     /*< public >*/
     ARMCPU cpu;
-    MemoryRegion iomem;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedTimerCtrlState timerctrl;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 2a5d041b3b..30d25f8b06 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -15,6 +15,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
+#include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial.h"
 #include "qemu/log.h"
@@ -99,31 +100,6 @@ static const AspeedSoCInfo aspeed_socs[] = {
     },
 };
 
-/*
- * IO handlers: simply catch any reads/writes to IO addresses that aren't
- * handled by a device mapping.
- */
-
-static uint64_t aspeed_soc_io_read(void *p, hwaddr offset, unsigned size)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
-                  __func__, offset, size);
-    return 0;
-}
-
-static void aspeed_soc_io_write(void *opaque, hwaddr offset, uint64_t value,
-                unsigned size)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
-                  __func__, offset, value, size);
-}
-
-static const MemoryRegionOps aspeed_soc_io_ops = {
-    .read = aspeed_soc_io_read,
-    .write = aspeed_soc_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void aspeed_soc_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
@@ -199,10 +175,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     Error *err = NULL, *local_err = NULL;
 
     /* IO space */
-    memory_region_init_io(&s->iomem, NULL, &aspeed_soc_io_ops, NULL,
-            "aspeed_soc.io", ASPEED_SOC_IOMEM_SIZE);
-    memory_region_add_subregion_overlap(get_system_memory(),
-                                        ASPEED_SOC_IOMEM_BASE, &s->iomem, -1);
+    create_unimplemented_device("aspeed_soc.io",
+                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_SIZE);
 
     /* CPU */
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-- 
2.16.1
