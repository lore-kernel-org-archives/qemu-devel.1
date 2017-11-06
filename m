Received: from eggs.gnu.org ([2001:4830:134:3::10]:33992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje3-0007W6-GR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje1-0000k4-Qj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:03 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:07 -0800
Message-Id: <20171106154813.19936-25-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 24/30] i.MX: Add code to emulate i.MX7 ADC
 IP block
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
 hw/misc/imx7_adc.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/imx7_adc.h | 22 +++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/misc/imx7_adc.c
 create mode 100644 include/hw/misc/imx7_adc.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c9944161bd..b578bd0cba 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -39,6 +39,7 @@ obj-$(CONFIG_IMX) += imx2_wdt.o
 obj-$(CONFIG_IMX) += imx7_snvs.o
 obj-$(CONFIG_IMX) += imx7_iomuxc.o
 obj-$(CONFIG_IMX) += imx_flexcan.o
+obj-$(CONFIG_IMX) += imx7_adc.o
 obj-$(CONFIG_IMX) += imx7_gpr.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
diff --git a/hw/misc/imx7_adc.c b/hw/misc/imx7_adc.c
new file mode 100644
index 0000000000..7945e99075
--- /dev/null
+++ b/hw/misc/imx7_adc.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 ADC block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx7_adc.h"
+#include "qemu/log.h"
+
+static void imx7_adc_reset(DeviceState *dev)
+{
+    IMX7ADCState *s = IMX7_ADC(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx7_adc_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMX7ADCState *s = opaque;
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx7_adc_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMX7ADCState *s = opaque;
+    s->regs[offset / sizeof(uint32_t)] = value;
+}
+
+static const struct MemoryRegionOps imx7_adc_ops = {
+    .read = imx7_adc_read,
+    .write = imx7_adc_write,
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
+static void imx7_adc_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX7ADCState *s = IMX7_ADC(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx7_adc_ops,
+                          s,
+                          TYPE_IMX7_ADC ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx7_adc = {
+    .name = TYPE_IMX7_ADC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMX7ADCState, ADC_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx7_adc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx7_adc_reset;
+    dc->vmsd  = &vmstate_imx7_adc;
+    dc->desc  = "i.MX ADC Module";
+}
+
+static const TypeInfo imx7_adc_info = {
+    .name          = TYPE_IMX7_ADC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX7ADCState),
+    .instance_init = imx7_adc_init,
+    .class_init    = imx7_adc_class_init,
+};
+
+static void imx7_adc_register_type(void)
+{
+    type_register_static(&imx7_adc_info);
+}
+type_init(imx7_adc_register_type)
diff --git a/include/hw/misc/imx7_adc.h b/include/hw/misc/imx7_adc.h
new file mode 100644
index 0000000000..4a61c52caf
--- /dev/null
+++ b/include/hw/misc/imx7_adc.h
@@ -0,0 +1,22 @@
+#ifndef IMX7_ADC_H
+#define IMX7_ADC_H
+
+#include "hw/sysbus.h"
+
+enum IMX7ADCRegisters {
+    ADC_NUM = 0x130 / sizeof(uint32_t) + 1,
+};
+
+typedef struct IMX7ADCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[ADC_NUM];
+} IMX7ADCState;
+
+#define TYPE_IMX7_ADC "imx7-adc"
+#define IMX7_ADC(obj) OBJECT_CHECK(IMX7ADCState, (obj), TYPE_IMX7_ADC)
+
+#endif /* IMX7_ADC_H */
-- 
2.13.6
