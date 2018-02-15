Received: from eggs.gnu.org ([2001:4830:134:3::10]:58425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmr-0004zi-UB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmq-0005Ay-Sf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:53 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmq-0005Al-Ny
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:52 -0500
Received: by mail-qt0-x241.google.com with SMTP id a9so1618116qtj.8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:12 -0300
Message-Id: <20180215221325.7611-8-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/20] sdcard: use the correct masked OCR in
 the R3 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

use the registerfields API to access the OCR register

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b43baa2edd..3970e590e6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -47,8 +47,6 @@
 
 //#define DEBUG_SD 1
 
-#define ACMD41_ENQUIRY_MASK     0x00ffffff
-
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -273,13 +271,26 @@ static uint16_t sd_crc16(void *message, size_t width)
 
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
+FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
+FIELD(OCR, VDD_VOLTAGE_WIN_LO,          0,  8)
+FIELD(OCR, DUAL_VOLTAGE_CARD,           7,  1)
+FIELD(OCR, VDD_VOLTAGE_WIN_HI,          8, 16)
+FIELD(OCR, ACCEPT_SWITCH_1V8,          24,  1) /* Only UHS-I */
+FIELD(OCR, UHS_II_CARD,                29,  1) /* Only UHS-II */
 FIELD(OCR, CARD_CAPACITY,              30,  1) /* 0:SDSC, 1:SDHC/SDXC */
 FIELD(OCR, CARD_POWER_UP,              31,  1)
 
+#define ACMD41_ENQUIRY_MASK     0x00ffffff
+#define ACMD41_R3_MASK          (R_OCR_VDD_VOLTAGE_WIN_HI_MASK \
+                               | R_OCR_ACCEPT_SWITCH_1V8_MASK \
+                               | R_OCR_UHS_II_CARD_MASK \
+                               | R_OCR_CARD_CAPACITY_MASK \
+                               | R_OCR_CARD_POWER_UP_MASK)
+
 static void sd_set_ocr(SDState *sd)
 {
-    /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
-    sd->ocr = 0x00ffff00;
+    /* All voltages OK */
+    sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -447,7 +458,7 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
 
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
-    stl_be_p(response, sd->ocr);
+    stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
-- 
2.16.1
