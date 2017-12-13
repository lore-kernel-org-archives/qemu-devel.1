Received: from eggs.gnu.org ([2001:4830:134:3::10]:60930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMX-00061L-JO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMW-0008JP-H4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:53 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMW-0008J0-DJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:52 -0500
Received: by mail-qt0-x242.google.com with SMTP id m59so5832588qte.11
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:14 -0300
Message-Id: <20171213232025.24503-16-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/26] sdcard: use PW_LEN define instead of
 '16' magic
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
 hw/sd/sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2a249b1612..542170c3ec 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -47,6 +47,8 @@
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
 
+#define PW_LEN 16
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -100,7 +102,7 @@ struct SDState {
     uint32_t multi_blk_cnt;
     uint32_t erase_start;
     uint32_t erase_end;
-    uint8_t pwd[16];
+    uint8_t pwd[PW_LEN];
     uint32_t pwd_len;
     uint8_t function_group[6];
 
@@ -571,7 +573,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT32(multi_blk_cnt, SDState),
         VMSTATE_UINT32(erase_start, SDState),
         VMSTATE_UINT32(erase_end, SDState),
-        VMSTATE_UINT8_ARRAY(pwd, SDState, 16),
+        VMSTATE_UINT8_ARRAY(pwd, SDState, PW_LEN),
         VMSTATE_UINT32(pwd_len, SDState),
         VMSTATE_UINT8_ARRAY(function_group, SDState, 6),
         VMSTATE_UINT8(current_cmd, SDState),
@@ -733,7 +735,7 @@ static void sd_lock_command(SDState *sd)
 
     if (sd->blk_len < 2 + pwd_len ||
                     pwd_len <= sd->pwd_len ||
-                    pwd_len > sd->pwd_len + 16) {
+                    pwd_len > sd->pwd_len + sizeof(sd->pwd)) {
         sd->card_status |= LOCK_UNLOCK_FAILED;
         return;
     }
-- 
2.15.1
