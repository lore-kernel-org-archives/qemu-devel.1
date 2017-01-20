Received: from eggs.gnu.org ([2001:4830:134:3::10]:33831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVIp-0004U3-CS
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUVIk-0003cF-46
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54422
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUVIj-0003c8-UE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:16:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9DfeJ049876
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:16:05 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283c3t0307-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:16:05 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 20 Jan 2017 09:16:03 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 20 Jan 2017 10:15:45 +0100
In-Reply-To: <20170120091553.11013-1-cornelia.huck@de.ibm.com>
References: <20170120091553.11013-1-cornelia.huck@de.ibm.com>
Message-Id: <20170120091553.11013-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL v2 04/12] s390x/pci: make S390PCIIOMMU inherit
 Object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Currently S390PCIIOMMU is a normal struct. Let's make it inherit Object
in order to take advantage of QOM. In addition, we move some stuff
related to IOMMU from S390PCIBusDevice to S390PCIIOMMU.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 52 +++++++++++++++++++++++++++++-------------------
 hw/s390x/s390-pci-bus.h  | 20 ++++++++++++-------
 hw/s390x/s390-pci-inst.c | 50 ++++++++++++++++++++++++----------------------
 hw/s390x/s390-pci-inst.h |  2 +-
 4 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 63f6248f1d..11244fc93c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -187,8 +187,8 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
         if (pbdev->summary_ind) {
             pci_dereg_irqs(pbdev);
         }
-        if (pbdev->iommu_enabled) {
-            pci_dereg_ioat(pbdev);
+        if (pbdev->iommu->enabled) {
+            pci_dereg_ioat(pbdev->iommu);
         }
         pbdev->state = ZPCI_FS_STANDBY;
         rc = SCLP_RC_NORMAL_COMPLETION;
@@ -377,12 +377,12 @@ out:
     return pte;
 }
 
-static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *iommu, hwaddr addr,
+static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *mr, hwaddr addr,
                                           bool is_write)
 {
     uint64_t pte;
     uint32_t flags;
-    S390PCIBusDevice *pbdev = container_of(iommu, S390PCIBusDevice, iommu_mr);
+    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
     IOMMUTLBEntry ret = {
         .target_as = &address_space_memory,
         .iova = 0,
@@ -391,10 +391,10 @@ static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *iommu, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    switch (pbdev->state) {
+    switch (iommu->pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
-        if (!pbdev->iommu_enabled) {
+        if (!iommu->enabled) {
             return ret;
         }
         break;
@@ -404,11 +404,11 @@ static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *iommu, hwaddr addr,
 
     DPRINTF("iommu trans addr 0x%" PRIx64 "\n", addr);
 
-    if (addr < pbdev->pba || addr > pbdev->pal) {
+    if (addr < iommu->pba || addr > iommu->pal) {
         return ret;
     }
 
-    pte = s390_guest_io_table_walk(s390_pci_get_table_origin(pbdev->g_iota),
+    pte = s390_guest_io_table_walk(s390_pci_get_table_origin(iommu->g_iota),
                                    addr);
     if (!pte) {
         return ret;
@@ -503,19 +503,21 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
+void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
 {
-    memory_region_init_iommu(&pbdev->iommu_mr, OBJECT(&pbdev->iommu->mr),
-                             &s390_iommu_ops, "iommu-s390", pbdev->pal + 1);
-    memory_region_add_subregion(&pbdev->iommu->mr, 0, &pbdev->iommu_mr);
-    pbdev->iommu_enabled = true;
+    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    memory_region_init_iommu(&iommu->iommu_mr, OBJECT(&iommu->mr),
+                             &s390_iommu_ops, name, iommu->pal + 1);
+    iommu->enabled = true;
+    memory_region_add_subregion(&iommu->mr, 0, &iommu->iommu_mr);
+    g_free(name);
 }
 
-void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
+void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
-    memory_region_del_subregion(&pbdev->iommu->mr, &pbdev->iommu_mr);
-    object_unparent(OBJECT(&pbdev->iommu_mr));
-    pbdev->iommu_enabled = false;
+    iommu->enabled = false;
+    memory_region_del_subregion(&iommu->mr, &iommu->iommu_mr);
+    object_unparent(OBJECT(&iommu->iommu_mr));
 }
 
 static void s390_pcihost_init_as(S390pciState *s)
@@ -660,6 +662,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
 
         pbdev->pdev = pdev;
         pbdev->iommu = s->iommu[PCI_SLOT(pdev->devfn)];
+        pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_STANDBY;
 
         s390_pci_msix_init(pbdev);
@@ -692,8 +695,8 @@ static void s390_pcihost_timer_cb(void *opaque)
     if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
-    if (pbdev->iommu_enabled) {
-        pci_dereg_ioat(pbdev);
+    if (pbdev->iommu->enabled) {
+        pci_dereg_ioat(pbdev->iommu);
     }
 
     pbdev->state = ZPCI_FS_STANDBY;
@@ -877,8 +880,8 @@ static void s390_pci_device_reset(DeviceState *dev)
     if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
-    if (pbdev->iommu_enabled) {
-        pci_dereg_ioat(pbdev);
+    if (pbdev->iommu->enabled) {
+        pci_dereg_ioat(pbdev->iommu);
     }
 
     pbdev->fmb_addr = 0;
@@ -944,11 +947,18 @@ static const TypeInfo s390_pci_device_info = {
     .class_init = s390_pci_device_class_init,
 };
 
+static TypeInfo s390_pci_iommu_info = {
+    .name = TYPE_S390_PCI_IOMMU,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(S390PCIIOMMU),
+};
+
 static void s390_pci_register_types(void)
 {
     type_register_static(&s390_pcihost_info);
     type_register_static(&s390_pcibus_info);
     type_register_static(&s390_pci_device_info);
+    type_register_static(&s390_pci_iommu_info);
 }
 
 type_init(s390_pci_register_types)
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 7f2701301e..1d05c1a92e 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -23,6 +23,7 @@
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
 #define TYPE_S390_PCI_BUS "s390-pcibus"
 #define TYPE_S390_PCI_DEVICE "zpci"
+#define TYPE_S390_PCI_IOMMU "s390-pci-iommu"
 #define FH_MASK_ENABLE   0x80000000
 #define FH_MASK_INSTANCE 0x7f000000
 #define FH_MASK_SHM      0x00ff0000
@@ -42,6 +43,8 @@
     OBJECT_CHECK(S390PCIBus, (obj), TYPE_S390_PCI_BUS)
 #define S390_PCI_DEVICE(obj) \
     OBJECT_CHECK(S390PCIBusDevice, (obj), TYPE_S390_PCI_DEVICE)
+#define S390_PCI_IOMMU(obj) \
+    OBJECT_CHECK(S390PCIIOMMU, (obj), TYPE_S390_PCI_IOMMU)
 
 #define HP_EVENT_TO_CONFIGURED        0x0301
 #define HP_EVENT_RESERVED_TO_STANDBY  0x0302
@@ -258,24 +261,28 @@ typedef struct S390MsixInfo {
     uint32_t pba_offset;
 } S390MsixInfo;
 
+typedef struct S390PCIBusDevice S390PCIBusDevice;
 typedef struct S390PCIIOMMU {
+    Object parent_obj;
+    S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
+    MemoryRegion iommu_mr;
+    bool enabled;
+    uint64_t g_iota;
+    uint64_t pba;
+    uint64_t pal;
 } S390PCIIOMMU;
 
 typedef struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
     ZpciState state;
-    bool iommu_enabled;
     char *target;
     uint16_t uid;
     uint32_t fh;
     uint32_t fid;
     bool fid_defined;
-    uint64_t g_iota;
-    uint64_t pba;
-    uint64_t pal;
     uint64_t fmb_addr;
     uint8_t isc;
     uint16_t noi;
@@ -283,7 +290,6 @@ typedef struct S390PCIBusDevice {
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
-    MemoryRegion iommu_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -306,8 +312,8 @@ int chsc_sei_nt2_get_event(void *res);
 int chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
-void s390_pci_iommu_enable(S390PCIBusDevice *pbdev);
-void s390_pci_iommu_disable(S390PCIBusDevice *pbdev);
+void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
 S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0864d9be12..7dbdb0c6d6 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -555,6 +555,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     CPUS390XState *env = &cpu->env;
     uint32_t fh;
     S390PCIBusDevice *pbdev;
+    S390PCIIOMMU *iommu;
     hwaddr start, end;
     IOMMUTLBEntry entry;
     MemoryRegion *mr;
@@ -597,7 +598,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         break;
     }
 
-    if (!pbdev->g_iota) {
+    iommu = pbdev->iommu;
+    if (!iommu->g_iota) {
         pbdev->state = ZPCI_FS_ERROR;
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
@@ -606,7 +608,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         goto out;
     }
 
-    if (end < pbdev->pba || start > pbdev->pal) {
+    if (end < iommu->pba || start > iommu->pal) {
         pbdev->state = ZPCI_FS_ERROR;
         setcc(cpu, ZPCI_PCI_LS_ERR);
         s390_set_status_code(env, r1, ZPCI_PCI_ST_INSUF_RES);
@@ -615,7 +617,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         goto out;
     }
 
-    mr = &pbdev->iommu_mr;
+    mr = &iommu->iommu_mr;
     while (start < end) {
         entry = mr->iommu_ops->translate(mr, start, 0);
 
@@ -783,7 +785,7 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     return 0;
 }
 
-static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
+static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib)
 {
     uint64_t pba = ldq_p(&fib.pba);
     uint64_t pal = ldq_p(&fib.pal);
@@ -803,21 +805,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
         return -EINVAL;
     }
 
-    pbdev->pba = pba;
-    pbdev->pal = pal;
-    pbdev->g_iota = g_iota;
+    iommu->pba = pba;
+    iommu->pal = pal;
+    iommu->g_iota = g_iota;
 
-    s390_pci_iommu_enable(pbdev);
+    s390_pci_iommu_enable(iommu);
 
     return 0;
 }
 
-void pci_dereg_ioat(S390PCIBusDevice *pbdev)
+void pci_dereg_ioat(S390PCIIOMMU *iommu)
 {
-    s390_pci_iommu_disable(pbdev);
-    pbdev->pba = 0;
-    pbdev->pal = 0;
-    pbdev->g_iota = 0;
+    s390_pci_iommu_disable(iommu);
+    iommu->pba = 0;
+    iommu->pal = 0;
+    iommu->g_iota = 0;
 }
 
 int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
@@ -892,10 +894,10 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (pbdev->iommu_enabled) {
+        } else if (pbdev->iommu->enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
-        } else if (reg_ioat(env, pbdev, fib)) {
+        } else if (reg_ioat(env, pbdev->iommu, fib)) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
         }
@@ -904,23 +906,23 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu_enabled) {
+        } else if (!pbdev->iommu->enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev);
+            pci_dereg_ioat(pbdev->iommu);
         }
         break;
     case ZPCI_MOD_FC_REREG_IOAT:
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu_enabled) {
+        } else if (!pbdev->iommu->enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
-            pci_dereg_ioat(pbdev);
-            if (reg_ioat(env, pbdev, fib)) {
+            pci_dereg_ioat(pbdev->iommu);
+            if (reg_ioat(env, pbdev->iommu, fib)) {
                 cc = ZPCI_PCI_LS_ERR;
                 s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
             }
@@ -1015,7 +1017,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         fib.fc |= 0x40;
     case ZPCI_FS_ENABLED:
         fib.fc |= 0x80;
-        if (pbdev->iommu_enabled) {
+        if (pbdev->iommu->enabled) {
             fib.fc |= 0x10;
         }
         if (!(fh & FH_MASK_ENABLE)) {
@@ -1028,9 +1030,9 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         return 0;
     }
 
-    stq_p(&fib.pba, pbdev->pba);
-    stq_p(&fib.pal, pbdev->pal);
-    stq_p(&fib.iota, pbdev->g_iota);
+    stq_p(&fib.pba, pbdev->iommu->pba);
+    stq_p(&fib.pal, pbdev->iommu->pal);
+    stq_p(&fib.iota, pbdev->iommu->g_iota);
     stq_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
     stq_p(&fib.fmb_addr, pbdev->fmb_addr);
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 23f4bfa0ed..94a959f91c 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -292,7 +292,7 @@ typedef struct ZpciFib {
 } QEMU_PACKED ZpciFib;
 
 int pci_dereg_irqs(S390PCIBusDevice *pbdev);
-void pci_dereg_ioat(S390PCIBusDevice *pbdev);
+void pci_dereg_ioat(S390PCIIOMMU *iommu);
 int clp_service_call(S390CPU *cpu, uint8_t r2);
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2);
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2);
-- 
2.11.0
