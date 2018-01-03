Received: from eggs.gnu.org ([2001:4830:134:3::10]:47656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSc-0000AS-9Y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSb-0006t8-6W
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:18 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:42895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSb-0006su-1i
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:17 -0500
Received: by mail-qt0-x244.google.com with SMTP id g9so3106807qth.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:07:49 -0300
Message-Id: <20180103180805.18140-2-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/17] sdhci: clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 4 ----
 include/hw/sd/sdhci.h  | 7 ++++++-
 hw/sd/sdhci.c          | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 161177cf39..248fd027f9 100644
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
index 0f0c3f1e64..1335373d3c 100644
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
index b064a087c9..b7d2a20985 100644
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
2.15.1
