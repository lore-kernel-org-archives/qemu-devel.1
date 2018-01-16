Received: from eggs.gnu.org ([2001:4830:134:3::10]:37412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNx-0008EA-DT
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNr-0002nK-HH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNr-0002ll-Ah
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNq-0002te-4P
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:06 +0000
Message-Id: <1516109659-1557-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/24] sdhci: clean up includes
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
Message-id: 20180115182436.2066-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci-internal.h | 4 ----
 include/hw/sd/sdhci.h  | 7 ++++++-
 hw/sd/sdhci.c          | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 161177c..248fd02 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -24,8 +24,6 @@
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
-#include "hw/sd/sdhci.h"
-
 /* R/W SDMA System Address register 0x0 */
 #define SDHC_SYSAD                     0x00
 
@@ -227,6 +225,4 @@ enum {
     sdhc_gap_write  = 2   /* SDHC stopped at block gap during write operation */
 };
 
-extern const VMStateDescription sdhci_vmstate;
-
 #endif
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 0f0c3f1..1335373 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -26,17 +26,19 @@
 #define SDHCI_H
 
 #include "qemu-common.h"
-#include "hw/block/block.h"
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
 
 /* SD/MMC host controller state */
 typedef struct SDHCIState {
+    /*< private >*/
     union {
         PCIDevice pcidev;
         SysBusDevice busdev;
     };
+
+    /*< public >*/
     SDBus sdbus;
     MemoryRegion iomem;
 
@@ -46,6 +48,7 @@ typedef struct SDHCIState {
     qemu_irq ro_cb;
     qemu_irq irq;
 
+    /* Registers cleared on reset */
     uint32_t sdmasysad;    /* SDMA System Address register */
     uint16_t blksize;      /* Host DMA Buff Boundary and Transfer BlkSize Reg */
     uint16_t blkcnt;       /* Blocks count for current transfer */
@@ -70,8 +73,10 @@ typedef struct SDHCIState {
     uint16_t acmd12errsts; /* Auto CMD12 error status register */
     uint64_t admasysaddr;  /* ADMA System Address Register */
 
+    /* Read-only registers */
     uint32_t capareg;      /* Capabilities Register */
     uint32_t maxcurr;      /* Maximum Current Capabilities Register */
+
     uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
     uint32_t buf_maxsz;
     uint16_t data_count;   /* current element in FIFO buffer */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b064a08..b7d2a20 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -29,6 +29,7 @@
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
 
-- 
2.7.4
