Received: from eggs.gnu.org ([2001:4830:134:3::10]:56029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI2-0001Ki-Fb
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI1-0003KJ-Ey
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:54 +1000
Message-Id: <20170424015927.8933-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/47] spapr_pci: Warn when RAM page size is not
 enabled in IOMMU page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

If a page size used by QEMU is not enabled in the PHB IOMMU page mask,
in-kernel acceleration of TCE handling won't be enabled and performance
might be slower than expected.

This prints a warning if system page size is not enabled. This should
print a warning if huge pages are enabled but sphb.pgsz still uses
the default value of 4K|64K.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e4..097ebdd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1771,6 +1771,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     /* DMA setup */
+    if ((sphb->page_size_mask & qemu_getrampagesize()) == 0) {
+        error_report("System page size 0x%lx is not enabled in page_size_mask "
+                     "(0x%"PRIx64"). Performance may be slow",
+                     qemu_getrampagesize(), sphb->page_size_mask);
+    }
+
     for (i = 0; i < windows_supported; ++i) {
         tcet = spapr_tce_new_table(DEVICE(sphb), sphb->dma_liobn[i]);
         if (!tcet) {
-- 
2.9.3
