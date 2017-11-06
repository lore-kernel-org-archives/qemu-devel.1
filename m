Received: from eggs.gnu.org ([2001:4830:134:3::10]:33732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjds-0007KX-Kh
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdr-0000bp-Ey
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:52 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:59 -0800
Message-Id: <20171106154813.19936-17-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/30] i.MX: Add code to emulate GPCv2 IP
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
 hw/intc/Makefile.objs       |   2 +-
 hw/intc/imx_gpcv2.c         | 125 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/intc/imx_gpcv2.h |  22 ++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 hw/intc/imx_gpcv2.c
 create mode 100644 include/hw/intc/imx_gpcv2.h

diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 78426a7daf..db234901aa 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -4,7 +4,7 @@ common-obj-$(CONFIG_PL190) += pl190.o
 common-obj-$(CONFIG_PUV3) += puv3_intc.o
 common-obj-$(CONFIG_XILINX) += xilinx_intc.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_pic.o
-common-obj-$(CONFIG_IMX) += imx_avic.o
+common-obj-$(CONFIG_IMX) += imx_avic.o imx_gpcv2.o
 common-obj-$(CONFIG_LM32) += lm32_pic.o
 common-obj-$(CONFIG_REALVIEW) += realview_gic.o
 common-obj-$(CONFIG_SLAVIO) += slavio_intctl.o
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
new file mode 100644
index 0000000000..496ed31b78
--- /dev/null
+++ b/hw/intc/imx_gpcv2.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 GPCv2 block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/imx_gpcv2.h"
+#include "qemu/log.h"
+
+#define GPC_PU_PGC_SW_PUP_REQ       0x0f8
+#define GPC_PU_PGC_SW_PDN_REQ       0x104
+
+#define USB_HSIC_PHY_SW_Pxx_REQ     BIT(4)
+#define USB_OTG2_PHY_SW_Pxx_REQ     BIT(3)
+#define USB_OTG1_PHY_SW_Pxx_REQ     BIT(2)
+#define PCIE_PHY_SW_Pxx_REQ         BIT(1)
+#define MIPI_PHY_SW_Pxx_REQ         BIT(0)
+
+
+static void imx_gpcv2_reset(DeviceState *dev)
+{
+    IMXGPCv2State *s = IMX_GPCV2(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx_gpcv2_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMXGPCv2State *s = opaque;
+
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx_gpcv2_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMXGPCv2State *s = opaque;
+    const size_t idx = offset / sizeof(uint32_t);
+
+    s->regs[idx] = value;
+
+    /*
+     * Real HW will clear those bits once as a way to indicate that
+     * power up request is complete
+     */
+    if (offset == GPC_PU_PGC_SW_PUP_REQ ||
+        offset == GPC_PU_PGC_SW_PDN_REQ) {
+        s->regs[idx] &= ~(USB_HSIC_PHY_SW_Pxx_REQ |
+                          USB_OTG2_PHY_SW_Pxx_REQ |
+                          USB_OTG1_PHY_SW_Pxx_REQ |
+                          PCIE_PHY_SW_Pxx_REQ     |
+                          MIPI_PHY_SW_Pxx_REQ);
+    }
+}
+
+static const struct MemoryRegionOps imx_gpcv2_ops = {
+    .read = imx_gpcv2_read,
+    .write = imx_gpcv2_write,
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
+static void imx_gpcv2_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMXGPCv2State *s = IMX_GPCV2(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx_gpcv2_ops,
+                          s,
+                          TYPE_IMX_GPCV2 ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx_gpcv2 = {
+    .name = TYPE_IMX_GPCV2,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMXGPCv2State, GPC_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_gpcv2_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx_gpcv2_reset;
+    dc->vmsd  = &vmstate_imx_gpcv2;
+    dc->desc  = "i.MX GPCv2 Module";
+}
+
+static const TypeInfo imx_gpcv2_info = {
+    .name          = TYPE_IMX_GPCV2,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXGPCv2State),
+    .instance_init = imx_gpcv2_init,
+    .class_init    = imx_gpcv2_class_init,
+};
+
+static void imx_gpcv2_register_type(void)
+{
+    type_register_static(&imx_gpcv2_info);
+}
+type_init(imx_gpcv2_register_type)
diff --git a/include/hw/intc/imx_gpcv2.h b/include/hw/intc/imx_gpcv2.h
new file mode 100644
index 0000000000..ed978b24bb
--- /dev/null
+++ b/include/hw/intc/imx_gpcv2.h
@@ -0,0 +1,22 @@
+#ifndef IMX_GPCV2_H
+#define IMX_GPCV2_H
+
+#include "hw/sysbus.h"
+
+enum IMXGPCv2Registers {
+    GPC_NUM        = 0xE00 / sizeof(uint32_t),
+};
+
+typedef struct IMXGPCv2State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[GPC_NUM];
+} IMXGPCv2State;
+
+#define TYPE_IMX_GPCV2 "imx-gpcv2"
+#define IMX_GPCV2(obj) OBJECT_CHECK(IMXGPCv2State, (obj), TYPE_IMX_GPCV2)
+
+#endif /* IMX_GPCV2_H */
-- 
2.13.6
