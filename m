Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOca-0004w9-Um
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eCOca-0002z7-1n
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:16 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:50776
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eCOcZ-0002xY-Mu
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:34:15 -0500
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed,  8 Nov 2017 12:32:43 +0100
Message-Id: <1510140763-18256-3-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
References: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.12 2/2] xlnx-zynqmp: add the timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, edgar.iglesias@gmail.com, peter.maydell@linaro.org, frederic.konrad@adacore.com

This adds the TTC to the xlnx-zynqmp board according to the ultrascale TRM.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/arm/xlnx-zynqmp.c         | 25 +++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 2b27daf..bd26a46 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -78,6 +78,14 @@ static const int spi_intr[XLNX_ZYNQMP_NUM_SPIS] = {
     19, 20,
 };
 
+static const uint64_t ttc_addr[XLNX_ZYNQMP_NUM_TTC] = {
+    0xFF110000, 0xFF120000, 0xFF130000, 0xFF140000,
+};
+
+static const uint64_t ttc_intr[XLNX_ZYNQMP_NUM_TTC] = {
+    36, 39, 42, 45,
+};
+
 typedef struct XlnxZynqMPGICRegion {
     int region_index;
     uint32_t address;
@@ -174,6 +182,11 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
     qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_TTC; i++) {
+        object_initialize(&s->ttc[i], sizeof(s->ttc[i]), TYPE_CADENCE_TTC);
+        qdev_set_parent_bus(DEVICE(&s->ttc[i]), sysbus_get_default());
+    }
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -422,6 +435,18 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
+
+    for (i = 0; i < XLNX_ZYNQMP_NUM_TTC; i++) {
+        object_property_set_bool(OBJECT(&s->ttc[i]), true, "realized", &err);
+
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ttc[i]), 0, ttc_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ttc[i]), 0,
+                           gic_spi[ttc_intr[i]]);
+    }
 }
 
 static Property xlnx_zynqmp_props[] = {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 6eff81a..9a20f6e 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -28,6 +28,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/display/xlnx_dp.h"
+#include "hw/timer/cadence_ttc.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -39,6 +40,7 @@
 #define XLNX_ZYNQMP_NUM_UARTS 2
 #define XLNX_ZYNQMP_NUM_SDHCI 2
 #define XLNX_ZYNQMP_NUM_SPIS 2
+#define XLNX_ZYNQMP_NUM_TTC 4
 
 #define XLNX_ZYNQMP_NUM_OCM_BANKS 4
 #define XLNX_ZYNQMP_OCM_RAM_0_ADDRESS 0xFFFC0000
@@ -85,6 +87,7 @@ typedef struct XlnxZynqMPState {
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
+    CadenceTTCState ttc[XLNX_ZYNQMP_NUM_TTC];
 
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
-- 
1.8.3.1
