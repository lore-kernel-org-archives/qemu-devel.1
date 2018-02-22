Received: from eggs.gnu.org ([2001:4830:134:3::10]:38678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiu-00059i-EH
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosit-0001zz-El
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosit-0001yC-7L
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosis-00027v-2q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:50 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:07 +0000
Message-Id: <20180222152307.7499-33-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/32] sdcard: simplify SD_SEND_OP_COND (ACMD41)
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

replace switch(single case) -> if()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-17-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 56 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 25fce7d6b6..933890e86f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1512,45 +1512,41 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
