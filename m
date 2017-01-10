Received: from eggs.gnu.org ([2001:4830:134:3::10]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9a-00074L-Eu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9W-0005JP-8y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:26 -0500
Received: from mail.kernel.org ([198.145.29.136]:47444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9V-0005Ht-VC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:22 -0500
Date: Tue, 10 Jan 2017 07:39:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/41] virtio, vhost, pc: fixes, features
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

The following changes since commit 77424a452abe5f941d8cd81f1e85f42bca31c9ef:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-09 15:30:45 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 987da7be996e63c294dc6485acb1c37af7696257:

  acpi-test: update expected files (2017-01-10 07:06:42 +0200)

----------------------------------------------------------------
virtio, vhost, pc: fixes, features

beginnings of iotlb support for vhost
acpi hotplug rework
vhost net tx flush on link down
passing mtu to guests
hotplug for virtio crypto
fixes and cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cao jin (2):
      doc/pcie: correct command line examples
      pcie_aer: Convert pcie_aer_init to Error

Dou Liyang (1):
      pcie_aer: support configurable AER capa version

Dr. David Alan Gilbert (1):
      balloon: Don't balloon roms

Gonglei (8):
      virtio-crypto: fix possible integer and heap overflow
      virtio-crypto: use the correct length for cipher operation
      cryptodev: introduce a new is_used property
      cryptodev: wrap the ready flag
      virtio-crypto-pci: add check for cryptodev object
      virtio-crypto: avoid one cryptodev device is used by multiple virtio crypto devices
      virtio-crypto-pci: tag virtio-crypto device hot pluggable
      virtio-crypto: zeroize the key material before free

Halil Pasic (1):
      virtio: fix vq->inuse recalc after migr

Igor Mammedov (9):
      tests: pc: add memory hotplug acpi tables tests
      memhp: move build_memory_hotplug_aml() into memory_hotplug.c
      memhp: move build_memory_devices() into memory_hotplug.c
      memhp: consolidate scattered MHPD device declaration
      memhp: merge build_memory_devices() into build_memory_hotplug_aml()
      memhp: move GPE handler_E03 into build_memory_hotplug_aml()
      memhp: move memory hotplug only defines to memory_hotplug.c
      memhp: don't generate memory hotplug AML if it's not enabled/supported
      memhp: move DIMM devices into dedicated scope with related common methods

Jason Wang (9):
      virtio: convert to use DMA api
      intel_iommu: name vtd address space with devfn
      intel_iommu: allocate new key when creating new address space
      exec: introduce address_space_get_iotlb_entry()
      intel_iommu: support device iotlb descriptor
      virtio-pci: address space translation service (ATS) support
      acpi: add ATSR for q35
      memory: handle alias for iommu notifier
      memory: handle alias in memory_region_is_iommu()

Maxime Coquelin (3):
      vhost-user: Add MTU protocol feature and op
      vhost-net: Notify the backend about the host MTU
      virtio-net: Add MTU feature support

Michael S. Tsirkin (1):
      acpi-test: update expected files

Peter Xu (2):
      migration: allow to prioritize save state entries
      intel_iommu: allow migration

Yuri Benditovich (4):
      net: Add virtio queue interface to update used index from vring state
      net: vhost stop updates virtio queue state
      virtio: Introduce virtqueue_drop_all procedure
      net: virtio-net discards TX data after link down

 docs/pcie.txt                             |  12 +-
 docs/specs/vhost-user.txt                 |  16 ++
 hw/i386/intel_iommu_internal.h            |  13 +-
 hw/virtio/virtio-pci.h                    |   4 +
 include/exec/memory.h                     |   8 +
 include/hw/acpi/acpi-defs.h               |  12 +
 include/hw/acpi/memory_hotplug.h          |  12 +-
 include/hw/acpi/pc-hotplug.h              |  23 --
 include/hw/i386/x86-iommu.h               |   1 +
 include/hw/pci/pcie.h                     |   4 +
 include/hw/pci/pcie_aer.h                 |   4 +-
 include/hw/virtio/vhost-backend.h         |   2 +
 include/hw/virtio/virtio-access.h         |  31 ++-
 include/hw/virtio/virtio-bus.h            |   1 +
 include/hw/virtio/virtio-net.h            |   1 +
 include/hw/virtio/virtio.h                |  11 +-
 include/migration/vmstate.h               |   7 +
 include/net/vhost_net.h                   |   2 +
 include/standard-headers/linux/pci_regs.h |   1 +
 include/sysemu/cryptodev.h                |  42 +++
 backends/cryptodev-builtin.c              |   4 +
 backends/cryptodev.c                      |  34 ++-
 exec.c                                    |  33 +++
 hw/acpi/ich9.c                            |   3 +-
 hw/acpi/memory_hotplug.c                  | 420 +++++++++++++++++++++++++++++-
 hw/acpi/memory_hotplug_acpi_table.c       | 262 -------------------
 hw/acpi/piix4.c                           |   3 +-
 hw/block/virtio-blk.c                     |   2 +-
 hw/char/virtio-serial-bus.c               |   3 +-
 hw/i386/acpi-build.c                      | 206 +++------------
 hw/i386/intel_iommu.c                     | 114 +++++++-
 hw/i386/x86-iommu.c                       |  17 ++
 hw/net/e1000e.c                           |   3 +-
 hw/net/vhost_net.c                        |  18 ++
 hw/net/virtio-net.c                       |  45 ++++
 hw/pci-bridge/ioh3420.c                   |   4 +-
 hw/pci-bridge/xio3130_downstream.c        |   4 +-
 hw/pci-bridge/xio3130_upstream.c          |   4 +-
 hw/pci/pcie.c                             |  15 ++
 hw/pci/pcie_aer.c                         |  19 +-
 hw/scsi/virtio-scsi.c                     |   4 +-
 hw/virtio/vhost-user.c                    |  34 +++
 hw/virtio/vhost.c                         |   1 +
 hw/virtio/virtio-balloon.c                |   7 +-
 hw/virtio/virtio-bus.c                    |   8 +
 hw/virtio/virtio-crypto-pci.c             |   6 +-
 hw/virtio/virtio-crypto.c                 |  41 ++-
 hw/virtio/virtio-pci.c                    |  21 ++
 hw/virtio/virtio.c                        | 108 ++++++--
 memory.c                                  |   9 +
 migration/savevm.c                        |  34 ++-
 tests/bios-tables-test.c                  |  24 ++
 hw/acpi/Makefile.objs                     |   2 +-
 hw/virtio/trace-events                    |   2 +
 tests/acpi-test-data/pc/DSDT              | Bin 6008 -> 5098 bytes
 tests/acpi-test-data/pc/DSDT.bridge       | Bin 7867 -> 6957 bytes
 tests/acpi-test-data/pc/DSDT.cphp         | Bin 6471 -> 5561 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs      | Bin 6080 -> 5170 bytes
 tests/acpi-test-data/pc/DSDT.memhp        | Bin 0 -> 6463 bytes
 tests/acpi-test-data/pc/SRAT.memhp        | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT             | Bin 8770 -> 7860 bytes
 tests/acpi-test-data/q35/DSDT.bridge      | Bin 8787 -> 7877 bytes
 tests/acpi-test-data/q35/DSDT.cphp        | Bin 9233 -> 8323 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt      | Bin 8845 -> 7935 bytes
 tests/acpi-test-data/q35/DSDT.memhp       | Bin 0 -> 9225 bytes
 tests/acpi-test-data/q35/SRAT.memhp       | Bin 0 -> 224 bytes
 66 files changed, 1164 insertions(+), 557 deletions(-)
 delete mode 100644 hw/acpi/memory_hotplug_acpi_table.c
 create mode 100644 tests/acpi-test-data/pc/DSDT.memhp
 create mode 100644 tests/acpi-test-data/pc/SRAT.memhp
 create mode 100644 tests/acpi-test-data/q35/DSDT.memhp
 create mode 100644 tests/acpi-test-data/q35/SRAT.memhp
