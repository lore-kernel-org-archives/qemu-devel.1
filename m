Received: from eggs.gnu.org ([2001:4830:134:3::10]:52349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd48-0007aC-CG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0000Ew-7F
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd46-0000Bt-VN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd45-0005kn-Lk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:18 +0000
Message-Id: <1515677902-23436-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/26] hw/sd/pxa2xx_mmci: add read/write() trace
 events
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
Message-id: 20180104000156.30932-1-f4bug@amsat.org
[PMM: add missing include]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/pxa2xx_mmci.c | 78 ++++++++++++++++++++++++++++++++++-------------------
 hw/sd/trace-events  |  4 +++
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 3deccf0..82f8ec0 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -19,6 +19,8 @@
 #include "hw/qdev.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "trace.h"
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 #define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
@@ -278,45 +280,56 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)
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
-        ret = 0;
         while (size-- && s->rx_len) {
             ret |= s->rx_fifo[s->rx_start++] << (size << 3);
             s->rx_start &= 0x1f;
@@ -324,16 +337,20 @@ static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr offset, unsigned size)
         }
         s->intreq &= ~INT_RXFIFO_REQ;
         pxa2xx_mmci_fifo_update(s);
-        return ret;
+        break;
     case MMC_RDWAIT:
-        return 0;
+        break;
     case MMC_BLKS_REM:
-        return s->numblk;
+        ret = s->numblk;
+        break;
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: incorrect register 0x%02" HWADDR_PRIx "\n",
+                      __func__, offset);
     }
+    trace_pxa2xx_mmci_read(size, offset, ret);
 
-    return 0;
+    return ret;
 }
 
 static void pxa2xx_mmci_write(void *opaque,
@@ -341,6 +358,7 @@ static void pxa2xx_mmci_write(void *opaque,
 {
     PXA2xxMMCIState *s = (PXA2xxMMCIState *) opaque;
 
+    trace_pxa2xx_mmci_write(size, offset, value);
     switch (offset) {
     case MMC_STRPCL:
         if (value & STRPCL_STRT_CLK) {
@@ -368,8 +386,10 @@ static void pxa2xx_mmci_write(void *opaque,
 
     case MMC_SPI:
         s->spi = value & 0xf;
-        if (value & SPI_SPI_MODE)
-            printf("%s: attempted to use card in SPI mode\n", __FUNCTION__);
+        if (value & SPI_SPI_MODE) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: attempted to use card in SPI mode\n", __func__);
+        }
         break;
 
     case MMC_CMDAT:
@@ -442,7 +462,9 @@ static void pxa2xx_mmci_write(void *opaque,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __FUNCTION__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: incorrect reg 0x%02" HWADDR_PRIx " "
+                      "(value 0x%08" PRIx64 ")\n", __func__, offset, value);
     }
 }
 
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 1fc0bcf..6eca347 100644
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
2.7.4
