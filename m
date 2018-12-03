Received: from eggs.gnu.org ([2001:4830:134:3::10]:49844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKd-0000sj-7l
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKa-0000aB-25
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:65450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTeKZ-0000Zq-PM
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:32 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  3 Dec 2018 10:18:24 +0800
Message-Id: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v10 0/7] virtio-balloon: free page hint support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

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
v9->v10:
migration:
    - qemu_guest_free_page_hint:
        - move "addr += used_len" to the for() loop;
        - add some comments about the ram block resize case.
    - precopy notifier:
        - enable callbacks to report errors (as the postcopy notifier);
        - rename the notifier reasons:
            - PRECOPY_NOTIFY_COMPLETE notifies the callback about the
              end of precopy;
            - PRECOPY_NOTIFY_CLEANUP notifies the callback in the case
              migration is cancelled;
        - relocate some notifications to the upper layer functions
          (i.e. qemu_savevm_state_*), which can get the callbacks notified
          when non-ram-saving code has errors which stops the precopy.
    - migration_bitmap_sync_precopy to be called by the precopy code path
      with precopy notifier supported, and migration_bitmap_sync is left
      for callers without the need of precopy notifier (e.g. some postcopy
      code).
    - avoid exposing migrate_postcopy;
virtio-balloon:
    - virtio_balloon_free_page_report_notify: remove the migrate_postcopy
      check becasue the migration code has guaranteed that the notifier
      callback is invoked when in the precopy mode.

Previous changelog:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02854.html

Wei Wang (7):
  bitmap: fix bitmap_count_one
  bitmap: bitmap_count_one_with_offset
  migration: use bitmap_mutex in migration_bitmap_clear_dirty
  migration: API to clear bits of guest free pages from the dirty bitmap
  migration/ram.c: add a notifier chain for precopy
  migration/ram.c: add a function to disable the bulk stage
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

 hw/virtio/virtio-balloon.c                      | 263 ++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h              |  28 ++-
 include/migration/misc.h                        |  22 ++
 include/qemu/bitmap.h                           |  17 ++
 include/standard-headers/linux/virtio_balloon.h |   5 +
 migration/ram.c                                 | 112 +++++++++-
 migration/savevm.c                              |  15 ++
 vl.c                                            |   1 +
 8 files changed, 458 insertions(+), 5 deletions(-)

-- 
1.8.3.1
