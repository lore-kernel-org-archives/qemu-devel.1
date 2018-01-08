Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbc-0002P1-NV
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbb-0007yS-Cm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:56 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:50 -0300
Message-Id: <20180108154303.6522-19-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 18/31] sdhci: add the Broadcom BCM2835 SDHCI
 controller
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

based on Arasan SD 3.0, eMMC 4.4

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/bcm2835_sdhci.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs   |  2 +-
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 hw/sd/bcm2835_sdhci.c

diff --git a/hw/sd/bcm2835_sdhci.c b/hw/sd/bcm2835_sdhci.c
new file mode 100644
index 0000000000..3baf0887d8
--- /dev/null
+++ b/hw/sd/bcm2835_sdhci.c
@@ -0,0 +1,77 @@
+/*
+ * Broadcom BCM2835 SDHCI controller emulation
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
+ * - SD Host Controller Specification Version 3.0 Draft 1.0
+ * - SDIO Specification Version 3.0
+ * - MMC Specification Version 4.4
+ *
+ * - 32-bit access only
+ * - default clocks
+ * - no DMA
+ * - SD high-speed (SDHS) card
+ * - maximum block size: 1kB
+ *
+ * For the exact details please refer to the Arasan documentation:
+ *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf   ¯\_(ツ)_/¯
+ */
+static void bcm2835_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_GET_CLASS(dev);
+    Object *obj = OBJECT(dev);
+    Error *local_err = NULL;
+
+    object_property_set_uint(obj, 3, "sd-spec-version", &local_err);
+    object_property_set_uint(obj, 52, "timeout-freq", &local_err);
+    object_property_set_uint(obj, 52, "max-frequency", &local_err);
+    object_property_set_bool(obj, false, "sdma", &local_err);
+    object_property_set_bool(obj, false, "adma1", &local_err);
+    object_property_set_bool(obj, false, "adma2", &local_err);
+    object_property_set_bool(obj, true, "1v8", &local_err);
+    /* FIXME verify/validate with someone from Broadcom?
+    object_property_set_uint(obj, 1024, "max-block-length", &local_err);
+    */
+    object_property_set_bool(obj, true, "pending-insert-quirk",  &local_err);
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
+static void bcm2835_sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_CLASS(klass);
+
+    cc->parent_realize = dc->realize;
+    dc->realize = bcm2835_sdhci_realize;
+}
+
+static const TypeInfo bcm2835_sdhci_info = {
+    .name = "brcm,bcm2835-sdhci",
+    .parent = TYPE_SYSBUS_SDHCI,
+    .class_init = bcm2835_sdhci_class_init,
+};
+
+static void brcm_sdhci_register_types(void)
+{
+    type_register_static(&bcm2835_sdhci_info);
+}
+
+type_init(brcm_sdhci_register_types)
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index ef0fc3d3f7..b3e69c3018 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -10,7 +10,7 @@ common-obj-$(CONFIG_SDHCI) += sdhci.o
 obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
 obj-$(CONFIG_OMAP) += omap_mmc.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
+obj-$(CONFIG_RASPI) += bcm2835_sdhost.o bcm2835_sdhci.o
 
 # emulated SD/MMC devices
 common-obj-$(CONFIG_SD) += sd.o
-- 
2.15.1
