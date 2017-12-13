Received: from eggs.gnu.org ([2001:4830:134:3::10]:60849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMO-0005vH-KK
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMN-0008Ay-Ei
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:44 -0500
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:40608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMN-0008AC-AK
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:43 -0500
Received: by mail-qk0-x22e.google.com with SMTP id b123so4156126qkg.7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:12 -0300
Message-Id: <20171213232025.24503-14-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/26] sdcard: add more trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Clement Deschamps <clement.deschamps@antfield.fr>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 12 ++++++++++++
 hw/sd/trace-events |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd583be835..84e02745f1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -449,6 +449,7 @@ static void sd_reset(DeviceState *dev)
     uint64_t size;
     uint64_t sect;
 
+    trace_sdcard_reset();
     if (sd->blk) {
         blk_get_geometry(sd->blk, &sect);
     } else {
@@ -500,7 +501,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
     bool readonly = sd_get_readonly(sd);
 
     if (inserted) {
+        trace_sdcard_inserted(readonly);
         sd_reset(dev);
+    } else {
+        trace_sdcard_ejected();
     }
 
     /* The IRQ notification is for legacy non-QOM SD controller devices;
@@ -632,6 +636,7 @@ static void sd_erase(SDState *sd)
     uint64_t erase_start = sd->erase_start;
     uint64_t erase_end = sd->erase_end;
 
+    trace_sdcard_erase();
     if (!sd->erase_start || !sd->erase_end) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
@@ -713,6 +718,11 @@ static void sd_lock_command(SDState *sd)
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
@@ -1639,6 +1649,7 @@ void sd_write_data(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
+    trace_sdcard_write_data(value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1776,6 +1787,7 @@ uint8_t sd_read_data(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
+    trace_sdcard_read_data(io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 117da83014..0e78f980de 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -26,8 +26,16 @@ sdcard_set_mode(const char *current_mode, const char *new_mode, const char *stat
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
 sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_reset(void) ""
+sdcard_inserted(bool readonly) "read_only: %d"
+sdcard_ejected(void) ""
+sdcard_erase(void) ""
+sdcard_lock(void) ""
+sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%08lx size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%08lx size 0x%x"
+sdcard_write_data(uint8_t value) "value 0x%02x"
+sdcard_read_data(int length) "len %d"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
