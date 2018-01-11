Received: from eggs.gnu.org ([2001:4830:134:3::10]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuS-0005W4-8d
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuR-0002Pf-0A
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:10 -0300
Message-Id: <20180111205626.23291-6-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 05/21] sdhci: add DMA and 64-bit
 capabilities (Spec v2)
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

new properties are introduced, with default value to Spec v2:
- adma1 (disabled, deprecated in v2)
- adma2 (enabled)
- 64bit (disabled)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 14 +++++++-------
 include/hw/sd/sdhci.h  |  4 ++++
 hw/sd/sdhci.c          | 36 ++++++++++++++----------------------
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index c5e26bf8f3..4ed9727ec3 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -89,12 +89,12 @@
 FIELD(SDHC_HOSTCTL, LED_CTRL,          0, 1);
 FIELD(SDHC_HOSTCTL, DATATRANSFERWIDTH, 1, 1); /* SD mode only */
 FIELD(SDHC_HOSTCTL, HIGH_SPEED,        2, 1);
-#define SDHC_CTRL_DMA_CHECK_MASK       0x18
+FIELD(SDHC_HOSTCTL, DMA,               3, 2);
 #define SDHC_CTRL_SDMA                 0x00
-#define SDHC_CTRL_ADMA1_32             0x08
+#define SDHC_CTRL_ADMA1_32             0x08 /* NOT ALLOWED since v2 */
 #define SDHC_CTRL_ADMA2_32             0x10
-#define SDHC_CTRL_ADMA2_64             0x18
-#define SDHC_DMA_TYPE(x)               ((x) & SDHC_CTRL_DMA_CHECK_MASK)
+#define SDHC_CTRL_ADMA2_64             0x18 /* only v1 & v2 (v3 optional) */
+#define SDHC_DMA_TYPE(x)               ((x) & R_SDHC_HOSTCTL_DMA_MASK)
 
 /* R/W Power Control Register 0x0 */
 #define SDHC_PWRCON                    0x29
@@ -185,19 +185,19 @@ FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
 
 /* HWInit Capabilities Register 0x05E80080 */
 #define SDHC_CAPAB                     0x40
-#define SDHC_CAN_DO_ADMA2              0x00080000
-#define SDHC_CAN_DO_ADMA1              0x00100000
-#define SDHC_64_BIT_BUS_SUPPORT        (1 << 28)
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
 FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
 FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
+FIELD(SDHC_CAPAB, ADMA2,              19, 1); /* since v2 */
+FIELD(SDHC_CAPAB, ADMA1,              20, 1); /* v1 only? */
 FIELD(SDHC_CAPAB, HIGHSPEED,          21, 1);
 FIELD(SDHC_CAPAB, SDMA,               22, 1);
 FIELD(SDHC_CAPAB, SUSPRESUME,         23, 1);
 FIELD(SDHC_CAPAB, V33,                24, 1);
 FIELD(SDHC_CAPAB, V30,                25, 1);
 FIELD(SDHC_CAPAB, V18,                26, 1);
+FIELD(SDHC_CAPAB, BUS64BIT,           28, 1); /* since v2 */
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index b5b4e411ff..26b50583af 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -93,6 +93,7 @@ typedef struct SDHCIState {
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint8_t spec_version;
     struct {
+        /* v1 */
         uint8_t timeout_clk_freq, base_clk_freq_mhz;
         bool timeout_clk_in_mhz;
         uint16_t max_blk_len;
@@ -100,6 +101,9 @@ typedef struct SDHCIState {
         bool high_speed;
         bool sdma;
         bool v33, v30, v18;
+        /* v2 */
+        bool adma1, adma2;
+        bool bus64;
     } cap;
 } SDHCIState;
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4c1fcf2c32..e2c7ec021d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -38,24 +38,6 @@
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
 
-/* Default SD/MMC host controller features information, which will be
- * presented in CAPABILITIES register of generic SD host controller at reset.
- * If not stated otherwise:
- * 0 - not supported, 1 - supported, other - prohibited.
- */
-#define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
-#define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
-#define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
-
-/* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1
-#error Capabilities features can have value 0 or 1 only!
-#endif
-
-#define SDHC_CAPAB_REG_DEFAULT                                 \
-   ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
-    (SDHC_CAPAB_ADMA2 << 19))
-
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
 static void sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
@@ -72,6 +54,8 @@ static void sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
     }
 }
 
+/* Default SD/MMC host controller features information, which will be
+ * presented in CAPABILITIES register of generic SD host controller at reset. */
 static void sdhci_init_capareg(SDHCIState *s, Error **errp)
 {
     uint64_t capareg = 0;
@@ -79,6 +63,10 @@ static void sdhci_init_capareg(SDHCIState *s, Error **errp)
 
     switch (s->spec_version) {
     case 2: /* default version */
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, ADMA1, s->cap.adma1);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, ADMA2, s->cap.adma2);
+        /* 64-bit System Bus Support */
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, BUS64BIT, s->cap.bus64);
 
     /* fallback */
     case 1:
@@ -792,7 +780,7 @@ static void sdhci_data_transfer(void *opaque)
 
             break;
         case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & SDHC_CAN_DO_ADMA1)) {
+            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
                 trace_sdhci_error("ADMA1 not supported");
                 break;
             }
@@ -800,7 +788,7 @@ static void sdhci_data_transfer(void *opaque)
             sdhci_do_adma(s);
             break;
         case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & SDHC_CAN_DO_ADMA2)) {
+            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
                 trace_sdhci_error("ADMA2 not supported");
                 break;
             }
@@ -808,8 +796,8 @@ static void sdhci_data_transfer(void *opaque)
             sdhci_do_adma(s);
             break;
         case SDHC_CTRL_ADMA2_64:
-            if (!(s->capareg & SDHC_CAN_DO_ADMA2) ||
-                    !(s->capareg & SDHC_64_BIT_BUS_SUPPORT)) {
+            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
+                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
                 trace_sdhci_error("64 bit ADMA not supported");
                 break;
             }
@@ -1317,6 +1305,8 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_UINT16("max-block-length", SDHCIState, cap.max_blk_len, 512),
     /* DMA */
     DEFINE_PROP_BOOL("sdma", SDHCIState, cap.sdma, true),
+    DEFINE_PROP_BOOL("adma1", SDHCIState, cap.adma1, false),
+    DEFINE_PROP_BOOL("adma2", SDHCIState, cap.adma2, true),
     /* Suspend/resume support */
     DEFINE_PROP_BOOL("suspend", SDHCIState, cap.suspend, false),
     /* High speed support */
@@ -1326,6 +1316,8 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_BOOL("3v0", SDHCIState, cap.v30, false),
     DEFINE_PROP_BOOL("1v8", SDHCIState, cap.v18, false),
 
+    DEFINE_PROP_BOOL("64bit", SDHCIState, cap.bus64, false),
+
     /* capareg: deprecated */
     DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
 
-- 
2.15.1
