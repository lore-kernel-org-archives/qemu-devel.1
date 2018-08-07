Received: from eggs.gnu.org ([2001:4830:134:3::10]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn7hm-0005Fh-Tp
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn7hj-0007y8-Qg
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fn7hj-0007xF-L4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 15:31:39 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue,  7 Aug 2018 13:31:21 -0600
Message-Id: <20180807193125.30378-1-alex.williamson@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, david@redhat.com

v3:
 - Drop "nested" term in commit log (David)
 - Adopt suggested wording in ccw code (Cornelia)
 - Explain balloon inhibitor usage in vfio common (Peter)
 - Fix to call inhibitor prior to re-using existing containers
   to avoid gap that pinning may have occurred in set container
   ioctl (self) - Peter, this change is the reason I didn't
   include your R-b.
 - Add R-b to patches 1 & 2

v2:
 - Use atomic ops for balloon inhibit counter (Peter)
 - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
   default, vfio-pci opt-in by device option, only allowed for mdev
   devices, no support added for platform as there are no platform
   mdev devices.

See patch 3/4 for detailed explanation why ballooning and device
assignment typically don't mix.  If this eventually changes, flags
on the iommu info struct or perhaps device info struct can inform
us for automatic opt-in.  Thanks,

Alex

Alex Williamson (4):
  balloon: Allow multiple inhibit users
  kvm: Use inhibit to prevent ballooning without synchronous mmu
  vfio: Inhibit ballooning based on group attachment to a container
  vfio/ccw/pci: Allow devices to opt-in for ballooning

 accel/kvm/kvm-all.c           |  4 +++
 balloon.c                     | 13 ++++++---
 hw/vfio/ccw.c                 |  9 +++++++
 hw/vfio/common.c              | 51 +++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 26 +++++++++++++++++-
 hw/vfio/trace-events          |  1 +
 hw/virtio/virtio-balloon.c    |  4 +--
 include/hw/vfio/vfio-common.h |  2 ++
 8 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.18.0
