Received: from eggs.gnu.org ([2001:4830:134:3::10]:34008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ej1PG-0003Ms-PZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ej1PD-0000yx-L3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:27:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:57904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ej1PD-0000w9-Ai
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:27:19 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue,  6 Feb 2018 19:08:16 +0800
Message-Id: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/3] virtio-balloon: free page hint
 reporting support
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
VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
receives the guest free page hints from the driver and clears the
corresponding bits in the dirty bitmap, so that those free pages are
not transferred by the migration thread to the destination.

Please see the driver patch link for test results:
https://lkml.org/lkml/2018/2/4/60

ChangeLog:
v1->v2: 
    1) virtio-balloon
        - use subsections to save free_page_report_cmd_id;
        - poll the free page vq after sending a cmd id to the driver;
        - change the free page vq size to VIRTQUEUE_MAX_SIZE;
        - virtio_balloon_poll_free_page_hints: handle the corner case
          that the free page block reported from the driver may cross
          the RAMBlock boundary.
    2) migration/ram.c
        - use balloon_free_page_poll to start the optimization

Wei Wang (3):
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  migration: use the free page reporting feature from balloon
  virtio-balloon: add a timer to limit the free page report waiting time

 balloon.c                                       |  39 ++--
 hw/virtio/virtio-balloon.c                      | 227 ++++++++++++++++++++++--
 hw/virtio/virtio-pci.c                          |   3 +
 include/hw/virtio/virtio-balloon.h              |  15 +-
 include/migration/misc.h                        |   3 +
 include/standard-headers/linux/virtio_balloon.h |   7 +
 include/sysemu/balloon.h                        |  12 +-
 migration/ram.c                                 |  34 +++-
 8 files changed, 307 insertions(+), 33 deletions(-)

-- 
1.8.3.1
