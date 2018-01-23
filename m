Received: from eggs.gnu.org ([2001:4830:134:3::10]:35411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9h-0003R0-OD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9g-0000Q2-GF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:49 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9g-0000PT-Al
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:48 -0500
Received: by mail-qt0-x243.google.com with SMTP id g14so17245067qti.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:21:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:25 -0300
Message-Id: <20180123032135.28863-3-f4bug@amsat.org>
In-Reply-To: <20180123032135.28863-1-f4bug@amsat.org>
References: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/12] sdcard: replace DPRINTF() by trace
 events
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 33 ++++++++++++++++++++++++++-------
 hw/sd/trace-events |  6 ++++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 55d2ba2dd7..f876973a2b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 //#define DEBUG_SD 1
 
@@ -132,6 +133,25 @@ struct SDState {
     bool cmd_line;
 };
 
+static const char *sd_state_name(enum SDCardStates state)
+{
+    static const char *state_name[] = {
+        [sd_idle_state]             = "idle",
+        [sd_ready_state]            = "ready",
+        [sd_identification_state]   = "identification",
+        [sd_standby_state]          = "standby",
+        [sd_transfer_state]         = "transfer",
+        [sd_sendingdata_state]      = "sendingdata",
+        [sd_receivingdata_state]    = "receivingdata",
+        [sd_programming_state]      = "programming",
+        [sd_disconnect_state]       = "disconnect",
+    };
+    if (state == sd_inactive_state) {
+        return "inactive";
+    }
+    return state_name[state];
+}
+
 static uint8_t sd_get_dat_lines(SDState *sd)
 {
     return sd->enable ? sd->dat_lines : 0;
@@ -776,6 +796,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
+    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
@@ -790,7 +812,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         sd->multi_blk_cnt = 0;
     }
 
-    DPRINTF("CMD%d 0x%08x state %d\n", req.cmd, req.arg, sd->state);
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
@@ -1310,8 +1331,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
 
     case 56:	/* CMD56:  GEN_CMD */
-        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
-
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
@@ -1345,7 +1364,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    DPRINTF("ACMD%d 0x%08x\n", req.cmd, req.arg);
+    trace_sdcard_app_command(req.cmd, req.arg);
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1594,7 +1613,7 @@ send_response:
         DPRINTF("Response:");
         for (i = 0; i < rsplen; i++)
             fprintf(stderr, " %02x", response[i]);
-        fprintf(stderr, " state %d\n", sd->state);
+        fputc('\n', stderr);
     } else {
         DPRINTF("No response %d\n", sd->state);
     }
@@ -1605,8 +1624,7 @@ send_response:
 
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
-    DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
-            (unsigned long long) addr, len);
+    trace_sdcard_read_block(addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1614,6 +1632,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 
 static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 {
+    trace_sdcard_write_block(addr, len);
     if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
         fprintf(stderr, "sd_blk_write: write error on host side\n");
     }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 0f8536db32..75dac5a2cd 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -23,6 +23,12 @@ sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read fr
 sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
 sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 
+# hw/sd/sd.c
+sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
+sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
+sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
+
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
