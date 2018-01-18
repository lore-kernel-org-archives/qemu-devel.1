Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz0-00079F-IC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyz-0003Ov-7t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:14 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEyz-0003Ol-3U
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:13 -0500
Received: by mail-qt0-x241.google.com with SMTP id z10so4516754qti.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:32:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:30:59 -0300
Message-Id: <20180118183108.16009-8-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118183108.16009-1-f4bug@amsat.org>
In-Reply-To: <20180118182510.15630-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 08/17] sdhci: add a 'spec_version property'
 (default to v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h |  4 ++--
 include/hw/sd/sdhci.h  |  2 ++
 hw/sd/sdhci.c          | 13 +++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

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
index cb37182536..c174a39ecf 100644
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
index caf5e5a1b4..76714f1143 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -174,7 +174,8 @@ static void sdhci_reset(SDHCIState *s)
 
     timer_del(s->insert_timer);
     timer_del(s->transfer_timer);
-    /* Set all registers to 0. Capabilities registers are not cleared
+
+    /* Set all registers to 0. Capabilities/Version registers are not cleared
      * and assumed to always preserve their value, given to them during
      * initialization */
     memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
@@ -918,7 +919,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (uint32_t)(s->admasysaddr >> 32);
         break;
     case SDHC_SLOT_INT_STATUS:
-        ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
+        ret = (s->version << 16) | sdhci_slotint(s);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
@@ -1176,6 +1177,12 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
+    if (s->spec_version != 2) {
+        error_setg(errp, "Only Spec v2 is supported");
+        return;
+    }
+    s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
+
     if (s->capareg == UINT64_MAX) {
         s->capareg = SDHC_CAPAB_REG_DEFAULT;
     }
@@ -1184,6 +1191,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 /* --- qdev common --- */
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
+    DEFINE_PROP_UINT8("sd-spec-version", _state, spec_version, 2), \
+    \
     /* deprecated: Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
     DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
-- 
2.15.1
