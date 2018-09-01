Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6py-0005sK-GH
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6pC-000654-Ki
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:24:31 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:23:10 +0200
Message-Id: <20180901142312.11662-19-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 18/20] target/arm/kvm: Notifies IOMMU on MSI
 stage 1 binding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

When the MSI route is setup, we know the MSI IOVA and
the doorbell GPA . At that point we can communicate this guest
stage 1 binding to the host. Then the host will be able
to construct a stage 2 binding taking as input address the
doorbell GPA.

We also directly use the iommu memory region translate() callback
as the addr_mask is returned in IOTLB entry. address_space_translate
does not return this information.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

TODO: access to as->root field may be cleaned later on
---
 target/arm/kvm.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 65f867d569..6f905215b8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -661,41 +661,35 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
     AddressSpace *as = pci_device_iommu_address_space(dev);
-    hwaddr xlat, len, doorbell_gpa;
-    MemoryRegionSection mrs;
-    MemoryRegion *mr;
-    int ret = 1;
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUMemoryRegion *iommu_mr;
+    IOMMUTLBEntry entry;
 
     if (as == &address_space_memory) {
         return 0;
     }
 
+    iommu_mr = IOMMU_MEMORY_REGION(as->root);
+    imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+
     /* MSI doorbell address is translated by an IOMMU */
 
     rcu_read_lock();
-    mr = address_space_translate(as, address, &xlat, &len, true,
-                                 MEMTXATTRS_UNSPECIFIED);
-    if (!mr) {
-        goto unlock;
-    }
-    mrs = memory_region_find(mr, xlat, 1);
-    if (!mrs.mr) {
-        goto unlock;
-    }
-
-    doorbell_gpa = mrs.offset_within_address_space;
-    memory_region_unref(mrs.mr);
-
-    route->u.msi.address_lo = doorbell_gpa;
-    route->u.msi.address_hi = doorbell_gpa >> 32;
-
-    trace_kvm_arm_fixup_msi_route(address, doorbell_gpa);
-
-    ret = 0;
-
-unlock:
+    entry = imrc->translate(iommu_mr, address, IOMMU_WO, 0);
     rcu_read_unlock();
-    return ret;
+
+    if (entry.perm == IOMMU_NONE) {
+        return -ENOENT;
+    }
+
+    route->u.msi.address_lo = entry.translated_addr;
+    route->u.msi.address_hi = entry.translated_addr >> 32;
+
+    memory_region_iotlb_notify_iommu(iommu_mr, 0, entry);
+
+    trace_kvm_arm_fixup_msi_route(address, entry.translated_addr);
+
+    return 0;
 }
 
 int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
-- 
2.17.1
