Received: from eggs.gnu.org ([2001:4830:134:3::10]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHc-0004MT-5i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHZ-0007iG-00
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:00 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHY-0007hq-Py
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:56 -0500
Received: by mail-wm0-x242.google.com with SMTP id i186so15519521wmi.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:25 +0100
Message-Id: <1518523252-49106-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/48] sdhci: use a numeric value for the
 default CAPAB register
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

using many #defines is not portable when scaling to different HCI.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-9-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 74 +++++++++++++----------------------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 17a1348..491e624 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -38,67 +38,25 @@
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
1.8.3.1
