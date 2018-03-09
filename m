Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4u-0006LJ-Hd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4t-0008CH-1R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:04 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4s-0008Br-ND
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:02 -0500
Received: by mail-wm0-x242.google.com with SMTP id x7so4647838wmc.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:48 +0100
Message-Id: <20180309153654.13518-3-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/8] sdcard: Display command name when tracing
 CMD/ACMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

The SDBus will reuse these functions, so we put them in a new source file.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdmmc-internal.h | 20 ++++++++++++++
 hw/sd/sd.c             | 13 +++++----
 hw/sd/sdmmc-internal.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/sd/Makefile.objs    |  2 +-
 hw/sd/trace-events     |  8 +++---
 5 files changed, 105 insertions(+), 10 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.c

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 0e96cb0081..bf6fb06128 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -12,4 +12,24 @@
 
 #define SDMMC_CMD_MAX 64
 
+/**
+ * sd_cmd_name:
+ * @cmd: A SD "normal" command, upto SDMMC_CMD_MAX.
+ *
+ * Returns an human useful name describing the command.
+ *
+ * Returns: The command name of @cmd or "UNKNOWN_CMD".
+ */
+const char *sd_cmd_name(uint8_t cmd);
+
+/**
+ * sd_acmd_name:
+ * @cmd: A SD "Application-Specific" command, upto SDMMC_CMD_MAX.
+ *
+ * Returns an human useful name describing the application command.
+ *
+ * Returns: The application command name of @cmd or "UNKNOWN_ACMD".
+ */
+const char *sd_acmd_name(uint8_t cmd);
+
 #endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4a9520e38e..bb149aa644 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -875,8 +875,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
-        trace_sdcard_normal_command(req.cmd, req.arg,
-                                    sd_state_name(sd->state));
+        trace_sdcard_normal_command(sd_cmd_name(req.cmd), req.cmd,
+                                    req.arg, sd_state_name(sd->state));
     }
 
     /* Not interpreting this as an app command */
@@ -1455,7 +1455,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(req.cmd, req.arg);
+    trace_sdcard_app_command(sd_acmd_name(req.cmd),
+                             req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
     switch (req.cmd) {
     case 6:	/* ACMD6:  SET_BUS_WIDTH */
@@ -1770,7 +1771,8 @@ void sd_write_data(SDState *sd, uint8_t value)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return;
 
-    trace_sdcard_write_data(sd->current_cmd, value);
+    trace_sdcard_write_data(sd_acmd_name(sd->current_cmd),
+                            sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1908,7 +1910,8 @@ uint8_t sd_read_data(SDState *sd)
 
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
-    trace_sdcard_read_data(sd->current_cmd, io_len);
+    trace_sdcard_read_data(sd_acmd_name(sd->current_cmd),
+                           sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
new file mode 100644
index 0000000000..2053def3f1
--- /dev/null
+++ b/hw/sd/sdmmc-internal.c
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
+        [50]    = "SW_FUNC_RSVD",
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
index c2b7664264..a99d9fbb04 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_PL181) += pl181.o
 common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o
+common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
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
2.16.2
