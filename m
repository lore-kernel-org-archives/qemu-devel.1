Received: from eggs.gnu.org ([2001:4830:134:3::10]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiW9l-0005oi-Bn
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fiW9i-0003LY-Ci
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 22:37:33 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Jul 2018 12:06:45 +0930
Message-Id: <20180726023645.13927-4-joel@jms.id.au>
In-Reply-To: <20180726023645.13927-1-joel@jms.id.au>
References: <20180726023645.13927-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH v3 3/3] arm: Add BBC micro:bit machine
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
---
 hw/arm/Makefile.objs |  2 +-
 hw/arm/microbit.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/microbit.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index e31875ec69bc..2798a257921d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -36,4 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
 obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
+obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
new file mode 100644
index 000000000000..ecf64e883f4f
--- /dev/null
+++ b/hw/arm/microbit.c
@@ -0,0 +1,54 @@
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
+} MICROBITMachineState;
+
+#define TYPE_MICROBIT_MACHINE "microbit"
+
+#define MICROBIT_MACHINE(obj) \
+    OBJECT_CHECK(MICROBITMachineState, obj, TYPE_MICROBIT_MACHINE)
+
+static void microbit_init(MachineState *machine)
+{
+    MICROBITMachineState *s = g_new(MICROBITMachineState, 1);
+    MemoryRegion *system_memory = get_system_memory();
+    Object *soc;
+
+    object_initialize(&s->nrf51, sizeof(s->nrf51), TYPE_NRF51_SOC);
+    soc = OBJECT(&s->nrf51);
+    object_property_add_child(OBJECT(machine), "nrf51", soc, &error_fatal);
+    object_property_set_link(soc, OBJECT(system_memory),
+                             "memory", &error_abort);
+
+    object_property_set_bool(soc, true, "realized", &error_abort);
+
+    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+            NRF51_SOC(soc)->flash_size);
+}
+
+static void microbit_machine_init(MachineClass *mc)
+{
+    mc->desc = "BBC micro:bit";
+    mc->init = microbit_init;
+    mc->max_cpus = 1;
+}
+DEFINE_MACHINE("microbit", microbit_machine_init);
-- 
2.17.1
