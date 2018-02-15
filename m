Received: from eggs.gnu.org ([2001:4830:134:3::10]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnJ-0005fG-AZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnI-0005VU-Bu
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:21 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnI-0005VD-7W
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:20 -0500
Received: by mail-qk0-x243.google.com with SMTP id s198so1578945qke.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:21 -0300
Message-Id: <20180215221325.7611-17-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/20] sdcard: simplify SD_SEND_OP_COND
 (ACMD41)
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

replace switch(single case) -> if()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 56 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 942143ab3e..911aae6233 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1517,45 +1517,41 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             sd->state = sd_transfer_state;
             return sd_r1;
         }
-        switch (sd->state) {
-        case sd_idle_state:
-            /* If it's the first ACMD41 since reset, we need to decide
-             * whether to power up. If this is not an enquiry ACMD41,
-             * we immediately report power on and proceed below to the
-             * ready state, but if it is, we set a timer to model a
-             * delay for power up. This works around a bug in EDK2
-             * UEFI, which sends an initial enquiry ACMD41, but
-             * assumes that the card is in ready state as soon as it
-             * sees the power up bit set. */
-            if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
-                if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
-                    timer_del(sd->ocr_power_timer);
-                    sd_ocr_powerup(sd);
-                } else {
-                    trace_sdcard_inquiry_cmd41();
-                    if (!timer_pending(sd->ocr_power_timer)) {
-                        timer_mod_ns(sd->ocr_power_timer,
-                                     (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
-                                      + OCR_POWER_DELAY_NS));
-                    }
+        if (sd->state != sd_idle_state) {
+            break;
+        }
+        /* If it's the first ACMD41 since reset, we need to decide
+         * whether to power up. If this is not an enquiry ACMD41,
+         * we immediately report power on and proceed below to the
+         * ready state, but if it is, we set a timer to model a
+         * delay for power up. This works around a bug in EDK2
+         * UEFI, which sends an initial enquiry ACMD41, but
+         * assumes that the card is in ready state as soon as it
+         * sees the power up bit set. */
+        if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
+            if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
+                timer_del(sd->ocr_power_timer);
+                sd_ocr_powerup(sd);
+            } else {
+                trace_sdcard_inquiry_cmd41();
+                if (!timer_pending(sd->ocr_power_timer)) {
+                    timer_mod_ns(sd->ocr_power_timer,
+                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                                  + OCR_POWER_DELAY_NS));
                 }
             }
+        }
 
+        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
             /* We accept any voltage.  10000 V is nothing.
              *
              * Once we're powered up, we advance straight to ready state
              * unless it's an enquiry ACMD41 (bits 23:0 == 0).
              */
-            if (req.arg & ACMD41_ENQUIRY_MASK) {
-                sd->state = sd_ready_state;
-            }
-
-            return sd_r3;
-
-        default:
-            break;
+            sd->state = sd_ready_state;
         }
-        break;
+
+        return sd_r3;
 
     case 42:	/* ACMD42: SET_CLR_CARD_DETECT */
         switch (sd->state) {
-- 
2.16.1
