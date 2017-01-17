Received: from eggs.gnu.org ([2001:4830:134:3::10]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZh-0002F4-6o
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZf-00087f-Ag
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50277
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZf-00087U-6C
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rUBe039824
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:02 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 281f47tkc1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:02 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:59 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:40 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 07/12] s390x/pci: optimize calling s390_get_phb()
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

A function may recursively call device search functions or may call
serveral different device search function. Passing the S390pciState to
search functions as an argument instead of looking up it inside the
search functions lowers the number of calling s390_get_phb().

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 67 +++++++++++++++++++++++-------------------------
 hw/s390x/s390-pci-bus.h  | 10 +++++---
 hw/s390x/s390-pci-inst.c | 24 +++++++++--------
 target/s390x/kvm.c       |  2 +-
 4 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index dfca006bde..e1b7649b0c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -31,7 +31,7 @@
     do { } while (0)
 #endif
 
-static S390pciState *s390_get_phb(void)
+S390pciState *s390_get_phb(void)
 {
     static S390pciState *phb;
 
@@ -91,9 +91,9 @@ int chsc_sei_nt2_have_event(void)
     return !QTAILQ_EMPTY(&s->pending_sei);
 }
 
-S390PCIBusDevice *s390_pci_find_next_avail_dev(S390PCIBusDevice *pbdev)
+S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
+                                               S390PCIBusDevice *pbdev)
 {
-    S390pciState *s = s390_get_phb();
     S390PCIBusDevice *ret = pbdev ? QTAILQ_NEXT(pbdev, link) :
         QTAILQ_FIRST(&s->zpci_devs);
 
@@ -104,10 +104,9 @@ S390PCIBusDevice *s390_pci_find_next_avail_dev(S390PCIBusDevice *pbdev)
     return ret;
 }
 
-S390PCIBusDevice *s390_pci_find_dev_by_fid(uint32_t fid)
+S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid)
 {
     S390PCIBusDevice *pbdev;
-    S390pciState *s = s390_get_phb();
 
     QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
         if (pbdev->fid == fid) {
@@ -121,7 +120,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_fid(uint32_t fid)
 void s390_pci_sclp_configure(SCCB *sccb)
 {
     PciCfgSccb *psccb = (PciCfgSccb *)sccb;
-    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(be32_to_cpu(psccb->aid));
+    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
+                                                       be32_to_cpu(psccb->aid));
     uint16_t rc;
 
     if (be16_to_cpu(sccb->h.length) < 16) {
@@ -153,7 +153,8 @@ out:
 void s390_pci_sclp_deconfigure(SCCB *sccb)
 {
     PciCfgSccb *psccb = (PciCfgSccb *)sccb;
-    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(be32_to_cpu(psccb->aid));
+    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_fid(s390_get_phb(),
+                                                       be32_to_cpu(psccb->aid));
     uint16_t rc;
 
     if (be16_to_cpu(sccb->h.length) < 16) {
@@ -192,10 +193,9 @@ out:
     psccb->header.response_code = cpu_to_be16(rc);
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_uid(uint16_t uid)
+static S390PCIBusDevice *s390_pci_find_dev_by_uid(S390pciState *s, uint16_t uid)
 {
     S390PCIBusDevice *pbdev;
-    S390pciState *s = s390_get_phb();
 
     QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
         if (pbdev->uid == uid) {
@@ -206,10 +206,10 @@ static S390PCIBusDevice *s390_pci_find_dev_by_uid(uint16_t uid)
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_target(const char *target)
+static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
+                                                     const char *target)
 {
     S390PCIBusDevice *pbdev;
-    S390pciState *s = s390_get_phb();
 
     if (!target) {
         return NULL;
@@ -224,10 +224,9 @@ static S390PCIBusDevice *s390_pci_find_dev_by_target(const char *target)
     return NULL;
 }
 
-S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx)
+S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
 {
     S390PCIBusDevice *pbdev;
-    S390pciState *s = s390_get_phb();
 
     QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
         if (pbdev->idx == idx) {
@@ -238,9 +237,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx)
     return NULL;
 }
 
-S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh)
+S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh)
 {
-    S390pciState *s = s390_get_phb();
     S390PCIBusDevice *pbdev;
 
     QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
@@ -544,10 +542,9 @@ void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
     object_unparent(OBJECT(&iommu->iommu_mr));
 }
 
-static void s390_pci_iommu_free(PCIBus *bus, int32_t devfn)
+static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
 {
     uint64_t key = (unsigned long)bus;
-    S390pciState *s = s390_get_phb();
     S390PCIIOMMUTable *table = g_hash_table_lookup(s->iommu_table, &key);
     S390PCIIOMMU *iommu = table ? table->iommu[PCI_SLOT(devfn)] : NULL;
 
@@ -639,10 +636,10 @@ static void s390_pci_msix_free(S390PCIBusDevice *pbdev)
     object_unparent(OBJECT(&pbdev->msix_notify_mr));
 }
 
-static S390PCIBusDevice *s390_pci_device_new(const char *target)
+static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
+                                             const char *target)
 {
     DeviceState *dev = NULL;
-    S390pciState *s = s390_get_phb();
 
     dev = qdev_try_create(BUS(s->bus), TYPE_S390_PCI_DEVICE);
     if (!dev) {
@@ -655,13 +652,12 @@ static S390PCIBusDevice *s390_pci_device_new(const char *target)
     return S390_PCI_DEVICE(dev);
 }
 
-static bool s390_pci_alloc_idx(S390PCIBusDevice *pbdev)
+static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
 {
     uint32_t idx;
-    S390pciState *s = s390_get_phb();
 
     idx = s->next_idx;
-    while (s390_pci_find_dev_by_idx(idx)) {
+    while (s390_pci_find_dev_by_idx(s, idx)) {
         idx = (idx + 1) & FH_MASK_INDEX;
         if (idx == s->next_idx) {
             return false;
@@ -693,9 +689,9 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
                                       PCI_FUNC(pdev->devfn));
         }
 
-        pbdev = s390_pci_find_dev_by_target(dev->id);
+        pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
-            pbdev = s390_pci_device_new(dev->id);
+            pbdev = s390_pci_device_new(s, dev->id);
             if (!pbdev) {
                 error_setg(errp, "create zpci device failed");
                 return;
@@ -723,7 +719,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
 
-        if (!s390_pci_alloc_idx(pbdev)) {
+        if (!s390_pci_alloc_idx(s, pbdev)) {
             error_setg(errp, "no slot for plugging zpci device");
             return;
         }
@@ -800,7 +796,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     devfn = pci_dev->devfn;
     object_unparent(OBJECT(pci_dev));
     s390_pci_msix_free(pbdev);
-    s390_pci_iommu_free(bus, devfn);
+    s390_pci_iommu_free(s, bus, devfn);
     pbdev->pdev = NULL;
     pbdev->state = ZPCI_FS_RESERVED;
 out:
@@ -839,13 +835,13 @@ static const TypeInfo s390_pcibus_info = {
     .instance_size = sizeof(S390PCIBus),
 };
 
-static uint16_t s390_pci_generate_uid(void)
+static uint16_t s390_pci_generate_uid(S390pciState *s)
 {
     uint16_t uid = 0;
 
     do {
         uid++;
-        if (!s390_pci_find_dev_by_uid(uid)) {
+        if (!s390_pci_find_dev_by_uid(s, uid)) {
             return uid;
         }
     } while (uid < ZPCI_MAX_UID);
@@ -853,12 +849,12 @@ static uint16_t s390_pci_generate_uid(void)
     return UID_UNDEFINED;
 }
 
-static uint32_t s390_pci_generate_fid(Error **errp)
+static uint32_t s390_pci_generate_fid(S390pciState *s, Error **errp)
 {
     uint32_t fid = 0;
 
     do {
-        if (!s390_pci_find_dev_by_fid(fid)) {
+        if (!s390_pci_find_dev_by_fid(s, fid)) {
             return fid;
         }
     } while (fid++ != ZPCI_MAX_FID);
@@ -870,25 +866,26 @@ static uint32_t s390_pci_generate_fid(Error **errp)
 static void s390_pci_device_realize(DeviceState *dev, Error **errp)
 {
     S390PCIBusDevice *zpci = S390_PCI_DEVICE(dev);
+    S390pciState *s = s390_get_phb();
 
     if (!zpci->target) {
         error_setg(errp, "target must be defined");
         return;
     }
 
-    if (s390_pci_find_dev_by_target(zpci->target)) {
+    if (s390_pci_find_dev_by_target(s, zpci->target)) {
         error_setg(errp, "target %s already has an associated zpci device",
                    zpci->target);
         return;
     }
 
     if (zpci->uid == UID_UNDEFINED) {
-        zpci->uid = s390_pci_generate_uid();
+        zpci->uid = s390_pci_generate_uid(s);
         if (!zpci->uid) {
             error_setg(errp, "no free uid could be found");
             return;
         }
-    } else if (s390_pci_find_dev_by_uid(zpci->uid)) {
+    } else if (s390_pci_find_dev_by_uid(s, zpci->uid)) {
         error_setg(errp, "uid %u already in use", zpci->uid);
         return;
     }
@@ -896,12 +893,12 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     if (!zpci->fid_defined) {
         Error *local_error = NULL;
 
-        zpci->fid = s390_pci_generate_fid(&local_error);
+        zpci->fid = s390_pci_generate_fid(s, &local_error);
         if (local_error) {
             error_propagate(errp, local_error);
             return;
         }
-    } else if (s390_pci_find_dev_by_fid(zpci->fid)) {
+    } else if (s390_pci_find_dev_by_fid(s, zpci->fid)) {
         error_setg(errp, "fid %u already in use", zpci->fid);
         return;
     }
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1bd37ad821..fbdc64febf 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -316,6 +316,7 @@ typedef struct S390pciState {
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
 } S390pciState;
 
+S390pciState *s390_get_phb(void);
 int chsc_sei_nt2_get_event(void *res);
 int chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
@@ -324,9 +325,10 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx);
-S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh);
-S390PCIBusDevice *s390_pci_find_dev_by_fid(uint32_t fid);
-S390PCIBusDevice *s390_pci_find_next_avail_dev(S390PCIBusDevice *pbdev);
+S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx);
+S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
+S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
+S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
+                                               S390PCIBusDevice *pbdev);
 
 #endif
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7dbdb0c6d6..405cccd2d0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -38,6 +38,7 @@ static void s390_set_status_code(CPUS390XState *env,
 static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
 {
     S390PCIBusDevice *pbdev = NULL;
+    S390pciState *s = s390_get_phb();
     uint32_t res_code, initial_l2, g_l2;
     int rc, i;
     uint64_t resume_token;
@@ -65,14 +66,14 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
     resume_token = ldq_p(&rrb->request.resume_token);
 
     if (resume_token) {
-        pbdev = s390_pci_find_dev_by_idx(resume_token);
+        pbdev = s390_pci_find_dev_by_idx(s, resume_token);
         if (!pbdev) {
             res_code = CLP_RC_LISTPCI_BADRT;
             rc = -EINVAL;
             goto out;
         }
     } else {
-        pbdev = s390_pci_find_next_avail_dev(NULL);
+        pbdev = s390_pci_find_next_avail_dev(s, NULL);
     }
 
     if (lduw_p(&rrb->response.hdr.len) < 48) {
@@ -118,7 +119,7 @@ static int list_pci(ClpReqRspListPci *rrb, uint8_t *cc)
                 lduw_p(&rrb->response.fh_list[i].device_id),
                 ldl_p(&rrb->response.fh_list[i].fid),
                 ldl_p(&rrb->response.fh_list[i].fh));
-        pbdev = s390_pci_find_next_avail_dev(pbdev);
+        pbdev = s390_pci_find_next_avail_dev(s, pbdev);
         i++;
     }
 
@@ -148,6 +149,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
     uint8_t buffer[4096 * 2];
     uint8_t cc = 0;
     CPUS390XState *env = &cpu->env;
+    S390pciState *s = s390_get_phb();
     int i;
 
     cpu_synchronize_state(CPU(cpu));
@@ -202,7 +204,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
         ClpReqSetPci *reqsetpci = (ClpReqSetPci *)reqh;
         ClpRspSetPci *ressetpci = (ClpRspSetPci *)resh;
 
-        pbdev = s390_pci_find_dev_by_fh(ldl_p(&reqsetpci->fh));
+        pbdev = s390_pci_find_dev_by_fh(s, ldl_p(&reqsetpci->fh));
         if (!pbdev) {
                 stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FH);
                 goto out;
@@ -253,7 +255,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
         ClpReqQueryPci *reqquery = (ClpReqQueryPci *)reqh;
         ClpRspQueryPci *resquery = (ClpRspQueryPci *)resh;
 
-        pbdev = s390_pci_find_dev_by_fh(ldl_p(&reqquery->fh));
+        pbdev = s390_pci_find_dev_by_fh(s, ldl_p(&reqquery->fh));
         if (!pbdev) {
             DPRINTF("query pci no pci dev\n");
             stw_p(&resquery->hdr.rsp, CLP_RC_SETPCIFN_FH);
@@ -338,7 +340,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     len = env->regs[r2] & 0xf;
     offset = env->regs[r2 + 1];
 
-    pbdev = s390_pci_find_dev_by_fh(fh);
+    pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("pcilg no pci dev\n");
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
@@ -471,7 +473,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     len = env->regs[r2] & 0xf;
     offset = env->regs[r2 + 1];
 
-    pbdev = s390_pci_find_dev_by_fh(fh);
+    pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("pcistg no pci dev\n");
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
@@ -576,7 +578,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     start = env->regs[r2];
     end = start + env->regs[r2 + 1];
 
-    pbdev = s390_pci_find_dev_by_fh(fh);
+    pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("rpcit no pci dev\n");
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
@@ -679,7 +681,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
         return 0;
     }
 
-    pbdev = s390_pci_find_dev_by_fh(fh);
+    pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("pcistb no pci dev fh 0x%x\n", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
@@ -845,7 +847,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         return 0;
     }
 
-    pbdev = s390_pci_find_dev_by_fh(fh);
+    pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
     if (!pbdev) {
         DPRINTF("mpcifc no pci dev fh 0x%x\n", fh);
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
@@ -990,7 +992,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         return 0;
     }
 
-    pbdev = s390_pci_find_dev_by_idx(fh & FH_MASK_INDEX);
+    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), fh & FH_MASK_INDEX);
     if (!pbdev) {
         setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
         return 0;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97afe02599..c47db9a884 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2301,7 +2301,7 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
-    pbdev = s390_pci_find_dev_by_idx(idx);
+    pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
     if (!pbdev) {
         DPRINTF("add_msi_route no dev\n");
         return -ENODEV;
-- 
2.11.0
