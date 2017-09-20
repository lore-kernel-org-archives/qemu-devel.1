Received: from eggs.gnu.org ([2001:4830:134:3::10]:47898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dun7t-00016T-Mb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dun7s-0000gv-Cn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:05:49 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Sep 2017 15:01:52 -0700
Message-ID: <e1b49cd103c58fba8d74afd1bcbd81441893beb5.1505929556.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505929556.git.alistair.francis@xilinx.com>
References: <cover.1505929556.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 7/8] xlnx-zynqmp-pmu: Connect the IPI device
 to the PMU
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

 hw/microblaze/xlnx-zynqmp-pmu.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index ca98d82e87..2016e34db6 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "boot.h"
 
+#include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 
 /* Define the PMU device */
@@ -38,18 +39,28 @@
 
 #define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
 
+#define XLNX_ZYNQMP_PMU_NUM_IPIS    4
+static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
+    0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
+};
+static const uint64_t ipi_irq[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
+    19, 20, 21, 22,
+};
+
 typedef struct XlnxZynqMPPMUState {
     /*< private >*/
     DeviceState parent_obj;
 
     /*< public >*/
     MicroBlazeCPU cpu;
+    XlnxZynqMPIPI ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
     XlnxPMUIOIntc intc;
 }  XlnxZynqMPPMUState;
 
 static void xlnx_zynqmp_pmu_init(Object *obj)
 {
     XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(obj);
+    int i;
 
     object_initialize(&s->cpu, sizeof(s->cpu),
                       TYPE_MICROBLAZE_CPU);
@@ -58,12 +69,19 @@ static void xlnx_zynqmp_pmu_init(Object *obj)
 
     object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
     qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
+
+   for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_initialize(&s->ipi[i], sizeof(s->ipi[i]), TYPE_XLNX_ZYNQMP_IPI);
+        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
+    }
 }
 
 static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
 {
     XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(dev);
     Error *err = NULL;
+    qemu_irq irq[32];
+    int i;
 
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
@@ -89,12 +107,9 @@ static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
-                             &error_abort);
-    object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
-                             &error_abort);
-    object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
-                             &error_abort);
+    object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size", &error_abort);
+    object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge", &error_abort);
+    object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive", &error_abort);
     object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -103,6 +118,19 @@ static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(DEVICE(&s->intc), i);
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0, irq[ipi_irq[i]]);
+    }
 }
 
 static void xlnx_zynqmp_pmu_class_init(ObjectClass *oc, void *data)
-- 
2.11.0
