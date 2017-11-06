Received: from eggs.gnu.org ([2001:4830:134:3::10]:33997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje3-0007W7-P2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBje2-0000ko-Gi
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:03 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:09 -0800
Message-Id: <20171106154813.19936-27-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 26/30] usb: Add basic code to emulate
 Chipidea USB IP
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

Add code to emulate Chipidea USB IP (used in i.MX SoCs). Tested to
work against:

-usb -drive if=none,id=stick,file=usb.img,format=raw -device \
 usb-storage,bus=usb-bus.0,drive=stick

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/usb/Makefile.objs      |   1 +
 hw/usb/chipidea.c         | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/usb/chipidea.h |  16 +++++
 3 files changed, 193 insertions(+)
 create mode 100644 hw/usb/chipidea.c
 create mode 100644 include/hw/usb/chipidea.h

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 813359fadc..fe8a4a6c64 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -13,6 +13,7 @@ common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
 obj-$(CONFIG_TUSB6010) += tusb6010.o
 obj-$(CONFIG_IMX)      += imx-usbmisc.o
+obj-$(CONFIG_IMX)      += chipidea.o
 
 # emulated usb devices
 common-obj-$(CONFIG_USB) += dev-hub.o
diff --git a/hw/usb/chipidea.c b/hw/usb/chipidea.c
new file mode 100644
index 0000000000..9bc8df448c
--- /dev/null
+++ b/hw/usb/chipidea.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * Chipidea USB block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/chipidea.h"
+#include "qemu/log.h"
+
+enum {
+    CHIPIDEA_USBx_DCIVERSION   = 0x000,
+    CHIPIDEA_USBx_DCCPARAMS    = 0x004,
+    CHIPIDEA_USBx_DCCPARAMS_HC = BIT(8),
+};
+
+static uint64_t chipidea_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    return 0;
+}
+
+static void chipidea_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+}
+
+static const struct MemoryRegionOps chipidea_ops = {
+    .read = chipidea_read,
+    .write = chipidea_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the
+         * real device but in practice there is no reason for a guest
+         * to access this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static uint64_t chipidea_dc_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    switch (offset) {
+    case CHIPIDEA_USBx_DCIVERSION:
+        return 0x1;
+    case CHIPIDEA_USBx_DCCPARAMS:
+        /*
+         * Real hardware (at least i.MX7) will also report the
+         * controller as "Device Capable" (and 8 supported endpoints),
+         * but there doesn't seem to be much point in doing so, since
+         * we don't emulate that part.
+         */
+        return CHIPIDEA_USBx_DCCPARAMS_HC;
+    }
+
+    return 0;
+}
+
+static void chipidea_dc_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+}
+
+static const struct MemoryRegionOps chipidea_dc_ops = {
+    .read = chipidea_dc_read,
+    .write = chipidea_dc_write,
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
+static void chipidea_init(Object *obj)
+{
+    EHCIState *ehci = &SYS_BUS_EHCI(obj)->ehci;
+    ChipideaState *ci = CHIPIDEA(obj);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(ci->iomem); i++) {
+        const struct {
+            const char *name;
+            hwaddr offset;
+            uint64_t size;
+            const struct MemoryRegionOps *ops;
+        } regions[ARRAY_SIZE(ci->iomem)] = {
+            /*
+             * Registers located between offsets 0x000 and 0xFC
+             */
+            {
+                .name   = TYPE_CHIPIDEA ".misc",
+                .offset = 0x000,
+                .size   = 0x100,
+                .ops    = &chipidea_ops,
+            },
+            /*
+             * Registers located between offsets 0x1A4 and 0x1DC
+             */
+            {
+                .name   = TYPE_CHIPIDEA ".endpoints",
+                .offset = 0x1A4,
+                .size   = 0x1DC - 0x1A4 + 4,
+                .ops    = &chipidea_ops,
+            },
+            /*
+             * USB_x_DCIVERSION and USB_x_DCCPARAMS
+             */
+            {
+                .name   = TYPE_CHIPIDEA ".dc",
+                .offset = 0x120,
+                .size   = 8,
+                .ops    = &chipidea_dc_ops,
+            },
+        };
+
+        memory_region_init_io(&ci->iomem[i],
+                              obj,
+                              regions[i].ops,
+                              ci,
+                              regions[i].name,
+                              regions[i].size);
+
+        memory_region_add_subregion(&ehci->mem,
+                                    regions[i].offset,
+                                    &ci->iomem[i]);
+    }
+}
+
+static void chipidea_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(klass);
+
+    /*
+     * Offsets used were taken from i.MX7Dual Applications Processor
+     * Reference Manual, Rev 0.1, p. 3177, Table 11-59
+     */
+    sec->capsbase   = 0x100;
+    sec->opregbase  = 0x140;
+    sec->portnr     = 1;
+
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    dc->desc = "Chipidea USB Module";
+}
+
+static const TypeInfo chipidea_info = {
+    .name          = TYPE_CHIPIDEA,
+    .parent        = TYPE_SYS_BUS_EHCI,
+    .instance_size = sizeof(ChipideaState),
+    .instance_init = chipidea_init,
+    .class_init    = chipidea_class_init,
+};
+
+static void chipidea_register_type(void)
+{
+    type_register_static(&chipidea_info);
+}
+type_init(chipidea_register_type)
diff --git a/include/hw/usb/chipidea.h b/include/hw/usb/chipidea.h
new file mode 100644
index 0000000000..1ec2e9dbda
--- /dev/null
+++ b/include/hw/usb/chipidea.h
@@ -0,0 +1,16 @@
+#ifndef CHIPIDEA_H
+#define CHIPIDEA_H
+
+#include "hw/usb/hcd-ehci.h"
+
+typedef struct ChipideaState {
+    /*< private >*/
+    EHCISysBusState parent_obj;
+
+    MemoryRegion iomem[3];
+} ChipideaState;
+
+#define TYPE_CHIPIDEA "usb-chipidea"
+#define CHIPIDEA(obj) OBJECT_CHECK(ChipideaState, (obj), TYPE_CHIPIDEA)
+
+#endif /* CHIPIDEA_H */
-- 
2.13.6
