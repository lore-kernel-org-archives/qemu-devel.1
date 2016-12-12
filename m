Received: from eggs.gnu.org ([2001:4830:134:3::10]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdN-0004cl-Th
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGOdJ-0000L5-Ti
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGOdJ-0000KY-Ne
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:19:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Dec 2016 12:18:46 +0100
Message-Id: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/11] speedup vring processing with
 MemoryRegionCaches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

It is known that virtio's usage of ld_*_phys and st_*_phys functions
wastes time in address_space_translate, visiting the
AddressSpaceDispatch's radix tree.

This series introduces a small cache that changes these functions
to a simple range check and memory access.  The effect is a bit
underwhelming, because the improvement is only 1-2Kiops/second.
Nevertheless I'm throwing out the patches so that for example they
can be tested on s390.

Things to fix: handle address_space_cache_init failures
in virtio_init_region_cache.  Also, once virtio breaks free of
address_space_memoory, we'll need to handle invalidation in IOMMU regions.
For the latter, maybe it's worth introducing a new abstraction that
is higher-level than MemoryListener and covers both regular and IOMMU
memory regions.

Paolo

Paolo Bonzini (11):
  exec: optimize remaining address_space_* cases
  exec: introduce memory_ldst.inc.c
  exec: introduce address_space_extend_translation
  exec: introduce MemoryRegionCache
  virtio: make virtio_should_notify static
  virtio: add virtio_*_phys_cached
  virtio: use address_space_map/unmap to access descriptors
  virtio: use MemoryRegionCache to access descriptors
  virtio: add MemoryListener to cache ring translations
  virtio: use VRingMemoryRegionCaches for descriptor ring
  virtio: use VRingMemoryRegionCaches for avail and used rings

 exec.c                            | 687 +++++-------------------------------
 hw/net/virtio-net.c               |  14 +-
 hw/virtio/virtio.c                | 322 +++++++++++++----
 include/exec/cpu-all.h            |  23 ++
 include/exec/cpu-common.h         |  15 -
 include/exec/memory.h             | 166 +++++++++
 include/hw/virtio/virtio-access.h |  52 +++
 include/hw/virtio/virtio.h        |   2 +-
 include/qemu/typedefs.h           |   1 +
 memory_ldst.inc.c                 | 709 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 1316 insertions(+), 675 deletions(-)
 create mode 100644 memory_ldst.inc.c

-- 
1.8.3.1
