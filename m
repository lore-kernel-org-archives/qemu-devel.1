Received: from eggs.gnu.org ([2001:4830:134:3::10]:47072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2m-0000Ry-Cs
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2i-0003wg-Cj
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:48 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2i-0003w7-8I
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:44 -0500
Received: by mail-qk0-x244.google.com with SMTP id d21so11262677qkj.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:07:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:06 -0300
Message-Id: <20180113050717.22969-4-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 03/14] sdhci: refactor same sysbus/pci
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>

Add common/sysbus/pci/sdbus comments to have clearer code blocks separation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  4 +++-
 hw/sd/sdhci.c         | 46 ++++++++++++++++++++++++++++------------------
 2 files changed, 31 insertions(+), 19 deletions(-)

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
index 365bc80009..6c3389cfdc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
@@ -1185,8 +1186,23 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     }
 }
 
+/* --- qdev common --- */
+
+/* Capabilities registers provide information on supported features of this
+ * specific host controller implementation */
+static Property sdhci_capareg_property =
+    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, SDHC_CAPAB_REG_DEFAULT);
+
+static Property sdhci_maxcurr_property =
+    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0);
+
 static void sdhci_initfn(SDHCIState *s)
 {
+    DeviceState *dev = DEVICE(s);
+
+    qdev_property_add_static(dev, &sdhci_capareg_property, &error_abort);
+    qdev_property_add_static(dev, &sdhci_maxcurr_property, &error_abort);
+
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
                         TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
 
@@ -1264,14 +1280,7 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-/* Capabilities registers provide information on supported features of this
- * specific host controller implementation */
-static Property sdhci_pci_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
+/* --- qdev PCI --- */
 
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
@@ -1305,7 +1314,6 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SYSTEM_SDHCI;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_pci_properties;
     dc->reset = sdhci_poweron_reset;
 }
 
@@ -1320,20 +1328,21 @@ static const TypeInfo sdhci_pci_info = {
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
+
+static Property sdhci_sysbus_pending_insert_quirk_property =
+     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState,
+                      pending_insert_quirk, false);
 
 static void sdhci_sysbus_init(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
     sdhci_initfn(s);
+
+    qdev_property_add_static(DEVICE(obj),
+                             &sdhci_sysbus_pending_insert_quirk_property,
+                             &error_abort);
 }
 
 static void sdhci_sysbus_finalize(Object *obj)
@@ -1360,7 +1369,6 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &sdhci_vmstate;
-    dc->props = sdhci_sysbus_properties;
     dc->realize = sdhci_sysbus_realize;
     dc->reset = sdhci_poweron_reset;
 }
@@ -1374,6 +1382,8 @@ static const TypeInfo sdhci_sysbus_info = {
     .class_init = sdhci_sysbus_class_init,
 };
 
+/* --- qdev bus master --- */
+
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
-- 
2.15.1
