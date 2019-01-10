Received: from eggs.gnu.org ([209.51.188.92]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZwl-0003Yf-GM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZwe-0007wY-EW
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35828
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghZwe-0007r9-5c
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0ACxPJF054817
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:00:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2px5x5ss9w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:00:15 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 10 Jan 2019 13:00:13 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 10 Jan 2019 14:00:07 +0100
In-Reply-To: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size mpcifc
 request
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
is given to the IOMMU by the guest through the mpcifc request
specifying the PCI Base Address and the PCI Address Limit.

Let set the size of the IOMMU region to:
    (PCI Address Limit) - (PCI Base Address) + 1.

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
