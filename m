Received: from eggs.gnu.org ([2001:4830:134:3::10]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuR-0005Um-02
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjuM-0002Lq-4N
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:57:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:09 -0300
Message-Id: <20180111205626.23291-5-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/21] sdhci: add clock capabilities (Spec
 v1)
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
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 53 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index b61953f7c5..b5b4e411ff 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -93,6 +93,8 @@ typedef struct SDHCIState {
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint8_t spec_version;
     struct {
+        uint8_t timeout_clk_freq, base_clk_freq_mhz;
+        bool timeout_clk_in_mhz;
         uint16_t max_blk_len;
         bool suspend;
         bool high_speed;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 54c1411d19..4c1fcf2c32 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -46,36 +46,32 @@
 #define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
 #define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
 #define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
-/* Maximum clock frequency for SDclock in MHz
- * value in range 10-63 MHz, 0 - not defined */
-#define SDHC_CAPAB_BASECLKFREQ    52ul
-#define SDHC_CAPAB_TOUNIT         1ul  /* Timeout clock unit 0 - kHz, 1 - MHz */
-/* Timeout clock frequency 1-63, 0 - not defined */
-#define SDHC_CAPAB_TOCLKFREQ      52ul
 
 /* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 || \
-    SDHC_CAPAB_TOUNIT > 1
+#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1
 #error Capabilities features can have value 0 or 1 only!
 #endif
 
-#if (SDHC_CAPAB_BASECLKFREQ > 0 && SDHC_CAPAB_BASECLKFREQ < 10) || \
-    SDHC_CAPAB_BASECLKFREQ > 63
-#error SDclock frequency can have value in range 0, 10-63 only!
-#endif
-
-#if SDHC_CAPAB_TOCLKFREQ > 63
-#error Timeout clock frequency can have value in range 0-63 only!
-#endif
-
 #define SDHC_CAPAB_REG_DEFAULT                                 \
    ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
-    (SDHC_CAPAB_ADMA2 << 19) |                                 \
-    (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
-    (SDHC_CAPAB_TOCLKFREQ))
+    (SDHC_CAPAB_ADMA2 << 19))
 
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
+static void sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
+                                         uint8_t freq, Error **errp)
+{
+    switch (freq) {
+    case 0:
+    case 10 ... 63:
+        break;
+    default:
+        error_setg(errp, "SD %s clock frequency can have value"
+                   "in range 0-63 only", desc);
+        return;
+    }
+}
+
 static void sdhci_init_capareg(SDHCIState *s, Error **errp)
 {
     uint64_t capareg = 0;
@@ -86,6 +82,16 @@ static void sdhci_init_capareg(SDHCIState *s, Error **errp)
 
     /* fallback */
     case 1:
+        sdhci_check_capab_freq_range(s, "Timeout", s->cap.timeout_clk_freq,
+                                     errp);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, TOCLKFREQ,
+                             s->cap.timeout_clk_freq);
+        sdhci_check_capab_freq_range(s, "Base", s->cap.base_clk_freq_mhz, errp);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, BASECLKFREQ,
+                             s->cap.base_clk_freq_mhz);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, TOUNIT,
+                             s->cap.timeout_clk_in_mhz);
+
         val = ctz32(s->cap.max_blk_len >> 9);
         if (val >= 0b11) {
             error_setg(errp, "block size can be 512, 1024 or 2048 only");
@@ -1299,6 +1305,13 @@ const VMStateDescription sdhci_vmstate = {
 static Property sdhci_properties[] = {
     DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),
 
+    /* Timeout clock frequency 1-63, 0 - not defined */
+    DEFINE_PROP_UINT8("timeout-freq", SDHCIState, cap.timeout_clk_freq, 0),
+    /* Timeout clock unit 0 - kHz, 1 - MHz */
+    DEFINE_PROP_BOOL("freq-in-mhz", SDHCIState, cap.timeout_clk_in_mhz, true),
+    /* Maximum base clock frequency for SD clock in MHz (range 10-63 MHz, 0) */
+    DEFINE_PROP_UINT8("max-frequency", SDHCIState, cap.base_clk_freq_mhz, 0),
+
     /* Maximum host controller R/W buffers size
      * Possible values: 512, 1024, 2048 bytes */
     DEFINE_PROP_UINT16("max-block-length", SDHCIState, cap.max_blk_len, 512),
-- 
2.15.1
