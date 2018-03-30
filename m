Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZO-0007Jq-MB
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZL-0007Kv-IW
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:45750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f1qZL-0007Io-96
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:35 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 30 Mar 2018 17:24:36 +0800
Message-Id: <1522401876-39613-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
References: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v6 5/5] migration: use the free page hint
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
 migration/ram.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0147548..1d85ffa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -51,6 +51,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/balloon.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -213,6 +214,8 @@ struct RAMState {
     uint32_t last_version;
     /* We are in the first round */
     bool ram_bulk_stage;
+    /* The free pages optimization feature is supported */
+    bool free_page_support;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
     /* these variables are used for bitmap sync */
@@ -841,6 +844,10 @@ static void migration_bitmap_sync(RAMState *rs)
     int64_t end_time;
     uint64_t bytes_xfer_now;
 
+    if (rs->free_page_support) {
+        balloon_free_page_stop();
+    }
+
     ram_counters.dirty_sync_count++;
 
     if (!rs->time_last_bitmap_sync) {
@@ -907,6 +914,10 @@ static void migration_bitmap_sync(RAMState *rs)
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
     }
+
+    if (rs->free_page_support) {
+        balloon_free_page_start();
+    }
 }
 
 /**
@@ -1663,7 +1674,17 @@ static void ram_state_reset(RAMState *rs)
     rs->last_sent_block = NULL;
     rs->last_page = 0;
     rs->last_version = ram_list.version;
-    rs->ram_bulk_stage = true;
+    rs->free_page_support = balloon_free_page_support() && !migrate_postcopy();
+    if (rs->free_page_support) {
+        /*
+         * When the free page optimization is used, not all the pages are
+         * treated as dirty pages (via migration_bitmap_find_dirty), which need
+         * to be sent. So disable ram_bulk_stage in this case.
+         */
+        rs->ram_bulk_stage = false;
+    } else {
+        rs->ram_bulk_stage = true;
+    }
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2369,6 +2390,9 @@ out:
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        if (rs->free_page_support) {
+            balloon_free_page_stop();
+        }
         return ret;
     }
 
-- 
1.8.3.1
