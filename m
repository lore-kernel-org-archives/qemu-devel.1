Received: from eggs.gnu.org ([2001:4830:134:3::10]:60075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RO-0008GW-A0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RL-00032I-5o
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:02 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RL-00032C-1p
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:24:59 -0500
Received: by mail-qk0-x243.google.com with SMTP id y80so11319384qkb.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:24:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:25 -0300
Message-Id: <20180115182436.2066-4-f4bug@amsat.org>
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 03/14] sdhci: use
 DEFINE_SDHCI_COMMON_PROPERTIES() for common sysbus/pci properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Add common/sysbus/pci/sdbus comments to have clearer code blocks separation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  4 +++-
 hw/sd/sdhci.c         | 25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

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
index 365bc80009..c0b4b8457a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
@@ -1185,6 +1186,14 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     }
 }
 
+/* --- qdev common --- */
+
+#define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
+    /* Capabilities registers provide information on supported features
+     * of this specific host controller implementation */ \
+    DEFINE_PROP_UINT32("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
+    DEFINE_PROP_UINT32("maxcurr", _state, maxcurr, 0)
+
 static void sdhci_initfn(SDHCIState *s)
 {
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
@@ -1264,12 +1273,10 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-/* Capabilities registers provide information on supported features of this
- * specific host controller implementation */
+/* --- qdev PCI --- */
+
 static Property sdhci_pci_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
+    DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1320,10 +1327,10 @@ static const TypeInfo sdhci_pci_info = {
     },
 };
 
+/* --- qdev SysBus --- */
+
 static Property sdhci_sysbus_properties[] = {
-    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
-    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
+    DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
     DEFINE_PROP_END_OF_LIST(),
@@ -1374,6 +1381,8 @@ static const TypeInfo sdhci_sysbus_info = {
     .class_init = sdhci_sysbus_class_init,
 };
 
+/* --- qdev bus master --- */
+
 static void sdhci_bus_class_init(ObjectClass *klass, void *data)
 {
     SDBusClass *sbc = SD_BUS_CLASS(klass);
-- 
2.15.1
