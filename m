Received: from eggs.gnu.org ([2001:4830:134:3::10]:38091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz4-0007DY-I8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz3-0003QN-4b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:18 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecEz2-0003QD-VG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:32:17 -0500
Received: by mail-qt0-x241.google.com with SMTP id e2so32639704qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:32:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:31:00 -0300
Message-Id: <20180118183108.16009-9-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-1-f4bug@amsat.org>
References: <20180118183108.16009-1-f4bug@amsat.org>
In-Reply-To: <20180118182510.15630-1-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 09/17] sdhci: add basic Spec v1 capabilities
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

(Note than Spec v2 is supported by default)

we emit a warning for missing capabilities bits.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 24 ++++++++++++++++++-
 include/hw/sd/sdhci.h  | 11 +++++++++
 hw/sd/sdhci.c          | 65 ++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 84 insertions(+), 16 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index b7751c815f..9acafe7b01 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,6 +24,8 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
+#include "hw/registerfields.h"
+
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -84,6 +86,9 @@
 
 /* R/W Host control Register 0x0 */
 #define SDHC_HOSTCTL                   0x28
+FIELD(SDHC_HOSTCTL, LED_CTRL,          0, 1);
+FIELD(SDHC_HOSTCTL, DATATRANSFERWIDTH, 1, 1); /* SD mode only */
+FIELD(SDHC_HOSTCTL, HIGH_SPEED,        2, 1);
 #define SDHC_CTRL_DMA_CHECK_MASK       0x18
 #define SDHC_CTRL_SDMA                 0x00
 #define SDHC_CTRL_ADMA1_32             0x08
@@ -94,6 +99,7 @@
 /* R/W Power Control Register 0x0 */
 #define SDHC_PWRCON                    0x29
 #define SDHC_POWER_ON                  (1 << 0)
+FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
 
 /* R/W Block Gap Control Register 0x0 */
 #define SDHC_BLKGAP                    0x2A
@@ -116,6 +122,7 @@
 
 /* R/W Timeout Control Register 0x0 */
 #define SDHC_TIMEOUTCON                0x2E
+FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 
 /* R/W Software Reset Register 0x0 */
 #define SDHC_SWRST                     0x2F
@@ -172,17 +179,32 @@
 
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
 #define SDHC_CAPAB_BLOCKSIZE(x)        (((x) >> 16) & 0x3)
+FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
+FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
+FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
+FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
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
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c174a39ecf..bc80f59d3c 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -92,6 +92,17 @@ typedef struct SDHCIState {
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint8_t spec_version;
+    struct {
+        /***********
+         * Spec v1
+         ***********/
+        /* Suspend/resume */
+        bool suspend;
+        bool high_speed;
+        bool sdma;
+        /* Voltage */
+        bool v33, v30, v18;
+    } cap;
 } SDHCIState;
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 76714f1143..e56ee7778c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
@@ -45,12 +46,6 @@
  * 0 - not supported, 1 - supported, other - prohibited.
  */
 #define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
-#define SDHC_CAPAB_18V            1ul        /* Voltage support 1.8v */
-#define SDHC_CAPAB_30V            0ul        /* Voltage support 3.0v */
-#define SDHC_CAPAB_33V            1ul        /* Voltage support 3.3v */
-#define SDHC_CAPAB_SUSPRESUME     0ul        /* Suspend/resume support */
-#define SDHC_CAPAB_SDMA           1ul        /* SDMA support */
-#define SDHC_CAPAB_HIGHSPEED      1ul        /* High speed support */
 #define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
 #define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
 /* Maximum host controller R/W buffers size
@@ -64,9 +59,7 @@
 #define SDHC_CAPAB_TOCLKFREQ      52ul
 
 /* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_18V > 1 || SDHC_CAPAB_30V > 1 ||     \
-    SDHC_CAPAB_33V > 1 || SDHC_CAPAB_SUSPRESUME > 1 || SDHC_CAPAB_SDMA > 1 ||  \
-    SDHC_CAPAB_HIGHSPEED > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 ||\
+#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 || \
     SDHC_CAPAB_TOUNIT > 1
 #error Capabilities features can have value 0 or 1 only!
 #endif
@@ -91,16 +84,37 @@
 #endif
 
 #define SDHC_CAPAB_REG_DEFAULT                                 \
-   ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_18V << 26) |     \
-    (SDHC_CAPAB_30V << 25) | (SDHC_CAPAB_33V << 24) |          \
-    (SDHC_CAPAB_SUSPRESUME << 23) | (SDHC_CAPAB_SDMA << 22) |  \
-    (SDHC_CAPAB_HIGHSPEED << 21) | (SDHC_CAPAB_ADMA1 << 20) |  \
+   ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
     (SDHC_CAPAB_ADMA2 << 19) | (MAX_BLOCK_LENGTH << 16) |      \
     (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
     (SDHC_CAPAB_TOCLKFREQ))
 
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
+static uint64_t sdhci_init_capareg(SDHCIState *s, Error **errp)
+{
+    uint64_t capareg = 0;
+
+    switch (s->spec_version) {
+    case 2: /* default version */
+
+    /* fallback */
+    case 1:
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, HIGHSPEED, s->cap.high_speed);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, SDMA, s->cap.sdma);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, SUSPRESUME, s->cap.suspend);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, V33, s->cap.v33);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, V30, s->cap.v30);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, V18, s->cap.v18);
+        break;
+
+    default:
+        error_setg(errp, "Unsupported spec version: %u", s->spec_version);
+    }
+
+    return capareg;
+}
+
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
     return (s->norintsts & s->norintsigen) || (s->errintsts & s->errintsigen) ||
@@ -1027,7 +1041,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_TRNMOD:
         /* DMA can be enabled only if it is supported as indicated by
          * capabilities register */
-        if (!(s->capareg & SDHC_CAN_DO_DMA)) {
+        if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
@@ -1177,14 +1191,27 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
+    uint64_t capab;
+    Error *local_err = NULL;
+
     if (s->spec_version != 2) {
         error_setg(errp, "Only Spec v2 is supported");
         return;
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
 
+    capab = sdhci_init_capareg(s, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     if (s->capareg == UINT64_MAX) {
-        s->capareg = SDHC_CAPAB_REG_DEFAULT;
+        s->capareg = capab;
+    } else {
+        capab = s->capareg & ~capab;
+        if (capab) {
+            warn_report("SDHCI: missing capability mask: 0x%" PRIx64, capab);
+        }
     }
 }
 
@@ -1193,6 +1220,14 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
     DEFINE_PROP_UINT8("sd-spec-version", _state, spec_version, 2), \
     \
+    /* Spec v1 properties */ \
+    DEFINE_PROP_BOOL("sdma", _state, cap.sdma, true), \
+    DEFINE_PROP_BOOL("suspend", _state, cap.suspend, false), \
+    DEFINE_PROP_BOOL("high-speed", _state, cap.high_speed, true), \
+    DEFINE_PROP_BOOL("3v3", _state, cap.v33, true), \
+    DEFINE_PROP_BOOL("3v0", _state, cap.v30, false), \
+    DEFINE_PROP_BOOL("1v8", _state, cap.v18, true), \
+    \
     /* deprecated: Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
     DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
-- 
2.15.1
