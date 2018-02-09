Received: from eggs.gnu.org ([2001:4830:134:3::10]:33925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4y-0001wH-Ud
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4w-0005EK-T0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:08 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA4w-0005Dv-NV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:06 -0500
Received: by mail-qt0-x243.google.com with SMTP id s27so10834780qts.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:55:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 11:54:10 -0300
Message-Id: <20180209145430.26007-11-f4bug@amsat.org>
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 10/30] sdhci: check the Spec v1
 capabilities correctness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Incorrect value will throw an error.

Note than Spec v2 is supported by default.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 22 ++++++++++-
 hw/sd/sdhci.c          | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events     |  1 +
 3 files changed, 118 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index def1c7f7aa..96d7f4dde7 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -86,7 +86,9 @@
 
 /* R/W Host control Register 0x0 */
 #define SDHC_HOSTCTL                   0x28
-#define SDHC_CTRL_LED                  0x01
+FIELD(SDHC_HOSTCTL, LED_CTRL,          0, 1);
+FIELD(SDHC_HOSTCTL, DATATRANSFERWIDTH, 1, 1); /* SD mode only */
+FIELD(SDHC_HOSTCTL, HIGH_SPEED,        2, 1);
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
index e25f1da0f3..5ed463ca77 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
@@ -64,6 +65,92 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
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
+    bool unit_mhz;
+
+    switch (s->sd_spec_version) {
+    case 2: /* default version */
+
+    /* fallback */
+    case 1:
+        unit_mhz = FIELD_EX64(s->capareg, SDHC_CAPAB, TOUNIT);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, TOUNIT, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, TOCLKFREQ);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, TOCLKFREQ, 0);
+        trace_sdhci_capareg(unit_mhz ? "timeout (MHz)" : "timeout (KHz)", val);
+        if (sdhci_check_capab_freq_range(s, "timeout", val, errp)) {
+            return;
+        }
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, BASECLKFREQ);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, BASECLKFREQ, 0);
+        trace_sdhci_capareg(unit_mhz ? "base (MHz)" : "Base (KHz)", val);
+        if (sdhci_check_capab_freq_range(s, "base", val, errp)) {
+            return;
+        }
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH);
+        if (val >= 0b11) {
+            error_setg(errp, "block size can be 512, 1024 or 2048 only");
+            return;
+        }
+        msk = FIELD_DP64(msk, SDHC_CAPAB, MAXBLOCKLENGTH, 0);
+        trace_sdhci_capareg("max block length", sdhci_get_fifolen(s));
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, HIGHSPEED);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, HIGHSPEED, 0);
+        trace_sdhci_capareg("high speed", val);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SDMA);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SDMA, 0);
+        trace_sdhci_capareg("SDMA", val);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SUSPRESUME);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SUSPRESUME, 0);
+        trace_sdhci_capareg("suspend/resume", val);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V33);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V33, 0);
+        trace_sdhci_capareg("3.3v", val);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V30);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V30, 0);
+        trace_sdhci_capareg("3.0v", val);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, V18);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, V18, 0);
+        trace_sdhci_capareg("1.8v", val);
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
@@ -991,7 +1078,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_TRNMOD:
         /* DMA can be enabled only if it is supported as indicated by
          * capabilities register */
-        if (!(s->capareg & SDHC_CAN_DO_DMA)) {
+        if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
@@ -1126,11 +1213,19 @@ static const MemoryRegionOps sdhci_mmio_ops = {
 
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
@@ -1538,7 +1633,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /*
          * First, save bits 7 6 and 0 since they are identical
          */
-        hostctl = value & (SDHC_CTRL_LED |
+        hostctl = value & (R_SDHC_HOSTCTL_LED_CTRL_MASK |
                            SDHC_CTRL_CDTEST_INS |
                            SDHC_CTRL_CDTEST_EN);
         /*
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0a121156a3..78d8707669 100644
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
2.16.1
