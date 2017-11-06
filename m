Received: from eggs.gnu.org ([2001:4830:134:3::10]:33725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjds-0007K8-Cx
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdr-0000bW-9u
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:52 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:58 -0800
Message-Id: <20171106154813.19936-16-andrew.smirnov@gmail.com>
In-Reply-To: <20171106154813.19936-1-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/30] i.MX: Add code to emulate i.MX7 SNVS
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

Add code to emulate SNVS IP-block. Currently only the bits needed to
be able to emulate machine shutdown are implemented.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/misc/Makefile.objs       |  1 +
 hw/misc/imx7_snvs.c         | 83 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/imx7_snvs.h | 35 +++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 hw/misc/imx7_snvs.c
 create mode 100644 include/hw/misc/imx7_snvs.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c393a93456..16cee88e0f 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -36,6 +36,7 @@ obj-$(CONFIG_IMX) += imx6_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
 obj-$(CONFIG_IMX) += imx7_ccm.o
 obj-$(CONFIG_IMX) += imx2_wdt.o
+obj-$(CONFIG_IMX) += imx7_snvs.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
new file mode 100644
index 0000000000..670b9f4639
--- /dev/null
+++ b/hw/misc/imx7_snvs.c
@@ -0,0 +1,83 @@
+/*
+ * IMX7 Secure Non-Volatile Storage
+ *
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * Bare minimum emulation code needed to support being able to shut
+ * down linux guest gracefully.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/imx7_snvs.h"
+#include "qemu/log.h"
+#include "sysemu/sysemu.h"
+
+static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void imx7_snvs_write(void *opaque, hwaddr offset,
+                            uint64_t v, unsigned size)
+{
+    const uint32_t value = v;
+    const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
+
+    if (offset == SNVS_LPCR && ((value & mask) == mask)) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
+static const struct MemoryRegionOps imx7_snvs_ops = {
+    .read = imx7_snvs_read,
+    .write = imx7_snvs_write,
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
+static void imx7_snvs_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX7SNVSState *s = IMX7_SNVS(obj);
+
+    memory_region_init_io(&s->mmio, obj, &imx7_snvs_ops, s,
+                          TYPE_IMX7_SNVS, 0x1000);
+
+    sysbus_init_mmio(sd, &s->mmio);
+}
+
+static void imx7_snvs_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc  = "i.MX7 Secure Non-Volatile Storage Module";
+}
+
+static const TypeInfo imx7_snvs_info = {
+    .name          = TYPE_IMX7_SNVS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IMX7SNVSState),
+    .instance_init = imx7_snvs_init,
+    .class_init    = imx7_snvs_class_init,
+};
+
+static void imx7_snvs_register_type(void)
+{
+    type_register_static(&imx7_snvs_info);
+}
+type_init(imx7_snvs_register_type)
diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
new file mode 100644
index 0000000000..255f8f26f9
--- /dev/null
+++ b/include/hw/misc/imx7_snvs.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 SNVS block emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef IMX7_SNVS_H
+#define IMX7_SNVS_H
+
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+
+
+enum IMX7SNVSRegisters {
+    SNVS_LPCR = 0x38,
+    SNVS_LPCR_TOP   = BIT(6),
+    SNVS_LPCR_DP_EN = BIT(5)
+};
+
+#define TYPE_IMX7_SNVS "imx7.snvs"
+#define IMX7_SNVS(obj) OBJECT_CHECK(IMX7SNVSState, (obj), TYPE_IMX7_SNVS)
+
+typedef struct IMX7SNVSState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+} IMX7SNVSState;
+
+#endif /* IMX7_SNVS_H */
-- 
2.13.6
