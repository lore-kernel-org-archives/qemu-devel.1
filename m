Received: from eggs.gnu.org ([2001:4830:134:3::10]:38556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosil-0004ze-P6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosik-0001pp-7Z
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosij-0001na-W5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosii-00025x-Sa
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:40 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:59 +0000
Message-Id: <20180222152307.7499-25-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/32] sdcard: use the registerfields API for
 the CARD_STATUS register masks
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
Message-id: 20180215221325.7611-9-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5044a306e4..cc5caaf4f0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -419,14 +419,56 @@ static void sd_set_rca(SDState *sd)
     sd->rca += 0x4567;
 }
 
+FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
+FIELD(CSR, APP_CMD,                     5,  1)
+FIELD(CSR, FX_EVENT,                    6,  1)
+FIELD(CSR, READY_FOR_DATA,              8,  1)
+FIELD(CSR, CURRENT_STATE,               9,  4)
+FIELD(CSR, ERASE_RESET,                13,  1)
+FIELD(CSR, CARD_ECC_DISABLED,          14,  1)
+FIELD(CSR, WP_ERASE_SKIP,              15,  1)
+FIELD(CSR, CSD_OVERWRITE,              16,  1)
+FIELD(CSR, DEFERRED_RESPONSE,          17,  1)
+FIELD(CSR, ERROR,                      19,  1)
+FIELD(CSR, CC_ERROR,                   20,  1)
+FIELD(CSR, CARD_ECC_FAILED,            21,  1)
+FIELD(CSR, ILLEGAL_COMMAND,            22,  1)
+FIELD(CSR, COM_CRC_ERROR,              23,  1)
+FIELD(CSR, LOCK_UNLOCK_FAILED,         24,  1)
+FIELD(CSR, CARD_IS_LOCKED,             25,  1)
+FIELD(CSR, WP_VIOLATION,               26,  1)
+FIELD(CSR, ERASE_PARAM,                27,  1)
+FIELD(CSR, ERASE_SEQ_ERROR,            28,  1)
+FIELD(CSR, BLOCK_LEN_ERROR,            29,  1)
+FIELD(CSR, ADDRESS_ERROR,              30,  1)
+FIELD(CSR, OUT_OF_RANGE,               31,  1)
+
 /* Card status bits, split by clear condition:
  * A : According to the card current state
  * B : Always related to the previous command
  * C : Cleared by read
  */
-#define CARD_STATUS_A	0x02004100
-#define CARD_STATUS_B	0x00c01e00
-#define CARD_STATUS_C	0xfd39a028
+#define CARD_STATUS_A           (R_CSR_READY_FOR_DATA_MASK \
+                               | R_CSR_CARD_ECC_DISABLED_MASK \
+                               | R_CSR_CARD_IS_LOCKED_MASK)
+#define CARD_STATUS_B           (R_CSR_CURRENT_STATE_MASK \
+                               | R_CSR_ILLEGAL_COMMAND_MASK \
+                               | R_CSR_COM_CRC_ERROR_MASK)
+#define CARD_STATUS_C           (R_CSR_AKE_SEQ_ERROR_MASK \
+                               | R_CSR_APP_CMD_MASK \
+                               | R_CSR_ERASE_RESET_MASK \
+                               | R_CSR_WP_ERASE_SKIP_MASK \
+                               | R_CSR_CSD_OVERWRITE_MASK \
+                               | R_CSR_ERROR_MASK \
+                               | R_CSR_CC_ERROR_MASK \
+                               | R_CSR_CARD_ECC_FAILED_MASK \
+                               | R_CSR_LOCK_UNLOCK_FAILED_MASK \
+                               | R_CSR_WP_VIOLATION_MASK \
+                               | R_CSR_ERASE_PARAM_MASK \
+                               | R_CSR_ERASE_SEQ_ERROR_MASK \
+                               | R_CSR_BLOCK_LEN_ERROR_MASK \
+                               | R_CSR_ADDRESS_ERROR_MASK \
+                               | R_CSR_OUT_OF_RANGE_MASK)
 
 static void sd_set_cardstatus(SDState *sd)
 {
-- 
2.16.1
