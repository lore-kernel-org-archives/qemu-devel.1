Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Gx-0007Kn-TF
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Gt-0002M0-2A
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7Gs-0002Km-Ok
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:34 -0400
Date: Mon, 3 Jul 2017 22:44:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/21] pc, acpi, pci, virtio: fixes, cleanups,
 features, tests
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

The following changes since commit fd479c60f5766f7fb247ad146b9e3c33d03d2055:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170603' into staging (2017-07-03 09:54:32 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d2f9ca94165b10c51d6d6cae5fe1cadf1ca42076:

  i386/acpi: update expected acpi files (2017-07-03 22:42:36 +0300)

----------------------------------------------------------------
pc, acpi, pci, virtio: fixes, cleanups, features, tests

Some fixes and cleanups. New tests.
Configurable tx queue size for virtio-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aleksandr Bezzubikov (1):
      hw/acpi: remove dead acpi code

Ben Warren (1):
      tests: Add unit tests for the VM Generation ID feature

Ladi Prosek (1):
      intel_iommu: relax iq tail check on VTD_GCMD_QIE enable

Mao Zhongyi (9):
      pci: Clean up error checking in pci_add_capability()
      pci: Add comment for pci_add_capability2()
      pci: Fix the wrong assertion.
      pci: Make errp the last parameter of pci_add_capability()
      pci: Replace pci_add_capability2() with pci_add_capability()
      pci: Convert to realize
      pci: Convert shpc_init() to Error
      i386/kvm/pci-assign: Fix return type of verify_irqchip_kernel()
      i386/kvm/pci-assign: Use errp directly rather than local_err

Mark Cave-Ayland (2):
      fw_cfg: don't map the fw_cfg IO ports in fw_cfg_io_realize()
      fw_cfg: move setting of FW_CFG_VERSION_DMA bit to fw_cfg_init1()

Maxime Coquelin (2):
      vhost: ensure vhost_ops are set before calling iotlb callback
      vhost-user: unregister slave req handler at cleanup time

Michael S. Tsirkin (2):
      virtio-net: fix tx queue size for !vhost-user
      i386/acpi: update expected acpi files

Peter Xu (1):
      intel_iommu: fix migration breakage on mr switch

Thomas Huth (1):
      hw/pci-bridge/dec: Classify the DEC PCI bridge as bridge device

Wei Wang (1):
      virtio-net: enable configurable tx queue size

 include/hw/pci/pci.h                 |   2 -
 include/hw/pci/pci_bridge.h          |   3 +-
 include/hw/pci/pcie.h                |   3 +-
 include/hw/pci/shpc.h                |   3 +-
 include/hw/pci/slotid_cap.h          |   3 +-
 include/hw/virtio/virtio-net.h       |   1 +
 hw/i386/acpi-build.c                 |  10 --
 hw/i386/amd_iommu.c                  |  24 +++--
 hw/i386/intel_iommu.c                |  48 ++++++---
 hw/i386/kvm/pci-assign.c             |  54 ++++------
 hw/ide/ich.c                         |   2 +-
 hw/net/e1000e.c                      |  30 +++---
 hw/net/eepro100.c                    |  18 +++-
 hw/net/virtio-net.c                  |  44 +++++++-
 hw/nvram/fw_cfg.c                    |  32 +++---
 hw/pci-bridge/dec.c                  |   2 +
 hw/pci-bridge/i82801b11.c            |  12 +--
 hw/pci-bridge/pci_bridge_dev.c       |  14 ++-
 hw/pci-bridge/pcie_root_port.c       |  18 ++--
 hw/pci-bridge/xio3130_downstream.c   |  20 ++--
 hw/pci-bridge/xio3130_upstream.c     |  20 ++--
 hw/pci/msi.c                         |   2 +-
 hw/pci/msix.c                        |   2 +-
 hw/pci/pci.c                         |  24 +----
 hw/pci/pci_bridge.c                  |   8 +-
 hw/pci/pcie.c                        |  28 +++--
 hw/pci/shpc.c                        |  10 +-
 hw/pci/slotid_cap.c                  |  12 ++-
 hw/usb/hcd-xhci.c                    |   2 +-
 hw/vfio/pci.c                        |  15 +--
 hw/virtio/vhost-backend.c            |  10 +-
 hw/virtio/vhost-user.c               |   1 +
 hw/virtio/virtio-pci.c               |  12 ++-
 tests/vmgenid-test.c                 | 203 +++++++++++++++++++++++++++++++++++
 hw/i386/trace-events                 |   2 +-
 tests/Makefile.include               |   2 +
 tests/acpi-test-data/q35/DSDT        | Bin 7824 -> 7782 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7841 -> 7799 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8287 -> 8245 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7899 -> 7857 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9189 -> 9147 bytes
 41 files changed, 492 insertions(+), 204 deletions(-)
 create mode 100644 tests/vmgenid-test.c
