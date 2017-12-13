Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNF-0006lL-9D
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNA-0000Zy-88
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:37 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNA-0000Zh-3Z
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:32 -0500
Received: by mail-qk0-x243.google.com with SMTP id b123so4158260qkg.7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:24 -0300
Message-Id: <20171213232025.24503-26-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/26] sdcard: add/use a SDCardCommandClass
 enum instead of magic numbers
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
 hw/sd/sd.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9b90987d7f..688bb40bd1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -274,11 +274,45 @@ static const sd_cmd_type_t sd_cmd_type[SD_CMD_MAX] = {
     sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
 };
 
-static const int sd_cmd_class[SD_CMD_MAX] = {
-    0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
-    2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
-    5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
-    7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
+enum SDCardCommandClass {
+    ccc_basic       = 1 << 0,
+    ccc_blk_read    = 1 << 2,
+    ccc_blk_write   = 1 << 4,
+    ccc_erase       = 1 << 5,
+    ccc_wp          = 1 << 6,
+    ccc_lock        = 1 << 7,
+    ccc_appspec     = 1 << 8,
+    ccc_io          = 1 << 9,
+    ccc_switch      = 1 << 10,
+    ccc_ext         = 1 << 11,
+};
+
+static const uint32_t sd_cmd_class[SD_CMD_MAX] = {
+    ccc_basic, 0, ccc_basic, ccc_basic,
+    ccc_basic, ccc_io, ccc_switch, ccc_basic,
+    ccc_basic, ccc_basic, ccc_basic, ccc_basic,
+    ccc_basic, ccc_basic, 0, ccc_basic,
+    /* 16 */
+    ccc_blk_read | ccc_blk_write | ccc_lock, ccc_blk_read,
+    ccc_blk_read, ccc_blk_read,
+    ccc_blk_read | ccc_blk_write, ccc_ext, 0,
+    ccc_blk_read | ccc_blk_write,
+    ccc_blk_write, ccc_blk_write,
+    0, ccc_blk_write,
+    ccc_wp, ccc_wp,
+    ccc_wp, 0,
+    /* 32 */
+    ccc_erase, ccc_erase,
+    ccc_switch, ccc_switch,
+    ccc_switch, ccc_switch,
+    ccc_erase, 0,
+    ccc_lock, 0, ccc_lock, 0, 0, 0, 0, 0,
+    /* 48 */
+    ccc_ext, ccc_ext, ccc_switch, 0,
+    ccc_io, ccc_io, 0, ccc_appspec,
+    ccc_appspec, ccc_switch,
+    ccc_ext, ccc_ext,
+    0, 0, 0, 0
 };
 
 static uint8_t sd_crc7(void *message, size_t width)
@@ -1565,8 +1599,8 @@ static bool cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return true;
     }
-    return sd_cmd_class[req->cmd] == 0
-            || sd_cmd_class[req->cmd] == 7;
+    return sd_cmd_class[req->cmd] == ccc_basic
+        || sd_cmd_class[req->cmd] == ccc_lock;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req, uint8_t *response)
-- 
2.15.1
