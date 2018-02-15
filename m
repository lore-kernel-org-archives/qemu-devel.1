Received: from eggs.gnu.org ([2001:4830:134:3::10]:58391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmm-0004rp-UI
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRml-000581-3R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:48 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmk-00057l-VN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:13:47 -0500
Received: by mail-qk0-x242.google.com with SMTP id c128so1585957qkb.4
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:13:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:10 -0300
Message-Id: <20180215221325.7611-6-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 05/20] sdcard: remove commands from
 unsupported old MMC specification
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

This device does not model MMCA Specification previous to v4.2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sd.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 41fac9a4aa..4267919ce0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1041,24 +1041,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
-        if (sd->spi)
-            goto bad_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = req.arg;
-            sd->data_offset = 0;
-
-            if (sd->data_start + sd->blk_len > sd->size)
-                sd->card_status |= ADDRESS_ERROR;
-            return sd_r0;
-
-        default:
-            break;
-        }
-        break;
-
     case 12:	/* CMD12:  STOP_TRANSMISSION */
         switch (sd->state) {
         case sd_sendingdata_state:
@@ -1871,21 +1853,6 @@ uint8_t sd_read_data(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
-        if (sd->data_offset == 0)
-            BLK_READ_BLOCK(sd->data_start, io_len);
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
-            sd->data_offset = 0;
-            if (sd->data_start + io_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-                break;
-            }
-        }
-        break;
-
     case 13:	/* ACMD13: SD_STATUS */
         ret = sd->sd_status[sd->data_offset ++];
 
-- 
2.16.1
