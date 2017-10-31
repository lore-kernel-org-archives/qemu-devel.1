Received: from eggs.gnu.org ([2001:4830:134:3::10]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1e9P1S-00012n-Ms
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1e9P1R-0004jJ-Tx
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:53480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1e9P1R-0004cw-Iu
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:33 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Tue, 31 Oct 2017 13:07:02 +0800
Message-Id: <1509426425-23890-4-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1509426425-23890-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1509426425-23890-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 3/6] intel_iommu: provide
 AddressSpaceOps.iommu_get instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com
Cc: tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

Provide AddressSpaceOps.iommu_get() in Intel IOMMU emulator.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         | 7 +++++++
 include/hw/i386/intel_iommu.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e81c706..54343e5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2687,6 +2687,12 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
+static IOMMUObject *vtd_as_iommu_get(AddressSpace *as)
+{
+    VTDAddressSpace *vtd_dev_as = container_of(as, VTDAddressSpace, as);
+    return &vtd_dev_as->iommu_object;
+}
+
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 {
     uintptr_t key = (uintptr_t)bus;
@@ -2748,6 +2754,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
                                             VTD_INTERRUPT_ADDR_FIRST,
                                             &vtd_dev_as->iommu_ir, 64);
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
+        vtd_dev_as->as.as_ops.iommu_get = vtd_as_iommu_get;
         memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
                                             &vtd_dev_as->sys_alias, 1);
         memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index c85f9ff..a3c6d45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -27,6 +27,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
+#include "hw/core/iommu.h"
 
 #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
 #define INTEL_IOMMU_DEVICE(obj) \
@@ -90,6 +91,7 @@ struct VTDAddressSpace {
     MemoryRegion sys_alias;
     MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
     IntelIOMMUState *iommu_state;
+    IOMMUObject iommu_object;
     VTDContextCacheEntry context_cache_entry;
 };
 
-- 
1.9.1
