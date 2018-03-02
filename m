Received: from eggs.gnu.org ([2001:4830:134:3::10]:46197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erge6-0006WA-Rh
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erge2-0000Ez-DC
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:56818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1erge2-0000Dx-4N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:26 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  2 Mar 2018 16:47:27 +0800
Message-Id: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/3] virtio-balloon: free page hint
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

- Test Environment
    Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
    Guest: 8G RAM, 4 vCPU
    Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second

- Test Results
    - Idle Guest Live Migration Time (results are averaged over 10 runs):
        - Optimization v.s. Legacy = 259ms vs 1769ms --> ~86% reduction
    - Guest with Linux Compilation Workload (make bzImage -j4):
        - Live Migration Time (average)
          Optimization v.s. Legacy = 1290ms v.s. 2634ms --> ~51% reduction
        - Linux Compilation Time
          Optimization v.s. Legacy = 5min v.s. 5min3s
          --> no obvious difference

- Source Code
    - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
    - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git

ChangeLog:
v2->v3:
    1) virtio-balloon
        - virtio_balloon_free_page_start: poll the hints using a new
          thread;
        - use cmd id between [0x80000000, UINT_MAX];
        - virtio_balloon_poll_free_page_hints:
            - stop the optimization only when it has started;
            - don't skip free pages when !poison_val;
        - add poison_val to vmsd to migrate;
        - virtio_balloon_get_features: add the F_PAGE_POISON feature when
          host has F_FREE_PAGE_HINT;
        - remove the timer patch which is not needed now.
    2) migration
       - new api, qemu_guest_free_page_hint;
       - rs->free_page_support set only in the precopy case;
       - use the new balloon APIs.
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
  migration: API to clear bits of guest free pages from the dirty bitmap
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  migration: use the free page hint feature from balloon

 balloon.c                                       |  49 +++++--
 hw/virtio/virtio-balloon.c                      | 172 +++++++++++++++++++++---
 include/hw/virtio/virtio-balloon.h              |  14 +-
 include/migration/misc.h                        |   2 +
 include/standard-headers/linux/virtio_balloon.h |   7 +
 include/sysemu/balloon.h                        |  15 ++-
 migration/ram.c                                 |  39 +++++-
 7 files changed, 268 insertions(+), 30 deletions(-)

-- 
1.8.3.1
