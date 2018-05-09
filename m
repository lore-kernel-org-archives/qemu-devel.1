Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4q-0004h6-CD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4o-00038b-EA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4o-00038C-8D
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:38 -0400
Received: by mail-qt0-x242.google.com with SMTP id j42-v6so43940710qtj.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:54 -0300
Message-Id: <20180509034658.26455-11-f4bug@amsat.org>
In-Reply-To: <20180509034658.26455-1-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/14] sdcard: Remove the SDRequest argument
 from internal functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Replace the SDRequest argument using directly {uint8_t cmd, uint32_t arg},
it will be easier to remove the SDRequest struct in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 104 +++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 125707a65c..0dfcaf480c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -853,35 +853,34 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
 }
 
-static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
+static sd_rsp_type_t sd_normal_command(SDState *sd, uint8_t cmd, uint32_t arg)
 {
     uint32_t rca = 0x0000;
-    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
+    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) arg << 9 : arg;
 
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
-    if (req.cmd != 55 || sd->expecting_acmd) {
+    if (cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd->proto_name,
-                                    sd_cmd_name(req.cmd), req.cmd,
-                                    req.arg, sd_state_name(sd->state));
+                                    sd_cmd_name(cmd), cmd,
+                                    arg, sd_state_name(sd->state));
     }
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd] == sd_ac
-        || sd_cmd_type[req.cmd] == sd_adtc) {
-        rca = req.arg >> 16;
+    if (sd_cmd_type[cmd] == sd_ac || sd_cmd_type[cmd] == sd_adtc) {
+        rca = arg >> 16;
     }
 
     /* CMD23 (set block count) must be immediately followed by CMD18 or CMD25
      * if not, its effects are cancelled */
-    if (sd->multi_blk_cnt != 0 && !(req.cmd == 18 || req.cmd == 25)) {
+    if (sd->multi_blk_cnt != 0 && !(cmd == 18 || cmd == 25)) {
         sd->multi_blk_cnt = 0;
     }
 
-    switch (req.cmd) {
+    switch (cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
         switch (sd->state) {
@@ -950,7 +949,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             goto bad_cmd;
         switch (sd->mode) {
         case sd_data_transfer_mode:
-            sd_function_switch(sd, req.arg);
+            sd_function_switch(sd, arg);
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
@@ -1007,12 +1006,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->vhs = 0;
 
         /* No response if not exactly one VHS bit is set.  */
-        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
+        if (!(arg >> 8) || (arg >> (ctz32(arg & ~0xff) + 1))) {
             return sd->spi ? sd_r7 : sd_r0;
         }
 
         /* Accept.  */
-        sd->vhs = req.arg;
+        sd->vhs = arg;
         return sd_r7;
 
     case 9:	/* CMD9:   SEND_CSD */
@@ -1109,11 +1108,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 16:	/* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
         case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT)) {
+            if (arg > (1 << HWBLOCK_SHIFT)) {
                 sd->card_status |= BLOCK_LEN_ERROR;
             } else {
-                trace_sdcard_set_blocklen(req.arg);
-                sd->blk_len = req.arg;
+                trace_sdcard_set_blocklen(arg);
+                sd->blk_len = arg;
             }
 
             return sd_r1;
@@ -1166,7 +1165,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 23:    /* CMD23: SET_BLOCK_COUNT */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->multi_blk_cnt = req.arg;
+            sd->multi_blk_cnt = arg;
             return sd_r1;
 
         default:
@@ -1303,7 +1302,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
             sd->state = sd_sendingdata_state;
-            *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
+            *(uint32_t *) sd->data = sd_wpbits(sd, arg);
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1b;
@@ -1317,7 +1316,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 32:	/* CMD32:  ERASE_WR_BLK_START */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->erase_start = req.arg;
+            sd->erase_start = arg;
             return sd_r1;
 
         default:
@@ -1328,7 +1327,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 33:	/* CMD33:  ERASE_WR_BLK_END */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->erase_end = req.arg;
+            sd->erase_end = arg;
             return sd_r1;
 
         default:
@@ -1391,7 +1390,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         case sd_idle_state:
             if (rca) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
+                              "SD: illegal RCA 0x%04x for APP_CMD\n", cmd);
             }
         default:
             break;
@@ -1409,10 +1408,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
-            if (req.arg & 1)
+            if (arg & 1) {
                 sd->state = sd_sendingdata_state;
-            else
+            } else {
                 sd->state = sd_receivingdata_state;
+            }
             return sd_r1;
 
         default:
@@ -1434,27 +1434,26 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     default:
     bad_cmd:
-        qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", cmd);
         return sd_illegal;
 
     unimplemented_spi_cmd:
         /* Commands that are recognised but not yet implemented in SPI mode.  */
         qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
-                      req.cmd);
+                      cmd);
         return sd_illegal;
     }
 
-    qemu_log_mask(LOG_GUEST_ERROR, "SD: CMD%i in a wrong state\n", req.cmd);
+    qemu_log_mask(LOG_GUEST_ERROR, "SD: CMD%i in a wrong state\n", cmd);
     return sd_illegal;
 }
 
-static sd_rsp_type_t sd_app_command(SDState *sd,
-                                    SDRequest req)
+static sd_rsp_type_t sd_app_command(SDState *sd, uint8_t cmd, uint32_t arg)
 {
-    trace_sdcard_app_command(sd->proto_name, sd_acmd_name(req.cmd),
-                             req.cmd, req.arg, sd_state_name(sd->state));
+    trace_sdcard_app_command(sd->proto_name, sd_acmd_name(cmd),
+                             cmd, arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
-    switch (req.cmd) {
+    switch (cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
         if (sd->spi) {
             goto unimplemented_spi_cmd;
@@ -1462,7 +1461,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         switch (sd->state) {
         case sd_transfer_state:
             sd->sd_status[0] &= 0x3f;
-            sd->sd_status[0] |= (req.arg & 0x03) << 6;
+            sd->sd_status[0] |= (arg & 0x03) << 6;
             return sd_r1;
 
         default:
@@ -1526,7 +1525,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
          * assumes that the card is in ready state as soon as it
          * sees the power up bit set. */
         if (!FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP)) {
-            if ((req.arg & ACMD41_ENQUIRY_MASK) != 0) {
+            if ((arg & ACMD41_ENQUIRY_MASK) != 0) {
                 timer_del(sd->ocr_power_timer);
                 sd_ocr_powerup(sd);
             } else {
@@ -1539,7 +1538,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
             }
         }
 
-        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
+        if (FIELD_EX32(sd->ocr & arg, OCR, VDD_VOLTAGE_WINDOW)) {
             /* We accept any voltage.  10000 V is nothing.
              *
              * Once we're powered up, we advance straight to ready state
@@ -1583,25 +1582,25 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
          * information about the SD Security Features.
          */
         qemu_log_mask(LOG_UNIMP, "SD: CMD%i Security not implemented\n",
-                      req.cmd);
+                      cmd);
         return sd_illegal;
 
     default:
         /* Fall back to standard commands.  */
-        return sd_normal_command(sd, req);
+        return sd_normal_command(sd, cmd, arg);
 
     unimplemented_spi_cmd:
         /* Commands that are recognised but not yet implemented in SPI mode.  */
         qemu_log_mask(LOG_UNIMP, "SD: CMD%i not implemented in SPI mode\n",
-                      req.cmd);
+                      cmd);
         return sd_illegal;
     }
 
-    qemu_log_mask(LOG_GUEST_ERROR, "SD: ACMD%i in a wrong state\n", req.cmd);
+    qemu_log_mask(LOG_GUEST_ERROR, "SD: ACMD%i in a wrong state\n", cmd);
     return sd_illegal;
 }
 
-static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
+static int cmd_valid_while_locked(SDState *sd, uint8_t cmd)
 {
     /* Valid commands in locked state:
      * basic class (0)
@@ -1612,13 +1611,12 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
      * Anything else provokes an "illegal command" response.
      */
     if (sd->expecting_acmd) {
-        return req->cmd == 41 || req->cmd == 42;
+        return cmd == 41 || cmd == 42;
     }
-    if (req->cmd == 16 || req->cmd == 55) {
+    if (cmd == 16 || cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd] == 0
-            || sd_cmd_class[req->cmd] == 7;
+    return sd_cmd_class[cmd] == 0 || sd_cmd_class[cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1626,25 +1624,29 @@ int sd_do_command(SDState *sd, SDRequest *req,
     int last_state;
     sd_rsp_type_t rtype;
     int rsplen;
+    uint8_t cmd;
+    uint32_t arg;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable) {
         return 0;
     }
 
+    cmd = req->cmd;
+    arg = req->arg;
+
     if (!sd_req_crc_is_valid(req)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
         goto send_response;
     }
 
-    if (req->cmd >= SDMMC_CMD_MAX) {
-        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n",
-                      req->cmd);
-        req->cmd &= 0x3f;
+    if (cmd >= SDMMC_CMD_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n", cmd);
+        cmd &= 0x3f;
     }
 
     if (sd->card_status & CARD_IS_LOCKED) {
-        if (!cmd_valid_while_locked(sd, req)) {
+        if (!cmd_valid_while_locked(sd, cmd)) {
             sd->card_status |= ILLEGAL_COMMAND;
             sd->expecting_acmd = false;
             qemu_log_mask(LOG_GUEST_ERROR, "SD: Card is locked\n");
@@ -1658,9 +1660,9 @@ int sd_do_command(SDState *sd, SDRequest *req,
 
     if (sd->expecting_acmd) {
         sd->expecting_acmd = false;
-        rtype = sd_app_command(sd, *req);
+        rtype = sd_app_command(sd, cmd, arg);
     } else {
-        rtype = sd_normal_command(sd, *req);
+        rtype = sd_normal_command(sd, cmd, arg);
     }
 
     if (rtype == sd_illegal) {
@@ -1669,7 +1671,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
+        sd->current_cmd = cmd;
         sd->card_status &= ~CURRENT_STATE;
         sd->card_status |= (last_state << 9);
     }
-- 
2.17.0
