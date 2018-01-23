Received: from eggs.gnu.org ([2001:4830:134:3::10]:48834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1Z-0005i2-2h
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1X-0003ff-Ud
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:09:21 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1X-0003fU-Pr
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:09:19 -0500
Received: by mail-qt0-x244.google.com with SMTP id a27so12961342qtd.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 18:09:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 23:08:17 -0300
Message-Id: <20180123020820.1288-14-f4bug@amsat.org>
In-Reply-To: <20180123020820.1288-1-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 13/16] sdhci: check Spec v2 capabilities
 (DMA and 64-bit bus)
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

Incorrect value will throw an error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h | 14 +++++++-------
 hw/sd/sdhci.c          | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 11 deletions(-)

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
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a6bba1939f..bc3a4f6e16 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -90,6 +90,17 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
 
     switch (s->sd_spec_version) {
     case 2: /* default version */
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA2);
+        trace_sdhci_capareg("ADMA2", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA2, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA1);
+        trace_sdhci_capareg("ADMA1", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA1, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT);
+        trace_sdhci_capareg("64-bit system bus", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT, 0);
 
     /* fallback */
     case 1:
@@ -832,7 +843,7 @@ static void sdhci_data_transfer(void *opaque)
 
             break;
         case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & SDHC_CAN_DO_ADMA1)) {
+            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
                 trace_sdhci_error("ADMA1 not supported");
                 break;
             }
@@ -840,7 +851,7 @@ static void sdhci_data_transfer(void *opaque)
             sdhci_do_adma(s);
             break;
         case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & SDHC_CAN_DO_ADMA2)) {
+            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
                 trace_sdhci_error("ADMA2 not supported");
                 break;
             }
@@ -848,8 +859,8 @@ static void sdhci_data_transfer(void *opaque)
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
-- 
2.15.1
