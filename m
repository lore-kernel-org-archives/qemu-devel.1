Received: from eggs.gnu.org ([2001:4830:134:3::10]:39514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuF-0004Wy-NG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuC-0007C3-Ip
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:31 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDuC-0007BX-D0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:45:28 -0500
Received: by mail-qk0-x241.google.com with SMTP id c13so3676009qke.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:45:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:34 -0300
Message-Id: <20171213204436.5379-10-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] sdhci: implement the SD_BUS_MASTER
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

The SDHCI is a SD master, let it implement the SD_BUS_MASTER interface,
this even allow remove the SDHCI_BUS type.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 40596f6ebe..d8188fdc2a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -35,9 +35,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#define TYPE_SDHCI_BUS "sdhci-bus"
-#define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
-
 /* Default SD/MMC host controller features information, which will be
  * presented in CAPABILITIES register of generic SD host controller at reset.
  * If not stated otherwise:
@@ -1279,11 +1276,15 @@ static Property sdhci_properties[] = {
 static void sdhci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SDBusClass *sbc = SDBUS_MASTER_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
     dc->props = sdhci_properties;
     dc->reset = sdhci_poweron_reset;
+
+    sbc->set_inserted = sdhci_set_inserted;
+    sbc->set_readonly = sdhci_set_readonly;
 }
 
 /* --- qdev PCI --- */
@@ -1328,6 +1329,7 @@ static const TypeInfo sdhci_pci_info = {
     .instance_size = sizeof(SDHCIState),
     .class_init = sdhci_pci_class_init,
     .interfaces = (InterfaceInfo[]) {
+        { TYPE_SD_BUS_MASTER_INTERFACE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -1383,30 +1385,16 @@ static const TypeInfo sdhci_sysbus_info = {
     .instance_init = sdhci_sysbus_init,
     .instance_finalize = sdhci_sysbus_finalize,
     .class_init = sdhci_sysbus_class_init,
-};
-
-/* --- qdev bus master --- */
-
-static void sdhci_bus_class_init(ObjectClass *klass, void *data)
-{
-    SDBusClass *sbc = SD_BUS_CLASS(klass);
-
-    sbc->set_inserted = sdhci_set_inserted;
-    sbc->set_readonly = sdhci_set_readonly;
-}
-
-static const TypeInfo sdhci_bus_info = {
-    .name = TYPE_SDHCI_BUS,
-    .parent = TYPE_SD_BUS,
-    .instance_size = sizeof(SDBus),
-    .class_init = sdhci_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_SD_BUS_MASTER_INTERFACE },
+        { },
+    },
 };
 
 static void sdhci_register_types(void)
 {
     type_register_static(&sdhci_pci_info);
     type_register_static(&sdhci_sysbus_info);
-    type_register_static(&sdhci_bus_info);
 }
 
 type_init(sdhci_register_types)
-- 
2.15.1
