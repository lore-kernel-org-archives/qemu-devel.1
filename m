Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-0008SO-NL
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-00067C-Nj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmt-00060G-EH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmk-00074Y-E1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:02 +0000
Message-Id: <20180309172622.4277-6-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/25] Implement support for i.MX7 Sabre board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Implement code needed to set up emulation of MCIMX7SABRE board from
NXP. For more info about the HW see:

https://www.nxp.com/support/developer-resources/hardware-development-tools/sabre-development-system/sabre-board-for-smart-devices-based-on-the-i.mx-7dual-applications-processors:MCIMX7SABRE

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs   |  2 +-
 hw/arm/mcimx7d-sabre.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/mcimx7d-sabre.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fcf764f373..48474c3394 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -22,4 +22,4 @@ obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
-obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o
+obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
new file mode 100644
index 0000000000..95fb409d9c
--- /dev/null
+++ b/hw/arm/mcimx7d-sabre.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (c) 2018, Impinj, Inc.
+ *
+ * MCIMX7D_SABRE Board System emulation.
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This code is licensed under the GPL, version 2 or later.
+ * See the file `COPYING' in the top level directory.
+ *
+ * It (partially) emulates a mcimx7d_sabre board, with a Freescale
+ * i.MX7 SoC
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/arm/fsl-imx7.h"
+#include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/device_tree.h"
+#include "qemu/error-report.h"
+#include "sysemu/qtest.h"
+#include "net/net.h"
+
+typedef struct {
+    FslIMX7State soc;
+    MemoryRegion ram;
+} MCIMX7Sabre;
+
+static void mcimx7d_sabre_init(MachineState *machine)
+{
+    static struct arm_boot_info boot_info;
+    MCIMX7Sabre *s = g_new0(MCIMX7Sabre, 1);
+    Object *soc;
+    int i;
+
+    if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
+        error_report("RAM size " RAM_ADDR_FMT " above max supported (%08x)",
+                     machine->ram_size, FSL_IMX7_MMDC_SIZE);
+        exit(1);
+    }
+
+    boot_info = (struct arm_boot_info) {
+        .loader_start = FSL_IMX7_MMDC_ADDR,
+        .board_id = -1,
+        .ram_size = machine->ram_size,
+        .kernel_filename = machine->kernel_filename,
+        .kernel_cmdline = machine->kernel_cmdline,
+        .initrd_filename = machine->initrd_filename,
+        .nb_cpus = smp_cpus,
+    };
+
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX7);
+    soc = OBJECT(&s->soc);
+    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal);
+    object_property_set_bool(soc, true, "realized", &error_fatal);
+
+    memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX7_MMDC_ADDR, &s->ram);
+
+    for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
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
+static void mcimx7d_sabre_machine_init(MachineClass *mc)
+{
+    mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex A7)";
+    mc->init = mcimx7d_sabre_init;
+    mc->max_cpus = FSL_IMX7_NUM_CPUS;
+}
+DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
-- 
2.16.2
