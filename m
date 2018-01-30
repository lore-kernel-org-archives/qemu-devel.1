Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVq-0001vr-Bo
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1egSVj-00036h-Vp
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57154
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1egSVj-00036V-Pj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:47:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0U9hkDD124408
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:24 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftkcxyj19-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 04:47:23 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 30 Jan 2018 04:47:23 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 30 Jan 2018 10:47:13 +0100
In-Reply-To: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
Message-Id: <20180130094715.11578-2-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] s390x/pci: fixup the code walking IOMMU
 tables
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

Current s390x PCI IOMMU code is lack of flags' checking, including:
1) protection bit
2) table length
3) table offset
4) intermediate tables' invalid bit
5) format control bit

This patch introduces a new struct named S390IOTLBEntry, and makes up
these missed checkings. At the same time, inform the guest with the
corresponding error number when the check fails.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 223 ++++++++++++++++++++++++++++++++++++++---------
 hw/s390x/s390-pci-bus.h  |  10 +++
 hw/s390x/s390-pci-inst.c |  10 ---
 3 files changed, 190 insertions(+), 53 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2b1e1409bf..e349d73abe 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -309,49 +309,186 @@ static uint64_t get_st_pto(uint64_t entry)
             : 0;
 }
 
-static uint64_t s390_guest_io_table_walk(uint64_t guest_iota,
-                                  uint64_t guest_dma_address)
+static bool rt_entry_isvalid(uint64_t entry)
 {
-    uint64_t sto_a, pto_a, px_a;
-    uint64_t sto, pto, pte;
-    uint32_t rtx, sx, px;
-
-    rtx = calc_rtx(guest_dma_address);
-    sx = calc_sx(guest_dma_address);
-    px = calc_px(guest_dma_address);
-
-    sto_a = guest_iota + rtx * sizeof(uint64_t);
-    sto = address_space_ldq(&address_space_memory, sto_a,
-                            MEMTXATTRS_UNSPECIFIED, NULL);
-    sto = get_rt_sto(sto);
-    if (!sto) {
-        pte = 0;
+    return (entry & ZPCI_TABLE_VALID_MASK) == ZPCI_TABLE_VALID;
+}
+
+static bool pt_entry_isvalid(uint64_t entry)
+{
+    return (entry & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID;
+}
+
+static bool entry_isprotected(uint64_t entry)
+{
+    return (entry & ZPCI_TABLE_PROT_MASK) == ZPCI_TABLE_PROTECTED;
+}
+
+/* ett is expected table type, -1 page table, 0 segment table, 1 region table */
+static uint64_t get_table_index(uint64_t iova, int8_t ett)
+{
+    switch (ett) {
+    case -1:
+        return calc_px(iova);
+    case 0:
+        return calc_sx(iova);
+    case 1:
+        return calc_rtx(iova);
+    }
+
+    return -1;
+}
+
+static bool entry_isvalid(uint64_t entry, int8_t ett)
+{
+    switch (ett) {
+    case -1:
+        return pt_entry_isvalid(entry);
+    case 0:
+    case 1:
+        return rt_entry_isvalid(entry);
+    }
+
+    return false;
+}
+
+/* Return true if address translation is done */
+static bool translate_iscomplete(uint64_t entry, int8_t ett)
+{
+    switch (ett) {
+    case 0:
+        return (entry & ZPCI_TABLE_FC) ? true : false;
+    case 1:
+        return false;
+    }
+
+    return true;
+}
+
+static uint64_t get_frame_size(int8_t ett)
+{
+    switch (ett) {
+    case -1:
+        return 1ULL << 12;
+    case 0:
+        return 1ULL << 20;
+    case 1:
+        return 1ULL << 31;
+    }
+
+    return 0;
+}
+
+static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
+{
+    switch (ett) {
+    case -1:
+        return entry & ZPCI_PTE_ADDR_MASK;
+    case 0:
+        return get_st_pto(entry);
+    case 1:
+        return get_rt_sto(entry);
+    }
+
+    return 0;
+}
+
+/**
+ * table_translate: do translation within one table and return the following
+ *                  table origin
+ *
+ * @entry: the entry being traslated, the result is stored in this.
+ * @to: the address of table origin.
+ * @ett: expected table type, 1 region table, 0 segment table and -1 page table.
+ * @error: error code
+ */
+static uint64_t table_translate(S390IOTLBEntry *entry, uint64_t to, int8_t ett,
+                                uint16_t *error)
+{
+    uint64_t tx, te, nto = 0;
+    uint16_t err = 0;
+
+    tx = get_table_index(entry->iova, ett);
+    te = address_space_ldq(&address_space_memory, to + tx * sizeof(uint64_t),
+                           MEMTXATTRS_UNSPECIFIED, NULL);
+
+    if (!te) {
+        err = ERR_EVENT_INVALTE;
         goto out;
     }
 
-    pto_a = sto + sx * sizeof(uint64_t);
-    pto = address_space_ldq(&address_space_memory, pto_a,
-                            MEMTXATTRS_UNSPECIFIED, NULL);
-    pto = get_st_pto(pto);
-    if (!pto) {
-        pte = 0;
+    if (!entry_isvalid(te, ett)) {
+        entry->perm &= IOMMU_NONE;
         goto out;
     }
 
-    px_a = pto + px * sizeof(uint64_t);
-    pte = address_space_ldq(&address_space_memory, px_a,
-                            MEMTXATTRS_UNSPECIFIED, NULL);
+    if (ett == 1 && ((te & ZPCI_TABLE_LEN_RTX) != ZPCI_TABLE_LEN_RTX ||
+                     te & ZPCI_TABLE_OFFSET_MASK)) {
+        err = ERR_EVENT_INVALTL;
+        goto out;
+    }
 
+    nto = get_next_table_origin(te, ett);
+    if (!nto) {
+        err = ERR_EVENT_TT;
+        goto out;
+    }
+
+    if (entry_isprotected(te)) {
+        entry->perm &= IOMMU_RO;
+    } else {
+        entry->perm &= IOMMU_RW;
+    }
+
+    if (translate_iscomplete(te, ett)) {
+        switch (ett) {
+        case -1:
+            entry->translated_addr = te & ZPCI_PTE_ADDR_MASK;
+            break;
+        case 0:
+            entry->translated_addr = (te & ZPCI_SFAA_MASK) |
+                (entry->iova & ~ZPCI_SFAA_MASK);
+            break;
+        }
+        nto = 0;
+    }
 out:
-    return pte;
+    if (err) {
+        entry->perm = IOMMU_NONE;
+        *error = err;
+    }
+    entry->len = get_frame_size(ett);
+    return nto;
+}
+
+static uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
+                                         S390IOTLBEntry *entry)
+{
+    uint64_t to = s390_pci_get_table_origin(g_iota);
+    int8_t ett = 1;
+    uint16_t error = 0;
+
+    entry->iova = addr & PAGE_MASK;
+    entry->translated_addr = 0;
+    entry->perm = IOMMU_RW;
+
+    if (entry_isprotected(g_iota)) {
+        entry->perm &= IOMMU_RO;
+    }
+
+    while (to) {
+        to = table_translate(entry, to, ett--, &error);
+    }
+
+    return error;
 }
 
 static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
                                           IOMMUAccessFlags flag)
 {
-    uint64_t pte;
-    uint32_t flags;
     S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
+    S390IOTLBEntry entry;
+    uint16_t error = 0;
     IOMMUTLBEntry ret = {
         .target_as = &address_space_memory,
         .iova = 0,
@@ -374,26 +511,26 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     DPRINTF("iommu trans addr 0x%" PRIx64 "\n", addr);
 
     if (addr < iommu->pba || addr > iommu->pal) {
-        return ret;
+        error = ERR_EVENT_OORANGE;
+        goto err;
     }
 
-    pte = s390_guest_io_table_walk(s390_pci_get_table_origin(iommu->g_iota),
-                                   addr);
-    if (!pte) {
-        return ret;
-    }
+    error = s390_guest_io_table_walk(iommu->g_iota, addr, &entry);
 
-    flags = pte & ZPCI_PTE_FLAG_MASK;
-    ret.iova = addr;
-    ret.translated_addr = pte & ZPCI_PTE_ADDR_MASK;
-    ret.addr_mask = 0xfff;
+    ret.iova = entry.iova;
+    ret.translated_addr = entry.translated_addr;
+    ret.addr_mask = entry.len - 1;
+    ret.perm = entry.perm;
 
-    if (flags & ZPCI_PTE_INVALID) {
-        ret.perm = IOMMU_NONE;
-    } else {
-        ret.perm = IOMMU_RW;
+    if ((flag != IOMMU_NONE) && !(flag & ret.perm)) {
+        error = ERR_EVENT_TPROTE;
+    }
+err:
+    if (error) {
+        iommu->pbdev->state = ZPCI_FS_ERROR;
+        s390_pci_generate_error_event(error, iommu->pbdev->fh,
+                                      iommu->pbdev->fid, addr, 0);
     }
-
     return ret;
 }
 
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 2993f0ddef..ca22ef393b 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -148,6 +148,8 @@ enum ZpciIoatDtype {
 #define ZPCI_STE_FLAG_MASK      0x7ffULL
 #define ZPCI_STE_ADDR_MASK      (~ZPCI_STE_FLAG_MASK)
 
+#define ZPCI_SFAA_MASK          (~((1ULL << 20) - 1))
+
 /* I/O Page tables */
 #define ZPCI_PTE_VALID_MASK             0x400
 #define ZPCI_PTE_INVALID                0x400
@@ -165,6 +167,7 @@ enum ZpciIoatDtype {
 #define ZPCI_TABLE_INVALID              0x20
 #define ZPCI_TABLE_PROTECTED            0x200
 #define ZPCI_TABLE_UNPROTECTED          0x000
+#define ZPCI_TABLE_FC                   0x400
 
 #define ZPCI_TABLE_VALID_MASK           0x20
 #define ZPCI_TABLE_PROT_MASK            0x200
@@ -253,6 +256,13 @@ typedef struct S390MsixInfo {
     uint32_t pba_offset;
 } S390MsixInfo;
 
+typedef struct S390IOTLBEntry {
+    uint64_t iova;
+    uint64_t translated_addr;
+    uint64_t len;
+    uint64_t perm;
+} S390IOTLBEntry;
+
 typedef struct S390PCIBusDevice S390PCIBusDevice;
 typedef struct S390PCIIOMMU {
     Object parent_obj;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index be449210d9..63fa06fb97 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -644,16 +644,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
     while (start < end) {
         entry = imrc->translate(iommu_mr, start, IOMMU_NONE);
-
-        if (!entry.translated_addr) {
-            pbdev->state = ZPCI_FS_ERROR;
-            setcc(cpu, ZPCI_PCI_LS_ERR);
-            s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
-            s390_pci_generate_error_event(ERR_EVENT_SERR, pbdev->fh, pbdev->fid,
-                                          start, ERR_EVENT_Q_BIT);
-            goto out;
-        }
-
         memory_region_notify_iommu(iommu_mr, entry);
         start += entry.addr_mask + 1;
     }
-- 
2.14.3 (Apple Git-98)
