Received: from eggs.gnu.org ([2001:4830:134:3::10]:57496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MZg-0005hg-Eh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MZb-0000sO-K2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8MZb-0000sD-Aa
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:15 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:43 +0800
Message-Id: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/12] VT-d: PT (passthrough) mode support
 and misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v3:
- add one patch to provide machine type 2.10 for pc, add r-b for Edurado
- add r-b/a-b for David on the two memory patches
- add a-b for Paolo on the two memory patches
- remove useless if in vtd_switch_address_space() [Jason]
- check pt_supported when needed [Yi]
- one more patch to check whether dev-iotlb is supported before
  allowing such type of context entry
- enable pt fast path (squashed into current patch 10). when we found
  pt is setup on the first translation, we do address space switch.
  When it's unset, we can capture it via invalidations. [Jason]
- add compat bit for HW_COMPAT_2_9 for "pt" param [Jason]
- one vhost fix for pt (added patch 4)
- faster vhost caching (added patch 12) [Jason]

This series add support for per-device passthrough mode for VT-d
emulation, along with some tweaks on existing codes.

Patch 1: introduce pc 2.10 machine type, it's in mst's pull request
         already, but to be complete, I included this patch.

Patches 2-3: memory related cleanups.

Patch 4: a fix for vhost to be prepared for passthrough mode.

Patches 5-9: some VT-d cleanups and fixes.

Patch 10: add support for passthrough.

Patch 11: turn pt off for machine type <=2.9, for compatibility.

Patch 12: vhost enhancement when used with passthrough, to pre-cache
          static mappings.

A simple test with PT mode using 10g nic is line speed.

Please review. Thanks.

Peter Xu (12):
  pc: add 2.10 machine type
  memory: tune last param of iommu_ops.translate()
  memory: remove the last param in memory_region_iommu_replay()
  memory: fix address_space_get_iotlb_entry()
  x86-iommu: use DeviceClass properties
  intel_iommu: renaming context entry helpers
  intel_iommu: provide vtd_ce_get_type()
  intel_iommu: use IOMMU_ACCESS_FLAG()
  intel_iommu: allow dev-iotlb context entry conditionally
  intel_iommu: support passthrough (PT)
  intel_iommu: turn off pt before 2.9
  vhost: iommu: cache static mapping if there is

 exec.c                         |  26 ++++-
 hw/alpha/typhoon.c             |   2 +-
 hw/dma/rc4030.c                |   2 +-
 hw/i386/amd_iommu.c            |   4 +-
 hw/i386/intel_iommu.c          | 260 +++++++++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/pc_piix.c              |  15 ++-
 hw/i386/pc_q35.c               |  13 ++-
 hw/i386/trace-events           |   2 +
 hw/i386/x86-iommu.c            |  48 ++------
 hw/pci-host/apb.c              |   2 +-
 hw/ppc/spapr_iommu.c           |   2 +-
 hw/s390x/s390-pci-bus.c        |   2 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/vfio/common.c               |   2 +-
 hw/virtio/trace-events         |   4 +
 hw/virtio/vhost.c              |  49 ++++++++
 include/exec/memory.h          |  15 ++-
 include/hw/compat.h            |   6 +-
 include/hw/i386/pc.h           |   3 +
 include/hw/i386/x86-iommu.h    |   1 +
 memory.c                       |   7 +-
 22 files changed, 339 insertions(+), 129 deletions(-)

-- 
2.7.4
