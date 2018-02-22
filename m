Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosij-0004wE-30
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosih-0001mz-Oh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosih-0001ls-Hb
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosig-00025D-K1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:56 +0000
Message-Id: <20180222152307.7499-22-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/32] sdcard: remove commands from unsupported
 old MMC specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This device does not model MMCA Specification previous to v4.2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c87142d648..e55bf1fa75 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1037,24 +1037,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
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
@@ -1862,21 +1844,6 @@ uint8_t sd_read_data(SDState *sd)
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
