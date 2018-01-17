Received: from eggs.gnu.org ([2001:4830:134:3::10]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhYB-00053W-8B
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ebhY8-0003n1-4p
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:59300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ebhY7-0003ju-RV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:50:16 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 14:31:56 +0800
Message-Id: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 0/4] virtio-balloon: support free page
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

This is the deivce part implementation to add a new feature,
VIRTIO_BALLOON_F_FREE_PAGE_VQ to the virtio-balloon device. The device
receives the guest free page hint from the driver and clears the
corresponding bits in the dirty bitmap, so that those free pages are
not transferred to the destination. Please see the results in the
commit log of patch 1.

Link to the driver patches:
https://marc.info/?l=kvm&m=151616696828185&w=2

Wei Wang (4):
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
  migration: call balloon to clear bits of free pages from dirty bitmap
  virtio-balloon: add a timer to limit the free page report wating time
  virtio-balloon: Don't skip free pages if the poison val is non-zero

 balloon.c                                       |  46 ++++-
 hw/virtio/virtio-balloon.c                      | 224 ++++++++++++++++++++++--
 hw/virtio/virtio-pci.c                          |   3 +
 include/hw/virtio/virtio-balloon.h              |  12 +-
 include/migration/misc.h                        |   3 +
 include/standard-headers/linux/virtio_balloon.h |   6 +
 include/sysemu/balloon.h                        |  15 +-
 migration/ram.c                                 |  38 +++-
 8 files changed, 316 insertions(+), 31 deletions(-)

-- 
1.8.3.1
