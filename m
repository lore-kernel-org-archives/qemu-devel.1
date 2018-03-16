Received: from eggs.gnu.org ([2001:4830:134:3::10]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnCt-0008NL-6c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnCp-00076a-H1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:53864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewnCp-0006yG-3z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:27 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Mar 2018 18:48:24 +0800
Message-Id: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v5 0/5] virtio-balloon: free page hint
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
        - Optimization v.s. Legacy = 261ms vs 1769ms --> ~86% reduction
    - Guest with Linux Compilation Workload (make bzImage -j4):
        - Live Migration Time (average)
          Optimization v.s. Legacy = 1260ms v.s. 2634ms --> ~51% reduction
        - Linux Compilation Time
          Optimization v.s. Legacy = 4min58s v.s. 5min3s
          --> no obvious difference

- Source Code
    - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
    - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git

ChangeLog:
v4->v5:
    1) migration:
        - bitmap_clear_dirty: update the dirty bitmap and dirty page
          count under the bitmap mutex as what other functions are doing;
        - qemu_guest_free_page_hint:
            - add comments for this function;
            - check the !block case;
            - check "offset > block->used_length" before proceed;
            - assign used_len inside the for{} body;
            - update the dirty bitmap and dirty page counter under the
              bitmap mutex;
        - ram_state_reset:
            - rs->free_page_support: && with use "migrate_postcopy"
              instead of migration_in_postcopy;
            - clear the ram_bulk_stage flag if free_page_support is true;
    2) balloon:
         - add the usage documentation of balloon_free_page_start and
           balloon_free_page_stop in code;
         - the optimization thread is named "balloon_fpo" to meet the
           requirement of "less than 14 characters";
         - virtio_balloon_poll_free_page_hints:
             - run on condition when runstate_is_running() is true;
             - add a qemu spin lock to synchronize accesses to the free
               page reporting related fields shared among the migration
               thread and the optimization thread;
          - virtio_balloon_free_page_start: just return if
            runstate_is_running is false;
          - virtio_balloon_free_page_stop: access to the free page
            reporting related fields under a qemu spin lock;
          - virtio_balloon_device_unrealize/reset: call
            virtio_balloon_free_page_stop is the free page hint feature is
            used;
          - virtio_balloon_set_status: call irtio_balloon_free_page_stop
            in case the guest is stopped by qmp when the optimization is
            running;
v3->v4:
    1) bitmap: add a new API to count 1s starting from an offset of a
       bitmap
    2) migration:
        - qemu_guest_free_page_hint: calculate
          ram_state->migration_dirty_pages by counting how many bits of
          free pages are truely cleared. If some of the bits were
          already 0, they shouldn't be deducted by
          ram_state->migration_dirty_pages. This wasn't needed for
          previous versions since we optimized bulk stage only,
          where all bits are guaranteed to be set. It's needed now
          because we extened the usage of this optimizaton to all stages
          except the last stop&copy stage. From 2nd stage onward, there
          are possibilities that some bits of free pages are already 0.
     3) virtio-balloon:
         - virtio_balloon_free_page_report_status: introduce a new status,
           FREE_PAGE_REPORT_S_EXIT. This status indicates that the
           optimization thread has exited. FREE_PAGE_REPORT_S_STOP means
           the reporting is stopped, but the optimization thread still needs
           to be joined by the migration thread.
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

Wei Wang (5):
  bitmap: bitmap_count_one_with_offset
  migration: use bitmap_mutex in migration_bitmap_clear_dirty
  migration: API to clear bits of guest free pages from the dirty bitmap
  virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
  migration: use the free page hint feature from balloon

 balloon.c                                       |  58 +++++--
 hw/virtio/virtio-balloon.c                      | 217 ++++++++++++++++++++++--
 include/hw/virtio/virtio-balloon.h              |  20 ++-
 include/migration/misc.h                        |   2 +
 include/qemu/bitmap.h                           |  13 ++
 include/standard-headers/linux/virtio_balloon.h |   7 +
 include/sysemu/balloon.h                        |  15 +-
 migration/ram.c                                 |  73 +++++++-
 8 files changed, 375 insertions(+), 30 deletions(-)

-- 
1.8.3.1
