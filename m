Received: from eggs.gnu.org ([2001:4830:134:3::10]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobS-0003i7-9s
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobN-00059r-AJ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:34124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobM-00057E-W0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:53:57 -0500
Date: Fri, 17 Feb 2017 21:53:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/23] virtio, pci: fixes, features
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

The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 7e58326ad7e79b8c5dbcc6f24e9dc1523d84c11b:

  intel_iommu: vtd_slpt_level_shift check level (2017-02-17 21:52:31 +0200)

----------------------------------------------------------------
virtio, pci: fixes, features

virtio is using region caches for performance
iommu support for IOTLBs
misc fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aviv Ben-David (1):
      intel_iommu: add "caching-mode" option

Fam Zheng (1):
      virtio: Report real progress in VQ aio poll handler

Haozhong Zhang (1):
      docs: add document to explain the usage of vNVDIMM

Michael S. Tsirkin (2):
      pci/pcie: don't assume cap id 0 is reserved
      virtio: Fix no interrupt when not creating msi controller

Paolo Bonzini (9):
      memory: make memory_listener_unregister idempotent
      virtio: add virtio_*_phys_cached
      virtio: use address_space_map/unmap to access descriptors
      exec: make address_space_cache_destroy idempotent
      virtio: use MemoryRegionCache to access descriptors
      virtio: add MemoryListener to cache ring translations
      virtio: use VRingMemoryRegionCaches for descriptor ring
      virtio: check for vring setup in virtio_queue_update_used_idx
      virtio: use VRingMemoryRegionCaches for avail and used rings

Peter Xu (9):
      pcie: simplify pcie_add_capability()
      vfio: trace map/unmap for notify as well
      vfio: introduce vfio_get_vaddr()
      vfio: allow to notify unmap for very large region
      intel_iommu: simplify irq region translation
      intel_iommu: renaming gpa to iova where proper
      intel_iommu: convert dbg macros to traces for inv
      intel_iommu: convert dbg macros to trace for trans
      intel_iommu: vtd_slpt_level_shift check level

 docs/nvdimm.txt                   | 124 +++++++++++++
 hw/i386/intel_iommu_internal.h    |   1 +
 include/exec/memory.h             |   2 +
 include/hw/i386/intel_iommu.h     |   2 +
 include/hw/virtio/virtio-access.h |  52 ++++++
 include/hw/virtio/virtio-blk.h    |   2 +-
 include/hw/virtio/virtio-scsi.h   |   6 +-
 include/hw/virtio/virtio.h        |   5 +-
 exec.c                            |   1 +
 hw/block/dataplane/virtio-blk.c   |   4 +-
 hw/block/virtio-blk.c             |  12 +-
 hw/i386/intel_iommu.c             | 238 ++++++++++---------------
 hw/net/virtio-net.c               |  14 +-
 hw/pci/pcie.c                     |  23 +--
 hw/scsi/virtio-scsi-dataplane.c   |  14 +-
 hw/scsi/virtio-scsi.c             |  14 +-
 hw/vfio/common.c                  |  65 ++++---
 hw/virtio/virtio.c                | 364 ++++++++++++++++++++++++++++++--------
 memory.c                          |   5 +
 hw/i386/trace-events              |  28 +++
 hw/vfio/trace-events              |   2 +-
 21 files changed, 702 insertions(+), 276 deletions(-)
 create mode 100644 docs/nvdimm.txt
