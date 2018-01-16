Received: from eggs.gnu.org ([2001:4830:134:3::10]:37416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNx-0008Ec-SJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNs-0002oR-V8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNs-0002gG-Nd
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNr-0002uS-K9
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:08 +0000
Message-Id: <1516109659-1557-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/24] sdhci: use
 DEFINE_SDHCI_COMMON_PROPERTIES() for common sysbus/pci properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add common/sysbus/pci/sdbus comments to have clearer code blocks separation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180115182436.2066-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h |  4 +++-
 hw/sd/sdhci.c         | 25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index dacd726..8041c96 100644
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
index 365bc80..c0b4b84 100644
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
2.7.4
