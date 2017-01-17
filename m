Received: from eggs.gnu.org ([2001:4830:134:3::10]:48934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZg-0002EV-FH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZd-000869-Ax
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZd-00085O-2H
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rVLs024216
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:00 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 281880yyys-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:59 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:57 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:39 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-7-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 06/12] s390x/pci: change the device array to a
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

In order to support a greater number of devices we use a QTAILQ
list of devices instead of a limited array.

This leads us to change:
- every lookup function s390_pci_find_xxx() for QTAILQ
- the FH_MASK_INDEX to index up to 65536 devices

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 100 ++++++++++++++++++++++++------------------------
 hw/s390x/s390-pci-bus.h |   7 +++-
 2 files changed, 56 insertions(+), 51 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 04a4c3508e..dfca006bde 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -93,33 +93,24 @@ int chsc_sei_nt2_have_event(void)
 
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390PCIBusDevice *pbdev)
 {
-    int idx = 0;
-    S390PCIBusDevice *dev = NULL;
     S390pciState *s = s390_get_phb();
+    S390PCIBusDevice *ret = pbdev ? QTAILQ_NEXT(pbdev, link) :
+        QTAILQ_FIRST(&s->zpci_devs);
 
-    if (pbdev) {
-        idx = (pbdev->fh & FH_MASK_INDEX) + 1;
+    while (ret && ret->state == ZPCI_FS_RESERVED) {
+        ret = QTAILQ_NEXT(ret, link);
     }
 
-    for (; idx < PCI_SLOT_MAX; idx++) {
-        dev = s->pbdev[idx];
-        if (dev && dev->state != ZPCI_FS_RESERVED) {
-            return dev;
-        }
-    }
-
-    return NULL;
+    return ret;
 }
 
 S390PCIBusDevice *s390_pci_find_dev_by_fid(uint32_t fid)
 {
     S390PCIBusDevice *pbdev;
-    int i;
     S390pciState *s = s390_get_phb();
 
-    for (i = 0; i < PCI_SLOT_MAX; i++) {
-        pbdev = s->pbdev[i];
-        if (pbdev && pbdev->fid == fid) {
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
+        if (pbdev->fid == fid) {
             return pbdev;
         }
     }
@@ -203,16 +194,10 @@ out:
 
 static S390PCIBusDevice *s390_pci_find_dev_by_uid(uint16_t uid)
 {
-    int i;
     S390PCIBusDevice *pbdev;
     S390pciState *s = s390_get_phb();
 
-    for (i = 0; i < PCI_SLOT_MAX; i++) {
-        pbdev = s->pbdev[i];
-        if (!pbdev) {
-            continue;
-        }
-
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
         if (pbdev->uid == uid) {
             return pbdev;
         }
@@ -223,7 +208,6 @@ static S390PCIBusDevice *s390_pci_find_dev_by_uid(uint16_t uid)
 
 static S390PCIBusDevice *s390_pci_find_dev_by_target(const char *target)
 {
-    int i;
     S390PCIBusDevice *pbdev;
     S390pciState *s = s390_get_phb();
 
@@ -231,12 +215,7 @@ static S390PCIBusDevice *s390_pci_find_dev_by_target(const char *target)
         return NULL;
     }
 
-    for (i = 0; i < PCI_SLOT_MAX; i++) {
-        pbdev = s->pbdev[i];
-        if (!pbdev) {
-            continue;
-        }
-
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
         if (!strcmp(pbdev->target, target)) {
             return pbdev;
         }
@@ -247,9 +226,16 @@ static S390PCIBusDevice *s390_pci_find_dev_by_target(const char *target)
 
 S390PCIBusDevice *s390_pci_find_dev_by_idx(uint32_t idx)
 {
+    S390PCIBusDevice *pbdev;
     S390pciState *s = s390_get_phb();
 
-    return s->pbdev[idx & FH_MASK_INDEX];
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
+        if (pbdev->idx == idx) {
+            return pbdev;
+        }
+    }
+
+    return NULL;
 }
 
 S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh)
@@ -257,9 +243,10 @@ S390PCIBusDevice *s390_pci_find_dev_by_fh(uint32_t fh)
     S390pciState *s = s390_get_phb();
     S390PCIBusDevice *pbdev;
 
-    pbdev = s->pbdev[fh & FH_MASK_INDEX];
-    if (pbdev && pbdev->fh == fh) {
-        return pbdev;
+    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
+        if (pbdev->fh == fh) {
+            return pbdev;
+        }
     }
 
     return NULL;
@@ -600,6 +587,7 @@ static int s390_pcihost_init(SysBusDevice *dev)
     s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
                                            NULL, g_free);
     QTAILQ_INIT(&s->pending_sei);
+    QTAILQ_INIT(&s->zpci_devs);
     return 0;
 }
 
@@ -667,6 +655,25 @@ static S390PCIBusDevice *s390_pci_device_new(const char *target)
     return S390_PCI_DEVICE(dev);
 }
 
+static bool s390_pci_alloc_idx(S390PCIBusDevice *pbdev)
+{
+    uint32_t idx;
+    S390pciState *s = s390_get_phb();
+
+    idx = s->next_idx;
+    while (s390_pci_find_dev_by_idx(idx)) {
+        idx = (idx + 1) & FH_MASK_INDEX;
+        if (idx == s->next_idx) {
+            return false;
+        }
+    }
+
+    pbdev->idx = idx;
+    s->next_idx = (idx + 1) & FH_MASK_INDEX;
+
+    return true;
+}
+
 static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
@@ -714,18 +721,14 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
                                          pbdev->fh, pbdev->fid);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
-        int idx;
-
         pbdev = S390_PCI_DEVICE(dev);
-        for (idx = 0; idx < PCI_SLOT_MAX; idx++) {
-            if (!s->pbdev[idx]) {
-                s->pbdev[idx] = pbdev;
-                pbdev->fh = idx;
-                return;
-            }
-        }
 
-        error_setg(errp, "no slot for plugging zpci device");
+        if (!s390_pci_alloc_idx(pbdev)) {
+            error_setg(errp, "no slot for plugging zpci device");
+            return;
+        }
+        pbdev->fh = pbdev->idx;
+        QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
     }
 }
 
@@ -751,16 +754,15 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
 {
     PCIDevice *pci_dev = NULL;
     PCIBus *bus;
-    int32_t devfn, i;
+    int32_t devfn;
     S390PCIBusDevice *pbdev = NULL;
     S390pciState *s = s390_get_phb();
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pci_dev = PCI_DEVICE(dev);
 
-        for (i = 0 ; i < PCI_SLOT_MAX; i++) {
-            if (s->pbdev[i] && s->pbdev[i]->pdev == pci_dev) {
-                pbdev = s->pbdev[i];
+        QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
+            if (pbdev->pdev == pci_dev) {
                 break;
             }
         }
@@ -803,7 +805,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     pbdev->state = ZPCI_FS_RESERVED;
 out:
     pbdev->fid = 0;
-    s->pbdev[pbdev->fh & FH_MASK_INDEX] = NULL;
+    QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
     object_unparent(OBJECT(pbdev));
 }
 
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index fe108e9330..1bd37ad821 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -27,7 +27,7 @@
 #define FH_MASK_ENABLE   0x80000000
 #define FH_MASK_INSTANCE 0x7f000000
 #define FH_MASK_SHM      0x00ff0000
-#define FH_MASK_INDEX    0x0000001f
+#define FH_MASK_INDEX    0x0000ffff
 #define FH_SHM_VFIO      0x00010000
 #define FH_SHM_EMUL      0x00020000
 #define S390_PCIPT_ADAPTER 2
@@ -285,6 +285,7 @@ typedef struct S390PCIBusDevice {
     ZpciState state;
     char *target;
     uint16_t uid;
+    uint32_t idx;
     uint32_t fh;
     uint32_t fid;
     bool fid_defined;
@@ -299,6 +300,7 @@ typedef struct S390PCIBusDevice {
     IndAddr *summary_ind;
     IndAddr *indicator;
     QEMUTimer *release_timer;
+    QTAILQ_ENTRY(S390PCIBusDevice) link;
 } S390PCIBusDevice;
 
 typedef struct S390PCIBus {
@@ -307,10 +309,11 @@ typedef struct S390PCIBus {
 
 typedef struct S390pciState {
     PCIHostState parent_obj;
+    uint32_t next_idx;
     S390PCIBus *bus;
-    S390PCIBusDevice *pbdev[PCI_SLOT_MAX];
     GHashTable *iommu_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
+    QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
 } S390pciState;
 
 int chsc_sei_nt2_get_event(void *res);
-- 
2.11.0
