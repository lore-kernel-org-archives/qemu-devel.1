Received: from eggs.gnu.org ([2001:4830:134:3::10]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cJvqD-0002vm-Jb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 00:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cJvqC-00016y-RG
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 00:22:57 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 22 Dec 2016 16:22:12 +1100
Message-Id: <20161222052212.49006-3-aik@ozlabs.ru>
In-Reply-To: <20161222052212.49006-1-aik@ozlabs.ru>
References: <20161222052212.49006-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 2/2] spapr_pci: Advertise 16M IOMMU pages
 when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On sPAPR, IOMMU page size varies and if QEMU is running with RAM
backed with hugepages, we can advertise this to the guest so does
this patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index fd6fc1d953..09244056fc 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1505,6 +1505,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     /* DMA setup */
+    /* This allows huge pages for IOMMU when guest is backed with huge pages */
+    sphb->page_size_mask |= qemu_getrampagesize();
+
     for (i = 0; i < windows_supported; ++i) {
         tcet = spapr_tce_new_table(DEVICE(sphb), sphb->dma_liobn[i]);
         if (!tcet) {
-- 
2.11.0
