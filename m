Received: from eggs.gnu.org ([2001:4830:134:3::10]:38578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosin-00051z-Ga
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosij-0001ow-BJ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosij-0001na-2Z
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosii-00025j-55
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:58 +0000
Message-Id: <20180222152307.7499-24-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/32] sdcard: use the correct masked OCR in the
 R3 reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

use the registerfields API to access the OCR register

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3e1f7e51ad..5044a306e4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -47,8 +47,6 @@
 
 //#define DEBUG_SD 1
 
-#define ACMD41_ENQUIRY_MASK     0x00ffffff
-
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -272,13 +270,26 @@ static uint16_t sd_crc16(void *message, size_t width)
 
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
@@ -446,7 +457,7 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
 
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
-    stl_be_p(response, sd->ocr);
+    stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
-- 
2.16.1
