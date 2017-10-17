Received: from eggs.gnu.org ([2001:4830:134:3::10]:34961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4Vkb-00055n-OA
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e4VkX-0006Ni-Ji
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 13:33:57 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Oct 2017 10:29:58 -0700
Message-ID: <def1a1e662b4d7856a3e4cae0c291626c7515ff0.1508261326.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508261326.git.alistair.francis@xilinx.com>
References: <cover.1508261326.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 7/8] xlnx-zynqmp-pmu: Connect the IPI device
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
V4:
 - Move the IPI to the machine instead of the SoC

 hw/microblaze/xlnx-zynqmp-pmu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 828eeedc9f..14b8ed4a43 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "boot.h"
 
+#include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 
 /* Define the PMU device */
@@ -38,6 +39,15 @@
 
 #define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
 
+#define XLNX_ZYNQMP_PMU_NUM_IPIS    4
+
+static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
+    0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
+};
+static const uint64_t ipi_irq[XLNX_ZYNQMP_PMU_NUM_IPIS] = {
+    19, 20, 21, 22,
+};
+
 typedef struct XlnxZynqMPPMUSoCState {
     /*< private >*/
     DeviceState parent_obj;
@@ -136,6 +146,9 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *pmu_rom = g_new(MemoryRegion, 1);
     MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
+    XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
+    qemu_irq irq[32];
+    int i;
 
     /* Create the ROM */
     memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
@@ -155,6 +168,24 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                               &error_abort);
     object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
 
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(DEVICE(&pmu->intc), i);
+    }
+
+    /* Create and connect the IPI device */
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        ipi[i] = g_new0(XlnxZynqMPIPI, 1);
+        object_initialize(ipi[i], sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
+        qdev_set_parent_bus(DEVICE(ipi[i]), sysbus_get_default());
+    }
+
+    for (i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_property_set_bool(OBJECT(ipi[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ipi[i]), 0, ipi_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]]);
+    }
+
     /* Load the kernel */
     microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
                            machine->ram_size,
-- 
2.11.0
