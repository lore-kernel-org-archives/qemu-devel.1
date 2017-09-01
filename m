Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7J-0000Xo-M7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7E-0006tH-TB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:41 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 14:00:47 -0700
Message-ID: <75dabbf39e5c9e84a82a6d7a3e82ed4ff247a707.1504293917.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504293917.git.alistair.francis@xilinx.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 6/6] xlnx-zynqmp: Connect the IPI device to
 the ZynqMP SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
 include/hw/arm/xlnx-zynqmp.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 9eceadbdc8..1988cb47f4 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -46,6 +46,9 @@
 #define DPDMA_ADDR          0xfd4c0000
 #define DPDMA_IRQ           116
 
+#define IPI_ADDR            0xFF300000
+#define IPI_IRQ             64
+
 static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] = {
     0xFF0B0000, 0xFF0C0000, 0xFF0D0000, 0xFF0E0000,
 };
@@ -179,6 +182,9 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
     qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
+
+    object_initialize(&s->ipi, sizeof(s->ipi), TYPE_XLNX_ZYNQMP_IPI);
+    qdev_set_parent_bus(DEVICE(&s->ipi), sysbus_get_default());
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -427,6 +433,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
+
+    object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 }
 
 static Property xlnx_zynqmp_props[] = {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c2931bf39c..02a89766e8 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -28,6 +28,7 @@
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/display/xlnx_dp.h"
+#include "hw/intc/xlnx-zynqmp-ipi.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -85,6 +86,7 @@ typedef struct XlnxZynqMPState {
     XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
     XlnxDPState dp;
     XlnxDPDMAState dpdma;
+    XlnxZynqMPIPI ipi;
 
     char *boot_cpu;
     ARMCPU *boot_cpu_ptr;
-- 
2.11.0
