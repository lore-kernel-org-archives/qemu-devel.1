Received: from eggs.gnu.org ([2001:4830:134:3::10]:50148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVm-0001uo-Q5
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVj-00036Z-KE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1egSVj-00036C-As
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:27 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0U9hh3g127529
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:25 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftkcyqrd1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:25 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 30 Jan 2018 04:47:24 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 30 Jan 2018 10:47:14 +0100
In-Reply-To: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
Message-Id: <20180130094715.11578-3-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] s390x/pci: fixup global refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, marcel@redhat.com, zyimin@linux.vnet.ibm.com

The VFIO common code doesn't provide the possibility to modify a
previous mapping entry in another way than unmapping and mapping again
with new properties.

To avoid -EEXIST DMA mapping error, this we introduce a GHashTable to
store S390IOTLBEntry instances in order to cache the mapped entries.
When intercepting rpcit instruction, ignore the identical mapped
entries to avoid doing map operations multiple times and do unmap and
re-map operations for the case of updating the valid entries. To
achieve that goal, we also export the DMA walking function and
optimize the code handling errors in rpcit handler.

Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 28 +++++++++-----
 hw/s390x/s390-pci-bus.h  |  3 ++
 hw/s390x/s390-pci-inst.c | 95 ++++++++++++++++++++++++++++++++++--------------
 3 files changed, 90 insertions(+), 36 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e349d73abe..b75af26db7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -461,8 +461,8 @@ out:
     return nto;
 }
 
-static uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
-                                         S390IOTLBEntry *entry)
+uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
+                                  S390IOTLBEntry *entry)
 {
     uint64_t to = s390_pci_get_table_origin(g_iota);
     int8_t ett = 1;
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
 
     if ((flag != IOMMU_NONE) && !(flag & ret.perm)) {
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
index ca22ef393b..395bbf0e13 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -274,6 +274,7 @@ typedef struct S390PCIIOMMU {
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
+    GHashTable *iotlb;
 } S390PCIIOMMU;
 
 typedef struct S390PCIIOMMUTable {
@@ -330,6 +331,8 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
+uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
+                                  S390IOTLBEntry *entry);
 S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx);
 S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 63fa06fb97..997a9cc2e9 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -571,27 +571,65 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
     uint32_t fh;
+    uint16_t error = 0;
     S390PCIBusDevice *pbdev;
     S390PCIIOMMU *iommu;
+    S390IOTLBEntry entry;
     hwaddr start, end;
-    IOMMUTLBEntry entry;
-    IOMMUMemoryRegion *iommu_mr;
-    IOMMUMemoryRegionClass *imrc;
 
     cpu_synchronize_state(CPU(cpu));
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
-        goto out;
+        return 0;
     }
 
     if (r2 & 0x1) {
         s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
-        goto out;
+        return 0;
     }
 
     fh = env->regs[r1] >> 32;
@@ -602,7 +640,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     if (!pbdev) {
         DPRINTF("rpcit no pci dev\n");
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
-        goto out;
+        return 0;
     }
 
     switch (pbdev->state) {
@@ -622,34 +660,37 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
     iommu = pbdev->iommu;
     if (!iommu->g_iota) {
-        pbdev->state = ZPCI_FS_ERROR;
-        setcc(cpu, ZPCI_PCI_LS_ERR);
-        s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
-        s390_pci_generate_error_event(ERR_EVENT_INVALAS, pbdev->fh, pbdev->fid,
-                                      start, 0);
-        goto out;
+        error = ERR_EVENT_INVALAS;
+        goto err;
     }
 
     if (end < iommu->pba || start > iommu->pal) {
-        pbdev->state = ZPCI_FS_ERROR;
-        setcc(cpu, ZPCI_PCI_LS_ERR);
-        s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
-        s390_pci_generate_error_event(ERR_EVENT_OORANGE, pbdev->fh, pbdev->fid,
-                                      start, 0);
-        goto out;
+        error = ERR_EVENT_OORANGE;
+        goto err;
     }
 
-    iommu_mr = &iommu->iommu_mr;
-    imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
-
     while (start < end) {
-        entry = imrc->translate(iommu_mr, start, IOMMU_NONE);
-        memory_region_notify_iommu(iommu_mr, entry);
-        start += entry.addr_mask + 1;
-    }
+        error = s390_guest_io_table_walk(iommu->g_iota, start, &entry);
+        if (error) {
+            break;
+        }
 
-    setcc(cpu, ZPCI_PCI_LS_OK);
-out:
+        start += entry.len;
+        while (entry.iova < start && entry.iova < end) {
+            s390_pci_update_iotlb(iommu, &entry);
+            entry.iova += PAGE_SIZE;
+            entry.translated_addr += PAGE_SIZE;
+        }
+    }
+err:
+    if (error) {
+        pbdev->state = ZPCI_FS_ERROR;
+        setcc(cpu, ZPCI_PCI_LS_ERR);
+        s390_set_status_code(env, r1, ZPCI_PCI_ST_FUNC_IN_ERR);
+        s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
+    } else {
+        setcc(cpu, ZPCI_PCI_LS_OK);
+    }
     return 0;
 }
 
-- 
2.14.3 (Apple Git-98)
