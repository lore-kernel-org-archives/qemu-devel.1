Received: from eggs.gnu.org ([2001:4830:134:3::10]:47385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIRu-0006F4-Ea
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIRr-00074O-D6
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:56:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxIRr-00073y-4Q
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:56:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 16:56:30 -0300
Message-Id: <20170927195635.16014-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Mark conventional/PCIe/hybrid PCI
 devices using interface names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Changes v1 -> v2:
* Use "Conventional PCI" instead of "legacy PCI"
  * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
* Mark base-xhci as hybrid too
  * Reported-by: Marcel Apfelbaum <marcel@redhat.com>
* Mark pcie-pci-bridge as PCI Express only
* New Conventional PCI devices: sungem, sunhme

v1 was a reimplementation of one portion of an old RFC:
  Subject: [RFC v2 00/20] qmp: Report bus information on
           'query-machines'

This series marks each PCI device type as Conventional PCI, PCI
Express, or "hybrid".  It uses two new QOM interface names to do
that: INTERFACE_CONVENTIONAL_PCI_DEVICE
("conventional-pci-device") and INTERFACE_PCIE_DEVICE
("pci-express-device").  Conventional PCI devices will implement
only the former; PCIe-only devices will implement only the
latter; hybrid devices will implement both interfaces.

With this, management software will then be able to use
qom-list-types to find out which PCI devices are
conventional/express/hybrid.

In the future, the new interface names can be used in the
bus/slot querying commands, to indicate which types of devices
are accepted on each slot.

The last patch in the series adds an assertion to the PCI device
class code, to ensure we won't forget to add the corresponding
interface names to new PCI device classes.

Eduardo Habkost (5):
  pci: conventional-pci-device and pci-express-device interfaces
  pci: Add interface names to hybrid PCI devices
  pci: Add INTERFACE_PCIE_DEVICE to all PCIe devices
  pci: Add INTERFACE_CONVENTIONAL_PCI_DEVICE to Conventional PCI devices
  pci: Validate interfaces on base_class_init

 include/hw/pci/pci.h                |  6 ++++++
 hw/acpi/piix4.c                     |  1 +
 hw/audio/ac97.c                     |  4 ++++
 hw/audio/es1370.c                   |  4 ++++
 hw/audio/intel-hda.c                |  4 ++++
 hw/block/nvme.c                     |  4 ++++
 hw/char/serial-pci.c                | 12 ++++++++++++
 hw/display/cirrus_vga.c             |  4 ++++
 hw/display/qxl.c                    |  4 ++++
 hw/display/sm501.c                  |  4 ++++
 hw/display/vga-pci.c                |  4 ++++
 hw/display/vmware_vga.c             |  4 ++++
 hw/i2c/smbus_ich9.c                 |  4 ++++
 hw/i386/amd_iommu.c                 |  4 ++++
 hw/i386/kvm/pci-assign.c            |  4 ++++
 hw/i386/pc_piix.c                   |  4 ++++
 hw/i386/xen/xen_platform.c          |  4 ++++
 hw/i386/xen/xen_pvdevice.c          |  4 ++++
 hw/ide/ich.c                        |  4 ++++
 hw/ide/pci.c                        |  4 ++++
 hw/ipack/tpci200.c                  |  4 ++++
 hw/isa/i82378.c                     |  4 ++++
 hw/isa/lpc_ich9.c                   |  1 +
 hw/isa/piix4.c                      |  4 ++++
 hw/isa/vt82c686.c                   | 16 ++++++++++++++++
 hw/mips/gt64xxx_pci.c               |  4 ++++
 hw/misc/edu.c                       |  5 +++++
 hw/misc/ivshmem.c                   |  4 ++++
 hw/misc/macio/macio.c               |  4 ++++
 hw/misc/pci-testdev.c               |  4 ++++
 hw/net/e1000.c                      |  4 ++++
 hw/net/e1000e.c                     |  4 ++++
 hw/net/eepro100.c                   |  4 ++++
 hw/net/ne2000.c                     |  4 ++++
 hw/net/pcnet-pci.c                  |  4 ++++
 hw/net/rocker/rocker.c              |  4 ++++
 hw/net/rtl8139.c                    |  4 ++++
 hw/net/sungem.c                     |  4 ++++
 hw/net/sunhme.c                     |  4 ++++
 hw/net/vmxnet3.c                    |  5 +++++
 hw/pci-bridge/dec.c                 |  8 ++++++++
 hw/pci-bridge/i82801b11.c           |  4 ++++
 hw/pci-bridge/pci_bridge_dev.c      |  1 +
 hw/pci-bridge/pci_expander_bridge.c |  8 ++++++++
 hw/pci-bridge/pcie_pci_bridge.c     |  1 +
 hw/pci-bridge/pcie_root_port.c      |  4 ++++
 hw/pci-bridge/xio3130_downstream.c  |  4 ++++
 hw/pci-bridge/xio3130_upstream.c    |  4 ++++
 hw/pci-host/apb.c                   |  8 ++++++++
 hw/pci-host/bonito.c                |  4 ++++
 hw/pci-host/gpex.c                  |  4 ++++
 hw/pci-host/grackle.c               |  4 ++++
 hw/pci-host/piix.c                  |  8 ++++++++
 hw/pci-host/ppce500.c               |  4 ++++
 hw/pci-host/prep.c                  |  4 ++++
 hw/pci-host/q35.c                   |  4 ++++
 hw/pci-host/uninorth.c              | 16 ++++++++++++++++
 hw/pci-host/versatile.c             |  4 ++++
 hw/pci-host/xilinx-pcie.c           |  4 ++++
 hw/pci/pci.c                        | 24 ++++++++++++++++++++++++
 hw/ppc/ppc4xx_pci.c                 |  4 ++++
 hw/scsi/esp-pci.c                   |  4 ++++
 hw/scsi/lsi53c895a.c                |  4 ++++
 hw/scsi/megasas.c                   | 10 ++++++++++
 hw/scsi/mptsas.c                    |  4 ++++
 hw/scsi/vmw_pvscsi.c                |  2 ++
 hw/sd/sdhci.c                       |  4 ++++
 hw/sh4/sh_pci.c                     |  4 ++++
 hw/sparc64/sun4u.c                  |  4 ++++
 hw/usb/hcd-ehci-pci.c               |  4 ++++
 hw/usb/hcd-ohci.c                   |  4 ++++
 hw/usb/hcd-uhci.c                   |  4 ++++
 hw/usb/hcd-xhci.c                   |  5 +++++
 hw/vfio/pci-quirks.c                |  4 ++++
 hw/vfio/pci.c                       |  5 +++++
 hw/virtio/virtio-pci.c              |  5 +++++
 hw/watchdog/wdt_i6300esb.c          |  4 ++++
 hw/xen/xen_pt.c                     |  4 ++++
 78 files changed, 379 insertions(+)

--=20
2.13.5
