Received: from eggs.gnu.org ([2001:4830:134:3::10]:33202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNF-0006lU-Rl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNE-0000e2-Hf
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:37 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGNE-0000dl-By
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:23:36 -0500
Received: by mail-qk0-x243.google.com with SMTP id z203so4157934qkb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:23:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:25 -0300
Message-Id: <20171213232025.24503-27-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/26] sdcard: add/use a ccc_spi enum for the
 commands supported in SPI mode
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

We can now simplify the 'if (sd->spi) ...' checks, reporting an UNIMP error
and returning a sd_illegal value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 83 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 688bb40bd1..a32da6af9f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -285,34 +285,45 @@ enum SDCardCommandClass {
     ccc_io          = 1 << 9,
     ccc_switch      = 1 << 10,
     ccc_ext         = 1 << 11,
+
+    /* extra */
+    ccc_spi         = 1 << 31,
 };
 
 static const uint32_t sd_cmd_class[SD_CMD_MAX] = {
-    ccc_basic, 0, ccc_basic, ccc_basic,
-    ccc_basic, ccc_io, ccc_switch, ccc_basic,
-    ccc_basic, ccc_basic, ccc_basic, ccc_basic,
-    ccc_basic, ccc_basic, 0, ccc_basic,
+    ccc_basic | ccc_spi, ccc_spi, ccc_basic, ccc_basic,
+    ccc_basic, ccc_io, ccc_switch | ccc_spi, ccc_basic,
+    ccc_basic, ccc_basic | ccc_spi, ccc_basic | ccc_spi, ccc_basic,
+    ccc_basic | ccc_spi, ccc_basic | ccc_spi, 0, ccc_basic,
     /* 16 */
-    ccc_blk_read | ccc_blk_write | ccc_lock, ccc_blk_read,
-    ccc_blk_read, ccc_blk_read,
+    ccc_blk_read | ccc_blk_write | ccc_lock | ccc_spi, ccc_blk_read | ccc_spi,
+    ccc_blk_read | ccc_spi, ccc_blk_read,
     ccc_blk_read | ccc_blk_write, ccc_ext, 0,
     ccc_blk_read | ccc_blk_write,
-    ccc_blk_write, ccc_blk_write,
-    0, ccc_blk_write,
-    ccc_wp, ccc_wp,
-    ccc_wp, 0,
+    ccc_blk_write | ccc_spi, ccc_blk_write | ccc_spi,
+    0, ccc_blk_write | ccc_spi,
+    ccc_wp | ccc_spi, ccc_wp | ccc_spi,
+    ccc_wp | ccc_spi, 0,
     /* 32 */
-    ccc_erase, ccc_erase,
-    ccc_switch, ccc_switch,
-    ccc_switch, ccc_switch,
-    ccc_erase, 0,
-    ccc_lock, 0, ccc_lock, 0, 0, 0, 0, 0,
+    ccc_erase | ccc_spi, ccc_erase | ccc_spi,
+    ccc_switch | ccc_spi, ccc_switch | ccc_spi,
+    ccc_switch | ccc_spi, ccc_switch | ccc_spi,
+    ccc_erase | ccc_spi, 0,
+    ccc_lock, 0, ccc_lock | ccc_spi, 0, 0, 0, 0, 0,
     /* 48 */
-    ccc_ext, ccc_ext, ccc_switch, 0,
-    ccc_io, ccc_io, 0, ccc_appspec,
-    ccc_appspec, ccc_switch,
-    ccc_ext, ccc_ext,
+    ccc_ext, ccc_ext, ccc_switch | ccc_spi, 0,
+    ccc_io | ccc_spi, ccc_io | ccc_spi, 0, ccc_appspec | ccc_spi,
+    ccc_appspec | ccc_spi, ccc_switch | ccc_spi,
+    ccc_ext | ccc_spi, ccc_ext | ccc_spi,
     0, 0, 0, 0
+}, sd_acmd_class[SD_CMD_MAX] = {
+    [6] = ccc_appspec, [13] = ccc_appspec | ccc_spi,
+    [14] = ccc_appspec, [15] = ccc_appspec,
+    [16] = ccc_appspec, [18] = ccc_spi,
+    [22] = ccc_appspec | ccc_spi, [23] = ccc_appspec | ccc_spi,
+    [25] = ccc_spi, [26] = ccc_spi, [28] = ccc_appspec, [38] = ccc_spi,
+    [41] = ccc_appspec | ccc_spi, [42] = ccc_appspec | ccc_spi, [43] = ccc_spi,
+    [49] = ccc_spi, [51] = ccc_appspec | ccc_spi,
 };
 
 static uint8_t sd_crc7(void *message, size_t width)
@@ -899,6 +910,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         sd->multi_blk_cnt = 0;
     }
 
+    if (sd->spi && !(sd_cmd_class[req.cmd] & ccc_spi)) {
+        qemu_log_mask(LOG_UNIMP, "SD: CMD%02u not implemented in SPI mode\n",
+                      req.cmd);
+        return sd_illegal;
+    }
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
@@ -921,8 +937,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
 
     case 2:	/* CMD2:   ALL_SEND_CID */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_ready_state:
             sd_set_state(sd, sd_identification_state);
@@ -934,8 +948,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 3:	/* CMD3:   SEND_RELATIVE_ADDR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_identification_state:
         case sd_standby_state:
@@ -949,8 +961,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 4:	/* CMD4:   SEND_DSR */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             break;
@@ -964,8 +974,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_illegal;
 
     case 6:	/* CMD6:   SWITCH_FUNCTION */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->mode) {
         case sd_data_transfer_mode:
             sd_function_switch(sd, req.arg);
@@ -980,8 +988,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 7:	/* CMD7:   SELECT/DESELECT_CARD */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_standby_state:
             if (sd->rca != rca)
@@ -1082,8 +1088,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 11:	/* CMD11:  READ_DAT_UNTIL_STOP */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             sd_set_state(sd, sd_sendingdata_state);
@@ -1130,8 +1134,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 15:	/* CMD15:  GO_INACTIVE_STATE */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->mode) {
         case sd_data_transfer_mode:
             if (sd->rca != rca)
@@ -1206,8 +1208,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
     /* Block write commands (Class 4) */
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1232,8 +1232,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 25:	/* CMD25:  WRITE_MULTIPLE_BLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             /* Writing in SPI mode not implemented.  */
@@ -1258,8 +1256,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         break;
 
     case 26:	/* CMD26:  PROGRAM_CID */
-        if (sd->spi)
-            goto bad_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             sd_set_state(sd, sd_receivingdata_state);
@@ -1274,7 +1270,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
     case 27:	/* CMD27:  PROGRAM_CSD */
         if (sd->spi)
-            goto unimplemented_cmd;
+            goto unimplemented_cmd; /* XXX */
         switch (sd->state) {
         case sd_transfer_state:
             sd_set_state(sd, sd_receivingdata_state);
@@ -1384,8 +1380,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
     /* Lock card commands (Class 7) */
     case 42:	/* CMD42:  LOCK_UNLOCK */
-        if (sd->spi)
-            goto unimplemented_cmd;
         switch (sd->state) {
         case sd_transfer_state:
             sd_set_state(sd, sd_receivingdata_state);
@@ -1456,6 +1450,11 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                              req.arg, sd_state_name(sd->state));
 
     sd->card_status |= APP_CMD;
+    if (sd->spi && !(sd_acmd_class[req.cmd] & ccc_spi)) {
+        qemu_log_mask(LOG_UNIMP, "SD: ACMD%02u not implemented in SPI mode\n",
+                      req.cmd);
+        return sd_illegal;
+    }
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
         switch (sd->state) {
-- 
2.15.1
