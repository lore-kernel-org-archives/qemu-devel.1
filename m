Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosir-00056j-QT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosir-0001xf-2I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiq-0001wQ-RH
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosip-00027B-TL
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:04 +0000
Message-Id: <20180222152307.7499-30-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/32] sdcard: check the card is in correct
 state for APP CMD (CMD55)
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
Message-id: 20180215221325.7611-14-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ff7ace3491..d6dd2b9a15 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1386,6 +1386,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
 
     /* Application specific commands (Class 8) */
     case 55:	/* CMD55:  APP_CMD */
+        switch (sd->state) {
+        case sd_ready_state:
+        case sd_identification_state:
+        case sd_inactive_state:
+            return sd_illegal;
+        default:
+            break;
+        }
         if (!sd->spi) {
             if (sd->rca != rca) {
                 return sd_r0;
-- 
2.16.1
