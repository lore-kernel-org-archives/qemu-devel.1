Received: from eggs.gnu.org ([2001:4830:134:3::10]:57583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5B-0003hd-Qa
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF56-0000os-Mk
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:14567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNF56-0000oM-F2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:04 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:07:56 +0800
Message-Id: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v9 0/8] virtio-balloon: free page hint support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

This is the deivce part implementation to add a new feature,
VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
receives the guest free page hints from the driver and clears the
corresponding bits in the dirty bitmap, so that those free pages are
not sent by the migration thread to the destination.

*Tests
1 Test Environment
    Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
    Migration setup: migrate_set_speed 100G, migrate_set_downtime 400ms

2 Test Results (results are averaged over several repeated runs)
    2.1 Guest setup: 8G RAM, 4 vCPU
        2.1.1 Idle guest live migration time
            Optimization v.s. Legacy = 620ms vs 2970ms
            --> ~79% reduction
        2.1.2 Guest live migration with Linux compilation workload
          (i.e. make bzImage -j4) running
          1) Live Migration Time:
             Optimization v.s. Legacy = 2273ms v.s. 4502ms
             --> ~50% reduction
          2) Linux Compilation Time:
             Optimization v.s. Legacy = 8min42s v.s. 8min43s
             --> no obvious difference

    2.2 Guest setup: 128G RAM, 4 vCPU
        2.2.1 Idle guest live migration time
            Optimization v.s. Legacy = 5294ms vs 41651ms
            --> ~87% reduction
        2.2.2 Guest live migration with Linux compilation workload
          1) Live Migration Time:
            Optimization v.s. Legacy = 8816ms v.s. 54201ms
            --> 84% reduction
          2) Linux Compilation Time:
             Optimization v.s. Legacy = 8min30s v.s. 8min36s
             --> no obvious difference

ChangeLog:
v8->v9:
bitmap:
    - fix bitmap_count_one to handle the nbits=0 case
migration:
    - replace the ram save notifier chain with a more general precopy
      notifier chain, which is similar to the postcopy notifier chain.
    - Avoid exposing the RAMState struct, and add a function,
      precopy_disable_bulk_stage, to let the virtio-balloon notifier
      callback to disable the bulk stage flag.
virtio-balloon:
    - Remove VIRTIO_BALLOON_F_PAGE_POISON from this series as it is not
      a limit to the free page optimization now. Plan to add the device
      support for VIRTIO_BALLOON_F_PAGE_POISON in another patch later.

Previous changelog:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01908.html

Wei Wang (8):
  bitmap: fix bitmap_count_one
  bitmap: bitmap_count_one_with_offset
  migration: use bitmap_mutex in migration_bitmap_clear_dirty
  migration: API to clear bits of guest free pages from the dirty bitmap
  migration/ram.c: add a notifier chain for precopy
  migration/ram.c: add a function to disable the bulk stage
  migration: move migrate_postcopy() to include/migration/misc.h
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

 hw/virtio/virtio-balloon.c                      | 255 ++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h              |  28 ++-
 include/migration/misc.h                        |  16 ++
 include/qemu/bitmap.h                           |  17 ++
 include/standard-headers/linux/virtio_balloon.h |   5 +
 migration/migration.h                           |   2 -
 migration/ram.c                                 |  91 +++++++++
 vl.c                                            |   1 +
 8 files changed, 412 insertions(+), 3 deletions(-)

-- 
1.8.3.1
