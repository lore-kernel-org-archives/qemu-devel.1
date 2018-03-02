Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWT-0002kr-RS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWS-0004kc-JF
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWS-0004kH-Bs
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWR-0001Ix-7p
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:04 +0000
Message-Id: <20180302110640.28004-4-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/39] xlnx-zynqmp: Connect the RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h |  2 ++
 hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 0a2b037c6b..3b613e364d 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -29,6 +29,7 @@
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/display/xlnx_dp.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
+#include "hw/timer/xlnx-zynqmp-rtc.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -92,6 +93,7 @@ typedef struct XlnxZynqMPState {
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
     XlnxZynqMPIPI ipi;
+    XlnxZynqMPRTC rtc;
 
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 4b93a3abd2..69227fd4c9 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -53,6 +53,9 @@
 #define IPI_ADDR            0xFF300000
 #define IPI_IRQ             64
 
+#define RTC_ADDR            0xffa60000
+#define RTC_IRQ             26
+
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Datasheet: UG1085 (v1.7) */
 
 static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] = {
@@ -191,6 +194,9 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize(&s->ipi, sizeof(s->ipi), TYPE_XLNX_ZYNQMP_IPI);
     qdev_set_parent_bus(DEVICE(&s->ipi), sysbus_get_default());
+
+    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_XLNX_ZYNQMP_RTC);
+    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -476,6 +482,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
+
+    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
 }
 
 static Property xlnx_zynqmp_props[] = {
-- 
2.16.2
