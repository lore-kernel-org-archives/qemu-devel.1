Received: from eggs.gnu.org ([2001:4830:134:3::10]:60592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934R-0005Xp-LN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934Q-0005Sr-Nd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 19 Apr 2018 16:29:17 +1000
Message-Id: <20180419062917.31486-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180419062917.31486-1-david@gibson.dropbear.id.au>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 7/7] spapr_pci: Remove unhelpful
 pagesize warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

By default, the IOMMU model built into the spapr virtual PCI host bridge
supports 4kiB and 64kiB IOMMU page sizes.  However this can be overridden
which may be desirable to allow larger IOMMU page sizes when running a
guest with hugepage backing and passthrough devices.  For that reason a
warning was printed when the device wasn't configured to allow the pagesize
with which guest RAM is backed.

Experience has proven, however, that this message is more confusing than
useful.  Worse it sometimes makes little sense when the host-available page
sizes don't match those available on the guest, which can happen with
a POWER8 guest running on a POWER9 KVM host.

Long term we do want better handling to allow large IOMMU page sizes to be
used, but for now this parameter and warning don't really accomplish it.
So, remove the message, pending a better solution.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39a14980d3..f936ce63ef 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1717,13 +1717,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     /* DMA setup */
-    if (((sphb->page_size_mask & qemu_getrampagesize()) == 0)
-        && kvm_enabled()) {
-        warn_report("System page size 0x%lx is not enabled in page_size_mask "
-                    "(0x%"PRIx64"). Performance may be slow",
-                    qemu_getrampagesize(), sphb->page_size_mask);
-    }
-
     for (i = 0; i < windows_supported; ++i) {
         tcet = spapr_tce_new_table(DEVICE(sphb), sphb->dma_liobn[i]);
         if (!tcet) {
-- 
2.14.3
