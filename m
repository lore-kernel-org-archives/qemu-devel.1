Received: from eggs.gnu.org ([209.51.188.92]:44953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwG-0007oA-4j
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgr-0005L0-8k
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
Received: from m12-12.163.com ([220.181.12.12]:59099)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgq-0005KQ-N3
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:01 -0400
From: Li Qiang <liq3ea@163.com>
Date: Mon, 22 Apr 2019 07:11:56 -0700
Message-Id: <20190422141156.15746-4-liq3ea@163.com>
In-Reply-To: <20190422141156.15746-1-liq3ea@163.com>
References: <20190422141156.15746-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v3 3/3] edu: uses uint64_t in dma operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jslaby@suse.cz, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, philmd@redhat.com, Li Qiang <liq3ea@163.com>

The dma related variable dma.dst/src/cnt is dma_addr_t, it is
uint64_t in x64 platform. Change these usage from uint32_to
uint64_t to avoid trancation in edu_dma_timer.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
---
 hw/misc/edu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 33de05141f..401ada74af 100644
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
