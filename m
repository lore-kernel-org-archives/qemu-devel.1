Received: from eggs.gnu.org ([2001:4830:134:3::10]:58974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuG-0005Hd-03
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuB-0002EY-3h
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:07 -0300
Message-Id: <20180111205626.23291-3-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/21] sdhci: add basic Spec v1 capabilities
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

(Note than Spec v2 is supported by default)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 24 +++++++++++++++++++-
 include/hw/sd/sdhci.h  |  6 +++++
 hw/sd/sdhci.c          | 61 +++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 74 insertions(+), 17 deletions(-)

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
index 8786676ac8..09b756eb7a 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -92,6 +92,12 @@ typedef struct SDHCIState {
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint8_t spec_version;
+    struct {
+        bool suspend;
+        bool high_speed;
+        bool sdma;
+        bool v33, v30, v18;
+    } cap;
 } SDHCIState;
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c8f750451e..d26ea821d0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -44,12 +44,6 @@
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
@@ -63,9 +57,7 @@
 #define SDHC_CAPAB_TOCLKFREQ      52ul
 
 /* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_18V > 1 || SDHC_CAPAB_30V > 1 ||     \
-    SDHC_CAPAB_33V > 1 || SDHC_CAPAB_SUSPRESUME > 1 || SDHC_CAPAB_SDMA > 1 ||  \
-    SDHC_CAPAB_HIGHSPEED > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 ||\
+#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 || \
     SDHC_CAPAB_TOUNIT > 1
 #error Capabilities features can have value 0 or 1 only!
 #endif
@@ -90,16 +82,36 @@
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
 
+static void sdhci_init_capareg(SDHCIState *s, Error **errp)
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
+    s->capareg = capareg;
+}
+
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
     return (s->norintsts & s->norintsigen) || (s->errintsts & s->errintsigen) ||
@@ -1026,7 +1038,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_TRNMOD:
         /* DMA can be enabled only if it is supported as indicated by
          * capabilities register */
-        if (!(s->capareg & SDHC_CAN_DO_DMA)) {
+        if (!(s->capareg & R_SDHC_CAPAB_SDMA_MASK)) {
             value &= ~SDHC_TRNS_DMA;
         }
         MASKED_WRITE(s->trnmod, mask, value & SDHC_TRNMOD_MASK);
@@ -1181,6 +1193,10 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
         return;
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
+
+    if (s->capareg == UINT64_MAX) {
+        sdhci_init_capareg(s, errp);
+    }
 }
 
 static void sdhci_initfn(SDHCIState *s)
@@ -1297,8 +1313,21 @@ const VMStateDescription sdhci_vmstate = {
  * specific host controller implementation */
 static Property sdhci_properties[] = {
     DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),
-    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg,
-            SDHC_CAPAB_REG_DEFAULT),
+
+    /* DMA */
+    DEFINE_PROP_BOOL("sdma", SDHCIState, cap.sdma, true),
+    /* Suspend/resume support */
+    DEFINE_PROP_BOOL("suspend", SDHCIState, cap.suspend, false),
+    /* High speed support */
+    DEFINE_PROP_BOOL("high-speed", SDHCIState, cap.high_speed, true),
+    /* Voltage support 3.3/3.0/1.8V */
+    DEFINE_PROP_BOOL("3v3", SDHCIState, cap.v33, true),
+    DEFINE_PROP_BOOL("3v0", SDHCIState, cap.v30, false),
+    DEFINE_PROP_BOOL("1v8", SDHCIState, cap.v18, false),
+
+    /* capareg: deprecated */
+    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
+
     DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.15.1
