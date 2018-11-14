Received: from eggs.gnu.org ([2001:4830:134:3::10]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN27O-000479-03
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN27J-0004RA-8d
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gN27J-0004Qd-2a
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:50:29 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 14 Nov 2018 13:50:18 -0700
Message-ID: <154222737752.9288.484557356059052047.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC for-3.2 PATCH 0/7] pcie: Enhanced link speed and
 width support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, geoff@hostfission.com

QEMU exposes gen1 PCI-express interconnect devices supporting only
2.5GT/s and x1 width.  It might not seem obvious that a virtual
bandwidth limitation can result in a real performance degradation, but
it's been reported that in some configurations assigned GPUs might not
scale their link speed up to the maximum supported value if the
downstream port above it only advertises limited link support.

As proposed[1] this series effectively implements virtual link
negotiation on downstream ports and enhances the generic PCIe root
port to allow user configurable speeds and widths.  The "negotiation"
simply mirrors the link status of the connected downstream device
providing the appearance of dynamic link speed scaling to match the
endpoint device.  Not yet implemented from the proposal is support
for globally updating defaults based on machine type, though the
foundation is provided here by allowing supporting PCIESlots to
implement an instance_init callback which can call into a common
helper for this.

I have not specifically tested migration with this, but we already
consider LNKSTA to be dynamic and the other changes implemented here
are static config space changes with no changes being implemented for
devices using default values, ie. they should be compatible by virtue
of existing config space migration support.

I think I've covered the required link related registers to support
PCIe 4.0, but please let me know if I've missed any.

Testing and feedback appreciated, patch 6/7 provides example qemu:arg
options and requirements to use with existing libvirt.  Native libvirt
support TBD.  Thanks,

Alex

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03086.html

---

Alex Williamson (7):
      pcie: Create enums for link speed and width
      pci: Sync PCIe downstream port LNKSTA on read
      qapi: Define PCIe link speed and width properties
      pcie: Add link speed and width fields to PCIESlot
      pcie: Fill PCIESlot link fields to support higher speeds and widths
      pcie: Allow generic PCIe root port to specify link speed and width
      vfio/pci: Remove PCIe Link Status emulation


 hw/core/qdev-properties.c          |  178 ++++++++++++++++++++++++++++++++++++
 hw/pci-bridge/gen_pcie_root_port.c |    2 
 hw/pci-bridge/pcie_root_port.c     |   14 +++
 hw/pci/pci.c                       |    4 +
 hw/pci/pcie.c                      |  118 +++++++++++++++++++++++-
 hw/vfio/pci.c                      |    9 --
 include/hw/pci/pci.h               |   13 +++
 include/hw/pci/pcie.h              |    1 
 include/hw/pci/pcie_port.h         |    4 +
 include/hw/pci/pcie_regs.h         |   23 ++++-
 include/hw/qdev-properties.h       |    8 ++
 qapi/common.json                   |   42 ++++++++
 12 files changed, 404 insertions(+), 12 deletions(-)
