Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKg-0001iT-VX
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eFOKd-00039q-6I
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eFOKd-00039Z-0C
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:52:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGHnKH4136146
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:01 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9etu283e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:52:00 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 16 Nov 2017 17:51:59 -0000
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 18:51:48 +0100
Message-Id: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/7] s390x/pci: Improve zPCI to cover more
 cases
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

This patch fixes the following BUG:
Even a guest is able to detect virtio_pci device, the init function
the Linux virtio_pci driver will hang because zPCI does not support
the subregions used by virtio_pci.

It follows that right now the PCI support is very limited
(e.g. pass through of a host vfio device)
To enable features like virtio-pci several modifications needs to be
done.

As already stated above, Virtio-PCI uses subregions, which may eventually
be discontinuous inside bars instead of a single flat region often used
by real devices.
The address offset being formerly calculated from the BAR base address
must be adapted to the subregions instead of to the single region.

This patch provides the new calculation for the three kind of BAR
access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK done by zPCI.

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
 hw/s390x/s390-pci-inst.c | 247 ++++++++++++++++++++++++++++-------------------
 hw/s390x/s390-pci-inst.h |   2 +-
 3 files changed, 150 insertions(+), 100 deletions(-)

-- 
2.7.4

Changelog:

- suppress fallthrough to PCI_ROM_SLOT to handle it in the default case.
- reword most of the patch commit messages
- add comments to the endianness conversion
- reword somme comments inside the patches
