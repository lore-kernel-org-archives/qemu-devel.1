Received: from eggs.gnu.org ([2001:4830:134:3::10]:53694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgUD-0005nM-9i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgUA-0000ys-57
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:33 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:33 -0300
Message-Id: <20171215031547.31006-7-f4bug@amsat.org>
In-Reply-To: <20171215031547.31006-1-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/20] sdhci: refactor common sysbus/pci
 class_init() into sdhci_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index fc5bac5cb9..f574495b19 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1283,6 +1283,16 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void sdhci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->vmsd = &sdhci_vmstate;
+    dc->props = sdhci_properties;
+    dc->reset = sdhci_poweron_reset;
+}
+
 /* --- qdev PCI --- */
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
@@ -1306,7 +1316,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
 
 static void sdhci_pci_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = sdhci_pci_realize;
@@ -1314,10 +1323,8 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_properties;
-    dc->reset = sdhci_poweron_reset;
+
+    sdhci_class_init(klass, data);
 }
 
 static const TypeInfo sdhci_pci_info = {
@@ -1361,10 +1368,9 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_properties;
     dc->realize = sdhci_sysbus_realize;
-    dc->reset = sdhci_poweron_reset;
+
+    sdhci_class_init(klass, data);
 }
 
 static const TypeInfo sdhci_sysbus_info = {
-- 
2.15.1
