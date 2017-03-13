Received: from eggs.gnu.org ([2001:4830:134:3::10]:42999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4f-0000jX-Q5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4e-0002Xe-Tx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4e-0002Wh-NQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9371BC0546E4
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:32 -0500
Message-Id: <20170313195547.21466-16-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/30] trace: Fix parameter types in hw/dma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/dma/trace-events | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 22878df..88dae95 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -14,16 +14,16 @@ sparc32_dma_set_irq_lower(void) "Lower IRQ"
 espdma_memory_read(uint32_t addr) "DMA read addr 0x%08x"
 espdma_memory_write(uint32_t addr) "DMA write addr 0x%08x"
 sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg %"PRIx64": 0x%08x"
-sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg %"PRIx64": 0x%08x -> 0x%08x"
+sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint64_t val) "write dmareg %"PRIx64": 0x%08x -> 0x%08" PRIx64
 sparc32_dma_enable_raise(void) "Raise DMA enable"
 sparc32_dma_enable_lower(void) "Lower DMA enable"

 # hw/dma/sun4m_iommu.c
 sun4m_iommu_mem_readl(uint64_t addr, uint32_t ret) "read reg[%"PRIx64"] = %x"
-sun4m_iommu_mem_writel(uint64_t addr, uint32_t val) "write reg[%"PRIx64"] = %x"
+sun4m_iommu_mem_writel(uint64_t addr, uint64_t val) "write reg[%"PRIx64"] = %" PRIx64
 sun4m_iommu_mem_writel_ctrl(uint64_t iostart) "iostart = %"PRIx64
-sun4m_iommu_mem_writel_tlbflush(uint32_t val) "tlb flush %x"
-sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush %x"
+sun4m_iommu_mem_writel_tlbflush(uint64_t val) "tlb flush %" PRIx64
+sun4m_iommu_mem_writel_pgflush(uint64_t val) "page flush %" PRIx64
 sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get flags addr %"PRIx64" => pte %"PRIx64", *pte = %x"
 sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlate dva %"PRIx64" => pa %"PRIx64" iopte = %x"
 sun4m_iommu_bad_addr(uint64_t addr) "bad addr %"PRIx64
-- 
2.9.3
