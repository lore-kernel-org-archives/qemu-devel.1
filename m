Received: from eggs.gnu.org ([209.51.188.92]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfah-0006G7-0k
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfSz-00053w-Ab
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:23 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:41648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfSz-00053e-60
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:21 -0500
Received: by mail-qk1-f172.google.com with SMTP id u188so36358qkh.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:21 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups, features
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

The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 5feab30ea98e30446361d184331b7b5ff94b4116:

  contrib/libvhost-user: cleanup casts (2019-02-04 09:23:56 -0500)

----------------------------------------------------------------
pci, pc, virtio: fixes, cleanups, features

vhost user blk discard/write zeroes features
misc cleanups and fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (3):
      contrib: compile vhost-user-blk tool by default
      contrib/vhost-user-blk: fix the compilation issue
      vhost-user-blk: add discard/write zeroes features support

Dima Stepanov (1):
      virtio: add checks for the size of the indirect table

Laszlo Ersek (1):
      fw_cfg: fix the life cycle and the name of "qemu_extra_params_fw"

Li Qiang (1):
      hw: virtio-pci: drop DO_UPCAST

Michael S. Tsirkin (3):
      contrib/libvhost-user: switch to uint64_t
      r2d: fix build on mingw
      contrib/libvhost-user: cleanup casts

Murilo Opsfelder Araujo (2):
      mmap-alloc: unfold qemu_ram_mmap()
      mmap-alloc: fix hugetlbfs misaligned length in ppc64

Paolo Bonzini (7):
      scripts/update-linux-headers.sh: adjust for Linux 4.21-rc1 (or 5.0-rc1)
      include: update Linux headers to 4.21-rc1/5.0-rc1
      vhost-net: move stubs to a separate file
      vhost-net-user: add stubs for when no virtio-net device is present
      vhost: restrict Linux dependency to kernel vhost
      vhost-net: compile it on all targets that have virtio-net.
      vhost-net: revamp configure logic

Peter Xu (4):
      intel_iommu: fix operator in vtd_switch_address_space
      intel_iommu: reset intr_enabled when system reset
      pci/msi: export msi_is_masked()
      i386/kvm: ignore masked irqs when update msi routes

Stefan Berger (1):
      acpi: Make TPM 2.0 with TIS available as MSFT0101

Thomas Huth (1):
      hw/virtio: Use CONFIG_VIRTIO_PCI switch instead of CONFIG_PCI

Wei Yang (1):
      i386, acpi: cleanup build_facs by removing second unused argument

 configure                                          |  105 +-
 default-configs/virtio.mak                         |    4 +-
 include/exec/poison.h                              |    1 -
 include/hw/pci/msi.h                               |    1 +
 include/qemu/mmap-alloc.h                          |    2 +-
 include/standard-headers/drm/drm_fourcc.h          |   63 ++
 include/standard-headers/linux/ethtool.h           |   19 +-
 include/standard-headers/linux/input-event-codes.h |   17 +
 include/standard-headers/linux/pci_regs.h          |    1 +
 include/standard-headers/linux/vhost_types.h       |  128 +++
 include/standard-headers/linux/virtio_balloon.h    |    8 +
 include/standard-headers/linux/virtio_blk.h        |   54 +
 include/standard-headers/linux/virtio_config.h     |    3 +
 include/standard-headers/linux/virtio_gpu.h        |   18 +
 include/standard-headers/linux/virtio_ring.h       |   52 +
 linux-headers/asm-arm/unistd-common.h              |    1 +
 linux-headers/asm-arm64/unistd.h                   |    1 +
 linux-headers/asm-generic/unistd.h                 |   10 +-
 linux-headers/asm-mips/sgidefs.h                   |    8 -
 linux-headers/asm-mips/unistd.h                    | 1074 +-------------------
 linux-headers/asm-mips/unistd_n32.h                |  338 ++++++
 linux-headers/asm-mips/unistd_n64.h                |  334 ++++++
 linux-headers/asm-mips/unistd_o32.h                |  374 +++++++
 linux-headers/asm-powerpc/unistd.h                 |  389 +------
 linux-headers/asm-powerpc/unistd_32.h              |  381 +++++++
 linux-headers/asm-powerpc/unistd_64.h              |  372 +++++++
 linux-headers/linux/kvm.h                          |   29 +
 linux-headers/linux/vfio.h                         |   92 ++
 linux-headers/linux/vhost.h                        |  113 +-
 linux-headers/linux/vhost_types.h                  |    1 +
 contrib/libvhost-user/libvhost-user.c              |    8 +-
 contrib/vhost-user-blk/vhost-user-blk.c            |  146 ++-
 exec.c                                             |    4 +-
 hw/block/vhost-user-blk.c                          |    4 +
 hw/i386/acpi-build.c                               |   16 +-
 hw/i386/intel_iommu.c                              |    3 +-
 hw/net/vhost_net-stub.c                            |   92 ++
 hw/net/vhost_net.c                                 |   85 +-
 hw/nvram/fw_cfg.c                                  |    9 +-
 hw/pci/msi.c                                       |    2 +-
 hw/sh4/r2d.c                                       |    2 +-
 hw/virtio/vhost-backend.c                          |   12 +-
 hw/virtio/vhost-user.c                             |   13 +-
 hw/virtio/vhost.c                                  |    2 +-
 hw/virtio/virtio-pci.c                             |    4 +-
 hw/virtio/virtio.c                                 |    4 +-
 net/net.c                                          |    2 +-
 net/vhost-user-stub.c                              |   23 +
 target/i386/kvm.c                                  |   14 +-
 tests/vhost-user-test.c                            |   16 +-
 util/mmap-alloc.c                                  |   71 +-
 util/oslib-posix.c                                 |    2 +-
 backends/Makefile.objs                             |    5 +-
 hw/net/Makefile.objs                               |    4 +-
 hw/virtio/Makefile.objs                            |    7 +-
 net/Makefile.objs                                  |    4 +-
 scripts/update-linux-headers.sh                    |   11 +
 tests/Makefile.include                             |    5 +-
 58 files changed, 2749 insertions(+), 1814 deletions(-)
 create mode 100644 include/standard-headers/linux/vhost_types.h
 create mode 100644 linux-headers/asm-mips/unistd_n32.h
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c
