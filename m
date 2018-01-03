Received: from eggs.gnu.org ([2001:4830:134:3::10]:51684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXO-0002OA-Dl
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXK-0007uS-1I
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:26 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXJ-0007tx-Sw
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:21 -0500
Received: by mail-qk0-x244.google.com with SMTP id x7so3255769qkb.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:19 -0300
Message-Id: <20180103212436.15762-9-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/25] sdcard: use the registerfields API to
 access the OCR register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7d43ab072b..1f209b8199 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "hw/hw.h"
+#include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
 #include "hw/sd/sdcard_legacy.h"
@@ -53,8 +54,6 @@ do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
 #endif
 
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
-#define OCR_POWER_UP            0x80000000
-#define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
 #define SDCARD_CMD_MAX 64
 
@@ -293,6 +292,10 @@ static uint16_t sd_crc16(void *message, size_t width)
     return shift_reg;
 }
 
+FIELD(OCR, CARD_POWER_UP,              31, 1);
+
+#define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
+
 static void sd_reset_ocr(SDState *sd)
 {
     /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
@@ -303,9 +306,10 @@ static void sd_ocr_powerup(void *opaque)
 {
     SDState *sd = opaque;
 
-    /* Set powered up bit in OCR */
-    assert(!(sd->ocr & OCR_POWER_UP));
-    sd->ocr |= OCR_POWER_UP;
+    assert(!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP));
+
+    /* card power-up OK */
+    sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 }
 
 static void sd_reset_scr(SDState *sd)
@@ -594,7 +598,7 @@ static bool sd_ocr_vmstate_needed(void *opaque)
     SDState *sd = opaque;
 
     /* Include the OCR state (and timer) if it is not yet powered up */
-    return !(sd->ocr & OCR_POWER_UP);
+    return !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
 }
 
 static const VMStateDescription sd_ocr_vmstate = {
@@ -1494,7 +1498,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
