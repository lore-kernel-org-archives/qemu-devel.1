Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYZS-0004t5-3l
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYZR-0000YQ-5i
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:58183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1etYZQ-0000VH-MQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:24 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed,  7 Mar 2018 20:34:25 +0800
Message-Id: <1520426065-40265-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v4 4/4] migration: use the free page hint
 feature from balloon
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

Start the free page optimization after the migration bitmap is
synchronized. This can't be used in the stop&copy phase since the guest
is paused. Make sure the guest reporting has stopped before
synchronizing the migration dirty bitmap. Currently, the optimization is
added to precopy only.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e172798..7b4c9b1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -51,6 +51,8 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/balloon.h"
+#include "sysemu/sysemu.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -208,6 +210,8 @@ struct RAMState {
     uint32_t last_version;
     /* We are in the first round */
     bool ram_bulk_stage;
+    /* The free pages optimization feature is supported */
+    bool free_page_support;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
     /* these variables are used for bitmap sync */
@@ -775,7 +779,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     unsigned long *bitmap = rb->bmap;
     unsigned long next;
 
-    if (rs->ram_bulk_stage && start > 0) {
+    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
         next = start + 1;
     } else {
         next = find_next_bit(bitmap, size, start);
@@ -833,6 +837,10 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
+    if (rs->free_page_support) {
+        balloon_free_page_stop();
+    }
+
     ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
@@ -899,6 +907,10 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
     }
+
+    if (rs->free_page_support && runstate_is_running()) {
+        balloon_free_page_start();
+    }
 }
 
 /**
@@ -1656,6 +1668,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+    rs->free_page_support = balloon_free_page_support() &
+                            !migration_in_postcopy();
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2330,6 +2344,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        if (rs->free_page_support) {
+            balloon_free_page_stop();
+        }
         return ret;
     }
 
-- 
1.8.3.1
