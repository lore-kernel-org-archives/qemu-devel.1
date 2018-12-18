Received: from eggs.gnu.org ([2001:4830:134:3::10]:53590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHxi-0004aX-3P
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHxe-0001KN-8M
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHxd-0001K1-WA
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:10 -0500
Date: Tue, 18 Dec 2018 11:11:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/30] pci, pc, virtio: fixes, features
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

Changes from v1:
    Drop
        intel_iommu: turn on IR by default

The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f=
6c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into =
staging (2018-12-17 13:04:25 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d4ea2be7e8718ad6c1e5810bee6bdf5a0b8f31b8:

  hw/i386: Remove deprecated machines pc-0.10 and pc-0.11 (2018-12-18 11:=
09:02 -0500)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

VTD fixes
ACPI refactoring
new names for virtio devices
multiple pcie link width/speeds

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Williamson (8):
      pcie: Create enums for link speed and width
      pci: Sync PCIe downstream port LNKSTA on read
      qapi: Define PCIe link speed and width properties
      pcie: Add link speed and width fields to PCIESlot
      pcie: Fill PCIESlot link fields to support higher speeds and widths
      pcie: Allow generic PCIe root port to specify link speed and width
      vfio/pci: Remove PCIe Link Status emulation
      pcie: Fast PCIe root ports for new machines

Corey Minyard (1):
      pc:piix4: Update smbus I/O space after a migration

Eduardo Habkost (2):
      virtio: Helper for registering virtio device types
      virtio: Provide version-specific variants of virtio PCI devices

Igor Mammedov (2):
      hw: arm: acpi: Fix incorrect checksums in RSDP
      hw: i386: Use correct RSDT length for checksum

Matthias Weckbecker (1):
      hw/pci-bridge: Fix invalid free()

Peter Xu (4):
      intel_iommu: dump correct iova when failed
      intel_iommu: convert invalid traces into error reports
      intel_iommu: dma read/write draining support
      intel_iommu: remove "x-" prefix for "aw-bits"

Philippe Mathieu-Daud=C3=A9 (4):
      tests: Remove unused include
      hw/smbios: Restrict access to "hw/smbios/ipmi.h"
      hw/smbios: Remove "smbios_ipmi.h"
      hw/smbios: Move to the hw/firmware/ subdirectory

Samuel Ortiz (6):
      hw: acpi: The RSDP build API can return void
      hw: arm: Carry RSDP specific data through AcpiRsdpData
      hw: arm: Convert the RSDP build to the buid_append_foo() API
      hw: arm: Support both legacy and current RSDP build
      hw: acpi: Export and share the ARM RSDP build
      hw: acpi: Remove AcpiRsdpDescriptor and fix tests

Thomas Huth (1):
      hw/i386: Remove deprecated machines pc-0.10 and pc-0.11

Zheng Xiang (1):
      pcie: set link state inactive/active after hot unplug/plug

 qapi/common.json                         |  42 +++++
 hw/i386/intel_iommu_internal.h           |   3 +
 hw/smbios/smbios_build.h                 |   4 +
 hw/virtio/virtio-pci.h                   |  78 +++++++--
 include/hw/acpi/acpi-defs.h              |  19 +--
 include/hw/acpi/aml-build.h              |   2 +
 include/hw/compat.h                      |  10 +-
 include/hw/{smbios =3D> firmware}/smbios.h |   0
 include/hw/i386/intel_iommu.h            |   1 +
 include/hw/i386/pc.h                     |   5 +
 include/hw/pci/pci.h                     |  13 ++
 include/hw/pci/pcie.h                    |   1 +
 include/hw/pci/pcie_port.h               |   4 +
 include/hw/pci/pcie_regs.h               |  23 ++-
 include/hw/qdev-properties.h             |   8 +
 include/hw/smbios/ipmi.h                 |  15 --
 tests/acpi-utils.h                       |   4 +-
 hw/acpi/aml-build.c                      |  68 ++++++++
 hw/acpi/piix4.c                          |   1 +
 hw/arm/virt-acpi-build.c                 |  40 +----
 hw/arm/virt.c                            |   2 +-
 hw/core/qdev-properties.c                | 176 ++++++++++++++++++++
 hw/display/virtio-gpu-pci.c              |   7 +-
 hw/display/virtio-vga.c                  |   7 +-
 hw/i386/acpi-build.c                     |  46 +++---
 hw/i386/intel_iommu.c                    |  66 ++++++--
 hw/i386/pc.c                             |   2 +-
 hw/i386/pc_piix.c                        |  72 +-------
 hw/i386/pc_q35.c                         |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c       |   4 +
 hw/pci-bridge/pcie_root_port.c           |  14 ++
 hw/pci/pci.c                             |   4 +
 hw/pci/pci_bridge.c                      |   2 +-
 hw/pci/pcie.c                            | 132 ++++++++++++++-
 hw/smbios/smbios-stub.c                  |   2 +-
 hw/smbios/smbios.c                       |   3 +-
 hw/smbios/smbios_type_38-stub.c          |   2 +-
 hw/smbios/smbios_type_38.c               |   3 +-
 hw/vfio/pci.c                            |   9 +-
 hw/virtio/virtio-crypto-pci.c            |   7 +-
 hw/virtio/virtio-pci.c                   | 271 +++++++++++++++++++++++--=
------
 tests/acpi-utils.c                       |  47 +++++-
 tests/bios-tables-test.c                 |  24 ++-
 tests/cpu-plug-test.c                    |   4 +-
 tests/vmgenid-test.c                     |   8 +-
 vl.c                                     |   2 +-
 MAINTAINERS                              |   2 +-
 hw/i386/trace-events                     |   6 -
 qemu-deprecated.texi                     |   2 +-
 tests/acceptance/virtio_version.py       | 176 ++++++++++++++++++++
 50 files changed, 1128 insertions(+), 317 deletions(-)
 rename include/hw/{smbios =3D> firmware}/smbios.h (100%)
 delete mode 100644 include/hw/smbios/ipmi.h
 create mode 100644 tests/acceptance/virtio_version.py
