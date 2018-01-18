Received: from eggs.gnu.org ([2001:4830:134:3::10]:44904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecGzq-0000M9-DU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecGzp-0007Q8-59
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:14 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecGzp-0007Pw-0v
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:13 -0500
Received: by mail-qt0-x241.google.com with SMTP id e2so33616952qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:41:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:45 -0300
Message-Id: <20180118204058.5768-2-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 01/14] sdhci: add v3 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 21 +++++++++++++++++++++
 include/hw/sd/sdhci.h  |  5 +++++
 hw/sd/sdhci.c          | 24 ++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 4ed9727ec3..ac4704eb61 100644
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
@@ -183,12 +184,23 @@ FIELD(SDHC_ACMD12ERRSTS, TIMEOUT_ERR,  1, 1);
 FIELD(SDHC_ACMD12ERRSTS, CRC_ERR,      2, 1);
 FIELD(SDHC_ACMD12ERRSTS, INDEX_ERR,    4, 1);
 
+/* Host Control Register 2 (since v3) */
+#define SDHC_HOSTCTL2                  0x3E
+FIELD(SDHC_HOSTCTL2, UHS_MODE_SEL,     0, 3);
+FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
+FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
+
 /* HWInit Capabilities Register 0x05E80080 */
 #define SDHC_CAPAB                     0x40
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
 FIELD(SDHC_CAPAB, BASECLKFREQ,         8, 8);
 FIELD(SDHC_CAPAB, MAXBLOCKLENGTH,     16, 2);
+FIELD(SDHC_CAPAB, EMBEDDED_8BIT,      18, 1); /* since v3 */
 FIELD(SDHC_CAPAB, ADMA2,              19, 1); /* since v2 */
 FIELD(SDHC_CAPAB, ADMA1,              20, 1); /* v1 only? */
 FIELD(SDHC_CAPAB, HIGHSPEED,          21, 1);
@@ -198,6 +210,15 @@ FIELD(SDHC_CAPAB, V33,                24, 1);
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
+FIELD(SDHC_CAPAB, TIMER_RETUNNING,    40, 4); /* since v3 */
+FIELD(SDHC_CAPAB, SDR50_TUNNING,      45, 1); /* since v3 */
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 7e624135f0..bf3bf243d7 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -115,6 +115,11 @@ typedef struct SDHCIState {
          ***********/
         bool adma1, adma2;
         bool bus64;
+
+        /***********
+         * Spec v3
+         ***********/
+        uint8_t slot_type, sdr, strength;
     } cap;
 } SDHCIState;
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e2379d610f..946dff0fac 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -65,6 +65,18 @@ static uint64_t sdhci_init_capareg(SDHCIState *s, Error **errp)
     uint32_t val;
 
     switch (s->spec_version) {
+    case 3:
+        val = FIELD_EX64(capareg, SDHC_CAPAB, SLOT_TYPE);
+        if (val) {
+            error_setg(errp, "slot-type not supported");
+            return 0;
+        }
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, SLOT_TYPE, val);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, BUS_SPEED, s->cap.sdr);
+        capareg = FIELD_DP64(capareg, SDHC_CAPAB, DRIVER_STRENGTH,
+                             s->cap.strength);
+
+    /* fallback */
     case 2: /* default version */
         capareg = FIELD_DP64(capareg, SDHC_CAPAB, ADMA1, s->cap.adma1);
         capareg = FIELD_DP64(capareg, SDHC_CAPAB, ADMA2, s->cap.adma2);
@@ -1175,8 +1187,11 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     uint64_t capab;
     Error *local_err = NULL;
 
-    if (s->spec_version != 2) {
-        error_setg(errp, "Only Spec v2 is supported");
+    switch (s->spec_version) {
+    case 2 ... 3:
+        break;
+    default:
+        error_setg(errp, "Only Spec v2/v3 are supported");
         return;
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
@@ -1219,6 +1234,11 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     DEFINE_PROP_BOOL("adma2", _state, cap.adma2, true), \
     DEFINE_PROP_BOOL("64bit", _state, cap.bus64, false), \
     \
+    /* Spec v3 properties */ \
+    DEFINE_PROP_UINT8("slot-type", _state, cap.slot_type, 0), \
+    DEFINE_PROP_UINT8("bus-speed", _state, cap.sdr, 0), \
+    DEFINE_PROP_UINT8("driver-strength", _state, cap.strength, 0), \
+    \
     /* deprecated: Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
     DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
-- 
2.15.1
