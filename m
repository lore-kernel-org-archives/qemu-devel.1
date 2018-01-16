Received: from eggs.gnu.org ([2001:4830:134:3::10]:35322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPlv-0005dS-0d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPlp-00009H-5z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:19 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:39279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ebPlo-00008x-TQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:13 -0500
Received: by mail-lf0-x242.google.com with SMTP id m8so17071760lfc.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:51:12 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Jan 2018 12:51:00 +0100
Message-Id: <1516103467-7983-2-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 1/8] xlnx-zynqmp-pmu: Initial commit of the
 ZynqMP PMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/microblaze/Makefile.objs     |  1 +
 hw/microblaze/xlnx-zynqmp-pmu.c | 83 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c

diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
index b2517d8..ae9fd40 100644
--- a/hw/microblaze/Makefile.objs
+++ b/hw/microblaze/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y += petalogix_s3adsp1800_mmu.o
 obj-y += petalogix_ml605_mmu.o
+obj-y += xlnx-zynqmp-pmu.o
 obj-y += boot.o
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
new file mode 100644
index 0000000..ac0f789
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
+#define TYPE_XLNX_ZYNQMP_PMU_SOC "xlnx,zynqmp-pmu-soc"
+#define XLNX_ZYNQMP_PMU_SOC(obj) OBJECT_CHECK(XlnxZynqMPPMUSoCState, (obj), \
+                                              TYPE_XLNX_ZYNQMP_PMU_SOC)
+
+typedef struct XlnxZynqMPPMUSoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+}  XlnxZynqMPPMUSoCState;
+
+static void xlnx_zynqmp_pmu_soc_init(Object *obj)
+{
+
+}
+
+static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
+{
+
+}
+
+static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = xlnx_zynqmp_pmu_soc_realize;
+}
+
+static const TypeInfo xlnx_zynqmp_pmu_soc_type_info = {
+    .name = TYPE_XLNX_ZYNQMP_PMU_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(XlnxZynqMPPMUSoCState),
+    .instance_init = xlnx_zynqmp_pmu_soc_init,
+    .class_init = xlnx_zynqmp_pmu_soc_class_init,
+};
+
+static void xlnx_zynqmp_pmu_soc_register_types(void)
+{
+    type_register_static(&xlnx_zynqmp_pmu_soc_type_info);
+}
+
+type_init(xlnx_zynqmp_pmu_soc_register_types)
+
+/* Define the PMU Machine */
+
+static void xlnx_zynqmp_pmu_init(MachineState *machine)
+{
+
+}
+
+static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
+{
+    mc->desc = "Xilinx ZynqMP PMU machine";
+    mc->init = xlnx_zynqmp_pmu_init;
+}
+
+DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
+
-- 
2.7.4
