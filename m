Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9w-0003eX-VJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9v-0000kZ-VP
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:04 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9v-0000kC-QV
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:22:03 -0500
Received: by mail-qt0-x241.google.com with SMTP id z10so26434053qti.5
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:22:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:30 -0300
Message-Id: <20180123032135.28863-8-f4bug@amsat.org>
In-Reply-To: <20180123032135.28863-1-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/12] sdcard: define SDMMC_CMD_MAX instead
 of using the magic '64'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 27c08aa894..7b1cbc0a2e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -126,6 +126,8 @@ struct SDState {
     bool cmd_line;
 };
 
+#define SDMMC_CMD_MAX 64
+
 static const char *sd_state_name(enum SDCardStates state)
 {
     static const char *state_name[] = {
@@ -213,18 +215,21 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const sd_cmd_type_t sd_cmd_type[64] = {
+static const sd_cmd_type_t sd_cmd_type[SDMMC_CMD_MAX] = {
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
+static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
     2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
     5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
@@ -829,8 +834,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd & 0x3F] == sd_ac
-        || sd_cmd_type[req.cmd & 0x3F] == sd_adtc) {
+    if (sd_cmd_type[req.cmd] == sd_ac
+        || sd_cmd_type[req.cmd] == sd_adtc) {
         rca = req.arg >> 16;
     }
 
@@ -1542,8 +1547,8 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd & 0x3F] == 0
-            || sd_cmd_class[req->cmd & 0x3F] == 7;
+    return sd_cmd_class[req->cmd] == 0
+            || sd_cmd_class[req->cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1562,6 +1567,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         goto send_response;
     }
 
+    if (req->cmd >= SDMMC_CMD_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n",
+                      req->cmd);
+        req->cmd &= 0x3f;
+    }
+
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req)) {
             sd->card_status |= ILLEGAL_COMMAND;
-- 
2.15.1
