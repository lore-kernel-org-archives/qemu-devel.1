Received: from eggs.gnu.org ([2001:4830:134:3::10]:32916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMu-0006NK-9l
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMs-0000ET-D7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:16 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMs-0000EA-8N
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:14 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so5863481qtj.6
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:19 -0300
Message-Id: <20171213232025.24503-21-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/26] sdcard: add/use SD_CMD_MAX to check
 valid SD commands
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

We check once in sd_do_command() if the command is valid
(and remove duplicate checks in sd_normal_command() and
cmd_valid_while_locked()).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8a10e28080..99678c89d5 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -198,18 +198,23 @@ static void sd_set_state(SDState *sd, enum SDCardStates state)
     }
 }
 
-static const sd_cmd_type_t sd_cmd_type[64] = {
+#define SD_CMD_MAX 64
+
+static const sd_cmd_type_t sd_cmd_type[SD_CMD_MAX] = {
     sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
     sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
+    /* 16 */
     sd_ac,   sd_adtc, sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none,
     sd_adtc, sd_adtc, sd_adtc, sd_adtc, sd_ac,   sd_ac,   sd_adtc, sd_none,
+    /* 32 */
     sd_ac,   sd_ac,   sd_none, sd_none, sd_none, sd_none, sd_ac,   sd_none,
     sd_none, sd_none, sd_bc,   sd_none, sd_none, sd_none, sd_none, sd_none,
+    /* 48 */
     sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_ac,
     sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
 };
 
-static const int sd_cmd_class[64] = {
+static const int sd_cmd_class[SD_CMD_MAX] = {
     0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
     2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
     5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
@@ -787,8 +792,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd & 0x3F] == sd_ac
-        || sd_cmd_type[req.cmd & 0x3F] == sd_adtc) {
+    if (sd_cmd_type[req.cmd] & sd_ac || sd_cmd_type[req.cmd] & sd_adtc) {
         rca = req.arg >> 16;
     }
 
@@ -1496,8 +1500,8 @@ static bool cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return true;
     }
-    return sd_cmd_class[req->cmd & 0x3F] == 0
-            || sd_cmd_class[req->cmd & 0x3F] == 7;
+    return sd_cmd_class[req->cmd] == 0
+            || sd_cmd_class[req->cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req, uint8_t *response)
@@ -1509,6 +1513,11 @@ int sd_do_command(SDState *sd, SDRequest *req, uint8_t *response)
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable) {
         return 0;
     }
+    if (req->cmd > SD_CMD_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n",
+                      req->cmd);
+        req->cmd &= 0x3f;
+    }
 
     if (sd_req_crc_validate(req)) {
         sd->card_status |= COM_CRC_ERROR;
-- 
2.15.1
