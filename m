Received: from eggs.gnu.org ([2001:4830:134:3::10]:33980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje2-0007W5-WE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje1-0000jz-Op
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:03 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:08 -0800
Message-Id: <20171106154813.19936-26-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 25/30] i.MX: Add code to emulate i.MX7 SRC
 IP-block
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
 hw/misc/Makefile.objs      |  1 +
 hw/misc/imx7_src.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/imx7_src.h | 22 +++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 hw/misc/imx7_src.c
 create mode 100644 include/hw/misc/imx7_src.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index b578bd0cba..6c0bf4d519 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -41,6 +41,7 @@ obj-$(CONFIG_IMX) += imx7_iomuxc.o
 obj-$(CONFIG_IMX) += imx_flexcan.o
 obj-$(CONFIG_IMX) += imx7_adc.o
 obj-$(CONFIG_IMX) += imx7_gpr.o
+obj-$(CONFIG_IMX) += imx7_src.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
new file mode 100644
index 0000000000..2634e60ad7
--- /dev/null
+++ b/hw/misc/imx7_src.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 SRC block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx7_src.h"
+#include "qemu/log.h"
+
+static void imx7_src_reset(DeviceState *dev)
+{
+    IMX7SRCState *s = IMX7_SRC(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx7_src_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMX7SRCState *s = opaque;
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx7_src_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMX7SRCState *s = opaque;
+    s->regs[offset / sizeof(uint32_t)] = value;
+}
+
+static const struct MemoryRegionOps imx7_src_ops = {
+    .read       = imx7_src_read,
+    .write      = imx7_src_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned       = false,
+    },
+};
+
+static void imx7_src_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX7SRCState *s = IMX7_SRC(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx7_src_ops,
+                          s,
+                          TYPE_IMX7_SRC ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx7_src = {
+    .name = TYPE_IMX7_SRC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX7SRCState, SRC_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx7_src_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx7_src_reset;
+    dc->vmsd  = &vmstate_imx7_src;
+    dc->desc  = "i.MX7 System Reset Controller";
+}
+
+static const TypeInfo imx7_src_info = {
+    .name          = TYPE_IMX7_SRC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX7SRCState),
+    .instance_init = imx7_src_init,
+    .class_init    = imx7_src_class_init,
+};
+
+static void imx7_src_register_type(void)
+{
+    type_register_static(&imx7_src_info);
+}
+type_init(imx7_src_register_type)
diff --git a/include/hw/misc/imx7_src.h b/include/hw/misc/imx7_src.h
new file mode 100644
index 0000000000..aaca091fa8
--- /dev/null
+++ b/include/hw/misc/imx7_src.h
@@ -0,0 +1,22 @@
+#ifndef IMX7_SRC_H
+#define IMX7_SRC_H
+
+#include "hw/sysbus.h"
+
+enum IMX7SRCRegisters {
+    SRC_NUM = 0x1000 / sizeof(uint32_t) + 1,
+};
+
+typedef struct IMX7SRCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[SRC_NUM];
+} IMX7SRCState;
+
+#define TYPE_IMX7_SRC "imx7-src"
+#define IMX7_SRC(obj) OBJECT_CHECK(IMX7SRCState, (obj), TYPE_IMX7_SRC)
+
+#endif /* IMX7_SRC_H */
-- 
2.13.6
