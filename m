Received: from eggs.gnu.org ([2001:4830:134:3::10]:34136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjeB-0007eW-Qe
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjeA-0000qD-FK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:49:11 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:48:11 -0800
Message-Id: <20171106154813.19936-29-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 28/30] i.MX: Add code to emulate i.MX LCD
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

Add basic i.MX LCD block emulation code needed to boot Linux guest.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/display/Makefile.objs       |  2 ++
 hw/display/imx_lcdif.c         | 71 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/display/imx_lcdif.h | 16 ++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 hw/display/imx_lcdif.c
 create mode 100644 include/hw/display/imx_lcdif.h

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 551c050a6a..a7b34be231 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -41,3 +41,5 @@ virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) += dpcd.o
 obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dp.o
+
+obj-$(CONFIG_IMX) += imx_lcdif.o
diff --git a/hw/display/imx_lcdif.c b/hw/display/imx_lcdif.c
new file mode 100644
index 0000000000..1d7ad4a77b
--- /dev/null
+++ b/hw/display/imx_lcdif.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX LCD block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/display/imx_lcdif.h"
+#include "qemu/log.h"
+
+static uint64_t imx_lcdif_read(void *opaque, hwaddr offset,
+                               unsigned size)
+{
+    return 0;
+}
+
+static void imx_lcdif_write(void *opaque, hwaddr offset,
+                            uint64_t value, unsigned size)
+{
+}
+
+static const struct MemoryRegionOps imx_lcdif_ops = {
+    .read       = imx_lcdif_read,
+    .write      = imx_lcdif_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned       = false,
+    },
+};
+
+static void imx_lcdif_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMXLCDState *s = IMX_LCDIF(obj);
+
+    memory_region_init_io(&s->iomem,
+                          obj,
+                          &imx_lcdif_ops,
+                          s,
+                          TYPE_IMX_LCDIF ".iomem",
+                          0x10000);
+    sysbus_init_mmio(sd, &s->iomem);
+}
+
+static void imx_lcdif_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc  = "i.MX LCD Controller";
+}
+
+static const TypeInfo imx_lcdif_info = {
+    .name          = TYPE_IMX_LCDIF,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMXLCDState),
+    .instance_init = imx_lcdif_init,
+    .class_init    = imx_lcdif_class_init,
+};
+
+static void imx_lcdif_register_type(void)
+{
+    type_register_static(&imx_lcdif_info);
+}
+type_init(imx_lcdif_register_type)
diff --git a/include/hw/display/imx_lcdif.h b/include/hw/display/imx_lcdif.h
new file mode 100644
index 0000000000..51985d3054
--- /dev/null
+++ b/include/hw/display/imx_lcdif.h
@@ -0,0 +1,16 @@
+#ifndef IMX_LCDIF_H
+#define IMX_LCDIF_H
+
+#include "hw/sysbus.h"
+
+typedef struct IMXLCDState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+} IMXLCDState;
+
+#define TYPE_IMX_LCDIF "imx:lcdif"
+#define IMX_LCDIF(obj) OBJECT_CHECK(IMXLCDState, (obj), TYPE_IMX_LCDIF)
+
+#endif /* IMX_LCDIF_H */
-- 
2.13.6
