Received: from eggs.gnu.org ([2001:4830:134:3::10]:58824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJy0u-00022J-8e
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJy0r-0005d3-IN
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:38 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:43975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eJy0r-0005Z5-45
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:46:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 29 Nov 2017 19:46:21 +1100
Message-Id: <20171129084628.12336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Here are a bunch of straightforward cleanups for the PCI code in
qemu-2.12.  These came up while I was looking at various other things.

David Gibson (7):
  pci: Rename root bus initialization functions for clarity
  pci: Move bridge data structures from pci_bus.h to pci_bridge.h
  pci: Fold pci_bus.h into pci.h
  pci: Simplify pci_bus_is_root()
  pci: Add pci_dev_bus_num() helper
  pci: Eliminate redundant PCIDevice::bus pointer
  pci: Eliminate pci_find_primary_bus()

 hw/acpi/pcihp.c                     |   5 +-
 hw/acpi/piix4.c                     |   7 +-
 hw/alpha/typhoon.c                  |   8 +-
 hw/i386/acpi-build.c                |   1 -
 hw/i386/amd_iommu.h                 |   1 -
 hw/i386/intel_iommu.c               |   1 -
 hw/i386/pc.c                        |   1 -
 hw/i386/pc_piix.c                   |   8 +-
 hw/i386/xen/xen_platform.c          |  12 +--
 hw/isa/lpc_ich9.c                   |  11 ++-
 hw/mips/gt64xxx_pci.c               |  12 +--
 hw/net/vmxnet3.c                    |   2 +-
 hw/pci-bridge/dec.c                 |   1 -
 hw/pci-bridge/pci_bridge_dev.c      |   1 -
 hw/pci-bridge/pci_expander_bridge.c |  28 +++----
 hw/pci-bridge/pcie_pci_bridge.c     |   1 -
 hw/pci-host/apb.c                   |  11 ++-
 hw/pci-host/bonito.c                |   8 +-
 hw/pci-host/gpex.c                  |   6 +-
 hw/pci-host/grackle.c               |  14 ++--
 hw/pci-host/piix.c                  |  14 ++--
 hw/pci-host/ppce500.c               |   6 +-
 hw/pci-host/prep.c                  |   5 +-
 hw/pci-host/q35.c                   |   7 +-
 hw/pci-host/uninorth.c              |  24 +++---
 hw/pci-host/versatile.c             |   9 +--
 hw/pci-host/xilinx-pcie.c           |   6 +-
 hw/pci/pci.c                        | 152 ++++++++++++++++--------------------
 hw/pci/pci_bridge.c                 |   7 +-
 hw/pci/pci_host.c                   |   1 -
 hw/pci/pcie.c                       |   6 +-
 hw/pci/pcie_aer.c                   |   5 +-
 hw/pci/shpc.c                       |   1 -
 hw/ppc/ppc4xx_pci.c                 |   6 +-
 hw/ppc/spapr_pci.c                  |  11 ++-
 hw/s390x/s390-pci-bus.c             |  19 +++--
 hw/scsi/megasas.c                   |   2 +-
 hw/scsi/mptsas.c                    |   2 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/sh4/sh_pci.c                     |  12 +--
 hw/sparc64/sun4u.c                  |   1 -
 hw/usb/hcd-xhci.c                   |   2 +-
 hw/vfio/pci.c                       |  10 +--
 hw/virtio/virtio-pci.c              |   4 +-
 hw/xen/xen_pt.c                     |  10 +--
 include/hw/i386/ich9.h              |   1 -
 include/hw/pci-host/xilinx-pcie.h   |   2 +-
 include/hw/pci/pci.h                |  94 +++++++++++++++++-----
 include/hw/pci/pci_bridge.h         |  47 +++++++++++
 include/hw/pci/pci_bus.h            |  94 ----------------------
 include/hw/pci/pcie_port.h          |   1 -
 include/hw/xen/xen_common.h         |   8 +-
 52 files changed, 336 insertions(+), 374 deletions(-)
 delete mode 100644 include/hw/pci/pci_bus.h

-- 
2.14.3
