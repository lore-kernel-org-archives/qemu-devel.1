Received: from eggs.gnu.org ([2001:4830:134:3::10]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbl-0002ZU-UW
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbk-00086B-Ti
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:52 -0300
Message-Id: <20180108154303.6522-21-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 20/31] sdhci: add the Freescale controller
 for i.MX
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
 hw/sd/fsl-sdhc.c    | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 hw/sd/fsl-sdhc.c

diff --git a/hw/sd/fsl-sdhc.c b/hw/sd/fsl-sdhc.c
new file mode 100644
index 0000000000..aa8075a9e5
--- /dev/null
+++ b/hw/sd/fsl-sdhc.c
@@ -0,0 +1,58 @@
+/*
+ * Freescale SD Host Controller for i.MX emulation
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
+/* UHS-I SDIO3.0 SDR104 1.8V ADMA */
+static void fsl_imx6q_usdhc_realize(DeviceState *dev, Error **errp)
+{
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_GET_CLASS(dev);
+    Object *obj = OBJECT(dev);
+    Error *local_err = NULL;
+
+    object_property_set_uint(obj, 3, "sd-spec-version", &local_err);
+    object_property_set_uint(obj, 52, "timeout-freq", &local_err);
+    object_property_set_uint(obj, 52, "max-frequency", &local_err);
+    object_property_set_bool(obj, true, "adma1", &local_err);
+    object_property_set_bool(obj, true, "1v8", &local_err);
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
+static void fsl_imx6q_usdhc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_CLASS(klass);
+
+    cc->parent_realize = dc->realize;
+    dc->realize = fsl_imx6q_usdhc_realize;
+}
+
+static const TypeInfo fsl_imx6q_usdhc_info = {
+    .name = "fsl,imx6q-usdhc",
+    .parent = TYPE_SYSBUS_SDHCI,
+    .class_init = fsl_imx6q_usdhc_class_init,
+};
+
+static void fsl_imx_sdhc_register_types(void)
+{
+    type_register_static(&fsl_imx6q_usdhc_info);
+}
+
+type_init(fsl_imx_sdhc_register_types)
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index b3e69c3018..b058a9328e 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) += core.o
 # SD/MMC host adapters
 common-obj-$(CONFIG_PL181) += pl181.o
 common-obj-$(CONFIG_ZYNQ) += arasan_sdhci.o
+common-obj-$(CONFIG_IMX) += fsl-sdhc.o
 common-obj-$(CONFIG_EXYNOS4) += dw-mshc.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
-- 
2.15.1
