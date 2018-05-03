Received: from eggs.gnu.org ([2001:4830:134:3::10]:51680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fEABc-0002Gt-P0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fEABb-0008Rp-N6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:06:00 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 May 2018 18:35:32 +0930
Message-Id: <20180503090532.3113-3-joel@jms.id.au>
In-Reply-To: <20180503090532.3113-1-joel@jms.id.au>
References: <20180503090532.3113-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 2/2] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

This adds the base for a machine model of the BBC micro:bit:

  https://en.wikipedia.org/wiki/Micro_Bit

This is a system with a nRF51 SoC containing the main processor, with
various peripherals on board.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/Makefile.objs |  2 +-
 hw/arm/microbit.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/microbit.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 1d7211850454..c01e7a1e39fb 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,4 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
+obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
new file mode 100644
index 000000000000..b61d0747fe56
--- /dev/null
+++ b/hw/arm/microbit.c
@@ -0,0 +1,33 @@
+/*
+ * BBC micro:bit machine
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
+
+#include "hw/arm/nrf51_soc.h"
+
+static void microbit_init(MachineState *machine)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_NRF51_SOC);
+    if (machine->kernel_filename) {
+        qdev_prop_set_string(dev, "kernel-filename", machine->kernel_filename);
+    }
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+}
+
+static void microbit_machine_init(MachineClass *mc)
+{
+    mc->desc = "BBC micro:bit";
+    mc->init = microbit_init;
+    mc->ignore_memory_transaction_failures = true;
+}
+DEFINE_MACHINE("microbit", microbit_machine_init);
-- 
2.17.0
