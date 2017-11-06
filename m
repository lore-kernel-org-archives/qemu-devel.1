Received: from eggs.gnu.org ([2001:4830:134:3::10]:33810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdw-0007PJ-Db
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdv-0000ed-7O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:56 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:03 -0800
Message-Id: <20171106154813.19936-21-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 20/30] i.MX: Add code to emulate FlexCAN IP
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Add minimal code needed to allow upstream Linux guest to boot.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/misc/Makefile.objs         |  1 +
 hw/misc/imx_flexcan.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/imx_flexcan.h | 22 ++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/misc/imx_flexcan.c
 create mode 100644 include/hw/misc/imx_flexcan.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 492c535330..943b22af40 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -38,6 +38,7 @@ obj-$(CONFIG_IMX) += imx7_ccm.o
 obj-$(CONFIG_IMX) += imx2_wdt.o
 obj-$(CONFIG_IMX) += imx7_snvs.o
 obj-$(CONFIG_IMX) += imx7_iomuxc.o
+obj-$(CONFIG_IMX) += imx_flexcan.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/hw/misc/imx_flexcan.c b/hw/misc/imx_flexcan.c
new file mode 100644
index 0000000000..dd4d3d6dc1
--- /dev/null
+++ b/hw/misc/imx_flexcan.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX FlexCAN block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx_flexcan.h"
+#include "qemu/log.h"
+
+static void imx_flexcan_reset(DeviceState *dev)
+{
+    IMXFlexCANState *s = IMX_FLEXCAN(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx_flexcan_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMXFlexCANState *s = opaque;
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx_flexcan_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMXFlexCANState *s = opaque;
+    s->regs[offset / sizeof(uint32_t)] = value;
+}
+
+static const struct MemoryRegionOps imx_flexcan_ops = {
+    .read = imx_flexcan_read,
+    .write = imx_flexcan_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx_flexcan_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMXFlexCANState *s = IMX_FLEXCAN(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx_flexcan_ops,
+                          s,
+                          TYPE_IMX_FLEXCAN ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx_flexcan = {
+    .name = TYPE_IMX_FLEXCAN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMXFlexCANState, FLEXCAN_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_flexcan_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx_flexcan_reset;
+    dc->vmsd  = &vmstate_imx_flexcan;
+    dc->desc  = "i.MX FlexCAN Module";
+}
+
+static const TypeInfo imx_flexcan_info = {
+    .name          = TYPE_IMX_FLEXCAN,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXFlexCANState),
+    .instance_init = imx_flexcan_init,
+    .class_init    = imx_flexcan_class_init,
+};
+
+static void imx_flexcan_register_type(void)
+{
+    type_register_static(&imx_flexcan_info);
+}
+type_init(imx_flexcan_register_type)
diff --git a/include/hw/misc/imx_flexcan.h b/include/hw/misc/imx_flexcan.h
new file mode 100644
index 0000000000..da9980cf86
--- /dev/null
+++ b/include/hw/misc/imx_flexcan.h
@@ -0,0 +1,22 @@
+#ifndef IMX_FLEXCAN_H
+#define IMX_FLEXCAN_H
+
+#include "hw/sysbus.h"
+
+enum IMXFlexCANRegisters {
+    FLEXCAN_NUM = 0x9E0 / sizeof(uint32_t) + 1,
+};
+
+typedef struct IMXFlexCANState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[FLEXCAN_NUM];
+} IMXFlexCANState;
+
+#define TYPE_IMX_FLEXCAN "imx-flexcan"
+#define IMX_FLEXCAN(obj) OBJECT_CHECK(IMXFlexCANState, (obj), TYPE_IMX_FLEXCAN)
+
+#endif /* IMX_FLEXCAN_H */
-- 
2.13.6
