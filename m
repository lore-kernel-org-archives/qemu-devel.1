Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfm-0001zG-S8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfl-0006Sn-DY
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfl-0006RO-2j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfj-0003s5-RX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:51 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:18 +0100
Message-Id: <20180615142521.19143-41-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/43] iommu: Add IOMMU index argument to
 notifier APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add support for multiple IOMMU indexes to the IOMMU notifier APIs.
When initializing a notifier with iommu_notifier_init(), the caller
must pass the IOMMU index that it is interested in. When a change
happens, the IOMMU implementation must pass
memory_region_notify_iommu() the IOMMU index that has changed and
that notifiers must be called for.

IOMMUs which support only a single index don't need to change.
Callers which only really support working with IOMMUs with a single
index can use the result of passing MEMTXATTRS_UNSPECIFIED to
memory_region_iommu_attrs_to_index().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180604152941.20374-3-peter.maydell@linaro.org
---
 include/exec/memory.h    | 7 ++++++-
 hw/i386/intel_iommu.c    | 6 +++---
 hw/ppc/spapr_iommu.c     | 2 +-
 hw/s390x/s390-pci-inst.c | 4 ++--
 hw/vfio/common.c         | 6 +++++-
 hw/virtio/vhost.c        | 7 ++++++-
 memory.c                 | 8 +++++++-
 7 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index fa6e98ee7be..ec75c45296e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -98,18 +98,21 @@ struct IOMMUNotifier {
     /* Notify for address space range start <= addr <= end */
     hwaddr start;
     hwaddr end;
+    int iommu_idx;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
 
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
-                                       hwaddr start, hwaddr end)
+                                       hwaddr start, hwaddr end,
+                                       int iommu_idx)
 {
     n->notify = fn;
     n->notifier_flags = flags;
     n->start = start;
     n->end = end;
+    n->iommu_idx = iommu_idx;
 }
 
 /*
@@ -1008,11 +1011,13 @@ uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr);
  * should be notified with an UNMAP followed by a MAP.
  *
  * @iommu_mr: the memory region that was changed
+ * @iommu_idx: the IOMMU index for the translation table which has changed
  * @entry: the new entry in the IOMMU translation table.  The entry
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                int iommu_idx,
                                 IOMMUTLBEntry entry);
 
 /**
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b5a09b79089..9c0b45963b5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1023,7 +1023,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
                                      void *private)
 {
-    memory_region_notify_iommu((IOMMUMemoryRegion *)private, *entry);
+    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry);
     return 0;
 }
 
@@ -1581,7 +1581,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                     .addr_mask = size - 1,
                     .perm = IOMMU_NONE,
                 };
-                memory_region_notify_iommu(&vtd_as->iommu, entry);
+                memory_region_notify_iommu(&vtd_as->iommu, 0, entry);
             }
         }
     }
@@ -2015,7 +2015,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
     entry.translated_addr = 0;
-    memory_region_notify_iommu(&vtd_dev_as->iommu, entry);
+    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
 
 done:
     return true;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index aaa6010d5c9..301708e45eb 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -428,7 +428,7 @@ static target_ulong put_tce_emu(sPAPRTCETable *tcet, target_ulong ioba,
     entry.translated_addr = tce & page_mask;
     entry.addr_mask = ~page_mask;
     entry.perm = spapr_tce_iommu_access_flags(tce);
-    memory_region_notify_iommu(&tcet->iommu, entry);
+    memory_region_notify_iommu(&tcet->iommu, 0, entry);
 
     return H_SUCCESS;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index d1a5f796783..7b61367ee31 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -589,7 +589,7 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
             }
 
             notify.perm = IOMMU_NONE;
-            memory_region_notify_iommu(&iommu->iommu_mr, notify);
+            memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
             notify.perm = entry->perm;
         }
 
@@ -601,7 +601,7 @@ static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
         g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
     }
 
-    memory_region_notify_iommu(&iommu->iommu_mr, notify);
+    memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
 }
 
 int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 8e57265edf1..fb396cf00ac 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -507,6 +507,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+        int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
@@ -523,10 +524,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
+        iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
+                                                       MEMTXATTRS_UNSPECIFIED);
         iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
                             IOMMU_NOTIFIER_ALL,
                             section->offset_within_region,
-                            int128_get64(llend));
+                            int128_get64(llend),
+                            iommu_idx);
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 96175b214d7..b129cb9dddd 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -662,6 +662,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                                          iommu_listener);
     struct vhost_iommu *iommu;
     Int128 end;
+    int iommu_idx;
+    IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -671,10 +673,13 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
     end = int128_sub(end, int128_one());
+    iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
+                                                   MEMTXATTRS_UNSPECIFIED);
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
                         IOMMU_NOTIFIER_UNMAP,
                         section->offset_within_region,
-                        int128_get64(end));
+                        int128_get64(end),
+                        iommu_idx);
     iommu->mr = section->mr;
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
diff --git a/memory.c b/memory.c
index 64f4a55d546..7aa75ff02d3 100644
--- a/memory.c
+++ b/memory.c
@@ -1799,6 +1799,9 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
     iommu_mr = IOMMU_MEMORY_REGION(mr);
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
     assert(n->start <= n->end);
+    assert(n->iommu_idx >= 0 &&
+           n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
+
     QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
     memory_region_update_iommu_notify_flags(iommu_mr);
 }
@@ -1891,6 +1894,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
 }
 
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                int iommu_idx,
                                 IOMMUTLBEntry entry)
 {
     IOMMUNotifier *iommu_notifier;
@@ -1898,7 +1902,9 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
     assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
-        memory_region_notify_one(iommu_notifier, &entry);
+        if (iommu_notifier->iommu_idx == iommu_idx) {
+            memory_region_notify_one(iommu_notifier, &entry);
+        }
     }
 }
 
-- 
2.17.1
