Received: from eggs.gnu.org ([2001:4830:134:3::10]:37707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIX-0003HB-Lz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIW-0007pT-SW
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:57 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edpIW-0007p1-Ni
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:30:56 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so26482629qtj.6
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:30:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:30:21 -0300
Message-Id: <20180123033034.29493-6-f4bug@amsat.org>
In-Reply-To: <20180123033034.29493-1-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/18] sdcard: remove commands from
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

This device does not model MMCA Specification previous to v4.2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5d50d48097..3c66521862 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1044,24 +1044,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -1874,21 +1856,6 @@ uint8_t sd_read_data(SDState *sd)
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
2.15.1
