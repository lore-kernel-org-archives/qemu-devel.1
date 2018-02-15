Received: from eggs.gnu.org ([2001:4830:134:3::10]:58732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnM-0005mE-EM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnL-0005XY-H0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:24 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRnL-0005X5-AF
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:23 -0500
Received: by mail-qk0-x242.google.com with SMTP id o7so1603111qkc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:22 -0300
Message-Id: <20180215221325.7611-18-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 17/20] sdcard: add SD SEND_TUNING_BLOCK
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 911aae6233..4b0bb7992d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1166,6 +1166,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -1889,6 +1897,15 @@ void sd_write_data(SDState *sd, uint8_t value)
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
@@ -1968,6 +1985,13 @@ uint8_t sd_read_data(SDState *sd)
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
2.16.1
