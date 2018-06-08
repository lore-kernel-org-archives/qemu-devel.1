Received: from eggs.gnu.org ([2001:4830:134:3::10]:50735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGly-0003Fc-PM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGly-0004TX-11
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlx-0004SV-Qg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlw-0003og-Pg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:17 +0100
Message-Id: <20180608124517.29475-32-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/31] sdcard: Disable CMD19/CMD23 for Spec v2
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

These commands got introduced by Spec v3
(see 0c3fb03f7ec and 4481bbc79d2).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180607180641.874-7-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4e49a3827a3..540bccb8d13 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1179,6 +1179,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 19:    /* CMD19: SEND_TUNING_BLOCK (SD) */
+        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            break;
+        }
         if (sd->state == sd_transfer_state) {
             sd->state = sd_sendingdata_state;
             sd->data_offset = 0;
@@ -1187,6 +1190,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 23:    /* CMD23: SET_BLOCK_COUNT */
+        if (sd->spec_version < SD_PHY_SPECv3_01_VERS) {
+            break;
+        }
         switch (sd->state) {
         case sd_transfer_state:
             sd->multi_blk_cnt = req.arg;
-- 
2.17.1
