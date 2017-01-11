Received: from eggs.gnu.org ([2001:4830:134:3::10]:45302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFMA-0000oB-Tp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFM6-0000tv-08
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cRFM5-0000sb-MR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:38:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0B9Xhet118265
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:38:04 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27whqe9bk3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:38:04 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 11 Jan 2017 09:38:02 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 11 Jan 2017 10:37:42 +0100
In-Reply-To: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
References: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
Message-Id: <20170111093742.21946-12-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 11/11] s390x/pci: merge msix init functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Currently there're two functions, s390_pci_setup_msix() and
s390_pci_msix_init(), for msix initialization, and being called once
for each zpci device plugging. Let's integrate them.

Moreover msix is mandatory in s390 architecture. So we ensure the pci
device being plugged supports msix. For vfio (which is the only tested
setup so far), nothing changes.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 736c0fcce5..0075cece14 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -582,8 +582,9 @@ static int s390_pcihost_init(SysBusDevice *dev)
     return 0;
 }
 
-static int s390_pci_setup_msix(S390PCIBusDevice *pbdev)
+static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
 {
+    char *name;
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
@@ -591,7 +592,7 @@ static int s390_pci_setup_msix(S390PCIBusDevice *pbdev)
     pos = pci_find_capability(pbdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         pbdev->msix.available = false;
-        return 0;
+        return -1;
     }
 
     ctrl = pci_host_config_read_common(pbdev->pdev, pos + PCI_MSIX_FLAGS,
@@ -607,21 +608,15 @@ static int s390_pci_setup_msix(S390PCIBusDevice *pbdev)
     pbdev->msix.pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     pbdev->msix.entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
     pbdev->msix.available = true;
-    return 0;
-}
-
-static void s390_pci_msix_init(S390PCIBusDevice *pbdev)
-{
-    char *name;
 
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
-
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
                           &s390_msi_ctrl_ops, pbdev, name, PAGE_SIZE);
     memory_region_add_subregion(&pbdev->iommu->mr, ZPCI_MSI_ADDR,
                                 &pbdev->msix_notify_mr);
-
     g_free(name);
+
+    return 0;
 }
 
 static void s390_pci_msix_free(S390PCIBusDevice *pbdev)
@@ -724,8 +719,11 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_STANDBY;
 
-        s390_pci_msix_init(pbdev);
-        s390_pci_setup_msix(pbdev);
+        if (s390_pci_msix_init(pbdev)) {
+            error_setg(errp, "MSI-X support is mandatory "
+                       "in the S390 architecture");
+            return;
+        }
 
         if (dev->hotplugged) {
             s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDBY,
-- 
2.11.0
