Received: from eggs.gnu.org ([2001:4830:134:3::10]:35559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpAF-0003u7-BY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpAC-00014z-5x
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:23 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpAC-00014E-0m
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:20 -0500
Received: by mail-qt0-x243.google.com with SMTP id d8so17830108qtm.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:22:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:35 -0300
Message-Id: <20180123032135.28863-13-f4bug@amsat.org>
In-Reply-To: <20180123032135.28863-1-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/12] sdcard: use the registerfields API to
 access the OCR register
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h |  1 -
 hw/sd/sd.c         | 21 +++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index bf1eb0713c..9bdb3c9285 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -53,7 +53,6 @@
 #define READY_FOR_DATA		(1 << 8)
 #define APP_CMD			(1 << 5)
 #define AKE_SEQ_ERROR		(1 << 3)
-#define OCR_CCS_BITN        30
 
 typedef enum {
     SD_VOLTAGE_0_4V     = 400,  /* currently not supported */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f87e543f8f..437ce25f79 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "hw/hw.h"
+#include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
@@ -47,8 +48,6 @@
 //#define DEBUG_SD 1
 
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
-#define OCR_POWER_UP            0x80000000
-#define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 typedef enum {
     sd_r0 = 0,    /* no response */
@@ -270,6 +269,11 @@ static uint16_t sd_crc16(void *message, size_t width)
     return shift_reg;
 }
 
+#define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
+
+FIELD(OCR, CARD_CAPACITY,              30,  1) /* 0:SDSC, 1:SDHC/SDXC */
+FIELD(OCR, CARD_POWER_UP,              31,  1)
+
 static void sd_reset_ocr(SDState *sd)
 {
     /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
@@ -281,9 +285,10 @@ static void sd_ocr_powerup(void *opaque)
     SDState *sd = opaque;
 
     trace_sdcard_powerup();
-    /* Set powered up bit in OCR */
-    assert(!(sd->ocr & OCR_POWER_UP));
-    sd->ocr |= OCR_POWER_UP;
+    assert(!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP));
+
+    /* card power-up OK */
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 }
 
 static void sd_reset_scr(SDState *sd)
@@ -574,7 +579,7 @@ static bool sd_ocr_vmstate_needed(void *opaque)
     SDState *sd = opaque;
 
     /* Include the OCR state (and timer) if it is not yet powered up */
-    return !(sd->ocr & OCR_POWER_UP);
+    return !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
 }
 
 static const VMStateDescription sd_ocr_vmstate = {
@@ -684,7 +689,7 @@ static void sd_erase(SDState *sd)
         return;
     }
 
-    if (extract32(sd->ocr, OCR_CCS_BITN, 1)) {
+    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
         /* High capacity memory card: erase units are 512 byte blocks */
         erase_start *= 512;
         erase_end *= 512;
@@ -1476,7 +1481,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
              * UEFI, which sends an initial enquiry ACMD41, but
              * assumes that the card is in ready state as soon as it
              * sees the power up bit set. */
-            if (!(sd->ocr & OCR_POWER_UP)) {
+            if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
                 if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
                     timer_del(sd->ocr_power_timer);
                     sd_ocr_powerup(sd);
-- 
2.15.1
