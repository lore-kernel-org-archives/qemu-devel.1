Received: from eggs.gnu.org ([2001:4830:134:3::10]:44086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7c-0007Qz-OZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7Y-0000gy-NF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eib7Y-0000gE-Dp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w157JX5i016080
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 02:23:19 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxj1c1ss0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 02:23:19 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 02:23:17 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:22:56 +0800
In-Reply-To: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
References: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
Message-Id: <20180205072258.5968-2-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/3] s390x/pci: fixup the code walking IOMMU
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
corresponding error number when the check fails. Finally, in order to
get the error number, we export s390_guest_io_table_walk().

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 223 ++++++++++++++++++++++++++++++++++++++---------
 hw/s390x/s390-pci-bus.h  |  16 ++++
 hw/s390x/s390-pci-inst.c |  64 ++++++--------
 3 files changed, 225 insertions(+), 78 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7d9c65e719..e7ef7d28d9 100644
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
+    case ZPCI_ETT_PT:
+        return calc_px(iova);
+    case ZPCI_ETT_ST:
+        return calc_sx(iova);
+    case ZPCI_ETT_RT:
+        return calc_rtx(iova);
+    }
+
+    return -1;
+}
+
+static bool entry_isvalid(uint64_t entry, int8_t ett)
+{
+    switch (ett) {
+    case ZPCI_ETT_PT:
+        return pt_entry_isvalid(entry);
+    case ZPCI_ETT_ST:
+    case ZPCI_ETT_RT:
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
+    case ZPCI_ETT_PT:
+        return 1ULL << 12;
+    case ZPCI_ETT_ST:
+        return 1ULL << 20;
+    case ZPCI_ETT_RT:
+        return 1ULL << 31;
+    }
+
+    return 0;
+}
+
+static uint64_t get_next_table_origin(uint64_t entry, int8_t ett)
+{
+    switch (ett) {
+    case ZPCI_ETT_PT:
+        return entry & ZPCI_PTE_ADDR_MASK;
+    case ZPCI_ETT_ST:
+        return get_st_pto(entry);
+    case ZPCI_ETT_RT:
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
+ * @entry: the entry being translated, the result is stored in this.
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
+    if (ett == ZPCI_ETT_RT && ((te & ZPCI_TABLE_LEN_RTX) != ZPCI_TABLE_LEN_RTX
+                               || te & ZPCI_TABLE_OFFSET_MASK)) {
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
+        case ZPCI_ETT_PT:
+            entry->translated_addr = te & ZPCI_PTE_ADDR_MASK;
+            break;
+        case ZPCI_ETT_ST:
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
+uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
+                                  S390IOTLBEntry *entry)
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
+    if (flag != IOMMU_NONE && !(flag & ret.perm)) {
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
index 2993f0ddef..7ed577c806 100644
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
@@ -165,10 +167,15 @@ enum ZpciIoatDtype {
 #define ZPCI_TABLE_INVALID              0x20
 #define ZPCI_TABLE_PROTECTED            0x200
 #define ZPCI_TABLE_UNPROTECTED          0x000
+#define ZPCI_TABLE_FC                   0x400
 
 #define ZPCI_TABLE_VALID_MASK           0x20
 #define ZPCI_TABLE_PROT_MASK            0x200
 
+#define ZPCI_ETT_RT 1
+#define ZPCI_ETT_ST 0
+#define ZPCI_ETT_PT -1
+
 /* PCI Function States
  *
  * reserved: default; device has just been plugged or is in progress of being
@@ -253,6 +260,13 @@ typedef struct S390MsixInfo {
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
@@ -320,6 +334,8 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
+uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
+                                  S390IOTLBEntry *entry);
 S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx);
 S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index be449210d9..1d33a89351 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -575,23 +575,23 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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
+    IOMMUTLBEntry notify;
 
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
@@ -602,7 +602,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     if (!pbdev) {
         DPRINTF("rpcit no pci dev\n");
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
-        goto out;
+        return 0;
     }
 
     switch (pbdev->state) {
@@ -622,44 +622,38 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 
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
-
-        if (!entry.translated_addr) {
-            pbdev->state = ZPCI_FS_ERROR;
-            setcc(cpu, ZPCI_PCI_LS_ERR);
-            s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
-            s390_pci_generate_error_event(ERR_EVENT_SERR, pbdev->fh, pbdev->fid,
-                                          start, ERR_EVENT_Q_BIT);
-            goto out;
+        error = s390_guest_io_table_walk(iommu->g_iota, start, &entry);
+        if (error) {
+            break;
         }
-
-        memory_region_notify_iommu(iommu_mr, entry);
-        start += entry.addr_mask + 1;
+        notify.target_as = &address_space_memory;
+        notify.iova = entry.iova;
+        notify.translated_addr = entry.translated_addr;
+        notify.addr_mask = entry.len - 1;
+        notify.perm = entry.perm;
+        memory_region_notify_iommu(&iommu->iommu_mr, notify);
+        start += entry.len;
     }
 
-    setcc(cpu, ZPCI_PCI_LS_OK);
-out:
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
