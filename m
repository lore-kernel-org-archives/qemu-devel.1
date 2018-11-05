Received: from eggs.gnu.org ([2001:4830:134:3::10]:59668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjOW-0005x8-3o
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjOS-0000cB-Go
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:14:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjOS-0000ae-53
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:14:32 -0500
Date: Mon, 5 Nov 2018 13:14:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/33] pci, pc, virtio: fixes, features
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

The following changes since commit b2f7a038bb4c4fc5ce6b8486e8513dfd97665e=
2a:

  Merge remote-tracking branch 'remotes/rth/tags/pull-softfloat-20181104'=
 into staging (2018-11-05 10:32:49 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6196df5c8e6688c1c3f06f73442820066335337c:

  vhost-scsi: prevent using uninitialized vqs (2018-11-05 12:59:35 -0500)

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

Michael S. Tsirkin (1):
      bios-tables-test: prepare expected files for mmio64

Peter Maydell (4):
      tests: Move tests/acpi-test-data/ to tests/data/acpi/
      tests: Move tests/hex-loader-check-data/ to tests/data/hex-loader/
      configure: Rename FILES variable to LINKS
      configure: Use LINKS loop for all build tree symlinks

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

 docs/specs/pci-testdev.txt                         |  15 +-
 configure                                          |  57 ++-
 hw/i386/amd_iommu.h                                |  96 ++++-
 hw/pci-bridge/ioh3420.h                            |   6 -
 hw/pci-bridge/xio3130_downstream.h                 |  11 -
 hw/pci-bridge/xio3130_upstream.h                   |  10 -
 include/hw/i386/intel_iommu.h                      |  59 ---
 include/hw/i386/x86-iommu.h                        |  66 ++++
 include/hw/pci/pci_bus.h                           |   2 +
 hw/block/vhost-user-blk.c                          |  25 ++
 hw/block/virtio-blk.c                              |   4 +-
 hw/i386/acpi-build.c                               |  31 +-
 hw/i386/amd_iommu.c                                | 414 +++++++++++++++=
+++++-
 hw/i386/intel_iommu.c                              | 131 +++----
 hw/i386/x86-iommu.c                                |  33 ++
 hw/misc/pci-testdev.c                              |  19 +
 hw/pci-bridge/ioh3420.c                            |   2 +-
 hw/pci-bridge/xio3130_downstream.c                 |  28 +-
 hw/pci-bridge/xio3130_upstream.c                   |  24 +-
 hw/pci-host/piix.c                                 |  34 +-
 hw/pci-host/q35.c                                  |  17 +-
 hw/pci/pci_bridge.c                                |   2 +-
 hw/scsi/vhost-scsi.c                               |   2 +-
 tests/bios-tables-test.c                           |  18 +-
 tests/hexloader-test.c                             |   2 +-
 MAINTAINERS                                        |   4 +-
 hw/i386/trace-events                               |  14 +
 tests/{acpi-test-data =3D> data/acpi}/pc/APIC        | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/APIC.cphp   | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/APIC.dimmpxm  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/DSDT        | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.bridge | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.cphp   | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/DSDT.dimmpxm  | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/DSDT.ipmikcs  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.memhp  | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/DSDT.numamem  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/FACP        | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/FACS        | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/HPET        | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/NFIT.dimmpxm  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/SLIT.cphp   | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/SLIT.memhp  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.cphp   | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/SRAT.dimmpxm  | Bin
 tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.memhp  | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/SRAT.numamem  | Bin
 .../{acpi-test-data =3D> data/acpi}/pc/SSDT.dimmpxm  | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/APIC       | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/APIC.cphp  | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/APIC.dimmpxm | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/DSDT       | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/DSDT.bridge  | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.cphp  | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/DSDT.dimmpxm | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/DSDT.ipmibt  | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.memhp | Bin
 tests/data/acpi/q35/DSDT.mmio64                    | Bin 0 -> 8947 bytes
 .../{acpi-test-data =3D> data/acpi}/q35/DSDT.numamem | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/FACP       | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/FACS       | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/HPET       | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/MCFG       | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/NFIT.dimmpxm | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/SLIT.cphp  | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/SLIT.memhp | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.cphp  | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/SRAT.dimmpxm | Bin
 tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.memhp | Bin
 tests/data/acpi/q35/SRAT.mmio64                    | Bin 0 -> 224 bytes
 .../{acpi-test-data =3D> data/acpi}/q35/SRAT.numamem | Bin
 .../{acpi-test-data =3D> data/acpi}/q35/SSDT.dimmpxm | Bin
 .../acpi}/rebuild-expected-aml.sh                  |   2 -
 .../hex-loader}/test.hex                           |   0
 74 files changed, 838 insertions(+), 290 deletions(-)
 delete mode 100644 hw/pci-bridge/ioh3420.h
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h
 rename tests/{acpi-test-data =3D> data/acpi}/pc/APIC (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/APIC.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/APIC.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.bridge (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.ipmikcs (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.memhp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/DSDT.numamem (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/FACP (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/FACS (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/HPET (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/NFIT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SLIT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SLIT.memhp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.memhp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SRAT.numamem (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/pc/SSDT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/APIC (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/APIC.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/APIC.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.bridge (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.ipmibt (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.memhp (100%)
 create mode 100644 tests/data/acpi/q35/DSDT.mmio64
 rename tests/{acpi-test-data =3D> data/acpi}/q35/DSDT.numamem (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/FACP (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/FACS (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/HPET (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/MCFG (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/NFIT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SLIT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SLIT.memhp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.cphp (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.memhp (100%)
 create mode 100644 tests/data/acpi/q35/SRAT.mmio64
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SRAT.numamem (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/q35/SSDT.dimmpxm (100%)
 rename tests/{acpi-test-data =3D> data/acpi}/rebuild-expected-aml.sh (86=
%)
 rename tests/{hex-loader-check-data =3D> data/hex-loader}/test.hex (100%=
)
