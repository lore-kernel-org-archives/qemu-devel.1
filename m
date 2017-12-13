Received: from eggs.gnu.org ([2001:4830:134:3::10]:33052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGN5-0006bZ-1O
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMz-0000Mg-RY
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:27 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMz-0000MC-N8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:21 -0500
Received: by mail-qk0-x244.google.com with SMTP id h19so4158028qkj.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:21 -0300
Message-Id: <20171213232025.24503-23-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 22/26] sdcard: reduce sd_cmd traces
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

Do not trace CMD55 used to start an ACMD.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 6 ++++--
 hw/sd/trace-events | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c50ac752d4..8104d6c055 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -826,8 +826,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
-    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state),
-                                sd_cmd_abbreviation(req.cmd));
+    if (req.cmd != 55 || sd->expecting_acmd) {
+        trace_sdcard_normal_command(sd_cmd_abbreviation(req.cmd), req.cmd,
+                                    req.arg, sd_state_name(sd->state));
+    }
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index f3714a6dc5..412f01a832 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -24,7 +24,7 @@ sdhci_led(bool state) "LED: %u"
 # hw/sd/sd.c
 sdcard_set_mode(const char *current_mode, const char *new_mode, const char *state) "%s -> %s (state: %s)"
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
-sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state, const char *cmd_desc) "CMD%d arg 0x%08x (state %s) %s"
+sdcard_normal_command(const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%20s/ CMD%02d arg 0x%08x (state %s)"
 sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
 sdcard_command_response(const char *hexdump, const char *state) "%s (state %s)"
 sdcard_reset(void) ""
-- 
2.15.1
