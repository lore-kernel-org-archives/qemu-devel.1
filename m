Received: from eggs.gnu.org ([2001:4830:134:3::10]:51981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXn-0002kT-To
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXX-00084b-7c
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:51 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqXX-00084J-11
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:25:35 -0500
Received: by mail-qk0-x241.google.com with SMTP id d202so3243758qkc.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:25:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:22 -0300
Message-Id: <20180103212436.15762-12-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/25] sdcard: replace switch(unique case)
 statements -> if(case)
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

this shortens the sd_normal_command/sd_app_command() big functions

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 177 +++++++++++--------------------------------------------------
 1 file changed, 30 insertions(+), 147 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c9fc6f5369..e0550cd174 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -880,34 +880,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
-        switch (sd->state) {
-        case sd_inactive_state:
-            return sd->spi ? sd_r1 : sd_r0;
-
-        default:
+        if (sd->state != sd_inactive_state) {
             sd->state = sd_idle_state;
             sd_reset(DEVICE(sd));
-            return sd->spi ? sd_r1 : sd_r0;
         }
-        break;
+        return sd->spi ? sd_r1 : sd_r0;
 
     case 1:	/* CMD1:   SEND_OP_CMD */
         if (!sd->spi)
             goto bad_cmd;
-
         sd->state = sd_transfer_state;
         return sd_r1;
 
     case 2:	/* CMD2:   ALL_SEND_CID */
         if (sd->spi)
             goto bad_cmd;
-        switch (sd->state) {
-        case sd_ready_state:
+        if (sd->state == sd_ready_state) {
             sd->state = sd_identification_state;
             return sd_r2_i;
-
-        default:
-            break;
         }
         break;
 
@@ -944,16 +934,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         if (sd->spi)
             goto bad_cmd;
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
+        if (sd->mode == sd_data_transfer_mode) {
             sd_function_switch(sd, req.arg);
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
@@ -1062,8 +1048,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
         if (sd->spi)
             goto bad_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = req.arg;
             sd->data_offset = 0;
@@ -1071,9 +1056,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (sd->data_start + sd->blk_len > sd->size)
                 sd->card_status |= ADDRESS_ERROR;
             return sd_r0;
-
-        default:
-            break;
         }
         break;
 
@@ -1095,53 +1077,40 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 13:	/* CMD13:  SEND_STATUS */
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
+        if (sd->mode == sd_data_transfer_mode) {
             if (sd->rca != rca)
                 return sd_r0;
 
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 15:	/* CMD15:  GO_INACTIVE_STATE */
         if (sd->spi)
             goto bad_cmd;
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
+        if (sd->mode == sd_data_transfer_mode) {
             if (sd->rca != rca)
                 return sd_r0;
 
             sd->state = sd_inactive_state;
             return sd_r0;
-
-        default:
-            break;
         }
         break;
 
     /* Block read commands (Classs 2) */
     case 16:	/* CMD16:  SET_BLOCKLEN */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             if (req.arg > (1 << HWBLOCK_SHIFT))
                 sd->card_status |= BLOCK_LEN_ERROR;
             else
                 sd->blk_len = req.arg;
 
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1149,15 +1118,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (sd->data_start + sd->blk_len > sd->size)
                 sd->card_status |= ADDRESS_ERROR;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1165,20 +1130,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (sd->data_start + sd->blk_len > sd->size)
                 sd->card_status |= ADDRESS_ERROR;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 23:    /* CMD23: SET_BLOCK_COUNT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->multi_blk_cnt = req.arg;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
@@ -1186,8 +1144,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         if (sd->spi)
             goto unimplemented_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1200,17 +1157,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (sd->csd[14] & 0x30)
                 sd->card_status |= WP_VIOLATION;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 25:	/* CMD25:  WRITE_MULTIPLE_BLOCK */
         if (sd->spi)
             goto unimplemented_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
@@ -1223,46 +1176,34 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (sd->csd[14] & 0x30)
                 sd->card_status |= WP_VIOLATION;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 26:	/* CMD26:  PROGRAM_CID */
         if (sd->spi)
             goto bad_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 27:	/* CMD27:  PROGRAM_CSD */
         if (sd->spi)
             goto unimplemented_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     /* Write protection (Class 6) */
     case 28:	/* CMD28:  SET_WRITE_PROT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             if (addr >= sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
                 return sd_r1b;
@@ -1273,15 +1214,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
-
-        default:
-            break;
         }
         break;
 
     case 29:	/* CMD29:  CLR_WRITE_PROT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             if (addr >= sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
                 return sd_r1b;
@@ -1292,52 +1229,36 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
-
-        default:
-            break;
         }
         break;
 
     case 30:	/* CMD30:  SEND_WRITE_PROT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1b;
-
-        default:
-            break;
         }
         break;
 
     /* Erase commands (Class 5) */
     case 32:	/* CMD32:  ERASE_WR_BLK_START */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->erase_start = req.arg;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 33:	/* CMD33:  ERASE_WR_BLK_END */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->erase_end = req.arg;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 38:	/* CMD38:  ERASE */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
                 return sd_r1b;
@@ -1348,9 +1269,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
-
-        default:
-            break;
         }
         break;
 
@@ -1358,15 +1276,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 42:	/* CMD42:  LOCK_UNLOCK */
         if (sd->spi)
             goto unimplemented_cmd;
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
@@ -1390,17 +1304,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_r1;
 
     case 56:	/* CMD56:  GEN_CMD */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->data_offset = 0;
             if (req.arg & 1)
                 sd->state = sd_sendingdata_state;
             else
                 sd->state = sd_receivingdata_state;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
@@ -1428,52 +1338,37 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->sd_status[0] &= 0x3f;
             sd->sd_status[0] |= (req.arg & 0x03) << 6;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 13:	/* ACMD13: SD_STATUS */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
 
-        default:
-            break;
         }
         break;
 
     case 22:	/* ACMD22: SEND_NUM_WR_BLOCKS */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             *(uint32_t *) sd->data = sd->blk_written;
 
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 23:	/* ACMD23: SET_WR_BLK_ERASE_COUNT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
@@ -1483,8 +1378,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             sd->state = sd_transfer_state;
             return sd_r1;
         }
-        switch (sd->state) {
-        case sd_idle_state:
+        if (sd->state == sd_idle_state) {
             /* If it's the first ACMD41 since reset, we need to decide
              * whether to power up. If this is not an enquiry ACMD41,
              * we immediately report power on and proceed below to the
@@ -1514,33 +1408,22 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             }
 
             return sd_r3;
-
-        default:
-            break;
         }
         break;
 
     case 42:	/* ACMD42: SET_CLR_CARD_DETECT */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             /* Bringing in the 50KOhm pull-up resistor... Done.  */
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
     case 51:	/* ACMD51: SEND_SCR */
-        switch (sd->state) {
-        case sd_transfer_state:
+        if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
             return sd_r1;
-
-        default:
-            break;
         }
         break;
 
-- 
2.15.1
