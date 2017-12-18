Received: from eggs.gnu.org ([2001:4830:134:3::10]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZI-0000kF-EN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZF-0001M4-6k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eQnZE-0001GU-UM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6507E4A6E6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:02:18 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Sun, 17 Dec 2017 22:02:14 -0700
Message-ID: <20171218040852.13478.19208.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC/RFT PATCH 0/5] vfio/pci: MSI-X MMIO relocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com

Currently the kernel vfio-pci interface disallows users to mmap over
the MSI-X MMIO areas within a vfio region, however there's a proposal
to enable mmap of this area to better support SPAPR.  The kernel
change benefits those systems because they use a 64K system page size,
such that disallowing direct mapping of the MSI-X MMIO space also
potentially disallows direct access to other device registers within
that page.  Additionally, those systems make use of hypercalls rather
than VM access to the MSI-X MMIO space for programming interrupts and
can therefore disable traps into QEMU for MSI-X MMIO emulation.

Other platforms, like ARM64, can also use 64K pages and therefore
may also experience performance issues on devices where performance
critical device registers are within the same page as MSI-X MMIO.
These systems can also take advantage of the kernel allowing mmap of
the device MSI-X MMIO space, but in order to avoid traps to this
page, we also need to move (relocate) MSI-X MMIO to avoid any chance
of interference.  This series adds the option 'x-msix-relocation='
to the vfio-pci device, which accepts values of 'off' (default),
'auto', and 'bar0' through 'bar5'.  The default is expected to have
full device and guest OS compatibility as it leaves the MSI-X MMIO
space at the native offset of the device.  The 'auto' option will
automatically relocate MSI-X MMIO space using an algorithm that
prefers the least additional MMIO space for the device, by either
adding a new BAR or extending existing BARs.  Finally, specifying a
specific BAR allows the user to choose where to add MSI-X MMIO.

I've made this new option experimental here, because we don't know
that device drivers across all guests will be compatible with this
change.  It's possible that some drivers might hard code addresses.
Any Linux driver following standard programming should be compatible
with this change.  There are also devices which don't need this
modification and enabling it by default would only serve to increase
the MMIO requirements of the device.  An example of this is the
Intel 82576 PF NIC, where BAR3 is sized at 16K and hosts the MSI-X
vector table at offset 0 and the PBA at offset 8K.  The datasheet
indicates this BAR is exclusively for MSI-X, therefore it's pointless
to relocate it.  Perhaps we'll eventually develop vendor or device
checks where it makes sense to enable this automatically when running
with large system page sizes.

x86 is of course largely immune to this problem since the system page
size is always 4K, which falls within the design recommendations in
the PCI spec for alignment of MSI-X registers from other registers,
but as this is only a recommendation, there may exist devices for
which this change could also be useful on 4K hosts.

Testing for this series can be done on any kernel, but one allowing
mmap of the MSI-X MMIO space is required to evaluate any performance
difference.  This requires Alexey's patch here:
http://www.spinics.net/lists/kvm/msg160605.html
Which depends on my patch:
https://lkml.org/lkml/2017/12/12/1083
Also, disabling hw/vfio/pci.c:vfio_pci_fixup_msix_region() is
necessary until we have some funtional proposals for QEMU making
use of the new capability exported by the kernel.  I welcome feedback
and/or test reports.  Thanks,

Alex

---

Alex Williamson (5):
      vfio/pci: Fixup VFIOMSIXInfo comment
      vfio/pci: Add base BAR MemoryRegion
      vfio/pci: Emulate BARs
      qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
      vfio/pci: Allow relocating MSI-X MMIO


 hw/core/qdev-properties.c    |   11 +++
 hw/vfio/pci.c                |  176 ++++++++++++++++++++++++++++++++++++++----
 hw/vfio/pci.h                |    6 +
 hw/vfio/trace-events         |    2 
 include/hw/qdev-properties.h |    4 +
 qapi/common.json             |   26 ++++++
 6 files changed, 207 insertions(+), 18 deletions(-)
