Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zQ-00049a-VK
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zM-0000KC-Op
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:49873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9zM-0000JB-FV
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:36 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:38 +0800
Message-Id: <1511513560-28611-6-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 5/7] intel_iommu: provide
 AddressSpaceOps.iommu_get instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

Provide AddressSpaceOps.iommu_get() in Intel IOMMU emulator.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c         | 8 ++++++++
 include/hw/i386/intel_iommu.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e81c706..23b13b3 100644
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
@@ -2747,7 +2753,9 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         memory_region_add_subregion_overlap(&vtd_dev_as->root,
                                             VTD_INTERRUPT_ADDR_FIRST,
                                             &vtd_dev_as->iommu_ir, 64);
+        iommu_object_init(&vtd_dev_as->iommu_object);
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
