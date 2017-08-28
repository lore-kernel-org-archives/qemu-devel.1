Received: from eggs.gnu.org ([2001:4830:134:3::10]:55445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2r-00085y-7M
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2p-0006D4-TW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34217
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmF2p-0006Cd-Ni
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S83jhY060222
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:15 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cm9ubcwsx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:14 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:05:12 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7S858ON38404344
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:05:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7S84x5O026105
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:59 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:04:47 +0200
In-Reply-To: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org, zyimin@linux.vnet.ibm.com

Let's introduce iommu replay callback for s390 pci iommu memory region.
Currently we don't need any dma mapping replay. So let it return
directly. This implementation will avoid meaningless loops calling
translation callback.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9e1f7ff5c5..359509ccea 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -407,6 +407,13 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     return ret;
 }
 
+static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
+                                  IOMMUNotifier *notifier)
+{
+    /* we don't need iommu replay currently */
+    return;
+}
+
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         int devfn)
 {
@@ -1055,6 +1062,7 @@ static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = s390_translate_iommu;
+    imrc->replay = s390_pci_iommu_replay;
 }
 
 static const TypeInfo s390_iommu_memory_region_info = {
-- 
2.11.0 (Apple Git-81)
