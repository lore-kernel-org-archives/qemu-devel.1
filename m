Received: from eggs.gnu.org ([2001:4830:134:3::10]:34963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4Vkb-000563-Vo
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4VkX-0006O2-Sh
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:33:58 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Oct 2017 10:29:53 -0700
Message-ID: <fdad64bee58c8c460542a0316a066daad38d9ae9.1508261326.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508261326.git.alistair.francis@xilinx.com>
References: <cover.1508261326.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/8] xlnx-zynqmp-pmu: Connect the PMU
 interrupt controller
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

 hw/microblaze/xlnx-zynqmp-pmu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index c6a0b3b8a1..828eeedc9f 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -24,6 +24,8 @@
 #include "cpu.h"
 #include "boot.h"
 
+#include "hw/intc/xlnx-pmu-iomod-intc.h"
+
 /* Define the PMU device */
 
 #define TYPE_XLNX_ZYNQMP_PMU_SOC "xlnx,zynqmp-pmu-soc"
@@ -34,14 +36,18 @@
 #define XLNX_ZYNQMP_PMU_ROM_ADDR    0xFFD00000
 #define XLNX_ZYNQMP_PMU_RAM_ADDR    0xFFDC0000
 
+#define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
+
 typedef struct XlnxZynqMPPMUSoCState {
     /*< private >*/
     DeviceState parent_obj;
 
     /*< public >*/
     MicroBlazeCPU cpu;
+    XlnxPMUIOIntc intc;
 }  XlnxZynqMPPMUSoCState;
 
+
 static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
@@ -50,6 +56,9 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
                       TYPE_MICROBLAZE_CPU);
     object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
                               &error_abort);
+
+    object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
+    qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
 }
 
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
@@ -80,6 +89,21 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
 }
 
 static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
-- 
2.11.0
