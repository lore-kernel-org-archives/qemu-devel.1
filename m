Received: from eggs.gnu.org ([2001:4830:134:3::10]:38353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiZ-0004kW-9D
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiY-0001dk-7c
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiY-0001cp-0c
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiX-00022G-4C
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:44 +0000
Message-Id: <20180222152307.7499-10-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/32] sdcard: reorder SDState struct members
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

place card registers first, this will ease further code movements.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215220540.6556-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9ac9b63ff8..ce1f2fdf76 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -88,16 +88,21 @@ enum SDCardStates {
 struct SDState {
     DeviceState parent_obj;
 
-    uint32_t mode;    /* current card mode, one of SDCardModes */
-    int32_t state;    /* current card state, one of SDCardStates */
+    /* SD Memory Card Registers */
     uint32_t ocr;
-    QEMUTimer *ocr_power_timer;
     uint8_t scr[8];
     uint8_t cid[16];
     uint8_t csd[16];
     uint16_t rca;
     uint32_t card_status;
     uint8_t sd_status[64];
+
+    /* Configurable properties */
+    BlockBackend *blk;
+    bool spi;
+
+    uint32_t mode;    /* current card mode, one of SDCardModes */
+    int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_groups;
@@ -110,8 +115,6 @@ struct SDState {
     uint8_t pwd[16];
     uint32_t pwd_len;
     uint8_t function_group[6];
-
-    bool spi;
     uint8_t current_cmd;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
@@ -123,8 +126,7 @@ struct SDState {
     uint8_t data[512];
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
-    BlockBackend *blk;
-
+    QEMUTimer *ocr_power_timer;
     bool enable;
     uint8_t dat_lines;
     bool cmd_line;
-- 
2.16.1
