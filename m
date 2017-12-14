Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePVIb-0000qi-4b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePVIW-0008HJ-Ja
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:19:49 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 07:19:34 -0800
Message-Id: <20171214151934.3647-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/misc: Add code to emulate Xilinx Slave
 Serial port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org, yurovsky@gmail.com

Add code to emulate Xilinx Slave Serial FPGA configuration port.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Integrating this into a build system via "obj-y" might not be the best
way. Does this code need a dedicated CONFIG_ symbol?

Thanks,
Andrey Smirnov


 hw/misc/Makefile.objs                 |   1 +
 hw/misc/xilinx_slave_serial.c         | 105 ++++++++++++++++++++++++++++++++++
 include/hw/misc/xilinx_slave_serial.h |  21 +++++++
 3 files changed, 127 insertions(+)
 create mode 100644 hw/misc/xilinx_slave_serial.c
 create mode 100644 include/hw/misc/xilinx_slave_serial.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index a68a201083..4599288e55 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -38,6 +38,7 @@ obj-$(CONFIG_IMX) += imx7_ccm.o
 obj-$(CONFIG_IMX) += imx2_wdt.o
 obj-$(CONFIG_IMX) += imx7_snvs.o
 obj-$(CONFIG_IMX) += imx7_gpr.o
+obj-y += xilinx_slave_serial.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/hw/misc/xilinx_slave_serial.c b/hw/misc/xilinx_slave_serial.c
new file mode 100644
index 0000000000..607674fb60
--- /dev/null
+++ b/hw/misc/xilinx_slave_serial.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * Code to emulate programming "port" of Xilinx FPGA in Slave Serial
+ * configuration connected via SPI, for more deatils see (p. 27):
+ *
+ * See https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/xilinx_slave_serial.h"
+#include "qemu/log.h"
+
+enum {
+    XILINX_SLAVE_SERIAL_STATE_RESET,
+    XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION,
+    XILINX_SLAVE_SERIAL_STATE_DONE,
+};
+
+static void xilinx_slave_serial_update_outputs(XilinxSlaveSerialState *xlnxss)
+{
+    qemu_set_irq(xlnxss->done,
+                 xlnxss->state == XILINX_SLAVE_SERIAL_STATE_DONE);
+}
+
+static void xilinx_slave_serial_reset(DeviceState *dev)
+{
+    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(dev);
+
+    xlnxss->state = XILINX_SLAVE_SERIAL_STATE_RESET;
+
+    xilinx_slave_serial_update_outputs(xlnxss);
+}
+
+static void xilinx_slave_serial_prog_b(void *opaque, int n, int level)
+{
+    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(opaque);
+    assert(n == 0);
+
+    if (level) {
+        xlnxss->state = XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION;
+    }
+
+    xilinx_slave_serial_update_outputs(xlnxss);
+}
+
+static void xilinx_slave_serial_realize(SSISlave *ss, Error **errp)
+{
+    DeviceState *dev = DEVICE(ss);
+    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(ss);
+
+    qdev_init_gpio_in_named(dev,
+                            xilinx_slave_serial_prog_b,
+                            XILINX_SLAVE_SERIAL_GPIO_PROG_B,
+                            1);
+    qdev_init_gpio_out_named(dev, &xlnxss->done,
+                             XILINX_SLAVE_SERIAL_GPIO_DONE, 1);
+}
+
+static uint32_t xilinx_slave_serial_transfer(SSISlave *ss, uint32_t tx)
+{
+    XilinxSlaveSerialState *xlnxss = XILINX_SLAVE_SERIAL(ss);
+
+    if (xlnxss->state == XILINX_SLAVE_SERIAL_STATE_RECONFIGURATION) {
+        xlnxss->state = XILINX_SLAVE_SERIAL_STATE_DONE;
+    }
+
+    xilinx_slave_serial_update_outputs(xlnxss);
+    return 0;
+}
+
+static void xilinx_slave_serial_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass   *dc = DEVICE_CLASS(klass);
+    SSISlaveClass *k  = SSI_SLAVE_CLASS(klass);
+
+    dc->reset      = xilinx_slave_serial_reset;
+    dc->desc       = "Xilinx Slave Serial";
+    k->realize     = xilinx_slave_serial_realize;
+    k->transfer    = xilinx_slave_serial_transfer;
+    /*
+     * Slave Serial configuration is not technically SPI and there's
+     * no CS signal
+     */
+    k->set_cs      = NULL;
+    k->cs_polarity = SSI_CS_NONE;
+}
+
+static const TypeInfo xilinx_slave_serial_info = {
+    .name          = TYPE_XILINX_SLAVE_SERIAL,
+    .parent        = TYPE_SSI_SLAVE,
+    .instance_size = sizeof(XilinxSlaveSerialState),
+    .class_init    = xilinx_slave_serial_class_init,
+};
+
+static void xilinx_slave_serial_register_type(void)
+{
+    type_register_static(&xilinx_slave_serial_info);
+}
+type_init(xilinx_slave_serial_register_type)
diff --git a/include/hw/misc/xilinx_slave_serial.h b/include/hw/misc/xilinx_slave_serial.h
new file mode 100644
index 0000000000..f7b2e22be3
--- /dev/null
+++ b/include/hw/misc/xilinx_slave_serial.h
@@ -0,0 +1,21 @@
+#ifndef XILINX_SLAVE_SERIAL_H
+#define XILINX_SLAVE_SERIAL_H
+
+#include "hw/ssi/ssi.h"
+
+typedef struct XilinxSlaveSerialState {
+    /*< private >*/
+    SSISlave parent_obj;
+
+    qemu_irq done;
+    int state;
+} XilinxSlaveSerialState;
+
+#define TYPE_XILINX_SLAVE_SERIAL "xilinx:slave-serial"
+#define XILINX_SLAVE_SERIAL(obj) \
+    OBJECT_CHECK(XilinxSlaveSerialState, (obj), TYPE_XILINX_SLAVE_SERIAL)
+
+#define XILINX_SLAVE_SERIAL_GPIO_DONE   "xilinx:slave-serial:done"
+#define XILINX_SLAVE_SERIAL_GPIO_PROG_B "xilinx:slave-serial:prog-b"
+
+#endif /* XILINX_SLAVE_SERIAL_H */
-- 
2.14.3
