Received: from eggs.gnu.org ([2001:4830:134:3::10]:59718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmx-0008UK-Ma
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmw-00069v-GQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmw-000693-6M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmv-00078f-8d
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:37 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:17 +0000
Message-Id: <20180309172622.4277-21-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/25] sdcard: Do not trace CMD55,
 except when we already expect an ACMD
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
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180309153654.13518-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 933890e86f..4a9520e38e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -866,13 +866,18 @@ static void sd_lock_command(SDState *sd)
         sd->card_status &= ~CARD_IS_LOCKED;
 }
 
-static sd_rsp_type_t sd_normal_command(SDState *sd,
-                                       SDRequest req)
+static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint32_t rca = 0x0000;
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
-    trace_sdcard_normal_command(req.cmd, req.arg, sd_state_name(sd->state));
+    /* CMD55 precedes an ACMD, so we are not interested in tracing it.
+     * However there is no ACMD55, so we want to trace this particular case.
+     */
+    if (req.cmd != 55 || sd->expecting_acmd) {
+        trace_sdcard_normal_command(req.cmd, req.arg,
+                                    sd_state_name(sd->state));
+    }
 
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
-- 
2.16.2
