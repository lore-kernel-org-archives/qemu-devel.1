Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZm-0002R4-Ch
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZj-0008AZ-3H
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZi-00089p-QF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:07 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rZM3035983
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:05 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2812r1b4wf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:05 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:57:02 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:42 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 09/12] s390x/pci: use hashtable to look up zpci
 via fh
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

After PCI multibus is supported, more than 32 PCI devices could be
plugged. The current implementation of s390_pci_find_dev_by_fh()
appears low performance if there's a huge number of PCI devices
plugged. Therefore we introduce a hashtable using idx as key to store
zpci device's pointer on account of translating fh to idx very easily.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 22 ++++++++--------------
 hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9ca67b2755..458ea2bdd7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -227,25 +227,16 @@ static S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
 
 S390PCIBusDevice *s390_pci_find_dev_by_idx(S390pciState *s, uint32_t idx)
 {
-    S390PCIBusDevice *pbdev;
-
-    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
-        if (pbdev->idx == idx) {
-            return pbdev;
-        }
-    }
-
-    return NULL;
+    return g_hash_table_lookup(s->zpci_table, &idx);
 }
 
 S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh)
 {
-    S390PCIBusDevice *pbdev;
+    uint32_t idx = FH_MASK_INDEX & fh;
+    S390PCIBusDevice *pbdev = s390_pci_find_dev_by_idx(s, idx);
 
-    QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
-        if (pbdev->fh == fh) {
-            return pbdev;
-        }
+    if (pbdev && pbdev->fh == fh) {
+        return pbdev;
     }
 
     return NULL;
@@ -584,6 +575,7 @@ static int s390_pcihost_init(SysBusDevice *dev)
 
     s->iommu_table = g_hash_table_new_full(g_int64_hash, g_int64_equal,
                                            NULL, g_free);
+    s->zpci_table = g_hash_table_new_full(g_int_hash, g_int_equal, NULL, NULL);
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
     return 0;
@@ -735,6 +727,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         }
         pbdev->fh = pbdev->idx;
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
+        g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
     }
 }
 
@@ -815,6 +808,7 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
 out:
     pbdev->fid = 0;
     QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+    g_hash_table_remove(s->zpci_table, &pbdev->idx);
     object_unparent(OBJECT(pbdev));
 }
 
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index fbdc64febf..b82b18eb07 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -312,6 +312,7 @@ typedef struct S390pciState {
     uint32_t next_idx;
     S390PCIBus *bus;
     GHashTable *iommu_table;
+    GHashTable *zpci_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
 } S390pciState;
-- 
2.11.0
