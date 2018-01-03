Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWm6e-0005eu-3Z
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWm6d-0007hL-4w
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:41:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 13:41:17 -0300
Message-Id: <20180103164117.11850-3-f4bug@amsat.org>
In-Reply-To: <20180103164117.11850-1-f4bug@amsat.org>
References: <20180103164117.11850-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] hw/sd/pxa2xx_mmci: add read/write() trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/pxa2xx_mmci.c | 63 ++++++++++++++++++++++++++++++++++-------------------
 hw/sd/trace-events  |  4 ++++
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 3deccf02c9..0759a0d2eb 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -19,6 +19,7 @@
 #include "hw/qdev.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 #define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
@@ -278,43 +279,55 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
 static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr offset, unsigned size)
 {
     PXA2xxMMCIState *s = (PXA2xxMMCIState *) opaque;
-    uint32_t ret;
+    uint32_t ret = 0;
 
     switch (offset) {
     case MMC_STRPCL:
-        return 0;
+        break;
     case MMC_STAT:
-        return s->status;
+        ret = s->status;
+        break;
     case MMC_CLKRT:
-        return s->clkrt;
+        ret = s->clkrt;
+        break;
     case MMC_SPI:
-        return s->spi;
+        ret = s->spi;
+        break;
     case MMC_CMDAT:
-        return s->cmdat;
+        ret = s->cmdat;
+        break;
     case MMC_RESTO:
-        return s->resp_tout;
+        ret = s->resp_tout;
+        break;
     case MMC_RDTO:
-        return s->read_tout;
+        ret = s->read_tout;
+        break;
     case MMC_BLKLEN:
-        return s->blklen;
+        ret = s->blklen;
+        break;
     case MMC_NUMBLK:
-        return s->numblk;
+        ret = s->numblk;
+        break;
     case MMC_PRTBUF:
-        return 0;
+        break;
     case MMC_I_MASK:
-        return s->intmask;
+        ret = s->intmask;
+        break;
     case MMC_I_REG:
-        return s->intreq;
+        ret = s->intreq;
+        break;
     case MMC_CMD:
-        return s->cmd | 0x40;
+        ret = s->cmd | 0x40;
+        break;
     case MMC_ARGH:
-        return s->arg >> 16;
+        ret = s->arg >> 16;
+        break;
     case MMC_ARGL:
-        return s->arg & 0xffff;
+        ret = s->arg & 0xffff;
+        break;
     case MMC_RES:
-        if (s->resp_len < 9)
-            return s->resp_fifo[s->resp_len ++];
-        return 0;
+        ret = (s->resp_len < 9) ? s->resp_fifo[s->resp_len++] : 0;
+        break;
     case MMC_RXFIFO:
         ret = 0;
         while (size-- && s->rx_len) {
@@ -324,16 +337,19 @@ static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr offset, unsigned size)
         }
         s->intreq &= ~INT_RXFIFO_REQ;
         pxa2xx_mmci_fifo_update(s);
-        return ret;
+        break;
+        ret = ret;
     case MMC_RDWAIT:
-        return 0;
+        break;
     case MMC_BLKS_REM:
-        return s->numblk;
+        ret = s->numblk;
+        break;
     default:
         hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
     }
+    trace_pxa2xx_mmci_read(size, offset, ret);
 
-    return 0;
+    return ret;
 }
 
 static void pxa2xx_mmci_write(void *opaque,
@@ -341,6 +357,7 @@ static void pxa2xx_mmci_write(void *opaque,
 {
     PXA2xxMMCIState *s = (PXA2xxMMCIState *) opaque;
 
+    trace_pxa2xx_mmci_write(size, offset, value);
     switch (offset) {
     case MMC_STRPCL:
         if (value & STRPCL_STRT_CLK) {
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 1fc0bcf44b..6eca3470e2 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -3,3 +3,7 @@
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+
+# hw/sd/pxa2xx_mmci.c
+pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
+pxa2xx_mmci_write(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
-- 
2.15.1
