Received: from eggs.gnu.org ([2001:4830:134:3::10]:43888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wm-0002U4-D5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wl-0006SX-1w
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:20 +0100
Message-Id: <20180209092524.31348-26-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 25/29] s390x/pci: fixup global refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

The VFIO common code doesn't provide the possibility to modify a
previous mapping entry in another way than unmapping and mapping again
with new properties.

To avoid -EEXIST DMA mapping error, we introduce a GHashTable to store
S390IOTLBEntry instances in order to cache the mapped entries. When
intercepting rpcit instruction, ignore the identical mapped entries to
avoid doing map operations multiple times and do unmap and re-map
operations for the case of updating the valid entries.

Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <20180205072258.5968-3-zyimin@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c  | 24 +++++++++++++++-------
 hw/s390x/s390-pci-bus.h  |  1 +
 hw/s390x/s390-pci-inst.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e7ef7d28d9..77a50cab36 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -487,7 +487,8 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
                                           IOMMUAccessFlags flag)
 {
     S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
-    S390IOTLBEntry entry;
+    S390IOTLBEntry *entry;
+    uint64_t iova = addr & PAGE_MASK;
     uint16_t error = 0;
     IOMMUTLBEntry ret = {
         .target_as = &address_space_memory,
@@ -515,12 +516,17 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         goto err;
     }
 
-    error = s390_guest_io_table_walk(iommu->g_iota, addr, &entry);
-
-    ret.iova = entry.iova;
-    ret.translated_addr = entry.translated_addr;
-    ret.addr_mask = entry.len - 1;
-    ret.perm = entry.perm;
+    entry = g_hash_table_lookup(iommu->iotlb, &iova);
+    if (entry) {
+        ret.iova = entry->iova;
+        ret.translated_addr = entry->translated_addr;
+        ret.addr_mask = entry->len - 1;
+        ret.perm = entry->perm;
+    } else {
+        ret.iova = iova;
+        ret.addr_mask = ~PAGE_MASK;
+        ret.perm = IOMMU_NONE;
+    }
 
     if (flag != IOMMU_NONE && !(flag & ret.perm)) {
         error = ERR_EVENT_TPROTE;
@@ -572,6 +578,8 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         PCI_FUNC(devfn));
         memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
         address_space_init(&iommu->as, &iommu->mr, as_name);
+        iommu->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                             NULL, g_free);
         table->iommu[PCI_SLOT(devfn)] = iommu;
 
         g_free(mr_name);
@@ -661,6 +669,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
+    g_hash_table_remove_all(iommu->iotlb);
     memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
     object_unparent(OBJECT(&iommu->iommu_mr));
 }
@@ -676,6 +685,7 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     }
 
     table->iommu[PCI_SLOT(devfn)] = NULL;
+    g_hash_table_destroy(iommu->iotlb);
     address_space_destroy(&iommu->as);
     object_unparent(OBJECT(&iommu->mr));
     object_unparent(OBJECT(iommu));
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 7ed577c806..1f7f9b5814 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -278,6 +278,7 @@ typedef struct S390PCIIOMMU {
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
+    GHashTable *iotlb;
 } S390PCIIOMMU;
 
 typedef struct S390PCIIOMMUTable {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 1d33a89351..997a9cc2e9 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -571,6 +571,45 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     return 0;
 }
 
+static void s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry)
+{
+    S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
+    IOMMUTLBEntry notify = {
+        .target_as = &address_space_memory,
+        .iova = entry->iova,
+        .translated_addr = entry->translated_addr,
+        .perm = entry->perm,
+        .addr_mask = ~PAGE_MASK,
+    };
+
+    if (entry->perm == IOMMU_NONE) {
+        if (!cache) {
+            return;
+        }
+        g_hash_table_remove(iommu->iotlb, &entry->iova);
+    } else {
+        if (cache) {
+            if (cache->perm == entry->perm &&
+                cache->translated_addr == entry->translated_addr) {
+                return;
+            }
+
+            notify.perm = IOMMU_NONE;
+            memory_region_notify_iommu(&iommu->iommu_mr, notify);
+            notify.perm = entry->perm;
+        }
+
+        cache = g_new(S390IOTLBEntry, 1);
+        cache->iova = entry->iova;
+        cache->translated_addr = entry->translated_addr;
+        cache->len = PAGE_SIZE;
+        cache->perm = entry->perm;
+        g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
+    }
+
+    memory_region_notify_iommu(&iommu->iommu_mr, notify);
+}
+
 int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
@@ -580,7 +619,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     S390PCIIOMMU *iommu;
     S390IOTLBEntry entry;
     hwaddr start, end;
-    IOMMUTLBEntry notify;
 
     cpu_synchronize_state(CPU(cpu));
 
@@ -636,15 +674,14 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         if (error) {
             break;
         }
-        notify.target_as = &address_space_memory;
-        notify.iova = entry.iova;
-        notify.translated_addr = entry.translated_addr;
-        notify.addr_mask = entry.len - 1;
-        notify.perm = entry.perm;
-        memory_region_notify_iommu(&iommu->iommu_mr, notify);
+
         start += entry.len;
+        while (entry.iova < start && entry.iova < end) {
+            s390_pci_update_iotlb(iommu, &entry);
+            entry.iova += PAGE_SIZE;
+            entry.translated_addr += PAGE_SIZE;
+        }
     }
-
 err:
     if (error) {
         pbdev->state = ZPCI_FS_ERROR;
-- 
2.13.6
