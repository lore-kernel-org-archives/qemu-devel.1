Received: from eggs.gnu.org ([2001:4830:134:3::10]:44296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpArM-0006gl-9U
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpArE-0003dw-EJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46393
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpArE-0003dZ-8q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85A8eZd007921
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 06:13:23 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cspu33a4b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 06:13:23 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 20:13:20 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v85ADHVq40960142
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:17 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v85ADGus012104
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:17 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue,  5 Sep 2017 12:13:00 +0200
In-Reply-To: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1504606380-49341-4-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] s390x/pci: add iommu replay callback
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
 hw/s390x/s390-pci-bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index bd8a3e1e1c..3b9965fde0 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -397,6 +397,17 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     return ret;
 }
 
+static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
+                                  IOMMUNotifier *notifier)
+{
+    /* It's impossible to plug a pci device on s390x that already has iommu
+     * mappings which need to be replayed, that is due to the "one iommu per
+     * zpci device" construct. But when we support migration of vfio-pci
+     * devices in future, we need to revisit this.
+     */
+    return;
+}
+
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         int devfn)
 {
@@ -1045,6 +1056,7 @@ static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = s390_translate_iommu;
+    imrc->replay = s390_pci_iommu_replay;
 }
 
 static const TypeInfo s390_iommu_memory_region_info = {
-- 
2.11.0 (Apple Git-81)
