Received: from eggs.gnu.org ([2001:4830:134:3::10]:55854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfd-0006UL-Vt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfc-0001Eq-NR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:25 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfc-0001EU-HB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:24 -0500
Received: by mail-qt0-x244.google.com with SMTP id k13so1611749qtg.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:06:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:38 -0300
Message-Id: <20180215220540.6556-10-f4bug@amsat.org>
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/11] sdcard: display protocol used when
 tracing
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

put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 14 ++++++++++----
 hw/sd/trace-events |  8 ++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 666ff3873f..6760815045 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -122,6 +122,7 @@ struct SDState {
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
+    const char *proto_name;
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
@@ -828,7 +829,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(sd_cmd_name(req.cmd), req.cmd,
+        trace_sdcard_normal_command(sd->proto_name,
+                                    sd_cmd_name(req.cmd), req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
 
@@ -1400,7 +1402,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd_acmd_name(req.cmd),
+    trace_sdcard_app_command(sd->proto_name, sd_acmd_name(req.cmd),
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
@@ -1699,7 +1701,8 @@ void sd_write_data(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd_acmd_name(sd->current_cmd),
+    trace_sdcard_write_data(sd->proto_name,
+                            sd_acmd_name(sd->current_cmd),
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
@@ -1838,7 +1841,8 @@ uint8_t sd_read_data(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd_acmd_name(sd->current_cmd),
+    trace_sdcard_read_data(sd->proto_name,
+                           sd_acmd_name(sd->current_cmd),
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
@@ -1980,6 +1984,8 @@ static void sd_realize(DeviceState *dev, Error **errp)
     SDState *sd = SD_CARD(dev);
     int ret;
 
+    sd->proto_name = sd->spi ? "SPI" : "SD";
+
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
         return;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index cdddca3dbf..2059ace61f 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -24,8 +24,8 @@ sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of
 sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 
 # hw/sd/sd.c
-sdcard_normal_command(const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%20s/ CMD%02d arg 0x%08x (state %s)"
-sdcard_app_command(const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%23s/ACMD%02d arg 0x%08x (state %s)"
+sdcard_normal_command(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%s %20s/ CMD%02d arg 0x%08x (state %s)"
+sdcard_app_command(const char *proto, const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%s %23s/ACMD%02d arg 0x%08x (state %s)"
 sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
@@ -39,8 +39,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *cmd_desc, uint8_t cmd, uint8_t value) "%20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *cmd_desc, uint8_t cmd, int length) "%20s/ CMD%02d len %d"
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # hw/sd/milkymist-memcard.c
-- 
2.16.1
