Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fq2-00043p-JN
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpy-0004Tg-K7
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpy-0004TC-EK
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:46 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:19 +0800
Message-Id: <1493285660-4470-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 7/8] intel_iommu: provide
 AddressSpaceOps.iommu_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Then it'll be the first one to support address_space_iommu_get() API.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 609732b..5131329 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2632,6 +2632,12 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
+static IOMMUObject *vtd_as_iommu_get(AddressSpace *as)
+{
+    VTDAddressSpace *vtd_dev_as = container_of(as, VTDAddressSpace, as);
+    return (IOMMUObject *)vtd_dev_as->iommu_state;
+}
+
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 {
     uintptr_t key = (uintptr_t)bus;
@@ -2692,6 +2698,9 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
                                             VTD_INTERRUPT_ADDR_FIRST,
                                             &vtd_dev_as->iommu_ir, 64);
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
+
+        vtd_dev_as->as.as_ops.iommu_get = vtd_as_iommu_get;
+
         memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
                                             &vtd_dev_as->sys_alias, 1);
         memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
-- 
2.7.4
