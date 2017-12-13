Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM3-0005Yd-Oi
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM1-0007oh-Mr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:23 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGM1-0007o6-IA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:21 -0500
Received: by mail-qk0-x243.google.com with SMTP id 8so4146278qkj.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:07 -0300
Message-Id: <20171213232025.24503-9-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/26] sdcard: add sd_set_state()
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

This will ease to trace state changes (in the following patchs).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 128 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 67 insertions(+), 61 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 465d254f2e..f67c9ff49c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -171,6 +171,11 @@ static void sd_update_mode(SDState *sd)
     }
 }
 
+static void sd_set_state(SDState *sd, enum SDCardStates state)
+{
+    sd->state = state;
+}
+
 static const sd_cmd_type_t sd_cmd_type[64] = {
     sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
     sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
@@ -429,7 +434,7 @@ static void sd_reset(DeviceState *dev)
 
     sect = sd_addr_to_wpnum(size) + 1;
 
-    sd->state = sd_idle_state;
+    sd_set_state(sd, sd_idle_state);
     sd->rca = 0x0000;
     sd_set_ocr(sd);
     sd_set_scr(sd);
@@ -767,7 +772,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             return sd->spi ? sd_r1 : sd_r0;
 
         default:
-            sd->state = sd_idle_state;
+            sd_set_state(sd, sd_idle_state);
             sd_reset(DEVICE(sd));
             return sd->spi ? sd_r1 : sd_r0;
         }
@@ -777,7 +782,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         if (!sd->spi)
             goto bad_cmd;
 
-        sd->state = sd_transfer_state;
+        sd_set_state(sd, sd_transfer_state);
         return sd_r1;
 
     case 2:	/* CMD2:   ALL_SEND_CID */
@@ -785,7 +790,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             goto bad_cmd;
         switch (sd->state) {
         case sd_ready_state:
-            sd->state = sd_identification_state;
+            sd_set_state(sd, sd_identification_state);
             return sd_r2_i;
 
         default:
@@ -799,7 +804,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         switch (sd->state) {
         case sd_identification_state:
         case sd_standby_state:
-            sd->state = sd_standby_state;
+            sd_set_state(sd, sd_standby_state);
             sd_set_rca(sd);
             return sd_r6;
 
@@ -829,7 +834,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         switch (sd->mode) {
         case sd_data_transfer_mode:
             sd_function_switch(sd, req.arg);
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -847,7 +852,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             if (sd->rca != rca)
                 return sd_r0;
 
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         case sd_transfer_state:
@@ -855,21 +860,21 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             if (sd->rca == rca)
                 break;
 
-            sd->state = sd_standby_state;
+            sd_set_state(sd, sd_standby_state);
             return sd_r1b;
 
         case sd_disconnect_state:
             if (sd->rca != rca)
                 return sd_r0;
 
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             return sd_r1b;
 
         case sd_programming_state:
             if (sd->rca == rca)
                 break;
 
-            sd->state = sd_disconnect_state;
+            sd_set_state(sd, sd_disconnect_state);
             return sd_r1b;
 
         default:
@@ -908,7 +913,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         case sd_transfer_state:
             if (!sd->spi)
                 break;
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             memcpy(sd->data, sd->csd, 16);
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -930,7 +935,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         case sd_transfer_state:
             if (!sd->spi)
                 break;
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             memcpy(sd->data, sd->cid, 16);
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -946,7 +951,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             goto bad_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = req.arg;
             sd->data_offset = 0;
 
@@ -962,13 +967,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     case 12:	/* CMD12:  STOP_TRANSMISSION */
         switch (sd->state) {
         case sd_sendingdata_state:
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         case sd_receivingdata_state:
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         default:
@@ -997,7 +1002,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             if (sd->rca != rca)
                 return sd_r0;
 
-            sd->state = sd_inactive_state;
+            sd_set_state(sd, sd_inactive_state);
             return sd_r0;
 
         default:
@@ -1024,7 +1029,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = addr;
             sd->data_offset = 0;
 
@@ -1040,7 +1045,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = addr;
             sd->data_offset = 0;
 
@@ -1073,7 +1078,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
@@ -1099,7 +1104,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
@@ -1122,7 +1127,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             goto bad_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1137,7 +1142,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1156,10 +1161,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
                 return sd_r1b;
             }
 
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             set_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         default:
@@ -1175,10 +1180,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
                 return sd_r1b;
             }
 
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             clear_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         default:
@@ -1189,7 +1194,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     case 30:	/* CMD30:  SEND_WRITE_PROT */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1231,10 +1236,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
                 return sd_r1b;
             }
 
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             sd_erase(sd);
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1b;
 
         default:
@@ -1248,7 +1253,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
             goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1283,10 +1288,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
-            if (req.arg & 1)
-                sd->state = sd_sendingdata_state;
-            else
-                sd->state = sd_receivingdata_state;
+            if (req.arg & 1) {
+                sd_set_state(sd, sd_sendingdata_state);
+            } else {
+                sd_set_state(sd, sd_receivingdata_state);
+            }
             return sd_r1;
 
         default:
@@ -1331,7 +1337,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 13:	/* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1346,7 +1352,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         case sd_transfer_state:
             *(uint32_t *) sd->data = sd->blk_written;
 
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1369,7 +1375,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 41:	/* ACMD41: SD_APP_OP_COND */
         if (sd->spi) {
             /* SEND_OP_CMD */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
             return sd_r1;
         }
         switch (sd->state) {
@@ -1399,7 +1405,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
              * unless it's an enquiry ACMD41 (bits 23:0 == 0).
              */
             if (req.arg & ACMD41_ENQUIRY_MASK) {
-                sd->state = sd_ready_state;
+                sd_set_state(sd, sd_ready_state);
             }
 
             return sd_r3;
@@ -1423,7 +1429,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 51:	/* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
+            sd_set_state(sd, sd_sendingdata_state);
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
@@ -1615,12 +1621,12 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
             sd->blk_written ++;
             sd->csd[14] |= 0x40;
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         }
         break;
 
@@ -1639,7 +1645,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
             sd->blk_written++;
             sd->data_start += sd->blk_len;
@@ -1650,12 +1656,12 @@ void sd_write_data(SDState *sd, uint8_t value)
             if (sd->multi_blk_cnt != 0) {
                 if (--sd->multi_blk_cnt == 0) {
                     /* Stop! */
-                    sd->state = sd_transfer_state;
+                    sd_set_state(sd, sd_transfer_state);
                     break;
                 }
             }
 
-            sd->state = sd_receivingdata_state;
+            sd_set_state(sd, sd_receivingdata_state);
         }
         break;
 
@@ -1663,7 +1669,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sizeof(sd->cid)) {
             /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             for (i = 0; i < sizeof(sd->cid); i ++)
                 if ((sd->cid[i] | 0x00) != sd->data[i])
                     sd->card_status |= CID_CSD_OVERWRITE;
@@ -1674,7 +1680,7 @@ void sd_write_data(SDState *sd, uint8_t value)
                     sd->cid[i] &= sd->data[i];
                 }
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         }
         break;
 
@@ -1682,7 +1688,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sizeof(sd->csd)) {
             /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             for (i = 0; i < sizeof(sd->csd); i ++)
                 if ((sd->csd[i] | sd_csd_rw_mask[i]) !=
                     (sd->data[i] | sd_csd_rw_mask[i]))
@@ -1698,7 +1704,7 @@ void sd_write_data(SDState *sd, uint8_t value)
                     sd->csd[i] &= sd->data[i];
                 }
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         }
         break;
 
@@ -1706,10 +1712,10 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
+            sd_set_state(sd, sd_programming_state);
             sd_lock_command(sd);
             /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         }
         break;
 
@@ -1717,7 +1723,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         sd->data[sd->data_offset ++] = value;
         if (sd->data_offset >= sd->blk_len) {
             APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         }
         break;
 
@@ -1752,7 +1758,7 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 64)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 9:	/* CMD9:   SEND_CSD */
@@ -1760,7 +1766,7 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 16)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
@@ -1782,7 +1788,7 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->sd_status[sd->data_offset ++];
 
         if (sd->data_offset >= sizeof(sd->sd_status))
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
@@ -1791,7 +1797,7 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
@@ -1811,7 +1817,7 @@ uint8_t sd_read_data(SDState *sd)
             if (sd->multi_blk_cnt != 0) {
                 if (--sd->multi_blk_cnt == 0) {
                     /* Stop! */
-                    sd->state = sd_transfer_state;
+                    sd_set_state(sd, sd_transfer_state);
                     break;
                 }
             }
@@ -1822,21 +1828,21 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 30:	/* CMD30:  SEND_WRITE_PROT */
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 51:	/* ACMD51: SEND_SCR */
         ret = sd->scr[sd->data_offset ++];
 
         if (sd->data_offset >= sizeof(sd->scr))
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     case 56:	/* CMD56:  GEN_CMD */
@@ -1845,7 +1851,7 @@ uint8_t sd_read_data(SDState *sd)
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= sd->blk_len)
-            sd->state = sd_transfer_state;
+            sd_set_state(sd, sd_transfer_state);
         break;
 
     default:
-- 
2.15.1
