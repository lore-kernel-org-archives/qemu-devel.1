Received: from eggs.gnu.org ([2001:4830:134:3::10]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqX3-00021a-LX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqX2-0007ef-JG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:05 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqX2-0007eN-Eq
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:04 -0500
Received: by mail-qt0-x241.google.com with SMTP id g10so3771707qtj.12
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:15 -0300
Message-Id: <20180103212436.15762-5-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/25] sdcard: define SDCARD_CMD_MAX instead
 of using the magic '64'
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
 hw/sd/sd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f0eaac4d42..489d13681d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -56,6 +56,8 @@ do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
+#define SDCARD_CMD_MAX 64
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -176,18 +178,21 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const sd_cmd_type_t sd_cmd_type[64] = {
+static const sd_cmd_type_t sd_cmd_type[SDCARD_CMD_MAX] = {
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
+static const int sd_cmd_class[SDCARD_CMD_MAX] = {
     0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
     2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
     5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
@@ -787,8 +792,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd & 0x3F] == sd_ac
-        || sd_cmd_type[req.cmd & 0x3F] == sd_adtc) {
+    if (sd_cmd_type[req.cmd] == sd_ac
+        || sd_cmd_type[req.cmd] == sd_adtc) {
         rca = req.arg >> 16;
     }
 
@@ -1495,8 +1500,8 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd & 0x3F] == 0
-            || sd_cmd_class[req->cmd & 0x3F] == 7;
+    return sd_cmd_class[req->cmd] == 0
+            || sd_cmd_class[req->cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1515,6 +1520,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         goto send_response;
     }
 
+    if (req->cmd >= SDCARD_CMD_MAX) {
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
