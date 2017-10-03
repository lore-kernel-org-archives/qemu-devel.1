Received: from eggs.gnu.org ([2001:4830:134:3::10]:37698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHb-0003Yn-Cg
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJHa-0004i6-Co
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzJHZ-0004XU-Pp
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:14:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Oct 2017 20:14:18 +1100
Message-Id: <20171003091423.28704-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 0/5] Assorted PCI/PCIe cleanups cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, ehabkost@redhat.com, marcel@redhat.com
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, David Gibson <david@gibson.dropbear.id.au>

I've been reworking my patches to consolidate the handling of PCI/PCIe
"hybrid" devices based on feedback from my earlier series.  I'm still
wrestling with some problems here, but along the way I've made some
cleanups which I think stand on their own.  So, here they are.

I built these on top of Eduardo's series to advertise PCI and PCIe
capability of devices via interface names.  I don't think I
fundamentally rely on anything in there, but if there are conflicts
against master, that'd be why.

David Gibson (5):
  pci: Rename root bus initialization functions for clarity
  pci: Move bridge data structures from pci_bus.h to pci_bridge.h
  pci: Fold pci_bus.h into pci.h
  pci: Simplify pci_bus_is_root()
  pcie: Don't allow extended config space access via conventional PCI
    bridges

 hw/acpi/pcihp.c                     |  1 -
 hw/alpha/typhoon.c                  |  8 ++--
 hw/i386/acpi-build.c                |  1 -
 hw/i386/amd_iommu.h                 |  1 -
 hw/i386/intel_iommu.c               |  1 -
 hw/i386/pc.c                        |  1 -
 hw/isa/lpc_ich9.c                   |  1 -
 hw/mips/gt64xxx_pci.c               | 12 ++---
 hw/pci-bridge/dec.c                 |  1 -
 hw/pci-bridge/pci_bridge_dev.c      |  1 -
 hw/pci-bridge/pci_expander_bridge.c | 11 +----
 hw/pci-bridge/pcie_pci_bridge.c     |  1 -
 hw/pci-host/apb.c                   | 11 ++---
 hw/pci-host/bonito.c                |  8 ++--
 hw/pci-host/gpex.c                  |  6 +--
 hw/pci-host/grackle.c               | 14 +++---
 hw/pci-host/piix.c                  |  4 +-
 hw/pci-host/ppce500.c               |  6 +--
 hw/pci-host/prep.c                  |  5 +-
 hw/pci-host/q35.c                   |  7 +--
 hw/pci-host/uninorth.c              | 24 +++++-----
 hw/pci-host/versatile.c             |  7 ++-
 hw/pci-host/xilinx-pcie.c           |  6 +--
 hw/pci/pci.c                        | 71 ++++++++++++++--------------
 hw/pci/pci_bridge.c                 |  1 -
 hw/pci/pci_host.c                   |  1 -
 hw/pci/pcie.c                       |  1 -
 hw/pci/pcie_aer.c                   |  1 -
 hw/pci/shpc.c                       |  1 -
 hw/ppc/ppc4xx_pci.c                 |  6 +--
 hw/ppc/spapr_pci.c                  |  9 ++--
 hw/s390x/s390-pci-bus.c             |  9 ++--
 hw/sh4/sh_pci.c                     | 12 ++---
 include/hw/i386/ich9.h              |  1 -
 include/hw/pci-host/xilinx-pcie.h   |  2 +-
 include/hw/pci/pci.h                | 91 ++++++++++++++++++++++++++++-------
 include/hw/pci/pci_bridge.h         | 47 +++++++++++++++++++
 include/hw/pci/pci_bus.h            | 94 -------------------------------------
 include/hw/pci/pcie_port.h          |  1 -
 39 files changed, 237 insertions(+), 249 deletions(-)
 delete mode 100644 include/hw/pci/pci_bus.h

-- 
2.13.6
