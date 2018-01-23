Received: from eggs.gnu.org ([2001:4830:134:3::10]:37768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIe-0003OV-5F
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpId-0007v0-Bl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:04 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpId-0007uk-7T
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:03 -0500
Received: by mail-qt0-x244.google.com with SMTP id z11so26464510qtm.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:23 -0300
Message-Id: <20180123033034.29493-8-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/18] sdcard: use the correct masked OCR in
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

use the registerfields API to access the OCR register

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 23f5d47782..ee381540aa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -47,8 +47,6 @@
 
 //#define DEBUG_SD 1
 
-#define ACMD41_ENQUIRY_MASK     0x00ffffff
-
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -271,13 +269,26 @@ static uint16_t sd_crc16(void *message, size_t width)
 
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
 static void sd_reset_ocr(SDState *sd)
 {
-    /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
-    sd->ocr = 0x00ffff00;
+    /* All voltages OK */
+    sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
 }
 
 static void sd_ocr_powerup(void *opaque)
@@ -450,7 +461,7 @@ static void sd_response_r1_make(SDState *sd, uint8_t *response)
 
 static void sd_response_r3_make(SDState *sd, uint8_t *response)
 {
-    stl_be_p(response, sd->ocr);
+    stl_be_p(response, sd->ocr & ACMD41_R3_MASK);
 }
 
 static void sd_response_r6_make(SDState *sd, uint8_t *response)
@@ -1634,7 +1645,13 @@ send_response:
     }
 
 #ifdef DEBUG_SD
-    qemu_hexdump((const char *)response, stderr, "Response", rsplen);
+    if (rsplen) {
+        int i;
+        DPRINTF("Response:");
+        for (i = 0; i < rsplen; i++)
+            fprintf(stderr, " %02x", response[i]);
+        fputc('\n', stderr);
+    }
 #endif
 
     return rsplen;
-- 
2.15.1
