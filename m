Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosie-0004qz-Mh
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosic-0001hF-EX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosic-0001gY-6u
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosib-00023U-98
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:49 +0000
Message-Id: <20180222152307.7499-15-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/32] sdcard: define SDMMC_CMD_MAX instead of
 using the magic '64'
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
Message-id: 20180215220540.6556-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdmmc-internal.h | 15 +++++++++++++++
 hw/sd/sd.c             | 22 ++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.h

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
new file mode 100644
index 0000000000..0e96cb0081
--- /dev/null
+++ b/hw/sd/sdmmc-internal.h
@@ -0,0 +1,15 @@
+/*
+ * SD/MMC cards common
+ *
+ * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef SD_INTERNAL_H
+#define SD_INTERNAL_H
+
+#define SDMMC_CMD_MAX 64
+
+#endif
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 564f7a9bfd..90d1e27ee7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "sdmmc-internal.h"
 #include "trace.h"
 
 //#define DEBUG_SD 1
@@ -215,18 +216,21 @@ static void sd_set_mode(SDState *sd)
     }
 }
 
-static const sd_cmd_type_t sd_cmd_type[64] = {
+static const sd_cmd_type_t sd_cmd_type[SDMMC_CMD_MAX] = {
     sd_bc,   sd_none, sd_bcr,  sd_bcr,  sd_none, sd_none, sd_none, sd_ac,
     sd_bcr,  sd_ac,   sd_ac,   sd_adtc, sd_ac,   sd_ac,   sd_none, sd_ac,
+    /* 16 */
     sd_ac,   sd_adtc, sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none,
     sd_adtc, sd_adtc, sd_adtc, sd_adtc, sd_ac,   sd_ac,   sd_adtc, sd_none,
+    /* 32 */
     sd_ac,   sd_ac,   sd_none, sd_none, sd_none, sd_none, sd_ac,   sd_none,
     sd_none, sd_none, sd_bc,   sd_none, sd_none, sd_none, sd_none, sd_none,
+    /* 48 */
     sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_ac,
     sd_adtc, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none, sd_none,
 };
 
-static const int sd_cmd_class[64] = {
+static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     0,  0,  0,  0,  0,  9, 10,  0,  0,  0,  0,  1,  0,  0,  0,  0,
     2,  2,  2,  2,  3,  3,  3,  3,  4,  4,  4,  4,  6,  6,  6,  6,
     5,  5, 10, 10, 10, 10,  5,  9,  9,  9,  7,  7,  7,  7,  7,  7,
@@ -829,8 +833,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd & 0x3F] == sd_ac
-        || sd_cmd_type[req.cmd & 0x3F] == sd_adtc) {
+    if (sd_cmd_type[req.cmd] == sd_ac
+        || sd_cmd_type[req.cmd] == sd_adtc) {
         rca = req.arg >> 16;
     }
 
@@ -1542,8 +1546,8 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
     if (req->cmd == 16 || req->cmd == 55) {
         return 1;
     }
-    return sd_cmd_class[req->cmd & 0x3F] == 0
-            || sd_cmd_class[req->cmd & 0x3F] == 7;
+    return sd_cmd_class[req->cmd] == 0
+            || sd_cmd_class[req->cmd] == 7;
 }
 
 int sd_do_command(SDState *sd, SDRequest *req,
@@ -1562,6 +1566,12 @@ int sd_do_command(SDState *sd, SDRequest *req,
         goto send_response;
     }
 
+    if (req->cmd >= SDMMC_CMD_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SD: incorrect command 0x%02x\n",
+                      req->cmd);
+        req->cmd &= 0x3f;
+    }
+
     if (sd->card_status & CARD_IS_LOCKED) {
         if (!cmd_valid_while_locked(sd, req)) {
             sd->card_status |= ILLEGAL_COMMAND;
-- 
2.16.1
