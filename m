Received: from eggs.gnu.org ([2001:4830:134:3::10]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZb8-0001wR-9I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZb7-0007b8-4S
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:26 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:44 -0300
Message-Id: <20180108154303.6522-13-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 12/31] sdhci: add the generic Arasan SDHCI
 4.9a PHY controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/arasan_sdhci.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs  |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 hw/sd/arasan_sdhci.c

diff --git a/hw/sd/arasan_sdhci.c b/hw/sd/arasan_sdhci.c
new file mode 100644
index 0000000000..c6d96b2583
--- /dev/null
+++ b/hw/sd/arasan_sdhci.c
@@ -0,0 +1,72 @@
+/*
+ * Arasan SDHCI Controller emulation
+ *
+ * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "hw/sd/sdhci.h"
+#include "qapi/error.h"
+
+/* Compatible with:
+ * - SD Host Controller Specification Version 2.0 Part A2
+ * - SDIO Specification Version 2.0
+ * - MMC Specification Version 3.31
+ *
+ * - SDMA (single operation DMA)
+ * - ADMA1 (4 KB boundary limited DMA)
+ * - ADMA2
+ *
+ * - up to seven functions in SD1, SD4, but does not support SPI mode
+ * - SD high-speed (SDHS) card
+ * - SD High Capacity (SDHC) card
+ *
+ * - Low-speed, 1 KHz to 400 KHz
+ * - Full-speed, 1 MHz to 50 MHz (25 MB/sec)
+ */
+static void arasan4_9a_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_GET_CLASS(dev);
+    Object *obj = OBJECT(dev);
+    Error *local_err = NULL;
+
+    object_property_set_uint(obj, 2, "sd-spec-version", &local_err);
+    object_property_set_bool(obj, true, "adma1", &local_err);
+    object_property_set_bool(obj, true, "high-speed", &local_err);
+    object_property_set_uint(obj, 1024, "max-block-length", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void arasan4_9a_sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_CLASS(klass);
+
+    cc->parent_realize = dc->realize;
+    dc->realize = arasan4_9a_sdhci_realize;
+}
+
+static const TypeInfo arasan4_9a_sdhci_info = {
+    .name = "arasan,sdhci-4.9a",
+    .parent = TYPE_SYSBUS_SDHCI,
+    .class_init = arasan4_9a_sdhci_class_init,
+};
+
+static void arasan_sdhci_register_types(void)
+{
+    type_register_static(&arasan4_9a_sdhci_info);
+}
+
+type_init(arasan_sdhci_register_types)
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index fd866d7f94..ef0fc3d3f7 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -3,6 +3,7 @@ common-obj-$(CONFIG_SD) += core.o
 
 # SD/MMC host adapters
 common-obj-$(CONFIG_PL181) += pl181.o
+common-obj-$(CONFIG_ZYNQ) += arasan_sdhci.o
 common-obj-$(CONFIG_EXYNOS4) += dw-mshc.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
-- 
2.15.1
