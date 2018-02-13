Received: from eggs.gnu.org ([2001:4830:134:3::10]:41908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHc-0004Mn-SR
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHb-0007j8-FI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:00 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHb-0007iv-5h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:59 -0500
Received: by mail-wm0-x230.google.com with SMTP id f3so15604147wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:27 +0100
Message-Id: <1518523252-49106-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/48] sdhci: check the Spec v1 capabilities
 correctness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Incorrect value will throw an error.

Note than Spec v2 is supported by default.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-11-f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 20 ++++++++++-
 hw/sd/sdhci.c          | 97 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events     |  1 +
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index def1c7f..f3d54fd 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -87,6 +87,8 @@
 /* R/W Host control Register 0x0 */
 #define SDHC_HOSTCTL                   0x28
 #define SDHC_CTRL_LED                  0x01
+#define SDHC_CTRL_DATATRANSFERWIDTH    0x02 /* SD mode only */
+#define SDHC_CTRL_HIGH_SPEED           0x04
 #define SDHC_CTRL_DMA_CHECK_MASK       0x18
 #define SDHC_CTRL_SDMA                 0x00
 #define SDHC_CTRL_ADMA1_32             0x08
@@ -102,6 +104,7 @@
 /* R/W Power Control Register 0x0 */
 #define SDHC_PWRCON                    0x29
 #define SDHC_POWER_ON                  (1 << 0)
+FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
 
 /* R/W Block Gap Control Register 0x0 */
 #define SDHC_BLKGAP                    0x2A
@@ -124,6 +127,7 @@
 
 /* R/W Timeout Control Register 0x0 */
 #define SDHC_TIMEOUTCON                0x2E
+FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 
 /* R/W Software Reset Register 0x0 */
 #define SDHC_SWRST                     0x2F
@@ -180,17 +184,31 @@
 
 /* ROC Auto CMD12 error status register 0x0 */
 #define SDHC_ACMD12ERRSTS              0x3C
+FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
+FIELD(SDHC_ACMD12ERRSTS, CRC_ERR,      2, 1);
+FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
 
 /* HWInit Capabilities Register 0x05E80080 */
 #define SDHC_CAPAB                     0x40
-#define SDHC_CAN_DO_DMA                0x00400000
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
 #define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
+FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
+FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
+FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
 FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
+FIELD(SDHC_CAPAB, HIGHSPEED,          21, 1);
+FIELD(SDHC_CAPAB, SDMA,               22, 1);
+FIELD(SDHC_CAPAB, SUSPRESUME,         23, 1);
+FIELD(SDHC_CAPAB, V33,                24, 1);
+FIELD(SDHC_CAPAB, V30,                25, 1);
+FIELD(SDHC_CAPAB, V18,                26, 1);
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
+FIELD(SDHC_MAXCURR, V33_VDD1,          0, 8);
+FIELD(SDHC_MAXCURR, V30_VDD1,          8, 8);
+FIELD(SDHC_MAXCURR, V18_VDD1,         16, 8);
 
 /* W Force Event Auto CMD12 Error Interrupt Register 0x0000 */
 #define SDHC_FEAER                     0x50
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f22ed91..116565a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
@@ -63,6 +64,92 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
     return 1 << (9 + FIELD_EX32(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH));
 }
 
+/* return true on error */
+static bool sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
+                                         uint8_t freq, Error **errp)
+{
+    switch (freq) {
+    case 0:
+    case 10 ... 63:
+        break;
+    default:
+        error_setg(errp, "SD %s clock frequency can have value"
+                   "in range 0-63 only", desc);
+        return true;
+    }
+    return false;
+}
+
+static void sdhci_check_capareg(SDHCIState *s, Error **errp)
+{
+    uint64_t msk = s->capareg;
+    uint32_t val;
+    bool y;
+
+    switch (s->sd_spec_version) {
+    case 2: /* default version */
+
+    /* fallthrough */
+    case 1:
+        y = FIELD_EX64(s->capareg, SDHC_CAPAB, TOUNIT);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, TOUNIT, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, TOCLKFREQ);
+        trace_sdhci_capareg(y ? "timeout (MHz)" : "Timeout (KHz)", val);
+        if (sdhci_check_capab_freq_range(s, "timeout", val, errp)) {
+            return;
+        }
+        msk = FIELD_DP64(msk, SDHC_CAPAB, TOCLKFREQ, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, BASECLKFREQ);
+        trace_sdhci_capareg(y ? "base (MHz)" : "Base (KHz)", val);
+        if (sdhci_check_capab_freq_range(s, "base", val, errp)) {
+            return;
+        }
+        msk = FIELD_DP64(msk, SDHC_CAPAB, BASECLKFREQ, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH);
+        if (val >= 3) {
+            error_setg(errp, "block size can be 512, 1024 or 2048 only");
+            return;
+        }
+        trace_sdhci_capareg("max block length", sdhci_get_fifolen(s));
+        msk = FIELD_DP64(msk, SDHC_CAPAB, MAXBLOCKLENGTH, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, HIGHSPEED);
+        trace_sdhci_capareg("high speed", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, HIGHSPEED, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SDMA);
+        trace_sdhci_capareg("SDMA", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SDMA, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SUSPRESUME);
+        trace_sdhci_capareg("suspend/resume", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SUSPRESUME, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V33);
+        trace_sdhci_capareg("3.3v", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V33, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V30);
+        trace_sdhci_capareg("3.0v", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V30, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V18);
+        trace_sdhci_capareg("1.8v", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V18, 0);
+        break;
+
+    default:
+        error_setg(errp, "Unsupported spec version: %u", s->sd_spec_version);
+    }
+    if (msk) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SDHCI: unknown CAPAB mask: 0x%016" PRIx64 "\n", msk);
+    }
+}
+
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
     return (s->norintsts & s->norintsigen) || (s->errintsts & s->errintsigen) ||
@@ -990,7 +1077,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_TRNMOD:
         /* DMA can be enabled only if it is supported as indicated by
          * capabilities register */
-        if (!(s->capareg & SDHC_CAN_DO_DMA)) {
+        if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
@@ -1125,11 +1212,19 @@ static const MemoryRegionOps sdhci_mmio_ops = {
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
+    Error *local_err = NULL;
+
     if (s->sd_spec_version != 2) {
         error_setg(errp, "Only Spec v2 is supported");
         return;
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
+
+    sdhci_check_capareg(s, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 /* --- qdev common --- */
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0a12115..78d8707 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -13,6 +13,7 @@ sdhci_adma_transfer_completed(void) ""
 sdhci_access(const char *access, unsigned int size, uint64_t offset, const char *dir, uint64_t val, uint64_t val2) "%s%u: addr[0x%04" PRIx64 "] %s 0x%08" PRIx64 " (%" PRIu64 ")"
 sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read from input buffer"
 sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
+sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
1.8.3.1
