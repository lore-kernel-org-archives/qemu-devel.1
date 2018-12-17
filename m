Received: from eggs.gnu.org ([2001:4830:134:3::10]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnQA-00048k-LB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnND-0002hK-02
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gYnNC-0002gX-QN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05C96C04FFEA
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:31:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Dec 2018 15:31:10 +0800
Message-Id: <20181217073114.11984-2-peterx@redhat.com>
In-Reply-To: <20181217073114.11984-1-peterx@redhat.com>
References: <20181217073114.11984-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] intel_iommu: dump correct iova when failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

The iotlb.iova can be zero if failure really happened.  Dump the addr
instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d97bcbc2f7..f21988f396 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2540,7 +2540,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                           __func__, pci_bus_num(vtd_as->bus),
                           VTD_PCI_SLOT(vtd_as->devfn),
                           VTD_PCI_FUNC(vtd_as->devfn),
-                          iotlb.iova);
+                          addr);
     }
 
     return iotlb;
-- 
2.17.1
