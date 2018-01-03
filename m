Received: from eggs.gnu.org ([2001:4830:134:3::10]:52919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYJ-0003JM-Ot
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYI-0000Pl-Kd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:23 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYI-0000PO-F6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:22 -0500
Received: by mail-qk0-x242.google.com with SMTP id v188so3247829qkh.11
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:33 -0300
Message-Id: <20180103212436.15762-23-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 22/25] sdcard: remove unreachable SPI
 commands
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

we already checked in sd_do_command() with cmd_version_supported() if
the command is protocol supported (returning ILLEGAL if not).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0e4871869f..16199cd886 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1071,8 +1071,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_r1;
 
     case 2:	/* CMD2:   ALL_SEND_CID */
-        if (sd->spi)
-            goto bad_cmd;
         if (sd->state == sd_ready_state) {
             sd->state = sd_identification_state;
             return sd_r2_i;
@@ -1080,8 +1078,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 3:	/* CMD3:   SEND_RELATIVE_ADDR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_identification_state:
         case sd_standby_state:
@@ -1095,8 +1091,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 4:	/* CMD4:   SEND_DSR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             break;
@@ -1110,8 +1104,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
 
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-        if (sd->spi)
-            goto bad_cmd;
         if (sd->mode == sd_data_transfer_mode) {
             sd_function_switch(sd, req.arg);
             sd->state = sd_sendingdata_state;
@@ -1122,8 +1114,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 7:	/* CMD7:   SELECT/DESELECT_CARD */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1224,8 +1214,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
-        if (sd->spi)
-            goto bad_cmd;
         if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_start = req.arg;
@@ -1264,8 +1252,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 15:	/* CMD15:  GO_INACTIVE_STATE */
-        if (sd->spi)
-            goto bad_cmd;
         if (sd->mode == sd_data_transfer_mode) {
             if (sd->rca != rca)
                 return sd_r0;
@@ -1358,8 +1344,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:	/* CMD26:  PROGRAM_CID */
-        if (sd->spi)
-            goto bad_cmd;
         if (sd->state == sd_transfer_state) {
             sd->state = sd_receivingdata_state;
             sd->data_start = 0;
@@ -1528,9 +1512,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd, SDRequest req)
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
-        if (sd->spi) {
-            goto unimplemented_cmd;
-        }
         if (sd->state == sd_transfer_state) {
             sd->sd_status[0] &= 0x3f;
             sd->sd_status[0] |= (req.arg & 0x03) << 6;
-- 
2.15.1
