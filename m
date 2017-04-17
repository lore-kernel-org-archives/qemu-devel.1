Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04tp-0001N5-Nt
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04tk-0003Vp-S5
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d04tk-0003VX-N8
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:32:48 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Apr 2017 19:32:03 +0800
Message-Id: <1492428730-13438-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] VT-d: PT (passthrough) mode support and
 misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

v2:
- resending v1 since my patch script had a regression, which failed to
  send the patches to the list... trying again. sorry for the noise!

This series is for 2.10, and based on following series:

    [PATCH v8 0/9] VT-d: vfio enablement and misc enhances

This series add support for per-device passthrough mode for VT-d
emulation, along with some tweaks on existing codes.

Patches 1-2 are memory related cleanups.
Patches 3-6 are VT-d cleanups.
Patch 7 add support for passthrough.

todo:
- vhost: when pt is specified for vhost-enabled device, kernel can
  avoid translating the message and fallback to no-iommu mode.

Please review. Thanks.

Peter Xu (7):
  memory: tune last param of iommu_ops.translate()
  memory: remove the last param in memory_region_iommu_replay()
  x86-iommu: use DeviceClass properties
  intel_iommu: renaming context entry helpers
  intel_iommu: provide vtd_ce_get_type()
  intel_iommu: use IOMMU_ACCESS_FLAG()
  intel_iommu: support passthrough (PT)

 exec.c                         |   6 +-
 hw/alpha/typhoon.c             |   2 +-
 hw/dma/rc4030.c                |   2 +-
 hw/i386/amd_iommu.c            |   4 +-
 hw/i386/intel_iommu.c          | 146 +++++++++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/trace-events           |   1 +
 hw/i386/x86-iommu.c            |  48 +++-----------
 hw/pci-host/apb.c              |   2 +-
 hw/ppc/spapr_iommu.c           |   2 +-
 hw/s390x/s390-pci-bus.c        |   2 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/vfio/common.c               |   2 +-
 include/exec/memory.h          |  15 +++--
 include/hw/i386/x86-iommu.h    |   1 +
 memory.c                       |   7 +-
 16 files changed, 146 insertions(+), 97 deletions(-)

-- 
2.7.4
