Received: from eggs.gnu.org ([2001:4830:134:3::10]:52146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fvrbr-0004ex-PP
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fvrbp-0004sm-7m
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:09:43 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Aug 2018 15:09:20 -0700
Message-Id: <20180831220920.27113-4-joel@jms.id.au>
In-Reply-To: <20180831220920.27113-1-joel@jms.id.au>
References: <20180831220920.27113-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH v6 3/3] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

This adds the base for a machine model of the BBC micro:bit:

  https://en.wikipedia.org/wiki/Micro_Bit

This is a system with a nRF51 SoC containing the main processor, with
various peripherals on board.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Instead of setting kernel filename property, load the image directly
 - Add link to hardware overview website
v3:
 - Rebase microbit on m0 changes
 - Remove hard-coded flash size and retrieve from the soc
 - Add Stefan's reviewed-by
v5:
 - move back to armv7m calls, as v4 of Stefan's patch removed the
 m_profile changes
v6:
 - MICROBITMachineState -> MicrobitMachineState
 - Rework machine type init with PMM's suggestions
---
 hw/arm/Makefile.objs |  2 +-
 hw/arm/microbit.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/microbit.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index ae4e20373b9e..5f88062c666d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -37,4 +37,4 @@ obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
 obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
+obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
new file mode 100644
index 000000000000..e7d74116a504
--- /dev/null
+++ b/hw/arm/microbit.c
@@ -0,0 +1,67 @@
+/*
+ * BBC micro:bit machine
+ * http://tech.microbit.org/hardware/
+ *
+ * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/arm/arm.h"
+#include "exec/address-spaces.h"
+
+#include "hw/arm/nrf51_soc.h"
+
+typedef struct {
+    MachineState parent;
+
+    NRF51State nrf51;
+} MicrobitMachineState;
+
+#define TYPE_MICROBIT_MACHINE MACHINE_TYPE_NAME("microbit")
+
+#define MICROBIT_MACHINE(obj) \
+    OBJECT_CHECK(MicrobitMachineState, obj, TYPE_MICROBIT_MACHINE)
+
+static void microbit_init(MachineState *machine)
+{
+    MicrobitMachineState *s = MICROBIT_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    Object *soc = OBJECT(&s->nrf51);
+
+    sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51),
+                          TYPE_NRF51_SOC);
+    object_property_set_link(soc, OBJECT(system_memory), "memory",
+                             &error_fatal);
+    object_property_set_bool(soc, true, "realized", &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                       NRF51_SOC(soc)->flash_size);
+}
+
+static void microbit_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "BBC micro:bit";
+    mc->init = microbit_init;
+    mc->max_cpus = 1;
+}
+
+static const TypeInfo microbit_info = {
+    .name = TYPE_MICROBIT_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(MicrobitMachineState),
+    .class_init = microbit_machine_class_init,
+};
+
+static void microbit_machine_init(void)
+{
+    type_register_static(&microbit_info);
+}
+
+type_init(microbit_machine_init);
-- 
2.17.1
