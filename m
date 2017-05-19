Received: from eggs.gnu.org ([2001:4830:134:3::10]:35247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYSb-0006cO-OD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYSY-0005IE-Kr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYSY-0005HB-BO
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:10 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:39 +0800
Message-Id: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/10] VT-d: PT (passthrough) mode support
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Online repo:

  https://github.com/xzpeter/qemu/tree/vtd-passthrough-misc-1

v4
- remove patch "pc: add 2.10 machine type" since it's merged already
- remove patch "memory: fix address_space_get_iotlb_entry()" since
  the problem is fixed by an much better upstream patch:
  "exec: abstract address_space_do_translate()"
- fix issue that patchew reported
- introduce vtd_ce_type_check(), then use it in
  vtd_dev_to_context_entry() [Jason]
- vtd_pt_enable_fast_path() don't use "SUCCESS" but bool [Jason]
- do address space switch for dsi/global ce invalidate [Jason]
- remove detect_pt in vtd_switch_address_space() [Jason]

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

Patches 1-2: memory related cleanups.

Patches 3-7: some VT-d cleanups and fixes.

Patch 8: add support for passthrough.

Patch 9: turn pt off for machine type <=2.9, for compatibility.

Patch 10: vhost enhancement when used with passthrough, to pre-cache
          static mappings.

A simple test with PT mode using 10g nic is line speed.

Please review. Thanks.

Peter Xu (10):
  memory: tune last param of iommu_ops.translate()
  memory: remove the last param in memory_region_iommu_replay()
  x86-iommu: use DeviceClass properties
  intel_iommu: renaming context entry helpers
  intel_iommu: provide vtd_ce_get_type()
  intel_iommu: use IOMMU_ACCESS_FLAG()
  intel_iommu: allow dev-iotlb context entry conditionally
  intel_iommu: support passthrough (PT)
  intel_iommu: turn off pt before 2.9
  vhost: iommu: cache static mapping if there is

 exec.c                         |   3 +-
 hw/alpha/typhoon.c             |   2 +-
 hw/dma/rc4030.c                |   2 +-
 hw/i386/amd_iommu.c            |   4 +-
 hw/i386/intel_iommu.c          | 313 ++++++++++++++++++++++++++++++-----------
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/trace-events           |   2 +
 hw/i386/x86-iommu.c            |  48 ++-----
 hw/pci-host/apb.c              |   2 +-
 hw/ppc/spapr_iommu.c           |   2 +-
 hw/s390x/s390-pci-bus.c        |   2 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/vfio/common.c               |   2 +-
 hw/virtio/trace-events         |   4 +
 hw/virtio/vhost.c              |  49 +++++++
 include/exec/memory.h          |  15 +-
 include/hw/compat.h            |   4 +
 include/hw/i386/x86-iommu.h    |   1 +
 memory.c                       |   7 +-
 19 files changed, 319 insertions(+), 146 deletions(-)

-- 
2.7.4
