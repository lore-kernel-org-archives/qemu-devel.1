Received: from eggs.gnu.org ([209.51.188.92]:58745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNHH-0005NT-IL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNHB-00063J-EW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmNH9-0005zG-Gj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:29:23 -0500
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 23 Jan 2019 19:27:58 +0100
Message-Id: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] pcie: Add simple ACS "support" to the
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tal Attaly <talat@mellanox.com>, Elijah Shakkour <elijahs@mellanox.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Knut Omang <knut.omang@oracle.com>

These two patches together implements a PCIe capability
config space header for Access Control Services (ACS) for the
new Qemu specific generic root port. ACS support in the
associated root port is a prerequisite to be able to pass the a function of
the device populating the port through to an L2 guest from an unmodified kernel.
Without this, the IOMMU group the device belongs to will also
include the root port itself, and all functions the device provides.

With an SR/IOV device this becomes even more important, as the whole
purpose with SR/IOV is to be able to share out individual VFs to different
guests, which will not be permitted by VFIO or the Windows Hyper-V equivalent
unless ACS is supported by the root port.

These patches can also be found as part of an updated version of
my SR/IOV emulation patch set at

  https://github.com/knuto/qemu/tree/sriov_patches_v9

Knut Omang (2):
  pcie: Add a simple PCIe ACS (Access Control Services) helper function
  gen_pcie_root_port: Add ACS (Access Control Services) capability

 hw/pci-bridge/gen_pcie_root_port.c |  2 ++
 hw/pci-bridge/ioh3420.c            |  1 -
 hw/pci-bridge/pcie_root_port.c     |  3 +++
 hw/pci/pcie.c                      | 14 ++++++++++++++
 include/hw/pci/pcie.h              |  1 +
 include/hw/pci/pcie_port.h         |  1 +
 include/hw/pci/pcie_regs.h         |  4 ++++
 7 files changed, 25 insertions(+), 1 deletion(-)

base-commit: a8d2b0685681e2f291faaa501efbbd76875f8ec8
-- 
git-series 0.9.1
