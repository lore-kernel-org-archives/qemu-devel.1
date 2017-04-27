Received: from eggs.gnu.org ([2001:4830:134:3::10]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpX-0003fu-UW
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpT-00049t-0g
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpS-00049J-Nm
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:14 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:16 +0800
Message-Id: <1493285660-4470-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/8] memory: rename *_notify_iommu*
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

Actually it's notifying IOTLB updates (map, or unmap). Let's be explicit
on the wording - replacing it with *_notify_iotlb*.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c    |  8 ++++----
 hw/ppc/spapr_iommu.c     |  2 +-
 hw/s390x/s390-pci-inst.c |  2 +-
 include/exec/memory.h    | 12 ++++++------
 memory.c                 |  8 ++++----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3306e6a..609732b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1205,7 +1205,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
                                            void *private)
 {
-    memory_region_notify_iommu((MemoryRegion *)private, *entry);
+    memory_region_notify_iotlb((MemoryRegion *)private, *entry);
     return 0;
 }
 
@@ -1709,7 +1709,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
     entry.translated_addr = 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, entry);
+    memory_region_notify_iotlb(&vtd_dev_as->iommu, entry);
 
 done:
     return true;
@@ -2752,7 +2752,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUMRNotifier *n)
                              VTD_PCI_FUNC(as->devfn),
                              entry.iova, size);
 
-    memory_region_notify_one(n, &entry);
+    memory_region_notify_iotlb_one(n, &entry);
 }
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
@@ -2771,7 +2771,7 @@ static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
-    memory_region_notify_one((IOMMUMRNotifier *)private, entry);
+    memory_region_notify_iotlb_one((IOMMUMRNotifier *)private, entry);
     return 0;
 }
 
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5e6e70b..9a34495 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -414,7 +414,7 @@ static target_ulong put_tce_emu(sPAPRTCETable *tcet, target_ulong ioba,
     entry.translated_addr = tce & page_mask;
     entry.addr_mask = ~page_mask;
     entry.perm = spapr_tce_iommu_access_flags(tce);
-    memory_region_notify_iommu(&tcet->iommu, entry);
+    memory_region_notify_iotlb(&tcet->iommu, entry);
 
     return H_SUCCESS;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 314a9cb..566eeda 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -635,7 +635,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             goto out;
         }
 
-        memory_region_notify_iommu(mr, entry);
+        memory_region_notify_iotlb(mr, entry);
         start += entry.addr_mask + 1;
     }
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8d8dcb2..09188a6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -673,7 +673,7 @@ static inline bool memory_region_is_iommu(MemoryRegion *mr)
 uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
 
 /**
- * memory_region_notify_iommu: notify a change in an IOMMU translation entry.
+ * memory_region_notify_iotlb: notify a change in an IOMMU translation entry.
  *
  * The notification type will be decided by entry.perm bits:
  *
@@ -689,12 +689,12 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
-void memory_region_notify_iommu(MemoryRegion *mr,
+void memory_region_notify_iotlb(MemoryRegion *mr,
                                 IOMMUTLBEntry entry);
 
 /**
- * memory_region_notify_one: notify a change in an IOMMU translation
- *                           entry to a single notifier
+ * memory_region_notify_iotlb_one: notify a change in an IOMMU translation
+ *                                 entry to a single notifier
  *
  * This works just like memory_region_notify_iommu(), but it only
  * notifies a specific notifier, not all of them.
@@ -704,8 +704,8 @@ void memory_region_notify_iommu(MemoryRegion *mr,
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
-void memory_region_notify_one(IOMMUMRNotifier *notifier,
-                              IOMMUTLBEntry *entry);
+void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
+                                    IOMMUTLBEntry *entry);
 
 /**
  * memory_region_register_iommu_notifier: register a notifier for changes to
diff --git a/memory.c b/memory.c
index ffbd020..c6532e4 100644
--- a/memory.c
+++ b/memory.c
@@ -1668,8 +1668,8 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(mr);
 }
 
-void memory_region_notify_one(IOMMUMRNotifier *notifier,
-                              IOMMUTLBEntry *entry)
+void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
+                                    IOMMUTLBEntry *entry)
 {
     IOMMUMREventFlags request_flags;
 
@@ -1693,7 +1693,7 @@ void memory_region_notify_one(IOMMUMRNotifier *notifier,
     }
 }
 
-void memory_region_notify_iommu(MemoryRegion *mr,
+void memory_region_notify_iotlb(MemoryRegion *mr,
                                 IOMMUTLBEntry entry)
 {
     IOMMUMRNotifier *iommu_notifier;
@@ -1701,7 +1701,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
     assert(memory_region_is_iommu(mr));
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
-        memory_region_notify_one(iommu_notifier, &entry);
+        memory_region_notify_iotlb_one(iommu_notifier, &entry);
     }
 }
 
-- 
2.7.4
