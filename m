Received: from eggs.gnu.org ([2001:4830:134:3::10]:38406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosid-0004pL-5B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosib-0001gd-Pt
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosib-0001fC-Hd
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosia-00023D-Fk
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:48 +0000
Message-Id: <20180222152307.7499-14-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/32] sdcard: add more trace events
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215220540.6556-6-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c         | 32 ++++++++++++++++++++++++++------
 hw/sd/trace-events | 13 +++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ceab263970..564f7a9bfd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -179,6 +179,8 @@ static bool sd_get_cmd_line(SDState *sd)
 
 static void sd_set_voltage(SDState *sd, uint16_t millivolts)
 {
+    trace_sdcard_set_voltage(millivolts);
+
     switch (millivolts) {
     case 3001 ... 3600: /* SD_VOLTAGE_3_3V */
     case 2001 ... 3000: /* SD_VOLTAGE_3_0V */
@@ -274,6 +276,7 @@ static void sd_ocr_powerup(void *opaque)
 {
     SDState *sd = opaque;
 
+    trace_sdcard_powerup();
     /* Set powered up bit in OCR */
     assert(!(sd->ocr & OCR_POWER_UP));
     sd->ocr |= OCR_POWER_UP;
@@ -477,6 +480,7 @@ static void sd_reset(DeviceState *dev)
     uint64_t size;
     uint64_t sect;
 
+    trace_sdcard_reset();
     if (sd->blk) {
         blk_get_geometry(sd->blk, &sect);
     } else {
@@ -530,7 +534,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
     bool readonly = sd_get_readonly(sd);
 
     if (inserted) {
+        trace_sdcard_inserted(readonly);
         sd_reset(dev);
+    } else {
+        trace_sdcard_ejected();
     }
 
     /* The IRQ notification is for legacy non-QOM SD controller devices;
@@ -662,6 +669,7 @@ static void sd_erase(SDState *sd)
     uint64_t erase_start = sd->erase_start;
     uint64_t erase_end = sd->erase_end;
 
+    trace_sdcard_erase();
     if (!sd->erase_start || !sd->erase_end) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
@@ -751,6 +759,11 @@ static void sd_lock_command(SDState *sd)
     else
         pwd_len = 0;
 
+    if (lock) {
+        trace_sdcard_lock();
+    } else {
+        trace_sdcard_unlock();
+    }
     if (erase) {
         if (!(sd->card_status & CARD_IS_LOCKED) || sd->blk_len > 1 ||
                         set_pwd || clr_pwd || lock || sd->wp_switch ||
@@ -1077,10 +1090,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     case 16:	/* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
         case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT))
+            if (req.arg > (1 << HWBLOCK_SHIFT)) {
                 sd->card_status |= BLOCK_LEN_ERROR;
-            else
+            } else {
+                trace_sdcard_set_blocklen(req.arg);
                 sd->blk_len = req.arg;
+            }
 
             return sd_r1;
 
@@ -1452,10 +1467,13 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                 if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
                     timer_del(sd->ocr_power_timer);
                     sd_ocr_powerup(sd);
-                } else if (!timer_pending(sd->ocr_power_timer)) {
-                    timer_mod_ns(sd->ocr_power_timer,
-                                 (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
-                                  + OCR_POWER_DELAY_NS));
+                } else {
+                    trace_sdcard_inquiry_cmd41();
+                    if (!timer_pending(sd->ocr_power_timer)) {
+                        timer_mod_ns(sd->ocr_power_timer,
+                                     (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                                      + OCR_POWER_DELAY_NS));
+                    }
                 }
             }
 
@@ -1668,6 +1686,7 @@ void sd_write_data(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
+    trace_sdcard_write_data(sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1805,6 +1824,7 @@ uint8_t sd_read_data(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
+    trace_sdcard_read_data(sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index b2aa19ec0d..3040d32560 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -27,8 +27,21 @@ sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
 sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
+sdcard_powerup(void) ""
+sdcard_inquiry_cmd41(void) ""
+sdcard_set_enable(bool current_state, bool new_state) "%u -> %u"
+sdcard_reset(void) ""
+sdcard_set_blocklen(uint16_t length) "0x%04x"
+sdcard_inserted(bool readonly) "read_only: %u"
+sdcard_ejected(void) ""
+sdcard_erase(void) ""
+sdcard_lock(void) ""
+sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
+sdcard_write_data(uint8_t cmd, uint8_t value) "CMD%02d value 0x%02x"
+sdcard_read_data(uint8_t cmd, int length) "CMD%02d len %d"
+sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.16.1
