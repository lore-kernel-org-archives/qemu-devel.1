Received: from eggs.gnu.org ([2001:4830:134:3::10]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjvV-0006w6-Jn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZjvU-0003Hq-Jk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:58:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:23 -0300
Message-Id: <20180111205626.23291-19-f4bug@amsat.org>
In-Reply-To: <20180111205626.23291-1-f4bug@amsat.org>
References: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 18/21] sdhci: implement the Host Control 2
 register for the tunning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2015.2]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 890dd1bbac..e66d6d6abd 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -71,6 +71,7 @@ typedef struct SDHCIState {
     uint16_t norintsigen;  /* Normal Interrupt Signal Enable Register */
     uint16_t errintsigen;  /* Error Interrupt Signal Enable Register */
     uint16_t acmd12errsts; /* Auto CMD12 error status register */
+    uint16_t hostctl2;     /* Host Control 2 */
     uint64_t admasysaddr;  /* ADMA System Address Register */
 
     /* Read-only registers */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8e4805c84e..834b835f3e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -312,14 +312,29 @@ static void sdhci_end_transfer(SDHCIState *s)
 static void sdhci_read_block_from_card(SDHCIState *s)
 {
     int index = 0;
+    uint8_t data;
+    const uint16_t blk_size = s->blksize & BLOCK_SIZE_MASK;
 
     if ((s->trnmod & SDHC_TRNS_MULTI) &&
             (s->trnmod & SDHC_TRNS_BLK_CNT_EN) && (s->blkcnt == 0)) {
         return;
     }
 
-    for (index = 0; index < (s->blksize & BLOCK_SIZE_MASK); index++) {
-        s->fifo_buffer[index] = sdbus_read_data(&s->sdbus);
+    for (index = 0; index < blk_size; index++) {
+        data = sdbus_read_data(&s->sdbus);
+        if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
+            /* Device is not in tunning */
+            s->fifo_buffer[index] = data;
+        }
+    }
+
+    if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
+        /* Device is in tunning */
+        s->hostctl2 &= ~R_SDHC_HOSTCTL2_EXECUTE_TUNING_MASK;
+        s->hostctl2 |= R_SDHC_HOSTCTL2_SAMPLING_CLKSEL_MASK;
+        s->prnsts &= ~(SDHC_DAT_LINE_ACTIVE | SDHC_DOING_READ |
+                       SDHC_DATA_INHIBIT);
+        goto read_done;
     }
 
     /* New data now available for READ through Buffer Port Register */
@@ -344,6 +359,7 @@ static void sdhci_read_block_from_card(SDHCIState *s)
         }
     }
 
+read_done:
     sdhci_update_irq(s);
 }
 
@@ -909,7 +925,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = s->norintsigen | (s->errintsigen << 16);
         break;
     case SDHC_ACMD12ERRSTS:
-        ret = s->acmd12errsts;
+        ret = s->acmd12errsts | (s->hostctl2 << 16);
         break;
     case SDHC_CAPAB:
         ret = (uint32_t)s->capareg;
-- 
2.15.1
