Received: from eggs.gnu.org ([2001:4830:134:3::10]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erALL-0000rg-QA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erALH-0008Oq-FF
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:59 -0500
Received: from mail-by2nam01on0058.outbound.protection.outlook.com
	([104.47.34.58]:22885
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erALG-0008Mi-Qs
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:55 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 28 Feb 2018 14:32:03 -0800
Message-ID: <c11bf012dbb789aa9e467cfaee1d8b9a10357282.1519856998.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1519856998.git.alistair.francis@xilinx.com>
References: <cover.1519856998.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/5] hw/gpio: Add the xlnx-pmu-iomod-gpo
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 include/hw/gpio/xlnx-pmu-iomod-gp.h |  52 +++++++++++++
 hw/gpio/xlnx-pmu-iomod-gp.c         | 150 ++++++++++++++++++++++++++++++++++++
 hw/gpio/Makefile.objs               |   2 +
 3 files changed, 204 insertions(+)
 create mode 100644 include/hw/gpio/xlnx-pmu-iomod-gp.h
 create mode 100644 hw/gpio/xlnx-pmu-iomod-gp.c

diff --git a/include/hw/gpio/xlnx-pmu-iomod-gp.h b/include/hw/gpio/xlnx-pmu-iomod-gp.h
new file mode 100644
index 0000000000..0ee162829b
--- /dev/null
+++ b/include/hw/gpio/xlnx-pmu-iomod-gp.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU model of Xilinx I/O Module GPO
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_XLNX_ZYNQMP_IOMOD_GPIO_H
+#define HW_XLNX_ZYNQMP_IOMOD_GPIO_H
+
+#include "qemu/osdep.h"
+
+#define TYPE_XLNX_ZYNQMP_IOMOD_GPIO "xlnx.pmu_iomodule_gpio"
+
+#define XLNX_ZYNQMP_IOMOD_GPIO(obj) \
+     OBJECT_CHECK(XlnxPMUIOGPIO, (obj), TYPE_XLNX_ZYNQMP_IOMOD_GPIO)
+
+#define XLNX_ZYNQMP_IOMOD_GPIO_R_MAX (0x00 + 1)
+
+typedef struct XlnxPMUIOGPIO {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    uint32_t size;
+
+    /* GPO */
+    uint32_t init;
+    qemu_irq outputs[32];
+
+    uint32_t regs[XLNX_ZYNQMP_IOMOD_GPIO_R_MAX];
+    RegisterInfo regs_info[XLNX_ZYNQMP_IOMOD_GPIO_R_MAX];
+} XlnxPMUIOGPIO;
+
+#endif /* HW_XLNX_ZYNQMP_IOMOD_GPIO_H */
diff --git a/hw/gpio/xlnx-pmu-iomod-gp.c b/hw/gpio/xlnx-pmu-iomod-gp.c
new file mode 100644
index 0000000000..0e45a89b44
--- /dev/null
+++ b/hw/gpio/xlnx-pmu-iomod-gp.c
@@ -0,0 +1,150 @@
+/*
+ * QEMU model of Xilinx I/O Module GPO
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "qemu/log.h"
+#include "hw/gpio/xlnx-pmu-iomod-gp.h"
+
+#ifndef XLNX_ZYNQMP_IOMOD_GPIO_DEBUG
+#define XLNX_ZYNQMP_IOMOD_GPIO_DEBUG 0
+#endif
+
+REG32(GPO0, 0x00)
+
+static void xlnx_iomod_gpio_gpo0_prew(RegisterInfo *reg, uint64_t value)
+{
+    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(reg->opaque);
+    unsigned int i;
+
+    for (i = 0; i < s->size; i++) {
+        bool flag = !!(value & (1 << i));
+        qemu_set_irq(s->outputs[i], flag);
+    }
+}
+
+static uint64_t xlnx_iomod_gpio_gpo0_postr(RegisterInfo *reg, uint64_t value)
+{
+    return 0;
+}
+
+static const RegisterAccessInfo xlnx_iomod_gpio_regs_info[] = {
+    {   .name = "GPO0",  .addr = A_GPO0,
+        .post_write = xlnx_iomod_gpio_gpo0_prew,
+        .post_read = xlnx_iomod_gpio_gpo0_postr,
+    }
+};
+
+static void xlnx_iomod_gpio_reset(DeviceState *dev)
+{
+    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+
+    xlnx_iomod_gpio_gpo0_prew(&s->regs_info[R_GPO0], s->init);
+}
+
+static const MemoryRegionOps xlnx_iomod_gpio_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void xlnx_iomod_gpio_realize(DeviceState *dev, Error **errp)
+{
+    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(dev);
+
+    assert(s->size <= 32);
+    qdev_init_gpio_out(dev, s->outputs, s->size);
+}
+
+static void xlnx_iomod_gpio_init(Object *obj)
+{
+    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_IOMOD_GPIO,
+                       XLNX_ZYNQMP_IOMOD_GPIO_R_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), xlnx_iomod_gpio_regs_info,
+                              ARRAY_SIZE(xlnx_iomod_gpio_regs_info),
+                              s->regs_info, s->regs,
+                              &xlnx_iomod_gpio_ops,
+                              XLNX_ZYNQMP_IOMOD_GPIO_DEBUG,
+                              XLNX_ZYNQMP_IOMOD_GPIO_R_MAX * 4);
+    memory_region_add_subregion(&s->iomem,
+                                0x0,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_xlnx_iomod_gpio = {
+    .name = TYPE_XLNX_ZYNQMP_IOMOD_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property xlnx_iomod_gpio_properties[] = {
+    DEFINE_PROP_UINT32("size", XlnxPMUIOGPIO, size, 0),
+    DEFINE_PROP_UINT32("gpo-init", XlnxPMUIOGPIO, init, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xlnx_iomod_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = xlnx_iomod_gpio_reset;
+    dc->realize = xlnx_iomod_gpio_realize;
+    dc->props = xlnx_iomod_gpio_properties;
+    dc->vmsd = &vmstate_xlnx_iomod_gpio;
+}
+
+static const TypeInfo xlnx_iomod_gpio_info = {
+    .name          = TYPE_XLNX_ZYNQMP_IOMOD_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxPMUIOGPIO),
+    .class_init    = xlnx_iomod_gpio_class_init,
+    .instance_init = xlnx_iomod_gpio_init,
+};
+
+static void xlnx_iomod_gpio_register_types(void)
+{
+    type_register_static(&xlnx_iomod_gpio_info);
+}
+
+type_init(xlnx_iomod_gpio_register_types)
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index fa0a72e6d0..4cefadee85 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -8,3 +8,5 @@ common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
 obj-$(CONFIG_OMAP) += omap_gpio.o
 obj-$(CONFIG_IMX) += imx_gpio.o
 obj-$(CONFIG_RASPI) += bcm2835_gpio.o
+
+obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-pmu-iomod-gp.o
-- 
2.14.1
