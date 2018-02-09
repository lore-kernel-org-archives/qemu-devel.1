Received: from eggs.gnu.org ([2001:4830:134:3::10]:34124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5L-0002LL-Qq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5H-0005ac-2c
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:31 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5G-0005a4-TF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:26 -0500
Received: by mail-qt0-x243.google.com with SMTP id d14so10836144qtg.1
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:55:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 11:54:17 -0300
Message-Id: <20180209145430.26007-18-f4bug@amsat.org>
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 17/30] sdhci: add support for v3
 capabilities
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 13 ++++++++++++
 hw/sd/sdhci.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index fe68b21e92..bfb39d614b 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -43,6 +43,7 @@
 #define SDHC_TRNS_DMA                  0x0001
 #define SDHC_TRNS_BLK_CNT_EN           0x0002
 #define SDHC_TRNS_ACMD12               0x0004
+#define SDHC_TRNS_ACMD23               0x0008 /* since v3 */
 #define SDHC_TRNS_READ                 0x0010
 #define SDHC_TRNS_MULTI                0x0020
 #define SDHC_TRNMOD_MASK               0x0037
@@ -194,6 +195,7 @@ FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
 FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
 FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
+FIELD(SDHC_CAPAB, EMBEDDED_8BIT,      18, 1); /* since v3 */
 FIELD(SDHC_CAPAB, ADMA2,              19, 1); /* since v2 */
 FIELD(SDHC_CAPAB, ADMA1,              20, 1); /* v1 only? */
 FIELD(SDHC_CAPAB, HIGHSPEED,          21, 1);
@@ -203,6 +205,17 @@ FIELD(SDHC_CAPAB, V33,                24, 1);
 FIELD(SDHC_CAPAB, V30,                25, 1);
 FIELD(SDHC_CAPAB, V18,                26, 1);
 FIELD(SDHC_CAPAB, BUS64BIT,           28, 1); /* since v2 */
+FIELD(SDHC_CAPAB, ASYNC_INT,          29, 1); /* since v3 */
+FIELD(SDHC_CAPAB, SLOT_TYPE,          30, 2); /* since v3 */
+FIELD(SDHC_CAPAB, BUS_SPEED,          32, 3); /* since v3 */
+FIELD(SDHC_CAPAB, DRIVER_STRENGTH,    36, 3); /* since v3 */
+FIELD(SDHC_CAPAB, DRIVER_TYPE_A,      36, 1); /* since v3 */
+FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* since v3 */
+FIELD(SDHC_CAPAB, DRIVER_TYPE_D,      38, 1); /* since v3 */
+FIELD(SDHC_CAPAB, TIMER_RETUNING,     40, 4); /* since v3 */
+FIELD(SDHC_CAPAB, SDR50_TUNING,       45, 1); /* since v3 */
+FIELD(SDHC_CAPAB, RETUNING_MODE,      46, 2); /* since v3 */
+FIELD(SDHC_CAPAB, CLOCK_MULT,         48, 8); /* since v3 */
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f0b9af4976..0fa58cea84 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -70,6 +70,9 @@ static inline unsigned int sdhci_get_fifolen(SDHCIState *s)
 static bool sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
                                          uint8_t freq, Error **errp)
 {
+    if (s->sd_spec_version >= 3) {
+        return false;
+    }
     switch (freq) {
     case 0:
     case 10 ... 63:
@@ -89,6 +92,50 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
     bool unit_mhz;
 
     switch (s->sd_spec_version) {
+    case 3:
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, ASYNC_INT);
+        trace_sdhci_capareg("async interrupt", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, ASYNC_INT, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SLOT_TYPE);
+        if (val) {
+            error_setg(errp, "slot-type not supported");
+            return;
+        }
+        trace_sdhci_capareg("slot type", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SLOT_TYPE, 0);
+
+        if (val != 0b10) {
+            val = FIELD_EX64(s->capareg, SDHC_CAPAB, EMBEDDED_8BIT);
+            trace_sdhci_capareg("8-bit bus", val);
+        }
+        msk = FIELD_DP64(msk, SDHC_CAPAB, EMBEDDED_8BIT, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS_SPEED);
+        trace_sdhci_capareg("bus speed mask", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, BUS_SPEED, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, DRIVER_STRENGTH);
+        trace_sdhci_capareg("driver strength mask", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, DRIVER_STRENGTH, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, TIMER_RETUNING);
+        trace_sdhci_capareg("timer re-tuning", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, TIMER_RETUNING, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, SDR50_TUNING);
+        trace_sdhci_capareg("use SDR50 tuning", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, SDR50_TUNING, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, RETUNING_MODE);
+        trace_sdhci_capareg("re-tuning mode", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, RETUNING_MODE, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, CLOCK_MULT);
+        trace_sdhci_capareg("clock multiplier", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, CLOCK_MULT, 0);
+
+    /* fallback */
     case 2: /* default version */
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA2);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA2, 0);
@@ -1228,8 +1275,11 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
     Error *local_err = NULL;
 
-    if (s->sd_spec_version != 2) {
-        error_setg(errp, "Only Spec v2 is supported");
+    switch (s->sd_spec_version) {
+    case 2 ... 3:
+        break;
+    default:
+        error_setg(errp, "Only Spec v2/v3 are supported");
         return;
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
-- 
2.16.1
