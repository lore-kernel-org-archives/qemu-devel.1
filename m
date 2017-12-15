Received: from eggs.gnu.org ([2001:4830:134:3::10]:53589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgU4-0005gL-6g
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgU1-0000rP-22
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:24 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:31 -0300
Message-Id: <20171215031547.31006-5-f4bug@amsat.org>
In-Reply-To: <20171215031547.31006-1-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/20] sdhci: refactor same sysbus/pci
 properties into a common one
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

add sysbus/pci/sdbus separator comments to keep it clearer

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2823da00da..dbdfd54350 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1265,13 +1265,17 @@ const VMStateDescription sdhci_vmstate = {
 
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
-static Property sdhci_pci_properties[] = {
+static Property sdhci_properties[] = {
     DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
             SDHC_CAPAB_REG_DEFAULT),
     DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
+    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/* --- qdev PCI --- */
+
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
     SDHCIState *s = PCI_SDHCI(dev);
@@ -1304,7 +1308,7 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_pci_properties;
+    dc->props = sdhci_properties;
     dc->reset = sdhci_poweron_reset;
 }
 
@@ -1319,14 +1323,7 @@ static const TypeInfo sdhci_pci_info = {
     },
 };
 
-static Property sdhci_sysbus_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
-    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
-                     false),
-    DEFINE_PROP_END_OF_LIST(),
-};
+/* --- qdev SysBus --- */
 
 static void sdhci_sysbus_init(Object *obj)
 {
@@ -1359,7 +1356,7 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_sysbus_properties;
+    dc->props = sdhci_properties;
     dc->realize = sdhci_sysbus_realize;
     dc->reset = sdhci_poweron_reset;
 }
@@ -1373,6 +1370,8 @@ static const TypeInfo sdhci_sysbus_info = {
     .class_init = sdhci_sysbus_class_init,
 };
 
+/* --- qdev bus master --- */
+
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
-- 
2.15.1
