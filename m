Received: from eggs.gnu.org ([2001:4830:134:3::10]:32936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMx-0006Qq-Cs
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMw-0000HS-8f
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:19 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMw-0000HG-2y
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:18 -0500
Received: by mail-qk0-x241.google.com with SMTP id 84so4157590qks.8
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:20 -0300
Message-Id: <20171213232025.24503-22-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/26] sdcard: add sd_cmd_abbreviation() to
 resolve the SD command id
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

This simplify reading trace output :)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 42 +++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events |  2 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 99678c89d5..c50ac752d4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -200,6 +200,45 @@ static void sd_set_state(SDState *sd, enum SDCardStates state)
 
 #define SD_CMD_MAX 64
 
+static const char *sd_cmd_abbreviation(uint8_t cmd)
+{
+    static const char *cmd_abbrev[SD_CMD_MAX] = {
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
 static const sd_cmd_type_t sd_cmd_type[SD_CMD_MAX] = {
     sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
     sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
@@ -787,7 +826,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
-    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state),
+                                sd_cmd_abbreviation(req.cmd));
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 01f94c4b54..f3714a6dc5 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -24,7 +24,7 @@ sdhci_led(bool state) "LED: %u"
 # hw/sd/sd.c
 sdcard_set_mode(const char *current_mode, const char *new_mode, const char *state) "%s -> %s (state: %s)"
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
-sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
+sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state, const char *cmd_desc) "CMD%d arg 0x%08x (state %s) %s"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
 sdcard_command_response(const char *hexdump, const char *state) "%s (state %s)"
 sdcard_reset(void) ""
-- 
2.15.1
