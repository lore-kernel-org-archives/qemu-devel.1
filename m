Received: from eggs.gnu.org ([2001:4830:134:3::10]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbv-0002nB-TU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZbu-0008Ip-Qz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:15 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:54 -0300
Message-Id: <20180108154303.6522-23-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 22/31] sdhci: add the generic Arasan SDHCI
 8.9a PHY
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
 hw/sd/arasan_sdhci.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/sd/arasan_sdhci.c b/hw/sd/arasan_sdhci.c
index c6d96b2583..11160baa22 100644
--- a/hw/sd/arasan_sdhci.c
+++ b/hw/sd/arasan_sdhci.c
@@ -49,6 +49,42 @@ static void arasan4_9a_sdhci_realize(DeviceState *dev, Error **errp)
     }
 }
 
+/* Compatible with:
+ * - SD Host Controller Specification Version 3.00
+ * - SDIO Specification Version 3.0
+ * - eMMC Specification Version 4.51
+ *
+ * Host clock rate variable between 0 and 208 MHz
+ * Transfers the data in SDR104, SDR50, DDR50 modes
+ * (SDR104 mode: up to 832Mbits/s using 4 parallel data lines)
+ * Transfers the data in 1 bit and 4 bit SD modes
+ * UHS speed modes, 1.8V
+ * voltage switch, tuning commands
+ */
+static void arasan8_9a_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_GET_CLASS(dev);
+    Object *obj = OBJECT(dev);
+    Error *local_err = NULL;
+
+    object_property_set_uint(obj, 3, "sd-spec-version", &local_err);
+    object_property_set_bool(obj, true, "suspend", &local_err);
+    object_property_set_bool(obj, true, "1v8", &local_err);
+    object_property_set_bool(obj, true, "64bit", &local_err);
+    object_property_set_uint(obj, 0b111, "bus-speed", &local_err);
+    object_property_set_uint(obj, 0b111, "driver-strength", &local_err);
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
 static void arasan4_9a_sdhci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -58,15 +94,31 @@ static void arasan4_9a_sdhci_class_init(ObjectClass *klass, void *data)
     dc->realize = arasan4_9a_sdhci_realize;
 }
 
+static void arasan8_9a_sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCICommonClass *cc = SYSBUS_SDHCI_COMMON_CLASS(klass);
+
+    cc->parent_realize = dc->realize;
+    dc->realize = arasan8_9a_sdhci_realize;
+}
+
 static const TypeInfo arasan4_9a_sdhci_info = {
     .name = "arasan,sdhci-4.9a",
     .parent = TYPE_SYSBUS_SDHCI,
     .class_init = arasan4_9a_sdhci_class_init,
 };
 
+static const TypeInfo arasan8_9a_sdhci_info = {
+    .name = "arasan,sdhci-8.9a",
+    .parent = TYPE_SYSBUS_SDHCI,
+    .class_init = arasan8_9a_sdhci_class_init,
+};
+
 static void arasan_sdhci_register_types(void)
 {
     type_register_static(&arasan4_9a_sdhci_info);
+    type_register_static(&arasan8_9a_sdhci_info);
 }
 
 type_init(arasan_sdhci_register_types)
-- 
2.15.1
