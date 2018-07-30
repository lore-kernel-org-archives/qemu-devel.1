Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkFMY-0006xy-Ui
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fkFMV-0001Ga-Pb
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:05:54 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fkFMV-0001Fw-I5
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:05:51 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Mon, 30 Jul 2018 23:05:44 +0200
Message-Id: <3f8eb4300206634dc01e04b12f65b73c0ad2f955.1532984236.git.jcd@tribudubois.net>
In-Reply-To: <cover.1532984236.git.jcd@tribudubois.net>
References: <cover.1532984236.git.jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v3 3/3] i.MX6UL: Add Freescale i.MX6 UltraLite
 14x14 EVK Board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Tested by booting linux 4.18 (built using imx_v6_v7_defconfig) on the
emulated board.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

Changes in V3:
 * None

Changes in V2:
 * use object_initialize_child instead of several funcions

 hw/arm/Makefile.objs  |  2 +-
 hw/arm/mcimx6ul-evk.c | 85 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/mcimx6ul-evk.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index e419ad040b..2902f47b4c 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -36,4 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
-obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o
+obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
new file mode 100644
index 0000000000..fb2b015bf6
--- /dev/null
+++ b/hw/arm/mcimx6ul-evk.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2018 Jean-Christophe Dubois <jcd@tribudubois.net>
+ *
+ * MCIMX6UL_EVK Board System emulation.
+ *
+ * This code is licensed under the GPL, version 2 or later.
+ * See the file `COPYING' in the top level directory.
+ *
+ * It (partially) emulates a mcimx6ul_evk board, with a Freescale
+ * i.MX6ul SoC
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/arm/fsl-imx6ul.h"
+#include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+#include "sysemu/qtest.h"
+
+typedef struct {
+    FslIMX6ULState soc;
+    MemoryRegion ram;
+} MCIMX6ULEVK;
+
+static void mcimx6ul_evk_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    MCIMX6ULEVK *s = g_new0(MCIMX6ULEVK, 1);
+    int i;
+
+    if (machine->ram_size > FSL_IMX6UL_MMDC_SIZE) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
+                     machine->ram_size, FSL_IMX6UL_MMDC_SIZE);
+        exit(1);
+    }
+
+    boot_info = (struct arm_boot_info) {
+        .loader_start = FSL_IMX6UL_MMDC_ADDR,
+        .board_id = -1,
+        .ram_size = machine->ram_size,
+        .kernel_filename = machine->kernel_filename,
+        .kernel_cmdline = machine->kernel_cmdline,
+        .initrd_filename = machine->initrd_filename,
+        .nb_cpus = smp_cpus,
+    };
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,  sizeof(s->soc),
+                            TYPE_FSL_IMX6UL, &error_fatal, NULL);
+
+    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+
+    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx6ul-evk.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_MMDC_ADDR, &s->ram);
+
+    for (i = 0; i < FSL_IMX6UL_NUM_USDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        DriveInfo *di;
+        BlockBackend *blk;
+
+        di = drive_get_next(IF_SD);
+        blk = di ? blk_by_legacy_dinfo(di) : NULL;
+        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
+        carddev = qdev_create(bus, TYPE_SD_CARD);
+        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+        object_property_set_bool(OBJECT(carddev), true,
+                                 "realized", &error_fatal);
+    }
+
+    if (!qtest_enabled()) {
+        arm_load_kernel(&s->soc.cpu[0], &boot_info);
+    }
+}
+
+static void mcimx6ul_evk_machine_init(MachineClass *mc)
+{
+    mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex A7)";
+    mc->init = mcimx6ul_evk_init;
+    mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+}
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
-- 
2.17.1
