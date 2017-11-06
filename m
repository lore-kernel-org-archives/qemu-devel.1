Received: from eggs.gnu.org ([2001:4830:134:3::10]:33953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje1-0007VR-VX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje0-0000iF-Hv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:02 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:06 -0800
Message-Id: <20171106154813.19936-24-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 23/30] i.MX: Add code to emulate i.MX7
 USBMISC IP block
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
 hw/usb/Makefile.objs         |  1 +
 hw/usb/imx-usbmisc.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/usb/imx-usbmisc.h | 22 ++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/usb/imx-usbmisc.c
 create mode 100644 include/hw/usb/imx-usbmisc.h

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 97f1c4561a..813359fadc 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -12,6 +12,7 @@ common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
 obj-$(CONFIG_TUSB6010) += tusb6010.o
+obj-$(CONFIG_IMX)      += imx-usbmisc.o
 
 # emulated usb devices
 common-obj-$(CONFIG_USB) += dev-hub.o
diff --git a/hw/usb/imx-usbmisc.c b/hw/usb/imx-usbmisc.c
new file mode 100644
index 0000000000..d5e236a4be
--- /dev/null
+++ b/hw/usb/imx-usbmisc.c
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
+#include "hw/usb/imx-usbmisc.h"
+#include "qemu/log.h"
+
+static void imx_usbmisc_reset(DeviceState *dev)
+{
+    IMXUSBMiscState *s = IMX_USBMISC(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static uint64_t imx_usbmisc_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    IMXUSBMiscState *s = opaque;
+    return s->regs[offset / sizeof(uint32_t)];
+}
+
+static void imx_usbmisc_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+    IMXUSBMiscState *s = opaque;
+    s->regs[offset / sizeof(uint32_t)] = value;
+}
+
+static const struct MemoryRegionOps imx_usbmisc_ops = {
+    .read = imx_usbmisc_read,
+    .write = imx_usbmisc_write,
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
+static void imx_usbmisc_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMXUSBMiscState *s = IMX_USBMISC(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx_usbmisc_ops,
+                          s,
+                          TYPE_IMX_USBMISC ".iomem",
+                          sizeof(s->regs));
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_imx_usbmisc = {
+    .name = TYPE_IMX_USBMISC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, IMXUSBMiscState, USBMISC_NUM),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx_usbmisc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = imx_usbmisc_reset;
+    dc->vmsd  = &vmstate_imx_usbmisc;
+    dc->desc  = "i.MX IOMUXC Module";
+}
+
+static const TypeInfo imx_usbmisc_info = {
+    .name          = TYPE_IMX_USBMISC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXUSBMiscState),
+    .instance_init = imx_usbmisc_init,
+    .class_init    = imx_usbmisc_class_init,
+};
+
+static void imx_usbmisc_register_type(void)
+{
+    type_register_static(&imx_usbmisc_info);
+}
+type_init(imx_usbmisc_register_type)
diff --git a/include/hw/usb/imx-usbmisc.h b/include/hw/usb/imx-usbmisc.h
new file mode 100644
index 0000000000..64b06f3d3c
--- /dev/null
+++ b/include/hw/usb/imx-usbmisc.h
@@ -0,0 +1,22 @@
+#ifndef IMX_USBMISC_H
+#define IMX_USBMISC_H
+
+#include "hw/sysbus.h"
+
+enum IMXUSBMiscRegisters {
+    USBMISC_NUM = 0x24 / sizeof(uint32_t) + 1,
+};
+
+typedef struct IMXUSBMiscState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    uint32_t     regs[USBMISC_NUM];
+} IMXUSBMiscState;
+
+#define TYPE_IMX_USBMISC "imx-usbmisc"
+#define IMX_USBMISC(obj) OBJECT_CHECK(IMXUSBMiscState, (obj), TYPE_IMX_USBMISC)
+
+#endif /* IMX_USBMISC_H */
-- 
2.13.6
