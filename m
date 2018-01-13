Received: from eggs.gnu.org ([2001:4830:134:3::10]:47071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2m-0000Rx-Ch
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2l-00040z-F4
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:48 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2l-00040b-AM
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:47 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so8538124qtr.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:07:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:07 -0300
Message-Id: <20180113050717.22969-5-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 04/14] sdhci: refactor common sysbus/pci
 class_init() into sdhci_common_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>

Now both inherited classes appear as DEVICE_CATEGORY_STORAGE.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6c3389cfdc..191f0d26ee 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1280,6 +1280,15 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
+static void sdhci_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->vmsd = &sdhci_vmstate;
+    dc->reset = sdhci_poweron_reset;
+}
+
 /* --- qdev PCI --- */
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
@@ -1304,7 +1313,6 @@ static void sdhci_pci_exit(PCIDevice *dev)
 
 static void sdhci_pci_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = sdhci_pci_realize;
@@ -1312,9 +1320,8 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_SDHCI;
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->vmsd = &sdhci_vmstate;
-    dc->reset = sdhci_poweron_reset;
+
+    sdhci_common_class_init(klass, data);
 }
 
 static const TypeInfo sdhci_pci_info = {
@@ -1368,9 +1375,9 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->vmsd = &sdhci_vmstate;
     dc->realize = sdhci_sysbus_realize;
-    dc->reset = sdhci_poweron_reset;
+
+    sdhci_common_class_init(klass, data);
 }
 
 static const TypeInfo sdhci_sysbus_info = {
-- 
2.15.1
