Received: from eggs.gnu.org ([2001:4830:134:3::10]:55538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf7-00063H-1L
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf6-0000y2-3z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:53 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf5-0000xm-Vq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:52 -0500
Received: by mail-qt0-x243.google.com with SMTP id k25so1594485qtj.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:05:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:30 -0300
Message-Id: <20180215220540.6556-2-f4bug@amsat.org>
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/11] sdcard: reorder SDState struct members
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

place card registers first, this will ease further code movements.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9ac9b63ff8..ce1f2fdf76 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -88,16 +88,21 @@ enum SDCardStates {
 struct SDState {
     DeviceState parent_obj;
 
-    uint32_t mode;    /* current card mode, one of SDCardModes */
-    int32_t state;    /* current card state, one of SDCardStates */
+    /* SD Memory Card Registers */
     uint32_t ocr;
-    QEMUTimer *ocr_power_timer;
     uint8_t scr[8];
     uint8_t cid[16];
     uint8_t csd[16];
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
+
+    /* Configurable properties */
+    BlockBackend *blk;
+    bool spi;
+
+    uint32_t mode;    /* current card mode, one of SDCardModes */
+    int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_groups;
@@ -110,8 +115,6 @@ struct SDState {
     uint8_t pwd[16];
     uint32_t pwd_len;
     uint8_t function_group[6];
-
-    bool spi;
     uint8_t current_cmd;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
@@ -123,8 +126,7 @@ struct SDState {
     uint8_t data[512];
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
-    BlockBackend *blk;
-
+    QEMUTimer *ocr_power_timer;
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
-- 
2.16.1
