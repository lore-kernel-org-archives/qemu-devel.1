Received: from eggs.gnu.org ([2001:4830:134:3::10]:57677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTt1-0001Aj-I6
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTso-0003ho-Ul
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFTso-0003g4-7G
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:18 -0400
Date: Wed, 24 Oct 2018 20:52:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025005110.249256-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/28] pci, pc, virtio: fixes, features
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

The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6a9fb4e1ba5594cde7739068617ad88e6117db93:

  vhost-scsi: prevent using uninitialized vqs (2018-10-24 20:50:13 -0400)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

AMD IOMMU VAPIC support + fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gerd Hoffmann (1):
      pci-testdev: add optional memory bar

Laszlo Ersek (4):
      MAINTAINERS: list "tests/acpi-test-data" files in ACPI/SMBIOS secti=
on
      hw/pci-host/x86: extract get_pci_hole64_start_value() helpers
      hw/pci-host/x86: extend the 64-bit PCI hole relative to the fw-assi=
gned base
      tests/bios-tables-test: add 64-bit PCI MMIO aperture round-up test =
on Q35

Li Qiang (3):
      i440fx: use ARRAY_SIZE for pam_regions
      piix: use TYPE_FOO constants than string constats
      piix_pci: fix i440fx data sheet link

Mao Zhongyi (1):
      pci_bridge: fix typo in comment

Peter Xu (4):
      intel_iommu: introduce vtd_reset_caches()
      intel_iommu: better handling of dmar state switch
      intel_iommu: move ce fetching out when sync shadow
      intel_iommu: handle invalid ce for shadow sync

Philippe Mathieu-Daud=C3=A9 (3):
      hw/pci-bridge/xio3130: Remove unused functions
      hw/pci-bridge/ioh3420: Remove unuseful header
      hw/pci: Add missing include

Singh, Brijesh (9):
      x86_iommu: move the kernel-irqchip check in common code
      x86_iommu: move vtd_generate_msi_message in common file
      x86_iommu/amd: remove V=3D1 check from amdvi_validate_dte()
      x86_iommu/amd: make the address space naming consistent with intel-=
iommu
      x86_iommu/amd: Prepare for interrupt remap support
      x86_iommu/amd: Add interrupt remap support when VAPIC is not enable=
d
      i386: acpi: add IVHD device entry for IOAPIC
      x86_iommu/amd: Add interrupt remap support when VAPIC is enabled
      x86_iommu/amd: Enable Guest virtual APIC support

Yaowei Bai (1):
      virtio-blk: fix comment for virtio_blk_rw_complete

Yongji Xie (1):
      vhost-user-blk: start vhost when guest kicks

yuchenlin (1):
      vhost-scsi: prevent using uninitialized vqs

 docs/specs/pci-testdev.txt           |  15 +-
 hw/i386/amd_iommu.h                  |  96 +++++++-
 hw/pci-bridge/ioh3420.h              |   6 -
 hw/pci-bridge/xio3130_downstream.h   |  11 -
 hw/pci-bridge/xio3130_upstream.h     |  10 -
 include/hw/i386/intel_iommu.h        |  59 -----
 include/hw/i386/x86-iommu.h          |  66 ++++++
 include/hw/pci/pci_bus.h             |   2 +
 hw/block/vhost-user-blk.c            |  25 +++
 hw/block/virtio-blk.c                |   4 +-
 hw/i386/acpi-build.c                 |  31 ++-
 hw/i386/amd_iommu.c                  | 414 +++++++++++++++++++++++++++++=
+++++-
 hw/i386/intel_iommu.c                | 131 +++++------
 hw/i386/x86-iommu.c                  |  33 +++
 hw/misc/pci-testdev.c                |  19 ++
 hw/pci-bridge/ioh3420.c              |   2 +-
 hw/pci-bridge/xio3130_downstream.c   |  28 +--
 hw/pci-bridge/xio3130_upstream.c     |  24 +-
 hw/pci-host/piix.c                   |  34 ++-
 hw/pci-host/q35.c                    |  17 +-
 hw/pci/pci_bridge.c                  |   2 +-
 hw/scsi/vhost-scsi.c                 |   2 +-
 tests/bios-tables-test.c             |  16 ++
 MAINTAINERS                          |   2 +
 hw/i386/trace-events                 |  14 ++
 tests/acpi-test-data/q35/DSDT.mmio64 | Bin 0 -> 8947 bytes
 tests/acpi-test-data/q35/SRAT.mmio64 | Bin 0 -> 224 bytes
 27 files changed, 811 insertions(+), 252 deletions(-)
 delete mode 100644 hw/pci-bridge/ioh3420.h
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h
 create mode 100644 tests/acpi-test-data/q35/DSDT.mmio64
 create mode 100644 tests/acpi-test-data/q35/SRAT.mmio64
