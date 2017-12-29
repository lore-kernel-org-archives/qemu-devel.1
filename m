Received: from eggs.gnu.org ([2001:4830:134:3::10]:56798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynF-0002px-SR
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynF-0005Xv-0r
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:05 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynE-0005Wk-SA
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:04 -0500
Received: by mail-qt0-x244.google.com with SMTP id i40so54935013qti.8
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:48:56 -0300
Message-Id: <20171229174933.1781-6-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/42] sdhci: refactor common sysbus/pci
 class_init() into sdhci_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a11469fbca..38d82b4c61 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1275,6 +1275,16 @@ static Property sdhci_properties[] = {
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
@@ -1299,7 +1309,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
 
 static void sdhci_pci_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = sdhci_pci_realize;
@@ -1307,10 +1316,8 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
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
@@ -1356,10 +1363,9 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
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
