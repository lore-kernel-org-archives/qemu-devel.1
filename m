Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fDy1Z-0007C5-Aq
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1fDy1W-0007qB-UM
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:49 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1fDy1W-0007pp-IU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:06:46 -0400
Received: by mail-lf0-x244.google.com with SMTP id y72-v6so8945785lfd.2
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 13:06:46 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed,  2 May 2018 22:06:40 +0200
Message-Id: <20180502200640.22635-3-frasse.iglesias@gmail.com>
In-Reply-To: <20180502200640.22635-1-frasse.iglesias@gmail.com>
References: <20180502200640.22635-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] xlnx-zynqmp: Connect the ZynqMP GDMA
 and ADMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, alistair23@gmail.com, francisco.iglesias@feimtech.se, peter.maydell@linaro.org

The ZynqMP contains two instances of a generic DMA, the GDMA, located in the
FPD (full power domain), and the ADMA, located in LPD (low power domain).  This
patch adds these two DMAs to the ZynqMP board.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/arm/xlnx-zynqmp.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  5 +++++
 2 files changed, 58 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 505253e0d2..2045b9d71e 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -90,6 +90,24 @@ static const int spi_intr[XLNX_ZYNQMP_NUM_SPIS] = {
     19, 20,
 };
 
+static const uint64_t gdma_ch_addr[XLNX_ZYNQMP_NUM_GDMA_CH] = {
+    0xFD500000, 0xFD510000, 0xFD520000, 0xFD530000,
+    0xFD540000, 0xFD550000, 0xFD560000, 0xFD570000
+};
+
+static const int gdma_ch_intr[XLNX_ZYNQMP_NUM_GDMA_CH] = {
+    124, 125, 126, 127, 128, 129, 130, 131
+};
+
+static const uint64_t adma_ch_addr[XLNX_ZYNQMP_NUM_ADMA_CH] = {
+    0xFFA80000, 0xFFA90000, 0xFFAA0000, 0xFFAB0000,
+    0xFFAC0000, 0xFFAD0000, 0xFFAE0000, 0xFFAF0000
+};
+
+static const int adma_ch_intr[XLNX_ZYNQMP_NUM_ADMA_CH] = {
+    77, 78, 79, 80, 81, 82, 83, 84
+};
+
 typedef struct XlnxZynqMPGICRegion {
     int region_index;
     uint32_t address;
@@ -197,6 +215,16 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize(&s->rtc, sizeof(s->rtc), TYPE_XLNX_ZYNQMP_RTC);
     qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
+        object_initialize(&s->gdma[i], sizeof(s->gdma[i]), TYPE_XLNX_ZDMA);
+        qdev_set_parent_bus(DEVICE(&s->gdma[i]), sysbus_get_default());
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
+        object_initialize(&s->adma[i], sizeof(s->adma[i]), TYPE_XLNX_ZDMA);
+        qdev_set_parent_bus(DEVICE(&s->adma[i]), sysbus_get_default());
+    }
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -492,6 +520,31 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
+        object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
+        object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gdma[i]), 0, gdma_ch_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gdma[i]), 0,
+                           gic_spi[gdma_ch_intr[i]]);
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
+        object_property_set_bool(OBJECT(&s->adma[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->adma[i]), 0, adma_ch_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->adma[i]), 0,
+                           gic_spi[adma_ch_intr[i]]);
+    }
 }
 
 static Property xlnx_zynqmp_props[] = {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 3b613e364d..82b6ec2486 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -27,6 +27,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
+#include "hw/dma/xlnx-zdma.h"
 #include "hw/display/xlnx_dp.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
@@ -41,6 +42,8 @@
 #define XLNX_ZYNQMP_NUM_UARTS 2
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
+#define XLNX_ZYNQMP_NUM_GDMA_CH 8
+#define XLNX_ZYNQMP_NUM_ADMA_CH 8
 
 #define XLNX_ZYNQMP_NUM_QSPI_BUS 2
 #define XLNX_ZYNQMP_NUM_QSPI_BUS_CS 2
@@ -94,6 +97,8 @@ typedef struct XlnxZynqMPState {
     XlnxDPDMAState dpdma;
     XlnxZynqMPIPI ipi;
     XlnxZynqMPRTC rtc;
+    XlnxZDMA gdma[XLNX_ZYNQMP_NUM_GDMA_CH];
+    XlnxZDMA adma[XLNX_ZYNQMP_NUM_ADMA_CH];
 
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
-- 
2.11.0
