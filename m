Received: from eggs.gnu.org ([2001:4830:134:3::10]:44056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7T-0007Im-89
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eib7P-0000dI-8m
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eib7O-0000cW-VJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 02:23:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w157JWSf016025
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 02:23:09 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxj1c1smh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 02:23:08 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 02:23:07 -0500
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:22:55 +0800
Message-Id: <20180205072258.5968-1-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] s390x/pci: fixup and optimize IOTLB code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, marcel@redhat.com, zyimin@linux.vnet.ibm.com

This series contains three patches,
1) optimizes the code including walking DMA tables and rpcit handler
2) fixes the issue caused by IOTLB global refresh
3) uses the right pal and pba when registering ioat

The issue mentioned above was found when we tested SMC-r tools. This
behavior has been introduced when linux guest started using a global
refresh to purge the whole IOTLB of invalid entries in a lazy fashion
instead of flushing each entry when invalidating table entries.

The previous QEMU implementation didn't keep track of the mapping,
didn't handle correctly the global flush demand from the guest and a
major part of the IOTLB entries were not flushed.

Consequently linux kernel on the host keeping the previous mapping
reports, as it should, -EEXIST DMA mapping error on the next mapping
with the same IOVA. The second patch fixes this issue.

During the investigation, we noticed that the current code walking
PCI IOMMU page tables didn't check important flags of table entries,
including:
1) protection bit
2) table length
3) table offset
4) intermediate tables' invalid bit
5) format control bit

We implement the checking in the first patch before handling the
IOTLB global refresh issue. To keep track of the mapped IOTLB entries
and be able to check if the host IOTLB entries need to be refreshed
we implement a IOTLB cache in QEMU, and introduce some helper
functions to check these bits. All S390IOTLBEntry instances are stored
in a new hashtable which are indexed by IOVA. Each PCI device has its
own IOMMU. Therefore each IOMMU also has its own hashtable caching
corresponding PCI device's DMA entries. Finally, we split 1M
contiguous DMA range into 4K pages to do DMA map, and the code about
error notification is also optimized.

Change log:
v1->v2:
1) update commit messages
2) move some changes from the 2nd patch to the 1st patch
3) define macros for 'ett' in the 1st patch

Yi Min Zhao (3):
  s390x/pci: fixup the code walking IOMMU tables
  s390x/pci: fixup global refresh
  s390x/pci: use the right pal and pba in reg_ioat()

 hw/s390x/s390-pci-bus.c  | 233 ++++++++++++++++++++++++++++++++++++++---------
 hw/s390x/s390-pci-bus.h  |  17 ++++
 hw/s390x/s390-pci-inst.c | 103 ++++++++++++++-------
 3 files changed, 275 insertions(+), 78 deletions(-)

-- 
2.14.3 (Apple Git-98)
