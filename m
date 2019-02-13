Received: from eggs.gnu.org ([209.51.188.92]:33267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gtqsF-0007Eh-NQ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gtqsB-00021Z-QU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:30:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gtqs9-0001ui-69
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:30:29 -0500
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 13 Feb 2019 10:29:57 +0100
Message-Id: <cover.cc19031e8d42f0196630e60c9016d57d8a46e676.1550050121.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/2] pcie: Add simple ACS "support" to the
 generic PCIe root port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahsh@mellanox.com>, Tal Attaly <talat@mellanox.com>, Knut Omang <knut.omang@oracle.com>

These two patches together implements a PCIe capability
config space header for Access Control Services (ACS) for the
new Qemu specific generic root port. ACS support in the
associated root port is a prerequisite to be able to pass
individual functions of a device populating the port through to
an L2 guest from an unmodified kernel.

Without this, the IOMMU group the device belongs to will also
include the root port itself, and all functions the device provides.

It is necessary to support SR/IOV where the primary
purpose is to be able to share out individual VFs to different
guests, which will not be permitted by VFIO or the Windows Hyper-V equivalent
unless ACS is supported by the root port.

These patches can also be found as part of an updated version of
my SR/IOV emulation patch set at

  https://github.com/knuto/qemu/tree/sriov_patches_v11

The patches' basic operation with VFIO and iommu groups have
been tested with the above patch set and a rebased version of an
in progress igb ethernet device, which needs some more care
before I can let it go out.

Changes from v3:
----------------
- rebased to the latest qemu master
- Revised commit message and comments for patch #1 to make it
  clearer that VFIO works for single function devices even without ACS.
- Improved checking for valid endpoints for ACS.
- Fixed comment style issue
- Co-locate the pci_acs_init and _reset functions and
  rename pci_cap_acs_reset to pci_acs_reset to adhere to the naming
  conventions that _cap_ functions in pcie is for changing state
  in the main pcie capability and not the individual extended
  capabilities.
- Added Marcel's r-b to patch 2, which did not change

Changes from v2:
----------------
- rebased to the latest qemu master

Incorporated further feedback from Alex:
- Make sure slot/downstream capability bits are only set for slots.
- Make acs reset callback do nothing if no acs capability exists
- Set correct acs version
- div simplification

Changes from v1:
----------------
Incorporated feedback from Alex Williamson:
- Make commit messages reflect a more correct understanding of how this
  affects VFIO operation.
- Implemented the CTRL register properly (reset callback + making non-implemented
  capabilities RO, default value 0)
- removed the egress ctrl vector parameter to the init function
- Fixed some whitespace issues

Knut Omang (2):
  pcie: Add a simple PCIe ACS (Access Control Services) helper function
  gen_pcie_root_port: Add ACS (Access Control Services) capability

 hw/pci-bridge/gen_pcie_root_port.c |  4 +++-
 hw/pci-bridge/pcie_root_port.c     |  4 +++-
 hw/pci/pcie.c                      | 39 +++++++++++++++++++++++++++++++-
 include/hw/pci/pcie.h              |  6 +++++-
 include/hw/pci/pcie_port.h         |  1 +-
 include/hw/pci/pcie_regs.h         |  4 +++-
 6 files changed, 58 insertions(+)

base-commit: 0b5e750bea635b167eb03d86c3d9a09bbd43bc06
-- 
git-series 0.9.1
