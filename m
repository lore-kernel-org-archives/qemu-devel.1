Received: from eggs.gnu.org ([2001:4830:134:3::10]:38367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosia-0004lv-Ht
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiZ-0001ef-9s
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:32 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiZ-0001dy-03
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:31 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiY-00022U-0q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:45 +0000
Message-Id: <20180222152307.7499-11-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/32] sdcard: replace DPRINTF() by trace events
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215220540.6556-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c         | 32 ++++++++++++++++++++++++++------
 hw/sd/trace-events |  6 ++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ce1f2fdf76..72e9b47e34 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 //#define DEBUG_SD 1
 
@@ -132,6 +133,26 @@ struct SDState {
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
+    assert(state <= ARRAY_SIZE(state_name));
+    return state_name[state];
+}
+
 static uint8_t sd_get_dat_lines(SDState *sd)
 {
     return sd->enable ? sd->dat_lines : 0;
@@ -776,6 +797,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
+    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
@@ -790,7 +813,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         sd->multi_blk_cnt = 0;
     }
 
-    DPRINTF("CMD%d 0x%08x state %d\n", req.cmd, req.arg, sd->state);
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
@@ -1310,8 +1332,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
         return sd_r1;
 
     case 56:	/* CMD56:  GEN_CMD */
-        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
-
         switch (sd->state) {
         case sd_transfer_state:
             sd->data_offset = 0;
@@ -1345,7 +1365,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    DPRINTF("ACMD%d 0x%08x\n", req.cmd, req.arg);
+    trace_sdcard_app_command(req.cmd, req.arg);
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1606,8 +1626,7 @@ send_response:
 
 static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 {
-    DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
-            (unsigned long long) addr, len);
+    trace_sdcard_read_block(addr, len);
     if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
         fprintf(stderr, "sd_blk_read: read error on host side\n");
     }
@@ -1615,6 +1634,7 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
 
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
2.16.1
