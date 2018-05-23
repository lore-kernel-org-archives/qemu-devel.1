Received: from eggs.gnu.org ([2001:4830:134:3::10]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyX-0001Vi-3W
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyT-0000hy-LL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyT-0000hi-Eq
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:42:45 -0400
Date: Wed, 23 May 2018 17:42:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/28] pc, pci, virtio, vhost: fixes, features
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

The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 63b88968f139b6a77f2f81e6f1eedf70c0170a85:

  intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)

----------------------------------------------------------------
pc, pci, virtio, vhost: fixes, features

Beginning of merging vDPA, new PCI ID, a new virtio balloon stat, intel
iommu rework fixing a couple of security problems (no CVEs yet), fixes
all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      contrib/vhost-user-blk: enable protocol feature for vhost-user-blk

Dr. David Alan Gilbert (2):
      vhost-user+postcopy: Use qemu_set_nonblock
      libvhost-user: Send messages with no data

Gerd Hoffmann (1):
      allocate pci id for mdpy

Jonathan Helman (1):
      virtio-balloon: add hugetlb page allocation counts

Michael S. Tsirkin (7):
      update-linux-headers.sh: drop kvm_para.h hacks
      include/standard-headers: add asm-x86/kvm_para.h
      x86/cpu: use standard-headers/asm-x86.kvm_para.h
      linux-headers: drop kvm_para.h
      update-linux-headers.sh: unistd.h, kvm consistency
      linux-headers: add unistd.h on all arches
      linux-headers: add kvm header for mips

Peter Xu (10):
      vhost: add trace for IOTLB miss
      intel-iommu: send PSI always even if across PDEs
      intel-iommu: remove IntelIOMMUNotifierNode
      intel-iommu: add iommu lock
      intel-iommu: only do page walk for MAP notifiers
      intel-iommu: introduce vtd_page_walk_info
      intel-iommu: pass in address space when page walk
      intel-iommu: trace domain id during page walk
      util: implement simple iova tree
      intel-iommu: rework the page walk logic

Richard Henderson (1):
      hw/virtio: Fix brace Werror with clang 6.0.0

Ross Zwisler (1):
      nvdimm: fix typo in label-size definition

Tiwei Bie (3):
      vhost-user: add Net prefix to internal state structure
      vhost-user: support receiving file descriptors in slave_read
      virtio: support setting memory region based host notifier

Zihan Yang (1):
      hw/pci-host/q35: Replace hardcoded value with macro

 docs/specs/pci-ids.txt                             |   1 +
 docs/virtio-balloon-stats.txt                      |   2 +
 include/hw/i386/intel_iommu.h                      |  19 +-
 include/hw/mem/nvdimm.h                            |   2 +-
 include/hw/pci/pci.h                               |   1 +
 include/hw/virtio/virtio-bus.h                     |   2 +
 include/hw/virtio/virtio.h                         |   2 +
 include/qemu/iova-tree.h                           | 134 ++++
 .../standard-headers}/asm-x86/kvm_para.h           |  49 +-
 include/standard-headers/linux/virtio_balloon.h    |   4 +-
 include/sysemu/kvm.h                               |   1 -
 linux-headers/asm-arm/bitsperlong.h                |   1 +
 linux-headers/asm-arm/kvm_para.h                   |   2 -
 linux-headers/asm-arm64/bitsperlong.h              |  24 +
 linux-headers/asm-arm64/kvm_para.h                 |   1 -
 linux-headers/asm-generic/bitsperlong.h            |  16 +
 linux-headers/asm-generic/kvm_para.h               |   4 -
 linux-headers/asm-generic/unistd.h                 | 781 +++++++++++++++++++++
 linux-headers/asm-mips/bitsperlong.h               |   9 +
 linux-headers/asm-mips/kvm.h                       |  25 +-
 linux-headers/asm-mips/kvm_para.h                  |   5 -
 linux-headers/asm-mips/sgidefs.h                   |  45 ++
 linux-headers/asm-mips/unistd.h                    |  44 +-
 linux-headers/asm-powerpc/bitsperlong.h            |  13 +
 linux-headers/asm-powerpc/epapr_hcalls.h           |  99 ---
 linux-headers/asm-powerpc/kvm_para.h               |  98 ---
 linux-headers/asm-s390/bitsperlong.h               |  14 +
 linux-headers/asm-s390/kvm_para.h                  |   8 -
 linux-headers/asm-s390/unistd_32.h                 |   1 +
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/bitsperlong.h                |  14 +
 linux-headers/linux/kvm_para.h                     |  35 -
 target/i386/cpu.h                                  |   2 -
 target/i386/kvm_i386.h                             |   6 -
 contrib/libvhost-user/libvhost-user.c              |  16 +-
 contrib/vhost-user-blk/vhost-user-blk.c            |   7 +
 hw/i386/intel_iommu.c                              | 396 ++++++++---
 hw/i386/kvm/clock.c                                |   2 +-
 hw/mem/nvdimm.c                                    |   2 +-
 hw/pci-host/q35.c                                  |  17 +-
 hw/virtio/vhost-user.c                             |  45 +-
 hw/virtio/vhost.c                                  |   7 +
 hw/virtio/virtio-balloon.c                         |   2 +
 hw/virtio/virtio-pci.c                             |  22 +
 hw/virtio/virtio.c                                 |  13 +
 net/vhost-user.c                                   |  38 +-
 target/i386/cpu.c                                  |   4 +-
 target/i386/kvm.c                                  |   4 +-
 util/iova-tree.c                                   | 114 +++
 MAINTAINERS                                        |   6 +
 hw/i386/trace-events                               |   5 +-
 hw/virtio/trace-events                             |   1 +
 scripts/update-linux-headers.sh                    |  20 +-
 util/Makefile.objs                                 |   1 +
 54 files changed, 1731 insertions(+), 456 deletions(-)
 create mode 100644 include/qemu/iova-tree.h
 rename {linux-headers => include/standard-headers}/asm-x86/kvm_para.h (80%)
 create mode 100644 linux-headers/asm-arm/bitsperlong.h
 delete mode 100644 linux-headers/asm-arm/kvm_para.h
 create mode 100644 linux-headers/asm-arm64/bitsperlong.h
 delete mode 100644 linux-headers/asm-arm64/kvm_para.h
 create mode 100644 linux-headers/asm-generic/bitsperlong.h
 delete mode 100644 linux-headers/asm-generic/kvm_para.h
 create mode 100644 linux-headers/asm-generic/unistd.h
 create mode 100644 linux-headers/asm-mips/bitsperlong.h
 delete mode 100644 linux-headers/asm-mips/kvm_para.h
 create mode 100644 linux-headers/asm-mips/sgidefs.h
 create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
 delete mode 100644 linux-headers/asm-powerpc/epapr_hcalls.h
 delete mode 100644 linux-headers/asm-powerpc/kvm_para.h
 create mode 100644 linux-headers/asm-s390/bitsperlong.h
 delete mode 100644 linux-headers/asm-s390/kvm_para.h
 create mode 100644 linux-headers/asm-x86/bitsperlong.h
 delete mode 100644 linux-headers/linux/kvm_para.h
 create mode 100644 util/iova-tree.c
