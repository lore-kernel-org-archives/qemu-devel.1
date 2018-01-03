Received: from eggs.gnu.org ([2001:4830:134:3::10]:51551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXB-00028F-87
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqX6-0007iR-Up
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:13 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqX6-0007i8-OL
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:08 -0500
Received: by mail-qk0-x241.google.com with SMTP id o126so3241242qke.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:16 -0300
Message-Id: <20180103212436.15762-6-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/25] sdcard: display command name when
 tracing CMD/ACMD
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
 hw/sd/sd.c         | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/sd/trace-events |  4 +--
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 489d13681d..7bb5c6fb5e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -133,6 +133,7 @@ struct SDState {
     QEMUTimer *ocr_power_timer;
 
     bool enable;
+    const char *proto_name;
 };
 
 static const char *sd_state_name(enum SDCardStates state)
@@ -154,6 +155,66 @@ static const char *sd_state_name(enum SDCardStates state)
     return state_name[state];
 }
 
+static const char *sd_cmd_abbreviation(uint8_t cmd)
+{
+    static const char *cmd_abbrev[SDCARD_CMD_MAX] = {
+         [0]    = "GO_IDLE_STATE",
+         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
+         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
+         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
+         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
+        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
+        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
+                                            [15]    = "GO_INACTIVE_STATE",
+        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
+        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
+        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
+                                            [23]    = "SET_BLOCK_COUNT",
+        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
+        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
+        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
+        [30]    = "SEND_WRITE_PROT",
+        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
+        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
+        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
+        [38]    = "ERASE",
+        [40]    = "DPS_spec",
+        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
+        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
+        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
+        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
+        [50]    = "SW_FUNC_RSVD", /* FIXME */
+        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
+        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
+        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
+        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
+        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
+        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
+    };
+    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
+}
+
+static const char *sd_acmd_abbreviation(uint8_t cmd)
+{
+    static const char *acmd_abbrev[SDCARD_CMD_MAX] = {
+         [6] = "SET_BUS_WIDTH",
+        [13] = "SD_STATUS",
+        [14] = "DPS_spec",                  [15] = "DPS_spec",
+        [16] = "DPS_spec",
+        [18] = "SECU_spec",
+        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
+        [41] = "SD_SEND_OP_COND",
+        [42] = "SET_CLR_CARD_DETECT",
+        [51] = "SEND_SCR",
+        [52] = "SECU_spec",                 [53] = "SECU_spec",
+        [54] = "SECU_spec",
+        [56] = "SECU_spec",                 [57] = "SECU_spec",
+        [58] = "SECU_spec",                 [59] = "SECU_spec",
+    };
+
+    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
+}
+
 static void sd_set_mode(SDState *sd)
 {
     switch (sd->state) {
@@ -781,13 +842,16 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
 }
 
-static sd_rsp_type_t sd_normal_command(SDState *sd,
-                                       SDRequest req)
+static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
-    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+    if (req.cmd != 55 || sd->expecting_acmd) {
+        trace_sdcard_normal_command(sd->proto_name,
+                                    sd_cmd_abbreviation(req.cmd), req.cmd,
+                                    req.arg, sd_state_name(sd->state));
+    }
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
@@ -1355,7 +1419,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(req.cmd, req.arg);
+    trace_sdcard_app_command(sd->proto_name, sd_acmd_abbreviation(req.cmd),
+                             req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1935,6 +2000,8 @@ static void sd_realize(DeviceState *dev, Error **errp)
     SDState *sd = SD_CARD(dev);
     int ret;
 
+    sd->proto_name = sd->spi ? "SPI" : "SD";
+
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
         return;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 727d6fd904..25ab339f97 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -16,8 +16,8 @@ sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of
 sdhci_led(bool state) "LED: %u"
 
 # hw/sd/sd.c
-sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
-sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_normal_command(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%s %20s/ CMD%02d arg 0x%08x (state %s)"
+sdcard_app_command(const char *proto, const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%s %23s/ACMD%02d arg 0x%08x (state %s)"
 sdcard_reset(void) ""
 sdcard_inserted(bool readonly) "read_only: %d"
 sdcard_ejected(void) ""
-- 
2.15.1
