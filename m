Received: from eggs.gnu.org ([2001:4830:134:3::10]:60800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMJ-0005qu-Lk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMI-00085h-MM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:39 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePGMI-00085M-H9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:38 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so5824702qtr.13
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 15:22:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 20:20:11 -0300
Message-Id: <20171213232025.24503-13-f4bug@amsat.org>
In-Reply-To: <20171213232025.24503-1-f4bug@amsat.org>
References: <20171213232025.24503-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/26] sdcard: replace DPRINTF() by trace events
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 11 +++++------
 hw/sd/trace-events |  4 ++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2fa05f42b7..bd583be835 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -773,6 +773,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
+    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
@@ -787,7 +789,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         sd->multi_blk_cnt = 0;
     }
 
-    DPRINTF("CMD%d 0x%08x state %d\n", req.cmd, req.arg, sd->state);
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
@@ -1307,8 +1308,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
 
     case 56:	/* CMD56:  GEN_CMD */
-        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
-
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
@@ -1343,7 +1342,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    DPRINTF("ACMD%d 0x%08x\n", req.cmd, req.arg);
+    trace_sdcard_app_command(req.cmd, req.arg);
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1603,8 +1602,7 @@ send_response:
 
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
-    DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
-            (unsigned long long) addr, len);
+    trace_sdcard_read_block(addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "sd_blk_read: read error on host side\n");
@@ -1613,6 +1611,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
+    trace_sdcard_write_block(addr, len);
     if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "sd_blk_write: write error on host side\n");
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index db5a5e62f2..117da83014 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -24,6 +24,10 @@ sdhci_led(bool state) "LED: %u"
 # hw/sd/sd.c
 sdcard_set_mode(const char *current_mode, const char *new_mode, const char *state) "%s -> %s (state: %s)"
 sdcard_set_state(const char *current_state, const char *new_state, const char *mode) "%s -> %s (mode: %s)"
+sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
+sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%08lx size 0x%x"
+sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%08lx size 0x%x"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
