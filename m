Received: from eggs.gnu.org ([2001:4830:134:3::10]:44448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxW-0002FK-OZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxR-0007ZN-7V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:57:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJxR-0007Yn-1W
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:57:05 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:03 +0200
Message-Id: <20170919145636.9389-6-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/38] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Let's introduce iommu replay callback for s390 pci iommu memory region.
Currently we don't need any dma mapping replay. So let it return
directly. This implementation will avoid meaningless loops calling
translation callback.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <1504606380-49341-4-git-send-email-zyimin@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.13.5
