Received: from eggs.gnu.org ([2001:4830:134:3::10]:52618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtb-0000n9-19
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtZ-0007ZU-Q8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:43 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtZ-0007ZG-KU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so2229367qtj.6
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:08:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:46 -0300
Message-Id: <20180213040809.26021-8-f4bug@amsat.org>
In-Reply-To: <20180213040809.26021-1-f4bug@amsat.org>
References: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 07/30] sdhci: add a 'spec_version property'
 (default to v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h |  4 ++--
 include/hw/sd/sdhci.h  |  2 ++
 hw/sd/sdhci.c          | 27 +++++++++++++++++++++++----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 0991acd724..64556480a9 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -216,9 +216,9 @@
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
index f8d1ba3538..2a26b46f05 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -78,6 +78,7 @@ typedef struct SDHCIState {
     /* Read-only registers */
     uint64_t capareg;      /* Capabilities Register */
     uint64_t maxcurr;      /* Maximum Current Capabilities Register */
+    uint16_t version;      /* Host Controller Version Register */
 
     uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
     uint32_t buf_maxsz;
@@ -93,6 +94,7 @@ typedef struct SDHCIState {
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint32_t quirks;
+    uint8_t sd_spec_version;
 } SDHCIState;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3602286f46..17a1348f0f 100644
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
@@ -918,7 +919,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (uint32_t)(s->admasysaddr >> 32);
         break;
     case SDHC_SLOT_INT_STATUS:
-        ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
+        ret = (s->version << 16) | sdhci_slotint(s);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
@@ -1174,11 +1175,22 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     }
 }
 
+static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
+{
+    if (s->sd_spec_version != 2) {
+        error_setg(errp, "Only Spec v2 is supported");
+        return;
+    }
+    s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
+}
+
 /* --- qdev common --- */
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    /* Capabilities registers provide information on supported features
-     * of this specific host controller implementation */ \
+    DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
+    \
+    /* Capabilities registers provide information on supported
+     * features of this specific host controller implementation */ \
     DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAULT), \
     DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
 
@@ -1206,6 +1218,13 @@ static void sdhci_uninitfn(SDHCIState *s)
 
 static void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
+    Error *local_err = NULL;
+
+    sdhci_init_readonly_registers(s, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-- 
2.16.1
