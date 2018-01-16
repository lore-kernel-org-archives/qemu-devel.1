Received: from eggs.gnu.org ([2001:4830:134:3::10]:47501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ8f-0007A8-68
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJ8b-000458-VQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJ8b-00043e-L5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:46:17 -0500
Date: Tue, 16 Jan 2018 06:46:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/33] pc, pci, virtio: features, fixes, cleanups
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

A large pull due to patch buildup over the holiday period.
Most notable here is probably the addition of vhost-user-blk.

The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 631ae6adb1fcea786e0db8c6f1b19570bad0f90c:

  vhost: remove assertion to prevent crash (2018-01-16 06:36:19 +0200)

----------------------------------------------------------------
pc, pci, virtio: features, fixes, cleanups

A bunch of fixes, cleanus and new features all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (4):
      vhost-user: add new vhost user messages to support virtio config space
      vhost-user-blk: introduce a new vhost-user-blk host device
      contrib/libvhost-user: enable virtio config space messages
      contrib/vhost-user-blk: introduce a vhost-user-blk sample application

Dou Liyang (2):
      ACPI/unit-test: Add a testcase for RAM allocation in numa node
      hw/acpi-build: Make next_base easy to follow

Dr. David Alan Gilbert (4):
      vhost: Build temporary section list and deref after commit
      vhost: Move log_dirty check
      vhost: Simplify ring verification checks
      vhost: Merge sections added to temporary list

Gal Hammer (3):
      qemu: add a cleanup callback function to EventNotifier
      virtio: postpone the execution of event_notifier_cleanup function
      virtio: improve virtio devices initialization time

Igor Mammedov (4):
      tests: acpi: move tested tables array allocation outside of test_acpi_dsdt_table()
      tests: acpi: init table descriptor in test_dst_table()
      tests: acpi: rename test_acpi_tables()/test_dst_table() to reflect its usage
      tests: acpi: add comments to fetch_rsdt_referenced_tables/data->tables usage

Jay Zhou (1):
      vhost: remove assertion to prevent crash

Marcel Apfelbaum (2):
      MAINTAINERS: Add myself as maintainer to X86 machines
      hw/pci-bridge: fix QEMU crash because of pcie-root-port

Maxime Coquelin (6):
      vhost-user: fix multiple queue specification
      vhost-user-test: fix features mask
      vhost-user-test: extract read-guest-mem test from main loop
      vhost-user-test: setup virtqueues in all tests
      vhost-user-test: make features mask an init_virtio_dev() argument
      vhost-user-test: use init_virtio_dev in multiqueue test

Michael S. Tsirkin (2):
      vhost-user: factor out msg head and payload
      vhost-user: fix misaligned access to payload

Mohammed Gamal (2):
      x86_iommu: Move machine check to x86_iommu_realize()
      x86_iommu: check if machine has PCI bus

Prasad Singamsetty (2):
      intel-iommu: Redefine macros to enable supporting 48 bit address width
      intel-iommu: Extend address width to 48 bits

Yuval Shaia (1):
      pci/shpc: Move function to generic header file

 docs/interop/vhost-user.txt             |  61 +++-
 Makefile                                |   3 +
 default-configs/pci.mak                 |   1 +
 contrib/libvhost-user/libvhost-user.h   |  33 ++
 hw/i386/intel_iommu_internal.h          |  43 ++-
 hw/virtio/virtio-pci.h                  |  18 ++
 include/hw/i386/intel_iommu.h           |   7 +-
 include/hw/virtio/vhost-backend.h       |  12 +
 include/hw/virtio/vhost-user-blk.h      |  41 +++
 include/hw/virtio/vhost.h               |  17 +
 include/qemu/event_notifier.h           |   1 +
 include/qemu/host-utils.h               |  10 +
 accel/kvm/kvm-all.c                     |   4 +
 contrib/libvhost-user/libvhost-user.c   |  42 +++
 contrib/vhost-user-blk/vhost-user-blk.c | 545 ++++++++++++++++++++++++++++++++
 hw/block/vhost-user-blk.c               | 359 +++++++++++++++++++++
 hw/i386/acpi-build.c                    |   5 +-
 hw/i386/amd_iommu.c                     |  13 +-
 hw/i386/intel_iommu.c                   | 136 ++++----
 hw/i386/x86-iommu.c                     |  13 +
 hw/pci-bridge/gen_pcie_root_port.c      |   7 +-
 hw/pci/shpc.c                           |  13 +-
 hw/virtio/vhost-user.c                  | 318 +++++++++++++------
 hw/virtio/vhost.c                       | 250 +++++++++++----
 hw/virtio/virtio-bus.c                  |  19 +-
 hw/virtio/virtio-pci.c                  |  55 ++++
 hw/virtio/virtio.c                      |   5 +
 tests/bios-tables-test.c                |  50 ++-
 tests/vhost-user-test.c                 | 171 +++++-----
 util/event_notifier-posix.c             |   5 +-
 util/event_notifier-win32.c             |   2 +
 .gitignore                              |   1 +
 MAINTAINERS                             |   1 +
 Makefile.objs                           |   1 +
 contrib/vhost-user-blk/Makefile.objs    |   1 +
 hw/block/Makefile.objs                  |   3 +
 hw/virtio/trace-events                  |   5 +
 tests/acpi-test-data/pc/DSDT.numamem    | Bin 0 -> 5150 bytes
 tests/acpi-test-data/pc/SRAT.numamem    | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.numamem   | Bin 0 -> 7834 bytes
 tests/acpi-test-data/q35/SRAT.numamem   | Bin 0 -> 224 bytes
 41 files changed, 1897 insertions(+), 374 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-blk.h
 create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
 create mode 100644 hw/block/vhost-user-blk.c
 create mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
