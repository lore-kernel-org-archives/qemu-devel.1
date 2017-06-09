Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJJag-0004H9-1f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJJaf-0003yP-6v
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJJaf-0003y9-0u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12DA5C057FA4
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:04:36 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 21:04:12 +0800
Message-Id: <1497013453-13688-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1497013453-13688-1-git-send-email-peterx@redhat.com>
References: <1497013453-13688-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] intel_iommu: cleanup vtd_iommu_translate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

So even with PT we'll get a log now. Also, remove useless assignments.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c818dd4..f94fc4e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2253,25 +2253,21 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
     IOMMUTLBEntry ret = {
+        /* We'll fill in the rest later. */
         .target_as = &address_space_memory,
-        .iova = addr,
-        .translated_addr = 0,
-        .addr_mask = ~(hwaddr)0,
-        .perm = IOMMU_NONE,
     };
 
-    if (!s->dmar_enabled) {
+    if (likely(s->dmar_enabled)) {
+        vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
+                               flag & IOMMU_WO, &ret);
+    } else {
         /* DMAR disabled, passthrough, use 4k-page*/
         ret.iova = addr & VTD_PAGE_MASK_4K;
         ret.translated_addr = addr & VTD_PAGE_MASK_4K;
         ret.addr_mask = ~VTD_PAGE_MASK_4K;
         ret.perm = IOMMU_RW;
-        return ret;
     }
 
-    vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
-                           flag & IOMMU_WO, &ret);
-
     trace_vtd_dmar_translate(pci_bus_num(vtd_as->bus),
                              VTD_PCI_SLOT(vtd_as->devfn),
                              VTD_PCI_FUNC(vtd_as->devfn),
-- 
2.7.4
