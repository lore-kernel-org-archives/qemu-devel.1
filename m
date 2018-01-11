Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZju7-0005AG-0F
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZju5-0002Af-Qu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:56:51 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:06 -0300
Message-Id: <20180111205626.23291-2-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 01/21] sdhci: add a 'spec_version property'
 (default to v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h |  4 ++--
 include/hw/sd/sdhci.h  |  2 ++
 hw/sd/sdhci.c          | 19 +++++++++++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index fc807f08f3..b7751c815f 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -210,9 +210,9 @@
 /* Slot interrupt status */
 #define SDHC_SLOT_INT_STATUS            0xFC
 
-/* HWInit Host Controller Version Register 0x0401 */
+/* HWInit Host Controller Version Register */
 #define SDHC_HCVER                      0xFE
-#define SD_HOST_SPECv2_VERS             0x2401
+#define SDHC_HCVER_VENDOR               0x24
 
 #define SDHC_REGISTERS_MAP_SIZE         0x100
 #define SDHC_INSERTION_DELAY            (NANOSECONDS_PER_SECOND)
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 6117004949..8786676ac8 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -76,6 +76,7 @@ typedef struct SDHCIState {
     /* Read-only registers */
     uint64_t capareg;      /* Capabilities Register */
     uint64_t maxcurr;      /* Maximum Current Capabilities Register */
+    uint16_t version;      /* Host Controller Version Register */
 
     uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
     uint32_t buf_maxsz;
@@ -90,6 +91,7 @@ typedef struct SDHCIState {
 
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
+    uint8_t spec_version;
 } SDHCIState;
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 7a2901ae4a..c8f750451e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -173,7 +173,8 @@ static void sdhci_reset(SDHCIState *s)
 
     timer_del(s->insert_timer);
     timer_del(s->transfer_timer);
-    /* Set all registers to 0. Capabilities registers are not cleared
+
+    /* Set all registers to 0. Capabilities/Version registers are not cleared
      * and assumed to always preserve their value, given to them during
      * initialization */
     memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
@@ -917,7 +918,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (uint32_t)(s->admasysaddr >> 32);
         break;
     case SDHC_SLOT_INT_STATUS:
-        ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
+        ret = (s->version << 16) | sdhci_slotint(s);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
@@ -1173,6 +1174,15 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     }
 }
 
+static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
+{
+    if (s->spec_version != 2) {
+        error_setg(errp, "Only Spec v2 is supported");
+        return;
+    }
+    s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
+}
+
 static void sdhci_initfn(SDHCIState *s)
 {
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
@@ -1184,6 +1194,10 @@ static void sdhci_initfn(SDHCIState *s)
 
 static void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
+    sdhci_init_readonly_registers(s, errp);
+    if (errp && *errp) {
+        return;
+    }
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
@@ -1282,6 +1296,7 @@ const VMStateDescription sdhci_vmstate = {
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
 static Property sdhci_properties[] = {
+    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),
     DEFINE_PROP_UINT64("capareg", SDHCIState, capareg,
             SDHC_CAPAB_REG_DEFAULT),
     DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
-- 
2.15.1
