Received: from eggs.gnu.org ([2001:4830:134:3::10]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7F-0000Tc-7f
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7E-0006sk-6m
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:37 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 14:00:45 -0700
Message-ID: <58a155d758561fd2011596b211db9080a78aa2ac.1504293917.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504293917.git.alistair.francis@xilinx.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/6] xlnx-zynqmp-pmu: Connect the IPI device
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

 hw/microblaze/xlnx-zynqmp-pmu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 33584cfa4d..a6c14495ec 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -24,6 +24,8 @@
 #include "cpu.h"
 #include "boot.h"
 
+#include "hw/intc/xlnx-zynqmp-ipi.h"
+
 /* Define the PMU device */
 
 #define TYPE_XLNX_ZYNQMP_PMU "xlnx,zynqmp-pmu"
@@ -34,27 +36,42 @@
 #define XLNX_ZYNQMP_PMU_ROM_ADDR    0xFFD00000
 #define XLNX_ZYNQMP_PMU_RAM_ADDR    0xFFDC0000
 
+#define XLNX_ZYNQMP_PMU_NUM_IPIS    4
+
+static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
+    0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
+};
+
 typedef struct XlnxZynqMPPMUState {
     /*< private >*/
     DeviceState parent_obj;
 
     /*< public >*/
     MicroBlazeCPU cpu;
+    XlnxZynqMPIPI ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
 }  XlnxZynqMPPMUState;
 
 static void xlnx_zynqmp_pmu_init(Object *obj)
 {
     XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(obj);
+    int i;
 
     object_initialize(&s->cpu, sizeof(s->cpu),
                       TYPE_MICROBLAZE_CPU);
     object_property_add_child(obj, "pmu-cpu[*]", OBJECT(&s->cpu),
                               &error_abort);
+
+   for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_initialize(&s->ipi[i], sizeof(s->ipi[i]), TYPE_XLNX_ZYNQMP_IPI);
+        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
+    }
 }
 
 static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
 {
     XlnxZynqMPPMUState *s = XLNX_ZYNQMP_PMU(dev);
+    Error *err = NULL;
+    int i;
 
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
@@ -75,6 +92,17 @@ static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &error_fatal);
+
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
+        /* Need to connect this to an interrupt controller */
+    }
+
 }
 
 static void xlnx_zynqmp_pmu_class_init(ObjectClass *oc, void *data)
-- 
2.11.0
