Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erALH-0000pM-VN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erALF-0008Mp-Ub
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:55 -0500
Received: from mail-cys01nam02on060d.outbound.protection.outlook.com
	([2a01:111:f400:fe45::60d]:61645
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erALF-0008Ky-9Q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:53 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 28 Feb 2018 14:32:08 -0800
Message-ID: <938a6b79c658dcdba39ed5b7f5a36806b25b655f.1519856998.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1519856998.git.alistair.francis@xilinx.com>
References: <cover.1519856998.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/5] xlnx-zynqmp-pmu: Connect the IOMOD
 GPI/GPO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/microblaze/xlnx-zynqmp-pmu.c | 77 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 35a2314ffb..fa5f0bfcf1 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -27,6 +27,7 @@
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 #include "hw/timer/xlnx-pmu-iomod-pit.h"
+#include "hw/gpio/xlnx-pmu-iomod-gp.h"
 
 /* Define the PMU device */
 
@@ -43,6 +44,9 @@
 #define XLNX_ZYNQMP_PMU_NUM_IPIS    4
 #define XLNX_ZYNQMP_PMU_NUM_PITS    4
 
+#define XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS    4
+#define XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS    4
+
 static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
     0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
 };
@@ -57,6 +61,17 @@ static const uint64_t pit_irq[XLNX_ZYNQMP_PMU_NUM_PITS] = {
     3, 4, 5, 6,
 };
 
+static const uint64_t iomod_gpi_addr[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS] = {
+    0xFFD40020, 0xFFD40024, 0xFFD40028, 0xFFD4002C,
+};
+static const uint64_t iomod_gpi_irq[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS] = {
+    11, 12, 13, 14,
+};
+
+static const uint64_t iomod_gpo_addr[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS] = {
+    0xFFD40010, 0xFFD40014, 0xFFD40018, 0xFFD4001C,
+};
+
 typedef struct XlnxZynqMPPMUSoCState {
     /*< private >*/
     DeviceState parent_obj;
@@ -156,6 +171,8 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
     MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
     XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
+    XlnxPMUIOGPIO *iomod_gpi[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS];
+    XlnxPMUIOGPIO *iomod_gpo[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS];
     XlnxPMUPIT *pit[XLNX_ZYNQMP_PMU_NUM_PITS];
     qemu_irq irq[32];
     qemu_irq tmp_irq;
@@ -197,10 +214,60 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
         sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
     }
 
+    /* Create and connect the IOMOD GPI device */
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS; i++) {
+        iomod_gpi[i] = g_new0(XlnxPMUIOGPIO, 1);
+        object_initialize(iomod_gpi[i], sizeof(XlnxPMUIOGPIO),
+                          TYPE_XLNX_ZYNQMP_IOMOD_GPIO);
+        qdev_set_parent_bus(DEVICE(iomod_gpi[i]), sysbus_get_default());
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS; i++) {
+        object_property_set_bool(OBJECT(iomod_gpi[i]), true, "input",
+                                 &error_abort);
+        object_property_set_uint(OBJECT(iomod_gpi[i]), 0x20, "size",
+                                 &error_abort);
+        object_property_set_bool(OBJECT(iomod_gpi[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(iomod_gpi[i]), 0, iomod_gpi_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(iomod_gpi[i]), 0,
+                           irq[iomod_gpi_irq[i]]);
+        /* The other GPIO lines connect to the ARM side of the SoC. When we
+         * have a way to model MicroBlaze QEMU and ARM QEMU together we can
+         * connect the GPIO lines.
+         */
+    }
+
+    /* Create and connect the IOMOD GPO device */
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS; i++) {
+        iomod_gpo[i] = g_new0(XlnxPMUIOGPIO, 1);
+        object_initialize(iomod_gpo[i], sizeof(XlnxPMUIOGPIO),
+                          TYPE_XLNX_ZYNQMP_IOMOD_GPIO);
+        qdev_set_parent_bus(DEVICE(iomod_gpo[i]), sysbus_get_default());
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS; i++) {
+        object_property_set_bool(OBJECT(iomod_gpo[i]), false, "input",
+                                 &error_abort);
+        if (i) {
+            object_property_set_uint(OBJECT(iomod_gpo[i]), 0x20, "size",
+                                     &error_abort);
+        } else {
+            object_property_set_uint(OBJECT(iomod_gpo[i]), 0x09, "size",
+                                     &error_abort);
+        }
+            object_property_set_uint(OBJECT(iomod_gpo[i]), 0x00, "gpo-init",
+                                     &error_abort);
+        object_property_set_bool(OBJECT(iomod_gpo[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(iomod_gpo[i]), 0, iomod_gpo_addr[i]);
+    }
+
     /* Create and connect the IOMOD PIT devices */
     for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_PITS; i++) {
         pit[i] = g_new0(XlnxPMUPIT, 1);
-        object_initialize(pit[i], sizeof(XlnxPMUPIT), TYPE_XLNX_ZYNQMP_IOMODULE_PIT);
+        object_initialize(pit[i], sizeof(XlnxPMUPIT),
+                          TYPE_XLNX_ZYNQMP_IOMODULE_PIT);
         qdev_set_parent_bus(DEVICE(pit[i]), sysbus_get_default());
     }
 
@@ -219,7 +286,13 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     tmp_irq = qdev_get_gpio_in_named(DEVICE(pit[2]), "ps_hit_in", 0);
     qdev_connect_gpio_out_named(DEVICE(pit[3]), "ps_hit_out", 0, tmp_irq);
 
-    /* TODO: PIT0 and PIT2 "ps_config" GPIO goes to The GPO1 device. */
+    /* GP01 goes into PIT0 */
+    tmp_irq = qdev_get_gpio_in_named(DEVICE(pit[0]), "ps_config", 0);
+    qdev_connect_gpio_out(DEVICE(iomod_gpo[1]), 2, tmp_irq);
+
+    /* GP01 goes into PIT2 */
+    tmp_irq = qdev_get_gpio_in_named(DEVICE(pit[2]), "ps_config", 0);
+    qdev_connect_gpio_out(DEVICE(iomod_gpo[1]), 6, tmp_irq);
 
     /* Load the kernel */
     microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
-- 
2.14.1
