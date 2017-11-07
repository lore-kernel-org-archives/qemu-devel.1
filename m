Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cQ-0001xq-6T
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eC7cM-0005J3-W2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43528
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eC7cM-0005H4-Oj
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:24:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7HNhKh128561
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:24:46 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e3gec2f4p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:24:45 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 7 Nov 2017 17:24:42 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue,  7 Nov 2017 18:24:32 +0100
Message-Id: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/7] s390x/pci: Improve zPCI to cover more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

Right now the PCI support is very limited (e.g. pass through of a
host vfio device)
To enable features like virtio-pci several modifications needs to be
done.

Virtio-PCI uses subregions, which may eventually be discontinuous
inside bars instead of a single flat region.
The address offset being formerly calculated from the BAR base address
must be adapted to the subregions instead of to the single region.

This patch provides the new calculation for the three kind of BAR
access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK.

We use the opportunity to
 - enhance the fault detection for zPCI STORE and LOAD,
 - enhance the fault detection and to provide the maximum STORE BLOCK
   block size, maxstbl, for zPCI STORE BLOCK
 - factor out part of the code used to calculate the offset and
   access the BARs,
 - factor out the code for endianess conversion.


Pierre Morel (7):
  s390x/pci: factor out endianess conversion
  s390x/pci: rework PCI STORE
  s390x/pci: rework PCI LOAD
  s390x/pci: rework PCI STORE BLOCK
  s390x/pci: move the memory region read from pcilg
  s390x/pci: move the memory region write from pcistg
  s390x/pci: search for subregion inside the BARs

 hw/s390x/s390-pci-bus.h  |   1 +
 hw/s390x/s390-pci-inst.c | 250 ++++++++++++++++++++++++++++-------------------
 hw/s390x/s390-pci-inst.h |   2 +-
 3 files changed, 153 insertions(+), 100 deletions(-)

-- 
2.7.4
