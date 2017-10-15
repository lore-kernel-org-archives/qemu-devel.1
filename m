Received: from eggs.gnu.org ([2001:4830:134:3::10]:48726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZVj-00020v-6t
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZVf-00065x-WE
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZVf-00065V-MB
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:22:39 -0400
Date: Sun, 15 Oct 2017 06:22:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/26] pc, pci, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57=
d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
71012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to ab06ec43577177a442e8e5ca28d0154efe4ff60f:

  tests/pxe: Test more NICs when running in SPEED=3Dslow mode (2017-10-15=
 05:54:44 +0300)

----------------------------------------------------------------
pc, pci, virtio: fixes, features

A bunch of fixes all over the place.
A new vmcore device - the user interface around it is still somewhat
controversial, but I feel most of the code is fine, suggestions can be
addressed by adding patches on top.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aleksandr Bezzubikov (1):
      hw/pci-bridge/pcie_pci_bridge: properly handle MSI unavailability c=
ase

Alexey Kardashevskiy (1):
      virtio-pci: Replace modern_as with direct access to modern_bar

Dr. David Alan Gilbert (1):
      virtio/pci/migration: Convert to VMState

Eduardo Habkost (8):
      xio3130_downstream: Report error if pcie_chassis_add_slot() failed
      pci: conventional-pci-device and pci-express-device interfaces
      pci: Add interface names to hybrid PCI devices
      pci: Add INTERFACE_PCIE_DEVICE to all PCIe devices
      pci: Add INTERFACE_CONVENTIONAL_PCI_DEVICE to Conventional PCI devi=
ces
      xen/pt: Mark TYPE_XEN_PT_DEVICE as hybrid
      pci: Validate interfaces on base_class_init
      isapc: Remove unnecessary migration compatibility code

Felipe Franciosi (1):
      virtio/vhost: reset dev->log after syncing

Laurent Vivier (1):
      pc: remove useless hot_add_cpu initialisation

Mao Zhongyi (1):
      pci: Set err to errp directly rather than through error_propagate()

Marc-Andr=C3=A9 Lureau (7):
      fw_cfg: add write callback
      hw/misc: add vmcoreinfo device
      dump: add guest ELF note
      dump: update phys_base header field based on VMCOREINFO content
      kdump: set vmcoreinfo location
      scripts/dump-guest-memory.py: add vmcoreinfo
      MAINTAINERS: add Dump maintainers

Marcel Apfelbaum (1):
      hw/gen_pcie_root_port: make IO RO 0 on IO disabled

Mark Cave-Ayland (1):
      pci: allow 32-bit PCI IO accesses to pass through the PCI bridge

Matt Redfearn (1):
      PCI: PCIe access should always be little endian

Thomas Huth (1):
      tests/pxe: Test more NICs when running in SPEED=3Dslow mode

Wolfgang Bumiller (1):
      virtio: fix descriptor counting in virtqueue_pop

 docs/specs/vmcoreinfo.txt           |  49 ++++++++++
 hw/virtio/virtio-pci.h              |  17 ++--
 include/hw/misc/vmcoreinfo.h        |  46 +++++++++
 include/hw/nvram/fw_cfg.h           |   3 +
 include/hw/pci/pci.h                |   6 ++
 include/sysemu/dump.h               |   2 +
 dump.c                              | 183 ++++++++++++++++++++++++++++++=
+++++
 hw/acpi/piix4.c                     |   1 +
 hw/acpi/vmgenid.c                   |   2 +-
 hw/audio/ac97.c                     |   4 +
 hw/audio/es1370.c                   |   4 +
 hw/audio/intel-hda.c                |   4 +
 hw/block/nvme.c                     |   4 +
 hw/char/serial-pci.c                |  12 +++
 hw/core/loader.c                    |   2 +-
 hw/display/cirrus_vga.c             |   4 +
 hw/display/qxl.c                    |   4 +
 hw/display/sm501.c                  |   4 +
 hw/display/vga-pci.c                |   4 +
 hw/display/vmware_vga.c             |   4 +
 hw/i2c/smbus_ich9.c                 |   4 +
 hw/i386/acpi-build.c                |   2 +-
 hw/i386/amd_iommu.c                 |   4 +
 hw/i386/kvm/pci-assign.c            |   4 +
 hw/i386/pc_piix.c                   |   8 +-
 hw/i386/pc_q35.c                    |   1 -
 hw/i386/xen/xen_platform.c          |   4 +
 hw/i386/xen/xen_pvdevice.c          |   4 +
 hw/ide/ich.c                        |   4 +
 hw/ide/pci.c                        |   4 +
 hw/ipack/tpci200.c                  |   4 +
 hw/isa/i82378.c                     |   4 +
 hw/isa/lpc_ich9.c                   |   5 +-
 hw/isa/piix4.c                      |   4 +
 hw/isa/vt82c686.c                   |  16 +++
 hw/mips/gt64xxx_pci.c               |   4 +
 hw/misc/edu.c                       |   5 +
 hw/misc/ivshmem.c                   |   4 +
 hw/misc/macio/macio.c               |   4 +
 hw/misc/pci-testdev.c               |   4 +
 hw/misc/vmcoreinfo.c                |  96 ++++++++++++++++++
 hw/net/e1000.c                      |   4 +
 hw/net/e1000e.c                     |   4 +
 hw/net/eepro100.c                   |   4 +
 hw/net/ne2000.c                     |   4 +
 hw/net/pcnet-pci.c                  |   4 +
 hw/net/rocker/rocker.c              |   4 +
 hw/net/rtl8139.c                    |   4 +
 hw/net/sungem.c                     |   4 +
 hw/net/sunhme.c                     |   4 +
 hw/net/vmxnet3.c                    |   5 +
 hw/nvram/fw_cfg.c                   |  14 ++-
 hw/pci-bridge/dec.c                 |   8 ++
 hw/pci-bridge/gen_pcie_root_port.c  |   7 ++
 hw/pci-bridge/i82801b11.c           |   4 +
 hw/pci-bridge/ioh3420.c             |   4 +-
 hw/pci-bridge/pci_bridge_dev.c      |   1 +
 hw/pci-bridge/pci_expander_bridge.c |   8 ++
 hw/pci-bridge/pcie_pci_bridge.c     |  25 +++--
 hw/pci-bridge/pcie_root_port.c      |   4 +
 hw/pci-bridge/xio3130_downstream.c  |   5 +
 hw/pci-bridge/xio3130_upstream.c    |   4 +
 hw/pci-host/apb.c                   |   8 ++
 hw/pci-host/bonito.c                |   4 +
 hw/pci-host/gpex.c                  |   4 +
 hw/pci-host/grackle.c               |   4 +
 hw/pci-host/piix.c                  |   8 ++
 hw/pci-host/ppce500.c               |   4 +
 hw/pci-host/prep.c                  |   4 +
 hw/pci-host/q35.c                   |   4 +
 hw/pci-host/uninorth.c              |  16 +++
 hw/pci-host/versatile.c             |   4 +
 hw/pci-host/xilinx-pcie.c           |   4 +
 hw/pci/pci.c                        |  24 +++++
 hw/pci/pci_bridge.c                 |   3 +-
 hw/pci/pcie_host.c                  |   2 +-
 hw/ppc/ppc4xx_pci.c                 |   4 +
 hw/scsi/esp-pci.c                   |   4 +
 hw/scsi/lsi53c895a.c                |   4 +
 hw/scsi/megasas.c                   |  10 ++
 hw/scsi/mptsas.c                    |   4 +
 hw/scsi/vmw_pvscsi.c                |   2 +
 hw/sd/sdhci.c                       |   4 +
 hw/sh4/sh_pci.c                     |   4 +
 hw/sparc64/sun4u.c                  |   4 +
 hw/usb/hcd-ehci-pci.c               |   4 +
 hw/usb/hcd-ohci.c                   |   4 +
 hw/usb/hcd-uhci.c                   |   4 +
 hw/usb/hcd-xhci.c                   |   5 +
 hw/vfio/pci-quirks.c                |   4 +
 hw/vfio/pci.c                       |   5 +
 hw/virtio/vhost.c                   |   5 +-
 hw/virtio/virtio-pci.c              | 188 +++++++++++++++---------------=
------
 hw/virtio/virtio.c                  |   6 +-
 hw/watchdog/wdt_i6300esb.c          |   4 +
 hw/xen/xen_pt.c                     |   5 +
 tests/pxe-test.c                    |  31 ++++--
 MAINTAINERS                         |  11 +++
 hw/misc/Makefile.objs               |   1 +
 scripts/dump-guest-memory.py        |  61 ++++++++++++
 100 files changed, 985 insertions(+), 159 deletions(-)
 create mode 100644 docs/specs/vmcoreinfo.txt
 create mode 100644 include/hw/misc/vmcoreinfo.h
 create mode 100644 hw/misc/vmcoreinfo.c
