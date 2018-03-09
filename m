Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4y-0006Ox-4c
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4w-0008ES-SD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:08 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4w-0008Dv-IS
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:06 -0500
Received: by mail-wr0-x242.google.com with SMTP id h2so2129334wre.12
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:37:06 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:51 +0100
Message-Id: <20180309153654.13518-6-f4bug@amsat.org>
In-Reply-To: <20180309153654.13518-1-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
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

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++--------
 hw/sd/trace-events |   1 +
 2 files changed, 127 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e0518d6..b907d62aef 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -124,6 +124,7 @@ struct SDState {
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
+    bool uhs_enabled;
 };
 
 static const char *sd_state_name(enum SDCardStates state)
@@ -563,6 +564,7 @@ static void sd_reset(DeviceState *dev)
     sd->expecting_acmd = false;
     sd->dat_lines = 0xf;
     sd->cmd_line = true;
+    sd->uhs_enabled = false;
     sd->multi_blk_cnt = 0;
 }
 
@@ -761,30 +763,132 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     return ret;
 }
 
+/* Function Group */
+enum {
+    SD_FG_MIN               = 1,
+    SD_FG_ACCESS_MODE       = 1,
+    SD_FG_COMMAND_SYSTEM    = 2,
+    SD_FG_DRIVER_STRENGTH   = 3,
+    SD_FG_CURRENT_LIMIT     = 4,
+    SD_FG_RSVD_5            = 5,
+    SD_FG_RSVD_6            = 6,
+    SD_FG_COUNT
+};
+
+/* Function name */
+#define SD_FN_COUNT 16
+
+static const char *sd_fn_grp_name[SD_FG_COUNT] = {
+    [SD_FG_ACCESS_MODE]     = "ACCESS_MODE",
+    [SD_FG_COMMAND_SYSTEM]  = "COMMAND_SYSTEM",
+    [SD_FG_DRIVER_STRENGTH] = "DRIVER_STRENGTH",
+    [SD_FG_CURRENT_LIMIT]   = "CURRENT_LIMIT",
+    [SD_FG_RSVD_5]          = "RSVD5",
+    [SD_FG_RSVD_6]          = "RSVD6",
+};
+
+typedef struct sd_fn_support {
+    const char *name;
+    bool uhs_only;
+    bool unimp;
+} sd_fn_support;
+
+static const sd_fn_support *sd_fn_support_defs[SD_FG_COUNT] = {
+    [SD_FG_ACCESS_MODE] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default/SDR12" },
+        [1] = { .name = "high-speed/SDR25" },
+        [2] = { .name = "SDR50",    .uhs_only = true },
+        [3] = { .name = "SDR104",   .uhs_only = true },
+        [4] = { .name = "DDR50",    .uhs_only = true },
+    },
+    [SD_FG_COMMAND_SYSTEM] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default" },
+        [1] = { .name = "For eC" },
+        [3] = { .name = "OTP",      .unimp = true },
+        [4] = { .name = "ASSD",     .unimp = true },
+    },
+    [SD_FG_DRIVER_STRENGTH] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default/Type B" },
+        [1] = { .name = "Type A",   .uhs_only = true },
+        [2] = { .name = "Type C",   .uhs_only = true },
+        [3] = { .name = "Type D",   .uhs_only = true },
+    },
+    [SD_FG_CURRENT_LIMIT] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default/200mA" },
+        [1] = { .name = "400mA",    .uhs_only = true },
+        [2] = { .name = "600mA",    .uhs_only = true },
+        [3] = { .name = "800mA",    .uhs_only = true },
+    },
+    [SD_FG_RSVD_5] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default" },
+    },
+    [SD_FG_RSVD_6] = (sd_fn_support [SD_FN_COUNT]) {
+        [0] = { .name = "default" },
+    },
+};
+
+#define SD_FN_NO_INFLUENCE          (1 << 15)
+
 static void sd_function_switch(SDState *sd, uint32_t arg)
 {
-    int i, mode, new_func;
-    mode = !!(arg & 0x80000000);
-
-    sd->data[0] = 0x00;		/* Maximum current consumption */
-    sd->data[1] = 0x01;
-    sd->data[2] = 0x80;		/* Supported group 6 functions */
-    sd->data[3] = 0x01;
-    sd->data[4] = 0x80;		/* Supported group 5 functions */
-    sd->data[5] = 0x01;
-    sd->data[6] = 0x80;		/* Supported group 4 functions */
-    sd->data[7] = 0x01;
-    sd->data[8] = 0x80;		/* Supported group 3 functions */
-    sd->data[9] = 0x01;
-    sd->data[10] = 0x80;	/* Supported group 2 functions */
-    sd->data[11] = 0x43;
-    sd->data[12] = 0x80;	/* Supported group 1 functions */
-    sd->data[13] = 0x03;
-    for (i = 0; i < 6; i ++) {
-        new_func = (arg >> (i * 4)) & 0x0f;
-        if (mode && new_func != 0x0f)
-            sd->function_group[i] = new_func;
-        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
+    int fn_grp, new_func, i;
+    uint8_t *data_p;
+    bool mode = extract32(arg, 31, 1);  /* 0: check only, 1: do switch */
+
+    stw_be_p(sd->data + 0, 0x0001);     /* Maximum current consumption */
+
+    data_p = &sd->data[2];
+    for (fn_grp = SD_FG_COUNT - 1; fn_grp >= SD_FG_MIN; fn_grp--) {
+        uint16_t supported_fns = SD_FN_NO_INFLUENCE;
+        for (i = 0; i < SD_FN_COUNT; ++i) {
+            const sd_fn_support *def = &sd_fn_support_defs[fn_grp][i];
+
+            if (def->name && !def->unimp &&
+                    !(def->uhs_only && !sd->uhs_enabled)) {
+                supported_fns |= 1 << i;
+            }
+        }
+        stw_be_p(data_p, supported_fns);
+        data_p += 2;
+    }
+
+    assert(data_p == &sd->data[14]);
+    for (fn_grp = SD_FG_COUNT - 1; fn_grp >= SD_FG_MIN; fn_grp--) {
+        new_func = (arg >> ((fn_grp - 1) * 4)) & 0x0f;
+        if (new_func == 0xf) {
+            new_func = sd->function_group[fn_grp - 1];
+        } else {
+            const sd_fn_support *def = &sd_fn_support_defs[fn_grp][new_func];
+            if (mode) {
+                if (!def->name) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Function %d not a valid for "
+                                  "function group %d\n",
+                                  new_func, fn_grp);
+                    new_func = 0xf;
+                } else if (def->unimp) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "Function %s (fn grp %d) not implemented\n",
+                                  def->name, fn_grp);
+                    new_func = 0xf;
+                } else if (def->uhs_only && !sd->uhs_enabled) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Function %s (fn grp %d) only "
+                                  "valid in UHS mode\n",
+                                  def->name, fn_grp);
+                    new_func = 0xf;
+                } else {
+                    sd->function_group[fn_grp - 1] = new_func;
+                }
+            }
+            trace_sdcard_function_select(def->name, sd_fn_grp_name[fn_grp],
+                                         mode);
+        }
+        if (!(fn_grp & 0x1)) { /* evens go in high nibble */
+            *data_p = new_func << 4;
+        } else { /* odds go in low nibble */
+            *(data_p++) |= new_func;
+        }
     }
     memset(&sd->data[17], 0, 47);
     stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 2059ace61f..c106541a47 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -42,6 +42,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
+sdcard_function_select(const char *fn_name, const char *grp_name, bool do_switch) "Function %s (group: %s, sw: %u)"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.16.2
