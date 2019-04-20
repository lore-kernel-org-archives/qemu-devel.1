Received: from eggs.gnu.org ([209.51.188.92]:57544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdr-0004st-5r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdo-0001vE-Az
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:02 -0400
Received: from m12-13.163.com ([220.181.12.13]:43634)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdk-0001qd-AW
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:00 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 09:14:46 -0700
Message-Id: <20190420161446.2274-4-liq3ea@163.com>
In-Reply-To: <20190420161446.2274-1-liq3ea@163.com>
References: <20190420161446.2274-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 3/3] edu: uses uint64_t in dma operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

The dma related variable is dma_addr_t, it is uint64_t in
x64 platform. Change these usage from uint32_to uint64_t to
avoid trancation.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:
Fix format compile error on Windows

 hw/misc/edu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 4018dddcb8..f4a6d5f1c5 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static bool within(uint32_t addr, uint32_t start, uint32_t end)
+static bool within(uint64_t addr, uint64_t start, uint64_t end)
 {
     return start <= addr && addr < end;
 }
 
-static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
+static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
                 uint32_t size2)
 {
-    uint32_t end1 = addr + size1;
-    uint32_t end2 = start + size2;
+    uint64_t end1 = addr + size1;
+    uint64_t end2 = start + size2;
 
     if (within(addr, start, end2) &&
             end1 > addr && within(end1, start, end2)) {
         return;
     }
 
-    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
+    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
+             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
             addr, end1 - 1, start, end2 - 1);
 }
 
@@ -139,13 +140,13 @@ static void edu_dma_timer(void *opaque)
     }
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
-        uint32_t dst = edu->dma.dst;
+        uint64_t dst = edu->dma.dst;
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
         pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
                 edu->dma_buf + dst, edu->dma.cnt);
     } else {
-        uint32_t src = edu->dma.src;
+        uint64_t src = edu->dma.src;
         edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
         src -= DMA_START;
         pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-- 
2.17.1
