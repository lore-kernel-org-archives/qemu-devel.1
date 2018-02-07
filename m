Received: from eggs.gnu.org ([2001:4830:134:3::10]:33923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUKE-00024e-BO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUKA-00050V-8E
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:06 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUKA-00050H-3j
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:20:02 -0500
Received: by mail-qt0-x242.google.com with SMTP id f18so2706608qth.11
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:20:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  7 Feb 2018 15:19:21 -0300
Message-Id: <20180207181929.8701-9-f4bug@amsat.org>
In-Reply-To: <20180207181929.8701-1-f4bug@amsat.org>
References: <20180207181929.8701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 08/16] sdhci: use a numeric value for the
 default CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

using many #defines is not portable when scaling to different HCI.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 74 +++++++++++++----------------------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2bcc5ff58a..da30b58723 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -39,67 +39,25 @@
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
 
+#define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
+
 /* Default SD/MMC host controller features information, which will be
  * presented in CAPABILITIES register of generic SD host controller at reset.
- * If not stated otherwise:
- * 0 - not supported, 1 - supported, other - prohibited.
+ *
+ * support:
+ * - 3.3v and 1.8v voltages
+ * - SDMA/ADMA1/ADMA2
+ * - high-speed
+ * max host controller R/W buffers size: 512B
+ * max clock frequency for SDclock: 52 MHz
+ * timeout clock frequency: 52 MHz
+ *
+ * does not support:
+ * - 3.0v voltage
+ * - 64-bit system bus
+ * - suspend/resume
  */
-#define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
-#define SDHC_CAPAB_18V            1ul        /* Voltage support 1.8v */
-#define SDHC_CAPAB_30V            0ul        /* Voltage support 3.0v */
-#define SDHC_CAPAB_33V            1ul        /* Voltage support 3.3v */
-#define SDHC_CAPAB_SUSPRESUME     0ul        /* Suspend/resume support */
-#define SDHC_CAPAB_SDMA           1ul        /* SDMA support */
-#define SDHC_CAPAB_HIGHSPEED      1ul        /* High speed support */
-#define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
-#define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
-/* Maximum host controller R/W buffers size
- * Possible values: 512, 1024, 2048 bytes */
-#define SDHC_CAPAB_MAXBLOCKLENGTH 512ul
-/* Maximum clock frequency for SDclock in MHz
- * value in range 10-63 MHz, 0 - not defined */
-#define SDHC_CAPAB_BASECLKFREQ    52ul
-#define SDHC_CAPAB_TOUNIT         1ul  /* Timeout clock unit 0 - kHz, 1 - MHz */
-/* Timeout clock frequency 1-63, 0 - not defined */
-#define SDHC_CAPAB_TOCLKFREQ      52ul
-
-/* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_18V > 1 || SDHC_CAPAB_30V > 1 ||     \
-    SDHC_CAPAB_33V > 1 || SDHC_CAPAB_SUSPRESUME > 1 || SDHC_CAPAB_SDMA > 1 ||  \
-    SDHC_CAPAB_HIGHSPEED > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1 ||\
-    SDHC_CAPAB_TOUNIT > 1
-#error Capabilities features can have value 0 or 1 only!
-#endif
-
-#if SDHC_CAPAB_MAXBLOCKLENGTH == 512
-#define MAX_BLOCK_LENGTH 0ul
-#elif SDHC_CAPAB_MAXBLOCKLENGTH == 1024
-#define MAX_BLOCK_LENGTH 1ul
-#elif SDHC_CAPAB_MAXBLOCKLENGTH == 2048
-#define MAX_BLOCK_LENGTH 2ul
-#else
-#error Max host controller block size can have value 512, 1024 or 2048 only!
-#endif
-
-#if (SDHC_CAPAB_BASECLKFREQ > 0 && SDHC_CAPAB_BASECLKFREQ < 10) || \
-    SDHC_CAPAB_BASECLKFREQ > 63
-#error SDclock frequency can have value in range 0, 10-63 only!
-#endif
-
-#if SDHC_CAPAB_TOCLKFREQ > 63
-#error Timeout clock frequency can have value in range 0-63 only!
-#endif
-
-#define SDHC_CAPAB_REG_DEFAULT                                 \
-   ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_18V << 26) |     \
-    (SDHC_CAPAB_30V << 25) | (SDHC_CAPAB_33V << 24) |          \
-    (SDHC_CAPAB_SUSPRESUME << 23) | (SDHC_CAPAB_SDMA << 22) |  \
-    (SDHC_CAPAB_HIGHSPEED << 21) | (SDHC_CAPAB_ADMA1 << 20) |  \
-    (SDHC_CAPAB_ADMA2 << 19) | (MAX_BLOCK_LENGTH << 16) |      \
-    (SDHC_CAPAB_BASECLKFREQ << 8) | (SDHC_CAPAB_TOUNIT << 7) | \
-    (SDHC_CAPAB_TOCLKFREQ))
-
-#define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
+#define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
 static uint8_t sdhci_slotint(SDHCIState *s)
 {
-- 
2.16.1
