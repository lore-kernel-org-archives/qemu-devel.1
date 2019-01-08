Received: from eggs.gnu.org ([209.51.188.92]:49251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggvGE-0003yd-Lc
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ggvGA-0006WI-S9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:33:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ggvGA-0006R9-HM
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:33:50 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08HPJWa050095
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 12:33:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pvx80f4j4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 12:33:47 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 8 Jan 2019 17:33:45 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue,  8 Jan 2019 18:33:39 +0100
Message-Id: <1546968819-8166-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/pci: Set the iommu region size as guest
 wants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

The size of the accessible iommu memory region in the guest
is calculated by the gues as:
    (PCI Address Limit) - (PCI Base Address) + 1.

Let's use this value to limit the IOMMU region size.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69e0671..e97696a 100644
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
2.7.4
