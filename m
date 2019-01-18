Received: from eggs.gnu.org ([209.51.188.92]:52387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7h-0004zj-6O
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7g-0001TB-G7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:45 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:20 +0100
Message-Id: <20190118121925.24468-7-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] s390x/pci: Set the iommu region size
 mpcifc request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Pierre Morel <pmorel@linux.ibm.com>

The size of the accessible iommu memory region in the guest
is given to the IOMMU by the guest through the mpcifc request
specifying the PCI Base Address and the PCI Address Limit.

Let's set the size of the IOMMU region to:
    (PCI Address Limit) - (PCI Base Address) + 1.

Fixes: f7c40aa1e7 ("s390x/pci: fix failures of dma map/unmap")
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
Acked-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 1579989213..400d9e4f28 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -660,7 +660,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
     char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
     memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal + 1);
+                             name, iommu->pal - iommu->pba + 1);
     iommu->enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
-- 
2.17.2
