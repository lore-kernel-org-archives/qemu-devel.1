Received: from eggs.gnu.org ([2001:4830:134:3::10]:46791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag3-0008Hh-Id
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag1-0003IZ-WE
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:47 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:46172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag1-0003I2-RJ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:45 -0400
Received: by mail-qt0-x22c.google.com with SMTP id h5-v6so6814650qtm.13
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 08:48:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:48:35 -0300
Message-Id: <20180606154835.2276-2-f4bug@amsat.org>
In-Reply-To: <20180606154835.2276-1-f4bug@amsat.org>
References: <20180606154835.2276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/1] sdcard: Implement the UHS-I Switch
 Function entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Per the "Physical Layer Simplified Specification Version 3.01":

  2. System Features

    Switch function command supports Bus Speed Mode, Command
    System, Drive Strength, and future functions.

  4.3.10 Switch Function Command

    The switch function command (CMD6) is used to switch or
    expand memory card functions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 238 ++++++++++++++++++++++++++++++++++++++++-----
 hw/sd/trace-events |   1 +
 2 files changed, 217 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7af19fa06c..5b05d77ac0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -124,6 +124,10 @@ struct SDState {
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
+    /* Whether the card entered the UHS mode with voltage level adjusted
+     * (used by soft-reset)
+     */
+    bool uhs_activated;
 };
 
 static const char *sd_state_name(enum SDCardStates state)
@@ -561,6 +565,7 @@ static void sd_reset(DeviceState *dev)
     sd->blk_len = 0x200;
     sd->pwd_len = 0;
     sd->expecting_acmd = false;
+    sd->uhs_activated = false;
     sd->dat_lines = 0xf;
     sd->cmd_line = true;
     sd->multi_blk_cnt = 0;
@@ -761,32 +766,221 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     return ret;
 }
 
+/* Function Group */
+enum {
+    FG_MIN               = 1,
+    FG_ACCESS_MODE       = 1,
+    FG_COMMAND_SYSTEM    = 2,
+    FG_DRIVER_STRENGTH   = 3,
+    FG_CURRENT_LIMIT     = 4,
+    FG_RSVD_5            = 5,
+    FG_RSVD_6            = 6,
+    FG_MAX               = 6,
+    FG_COUNT
+};
+
+/* Function name */
+enum {
+    FN_NO_INFLUENCE      = 0xf,
+    FN_COUNT             = 16
+};
+
+/* Bus Speed Mode */
+static bool fg1_selectable(SDState *sd, int fn)
+{
+    if (sd->uhs_activated) {
+        return fn <= 4;
+    }
+    return fn <= 1;
+}
+
+/* driver strength selection for UHS-I modes */
+static bool fg3_selectable(SDState *sd, int fn)
+{
+    if (sd->uhs_activated) {
+        return fn <= 3;
+    }
+    return false;
+}
+
+/* Current Limit switch for SDR50, SDR104 and DDR50 */
+static bool fg4_selectable(SDState *sd, int fn)
+{
+    if (sd->uhs_activated) {
+        return fn <= 3;
+    }
+    return false;
+}
+
+typedef struct sd_fn_support {
+    bool (*is_selectable)(SDState *sd, int fn);
+    const char *name[FN_COUNT];
+} sd_fn_support;
+
+static const sd_fn_support fn_support_defs[FG_COUNT] = {
+    [FG_ACCESS_MODE] = {
+        &fg1_selectable, {
+            [0] = "default/SDR12",
+            [1] = "high-speed/SDR25",
+            [2] = "SDR50",
+            [3] = "SDR104",
+            [4] = "DDR50",
+        }
+    },
+    [FG_COMMAND_SYSTEM] = {
+        NULL, {
+            [1] = "For eC",
+            [3] = "OTP",
+            [4] = "ASSD",
+        }
+    },
+    [FG_DRIVER_STRENGTH] = {
+        &fg3_selectable, {
+            [0] = "default/Type B",
+            [1] = "Type A",
+            [2] = "Type C",
+            [3] = "Type D",
+        }
+    },
+    [FG_CURRENT_LIMIT] = {
+        &fg4_selectable, {
+            [0] = "default/200mA",
+            [1] = "400mA",
+            [2] = "600mA",
+            [3] = "800mA",
+        }
+    },
+};
+
+static const char *sd_fn_grp_name[FG_COUNT] = {
+    [FG_ACCESS_MODE]     = "ACCESS_MODE",
+    [FG_COMMAND_SYSTEM]  = "COMMAND_SYSTEM",
+    [FG_DRIVER_STRENGTH] = "DRIVER_STRENGTH",
+    [FG_CURRENT_LIMIT]   = "CURRENT_LIMIT",
+    [FG_RSVD_5]          = "RSVD5",
+    [FG_RSVD_6]          = "RSVD6",
+};
+
+static const char *sd_fn_name(int grp, int fn)
+{
+    if (fn_support_defs[grp].name[fn]) {
+        return fn_support_defs[grp].name[fn];
+    }
+    if (fn == 0) {
+        return "default";
+    }
+    return "invalid";
+};
+
+static bool sd_function_is_selectable(SDState *sd, int grp, int fn)
+{
+    const sd_fn_support *def = &fn_support_defs[grp];
+
+    if (fn == 0) {
+        /* default is always selectable */
+        return true;
+    }
+    if (def->is_selectable) {
+        return def->is_selectable(sd, fn);
+    }
+    return false;
+}
+
+static bool sd_function_is_valid(SDState *sd, int group, int fn)
+{
+    const sd_fn_support *def = &fn_support_defs[group];
+    bool is_valid = false;
+
+    if (fn == FN_NO_INFLUENCE) {
+        fn = sd->function_group[group - 1];
+    }
+    if (fn == 0) {
+        /* default is always valid */
+        is_valid = true;
+    } else if (!def->name[fn]) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Function %d not valid for function group %d\n",
+                      fn, group);
+    } else if (!def->is_selectable) {
+        qemu_log_mask(LOG_UNIMP, "Function %s (fn group %d) not implemented\n",
+                      sd_fn_name(group, fn), group);
+    } else if (!def->is_selectable(sd, fn)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Function %s (fn group %d) only valid in current mode\n",
+                      sd_fn_name(group, fn), group);
+    } else {
+        is_valid = true;
+    }
+
+    return is_valid;
+}
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
+    int group, func_num, i;
+    uint16_t max_current_mA = 1; /* 1 mA is virtually enough */
+    uint32_t switch_fns = 0;
+    bool do_switch = extract32(arg, 31, 1);
+
+    /* Bits 400-495: groups functions supported (16 bits each group) */
+    for (group = FG_MIN; group <= FG_MAX; group++) {
+        uint16_t supported_fns = 1 << FN_NO_INFLUENCE;
+
+        for (i = 0; i < FN_COUNT; ++i) {
+            if (sd_function_is_selectable(sd, group, i)) {
+                supported_fns |= 1 << i;
+            }
+        }
+        stw_be_p(sd->data + 2 + 2 * (FG_MAX - group), supported_fns);
+    }
+
+    /* Bits 376-399: functions information (4 bits each group) */
+    for (group = FG_MIN; group <= FG_MAX; group++) {
+        bool fn_valid;
+        func_num = (arg >> ((group - 1) * 4)) & 0x0f;
+        fn_valid = sd_function_is_valid(sd, group, func_num);
+        trace_sdcard_function_select(1, "valid", fn_valid,
+                                     group, sd_fn_grp_name[group],
+                                     sd_fn_name(group, func_num));
+        if (!fn_valid) {
+            /* 0xf shows function set error with the argument. */
+            switch_fns = deposit32(switch_fns, 4 * (group + 1), 4, 0xf);
+        }
+    }
+    if (switch_fns) {
+        /* pass #1 set switch_fns if an invalid function got selected.
+         *
+         * Maximum current consumption:
+         * If one of the selected functions was wrong, the return value is 0.
+         */
+        max_current_mA = 0;
+    } else {
+        for (group = FG_MIN; group <= FG_MAX; group++) {
+            func_num = (arg >> ((group - 1) * 4)) & 0x0f;
+            if (func_num == FN_NO_INFLUENCE) {
+                /* Guest requested no influence, so this function group
+                 * stays the same.
+                 */
+                func_num = sd->function_group[group - 1];
+            }
+            trace_sdcard_function_select(2, "switch", do_switch,
+                                         group, sd_fn_grp_name[group],
+                                         sd_fn_name(group, func_num));
+            if (do_switch) {
+                sd->function_group[group - 1] = func_num;
+            }
+            switch_fns = deposit32(switch_fns, 4 * (group + 1), 4, func_num);
+        }
     }
+    stl_be_p(sd->data + 14, switch_fns);
+
+    /* Data Structure Version = 0x00: 376 bits reserved (undefined)  */
     memset(&sd->data[17], 0, 47);
+
+    /* Bits 496-511 Maximum current consumption */
+    stw_be_p(sd->data, max_current_mA);
+
+    /* Finally update the checksum */
     stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
 }
 
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index bfd1d62efc..82fa2e18d4 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -48,6 +48,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
+sdcard_function_select(int pass, const char *bool_name, bool bool_value, int grp_num, const char *grp_name, const char *fn_name) "PASS#%d %s:%u group:%d/%s func:'%s'"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.17.1
