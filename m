Received: from eggs.gnu.org ([2001:4830:134:3::10]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfZ-0006OU-OR
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfY-0001Cr-Hm
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:21 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRfY-0001Cj-Ad
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:06:20 -0500
Received: by mail-qk0-x242.google.com with SMTP id s198so1553342qke.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:06:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:37 -0300
Message-Id: <20180215220540.6556-9-f4bug@amsat.org>
In-Reply-To: <20180215220540.6556-1-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 08/11] sdcard: display command name when
 tracing CMD/ACMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdmmc-internal.h |  3 +++
 hw/sd/sd.c             | 13 +++++----
 hw/sd/sdmmc-common.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs    |  2 +-
 hw/sd/trace-events     |  8 +++---
 5 files changed, 88 insertions(+), 10 deletions(-)
 create mode 100644 hw/sd/sdmmc-common.c

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 0e96cb0081..02b730089b 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -12,4 +12,7 @@
 
 #define SDMMC_CMD_MAX 64
 
+const char *sd_cmd_name(uint8_t cmd);
+const char *sd_acmd_name(uint8_t cmd);
+
 #endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6acd6b3c5c..666ff3873f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -828,8 +828,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(req.cmd, req.arg,
-                                    sd_state_name(sd->state));
+        trace_sdcard_normal_command(sd_cmd_name(req.cmd), req.cmd,
+                                    req.arg, sd_state_name(sd->state));
     }
 
     /* Not interpreting this as an app command */
@@ -1400,7 +1400,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(req.cmd, req.arg);
+    trace_sdcard_app_command(sd_acmd_name(req.cmd),
+                             req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1698,7 +1699,8 @@ void sd_write_data(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd->current_cmd, value);
+    trace_sdcard_write_data(sd_acmd_name(sd->current_cmd),
+                            sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1836,7 +1838,8 @@ uint8_t sd_read_data(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd->current_cmd, io_len);
+    trace_sdcard_read_data(sd_acmd_name(sd->current_cmd),
+                           sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/sdmmc-common.c b/hw/sd/sdmmc-common.c
new file mode 100644
index 0000000000..1d0198b1ad
--- /dev/null
+++ b/hw/sd/sdmmc-common.c
@@ -0,0 +1,72 @@
+/*
+ * SD/MMC cards common helpers
+ *
+ * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "sdmmc-internal.h"
+
+const char *sd_cmd_name(uint8_t cmd)
+{
+    static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
+         [0]    = "GO_IDLE_STATE",
+         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
+         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
+         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
+         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
+        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
+        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
+                                            [15]    = "GO_INACTIVE_STATE",
+        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
+        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
+        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
+                                            [23]    = "SET_BLOCK_COUNT",
+        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
+        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
+        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
+        [30]    = "SEND_WRITE_PROT",
+        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
+        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
+        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
+        [38]    = "ERASE",
+        [40]    = "DPS_spec",
+        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
+        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
+        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
+        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
+        [50]    = "SW_FUNC_RSVD", /* FIXME */
+        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
+        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
+        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
+        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
+        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
+        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
+    };
+    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
+}
+
+const char *sd_acmd_name(uint8_t cmd)
+{
+    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
+         [6] = "SET_BUS_WIDTH",
+        [13] = "SD_STATUS",
+        [14] = "DPS_spec",                  [15] = "DPS_spec",
+        [16] = "DPS_spec",
+        [18] = "SECU_spec",
+        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
+        [41] = "SD_SEND_OP_COND",
+        [42] = "SET_CLR_CARD_DETECT",
+        [51] = "SEND_SCR",
+        [52] = "SECU_spec",                 [53] = "SECU_spec",
+        [54] = "SECU_spec",
+        [56] = "SECU_spec",                 [57] = "SECU_spec",
+        [58] = "SECU_spec",                 [59] = "SECU_spec",
+    };
+
+    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
+}
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index c2b7664264..af4a248728 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_PL181) += pl181.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o
+common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-common.o
 common-obj-$(CONFIG_SDHCI) += sdhci.o
 
 obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 3040d32560..cdddca3dbf 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -24,8 +24,8 @@ sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of
 sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
 
 # hw/sd/sd.c
-sdcard_normal_command(uint8_t cmd, uint32_t arg, const char *state) "CMD%d arg 0x%08x (state %s)"
-sdcard_app_command(uint8_t acmd, uint32_t arg) "ACMD%d arg 0x%08x"
+sdcard_normal_command(const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%20s/ CMD%02d arg 0x%08x (state %s)"
+sdcard_app_command(const char *acmd_desc, uint8_t acmd, uint32_t arg, const char *state) "%23s/ACMD%02d arg 0x%08x (state %s)"
 sdcard_response(const char *rspdesc, int rsplen) "%s (sz:%d)"
 sdcard_powerup(void) ""
 sdcard_inquiry_cmd41(void) ""
@@ -39,8 +39,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(uint8_t cmd, uint8_t value) "CMD%02d value 0x%02x"
-sdcard_read_data(uint8_t cmd, int length) "CMD%02d len %d"
+sdcard_write_data(const char *cmd_desc, uint8_t cmd, uint8_t value) "%20s/ CMD%02d value 0x%02x"
+sdcard_read_data(const char *cmd_desc, uint8_t cmd, int length) "%20s/ CMD%02d len %d"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # hw/sd/milkymist-memcard.c
-- 
2.16.1
