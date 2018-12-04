Received: from eggs.gnu.org ([2001:4830:134:3::10]:36906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUDiq-0002ap-Jh
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUDWN-0005AJ-QL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:26:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUDWN-00059J-Fk
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:26:03 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 04 Dec 2018 09:25:54 -0700
Message-ID: <154393964026.28192.13536237934563059985.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-4.0 PATCH v3 0/9] pcie: Enhanced link speed and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Geoffrey McRae <geoff@hostfission.com>

v2->v3:
 - Michael suggested offline that we not commit the pcie-root-port
   driver API to support arbitrary speeds and widths without some
   necessary use case where it's required to set these outside of
   the machine type defaults.  These options therefore become
   experimental, x-speed and x-width, with the expectation that users
   can either update their machine type or use experimental options
   for old machine types.  Patches 6 & 9 affected.  Leaving Geoffrey's
   Tested-by on patch 6 as this is a superficial change.
 - Rolled in David's Ack for spapr 4.0 machine type (patch 8).

v1->v2:
 - Update for QEMU release numbering, next is 4.0 not 3.2.  Only
   patch 8 and the commit log of patch 9 updated.

RFC->v1:
 - Add Cc reported by get_maintainer
 - Fixup some commit logs (no code changes in patches 1-7)
 - Add Geoffrey's Tested-by
 - Add patches 8 & 9 which define a QEMU 3.2 machine type and cranking
   up the link speed and width for that machine type while maintaining
   compatibile speeds for older machine types (testing requested for
   non-x86 machine types)
 - Various other users have also reported success with this series
   (/r/VFIO)

Original cover letter:

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

Alex Williamson (9):
      pcie: Create enums for link speed and width
      pci: Sync PCIe downstream port LNKSTA on read
      qapi: Define PCIe link speed and width properties
      pcie: Add link speed and width fields to PCIESlot
      pcie: Fill PCIESlot link fields to support higher speeds and widths
      pcie: Allow generic PCIe root port to specify link speed and width
      vfio/pci: Remove PCIe Link Status emulation
      q35/440fx/arm/spapr: Add QEMU 4.0 machine type
      pcie: Fast PCIe root ports for new machines


 hw/arm/virt.c                      |   19 +++-
 hw/core/qdev-properties.c          |  178 ++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c                  |   15 ++-
 hw/i386/pc_q35.c                   |   13 ++-
 hw/pci-bridge/gen_pcie_root_port.c |    4 +
 hw/pci-bridge/pcie_root_port.c     |   14 +++
 hw/pci/pci.c                       |    4 +
 hw/pci/pcie.c                      |  118 +++++++++++++++++++++++-
 hw/ppc/spapr.c                     |   25 ++++-
 hw/vfio/pci.c                      |    9 --
 include/hw/compat.h                |   11 ++
 include/hw/i386/pc.h               |    3 +
 include/hw/pci/pci.h               |   13 +++
 include/hw/pci/pcie.h              |    1 
 include/hw/pci/pcie_port.h         |    4 +
 include/hw/pci/pcie_regs.h         |   23 ++++-
 include/hw/qdev-properties.h       |    8 ++
 qapi/common.json                   |   42 ++++++++
 18 files changed, 482 insertions(+), 22 deletions(-)
