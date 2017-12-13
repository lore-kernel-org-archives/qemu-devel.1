Received: from eggs.gnu.org ([2001:4830:134:3::10]:33053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN5-0006bb-1h
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN3-0000QI-Bb
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:26 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN3-0000PX-6k
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:25 -0500
Received: by mail-qk0-x243.google.com with SMTP id h19so4158206qkj.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:22 -0300
Message-Id: <20171213232025.24503-24-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 23/26] sdcard: add ACMD trace events
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

and his sd_acmd_abbreviation() companion to pretty-print the ACMD id.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 25 ++++++++++++++++++++++++-
 hw/sd/trace-events |  2 +-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8104d6c055..b8a5a344f5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -239,6 +239,27 @@ static const char *sd_cmd_abbreviation(uint8_t cmd)
     return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
 }
 
+static const char *sd_acmd_abbreviation(uint8_t cmd)
+{
+    static const char *acmd_abbrev[SD_CMD_MAX] = {
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
 static const sd_cmd_type_t sd_cmd_type[SD_CMD_MAX] = {
     sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
     sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
@@ -1397,7 +1418,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(req.cmd, req.arg);
+    trace_sdcard_app_command(sd_acmd_abbreviation(req.cmd), req.cmd,
+                             req.arg, sd_state_name(sd->state));
+
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 412f01a832..651e3fb303 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -25,7 +25,7 @@ sdhci_led(bool state) "LED: %u"
 sdcard_set_mode(const char *current_mode, const char *new_mode, const char *state) "%s -> %s (state: %s)"
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
 sdcard_normal_command(const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%20s/ CMD%02d arg 0x%08x (state %s)"
-sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_app_command(const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%23s/ACMD%02d arg 0x%08x (state %s)"
 sdcard_command_response(const char *hexdump, const char *state) "%s (state %s)"
 sdcard_reset(void) ""
 sdcard_inserted(bool readonly) "read_only: %d"
-- 
2.15.1
