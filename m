Received: from eggs.gnu.org ([2001:4830:134:3::10]:33786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdv-0007Mz-2T
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdu-0000dg-01
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:55 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:02 -0800
Message-Id: <20171106154813.19936-20-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 19/30] i.MX: Add code to emulate SDMA IP
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
 hw/dma/Makefile.objs      |  1 +
 hw/dma/imx_sdma.c         | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/dma/imx_sdma.h | 22 +++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/dma/imx_sdma.c
 create mode 100644 include/hw/dma/imx_sdma.h

diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 087c8e6855..3cee0b1047 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -14,3 +14,4 @@ obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
 obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
 obj-$(CONFIG_RASPI) += bcm2835_dma.o
+obj-$(CONFIG_IMX) += imx_sdma.o
diff --git a/hw/dma/imx_sdma.c b/hw/dma/imx_sdma.c
new file mode 100644
index 0000000000..0776e41b9a
--- /dev/null
+++ b/hw/dma/imx_sdma.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 IOMUXC block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/dma/imx_sdma.h"
+#include "qemu/log.h"
+
+static void imx_sdma_reset(DeviceState *dev)
+{
+    IMXSDMAState *s = IMX_SDMA(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx_sdma_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMXSDMAState *s = opaque;
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx_sdma_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMXSDMAState *s = opaque;
+    s->regs[offset / sizeof(uint32_t)] = value;
+}
+
+static const struct MemoryRegionOps imx_sdma_ops = {
+    .read = imx_sdma_read,
+    .write = imx_sdma_write,
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
+static void imx_sdma_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMXSDMAState *s = IMX_SDMA(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx_sdma_ops,
+                          s,
+                          TYPE_IMX_SDMA ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx_sdma = {
+    .name = TYPE_IMX_SDMA,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMXSDMAState, SDMA_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_sdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx_sdma_reset;
+    dc->vmsd  = &vmstate_imx_sdma;
+    dc->desc  = "i.MX IOMUXC Module";
+}
+
+static const TypeInfo imx_sdma_info = {
+    .name          = TYPE_IMX_SDMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXSDMAState),
+    .instance_init = imx_sdma_init,
+    .class_init    = imx_sdma_class_init,
+};
+
+static void imx_sdma_register_type(void)
+{
+    type_register_static(&imx_sdma_info);
+}
+type_init(imx_sdma_register_type)
diff --git a/include/hw/dma/imx_sdma.h b/include/hw/dma/imx_sdma.h
new file mode 100644
index 0000000000..13c5be7a00
--- /dev/null
+++ b/include/hw/dma/imx_sdma.h
@@ -0,0 +1,22 @@
+#ifndef IMX_SDMA_H
+#define IMX_SDMA_H
+
+#include "hw/sysbus.h"
+
+enum IMXSDMARegisters {
+    SDMA_NUM = 0x300 / sizeof(uint32_t) + 1,
+};
+
+typedef struct IMXSDMAState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[SDMA_NUM];
+} IMXSDMAState;
+
+#define TYPE_IMX_SDMA "imx-sdma"
+#define IMX_SDMA(obj) OBJECT_CHECK(IMXSDMAState, (obj), TYPE_IMX_SDMA)
+
+#endif /* IMX_SDMA_H */
-- 
2.13.6
