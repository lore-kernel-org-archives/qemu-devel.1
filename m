Received: from eggs.gnu.org ([2001:4830:134:3::10]:44641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYl-0002ha-CX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYh-0005HM-Gv
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:43 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZiYh-0005Gp-D6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:30:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id u10so3220314qtg.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:30:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 16:30:11 -0300
Message-Id: <20180111193021.17466-4-f4bug@amsat.org>
In-Reply-To: <20180111193021.17466-1-f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 03/13] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

Now both sysbus/pci classes inherit of the 'pending-insert-quirk' property,
which is a HCI dependent property (regardless if accessed through a MMIO
sysbus or a PCI bus).
So far only the BCM implementation has to use it.

Add sysbus/pci/sdbus comments to have clearer code blocks separation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/sd/sdhci.h |  4 +++-
 hw/sd/sdhci.c         | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index dacd726537..8041c9629e 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -79,13 +79,15 @@ typedef struct SDHCIState {
     uint32_t buf_maxsz;
     uint16_t data_count;   /* current element in FIFO buffer */
     uint8_t  stopped_state;/* Current SDHC state */
-    bool     pending_insert_quirk;/* Quirk for Raspberry Pi card insert int */
     bool     pending_insert_state;
     /* Buffer Data Port Register - virtual access point to R and W buffers */
     /* Software Reset Register - always reads as 0 */
     /* Force Event Auto CMD12 Error Interrupt Reg - write only */
     /* Force Event Error Interrupt Register- write only */
     /* RO Host Controller Version Register always reads as 0x2401 */
+
+    /* Configurable properties */
+    bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
 } SDHCIState;
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 365bc80009..a11469fbca 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1266,13 +1266,17 @@ const VMStateDescription sdhci_vmstate = {
 
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
@@ -1305,7 +1309,7 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_pci_properties;
+    dc->props = sdhci_properties;
     dc->reset = sdhci_poweron_reset;
 }
 
@@ -1320,14 +1324,7 @@ static const TypeInfo sdhci_pci_info = {
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
@@ -1360,7 +1357,7 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_sysbus_properties;
+    dc->props = sdhci_properties;
     dc->realize = sdhci_sysbus_realize;
     dc->reset = sdhci_poweron_reset;
 }
@@ -1374,6 +1371,8 @@ static const TypeInfo sdhci_sysbus_info = {
     .class_init = sdhci_sysbus_class_init,
 };
 
+/* --- qdev bus master --- */
+
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
-- 
2.15.1
