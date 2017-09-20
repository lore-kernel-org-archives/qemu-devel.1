Received: from eggs.gnu.org ([2001:4830:134:3::10]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dun7Y-0000oC-O4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dun7X-0007wo-FQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 18:05:28 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Sep 2017 15:01:33 -0700
Message-ID: <3e3eaffaff956a406588ed26cddcbe3a7fb385d6.1505929556.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505929556.git.alistair.francis@xilinx.com>
References: <cover.1505929556.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/8] xlnx-zynqmp-pmu: Initial commit of the
 ZynqMP PMU
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

The Xilinx ZynqMP SoC has two main processing systems in it. The ARM
processing system (which is already modeled in QEMU) and the MicroBlaze
Power Management Unit (PMU). This is the inital work for adding support
for the PMU.

The PMU susbsystem runs along side the ARM system on hardware, but due
to architecture limitations in QEMU the two instances are seperate for
the time being.

Let's follow the same setup we do with the ARM system, where there is an
SoC device and a ZCU102 board. Although the PMU is less board specific
we are still going to follow the same split as maybe in future we can
connect the PMU device to the ARM ZCU102 board. As the machine will be
fairly small let's keep them both together in one file.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/microblaze/Makefile.objs     |  1 +
 hw/microblaze/xlnx-zynqmp-pmu.c | 83 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c

diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
index b2517d87fe..ae9fd40de7 100644
--- a/hw/microblaze/Makefile.objs
+++ b/hw/microblaze/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y += petalogix_s3adsp1800_mmu.o
 obj-y += petalogix_ml605_mmu.o
+obj-y += xlnx-zynqmp-pmu.o
 obj-y += boot.o
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
new file mode 100644
index 0000000000..fc3c8b236f
--- /dev/null
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -0,0 +1,83 @@
+/*
+ * Xilinx Zynq MPSoC PMU (Power Management Unit) emulation
+ *
+ * Copyright (C) 2017 Xilinx Inc
+ * Written by Alistair Francis <alistair.francis@xilinx.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/boards.h"
+#include "cpu.h"
+
+/* Define the PMU device */
+
+#define TYPE_XLNX_ZYNQMP_PMU "xlnx,zynqmp-pmu"
+#define XLNX_ZYNQMP_PMU(obj) OBJECT_CHECK(XlnxZynqMPPMUState, (obj), \
+                                          TYPE_XLNX_ZYNQMP_PMU)
+
+typedef struct XlnxZynqMPPMUState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+}  XlnxZynqMPPMUState;
+
+static void xlnx_zynqmp_pmu_init(Object *obj)
+{
+
+}
+
+static void xlnx_zynqmp_pmu_realize(DeviceState *dev, Error **errp)
+{
+
+}
+
+static void xlnx_zynqmp_pmu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = xlnx_zynqmp_pmu_realize;
+}
+
+static const TypeInfo xlnx_zynqmp_pmu_type_info = {
+    .name = TYPE_XLNX_ZYNQMP_PMU,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(XlnxZynqMPPMUState),
+    .instance_init = xlnx_zynqmp_pmu_init,
+    .class_init = xlnx_zynqmp_pmu_class_init,
+};
+
+static void xlnx_zynqmp_pmu_register_types(void)
+{
+    type_register_static(&xlnx_zynqmp_pmu_type_info);
+}
+
+type_init(xlnx_zynqmp_pmu_register_types)
+
+/* Define the PMU Machine */
+
+static void xlnx_zcu102_pmu_init(MachineState *machine)
+{
+
+}
+
+static void xlnx_zcu102_pmu_machine_init(MachineClass *mc)
+{
+    mc->desc = "Xilinx ZynqMP ZCU102 PMU machine";
+    mc->init = xlnx_zcu102_pmu_init;
+}
+
+DEFINE_MACHINE("xlnx-zcu102-pmu", xlnx_zcu102_pmu_machine_init)
+
-- 
2.11.0
