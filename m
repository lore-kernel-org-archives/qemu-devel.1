Received: from eggs.gnu.org ([2001:4830:134:3::10]:37916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ5-0003lF-JO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ1-0008Ex-Lc
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:30 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpJ1-0008Ei-Hc
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:31:27 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so26455140qtm.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:31:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:31 -0300
Message-Id: <20180123033034.29493-16-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/18] sdcard: add SD SEND_TUNING_BLOCK
 (CMD19)
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

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6efcacb942..27176ba33e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1169,6 +1169,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
+    case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
+        if (sd->state == sd_transfer_state) {
+            sd->state = sd_sendingdata_state;
+            sd->data_offset = 0;
+            return sd_r1;
+        }
+        break;
+
     case 23:    /* CMD23: SET_BLOCK_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
@@ -1911,6 +1919,15 @@ void sd_write_data(SDState *sd, uint8_t value)
     }
 }
 
+#define SD_TUNING_BLOCK_SIZE    64
+
+static const uint32_t sd_tunning_data[SD_TUNING_BLOCK_SIZE / 4] = {
+    0xFF0FFF00, 0x0FFCC3CC, 0xC33CCCFF, 0xFEFFFEEF,
+    0xFFDFFFDD, 0xFFFBFFFB, 0XBFFF7FFF, 0X77F7BDEF,
+    0XFFF0FFF0, 0X0FFCCC3C, 0XCC33CCCF, 0XFFEFFFEE,
+    0XFFFDFFFD, 0XDFFFBFFF, 0XBBFFF7FF, 0XF77F7BDE,
+};
+
 uint8_t sd_read_data(SDState *sd)
 {
     /* TODO: Append CRCs */
@@ -1990,6 +2007,13 @@ uint8_t sd_read_data(SDState *sd)
         }
         break;
 
+    case 19:    /* CMD19:  SEND_TUNING_BLOCK (SD) */
+        if (sd->data_offset >= SD_TUNING_BLOCK_SIZE - 1) {
+            sd->state = sd_transfer_state;
+        }
+        ret = ((uint8_t *)(&sd_tunning_data))[sd->data_offset++];
+        break;
+
     case 22:	/* ACMD22: SEND_NUM_WR_BLOCKS */
         ret = sd->data[sd->data_offset ++];
 
-- 
2.15.1
