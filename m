Received: from eggs.gnu.org ([2001:4830:134:3::10]:38663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosit-00058h-EI
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosis-0001zD-Gx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosis-0001yC-9k
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosir-00027g-C0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:06 +0000
Message-Id: <20180222152307.7499-32-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/32] sdcard: simplify SEND_IF_COND (CMD8)
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

replace switch(single case) -> if()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-16-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c8351d4f0b..25fce7d6b6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1008,23 +1008,19 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
     case 8:	/* CMD8:   SEND_IF_COND */
         /* Physical Layer Specification Version 2.00 command */
-        switch (sd->state) {
-        case sd_idle_state:
-            sd->vhs = 0;
-
-            /* No response if not exactly one VHS bit is set.  */
-            if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-                return sd->spi ? sd_r7 : sd_r0;
-            }
-
-            /* Accept.  */
-            sd->vhs = req.arg;
-            return sd_r7;
-
-        default:
+        if (sd->state != sd_idle_state) {
             break;
         }
-        break;
+        sd->vhs = 0;
+
+        /* No response if not exactly one VHS bit is set.  */
+        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
+            return sd->spi ? sd_r7 : sd_r0;
+        }
+
+        /* Accept.  */
+        sd->vhs = req.arg;
+        return sd_r7;
 
     case 9:	/* CMD9:   SEND_CSD */
         switch (sd->state) {
-- 
2.16.1
