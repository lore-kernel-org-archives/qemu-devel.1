Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erge6-0006WC-SI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1erge4-0000Fi-IB
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:56819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1erge4-0000EQ-9H
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:06:28 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  2 Mar 2018 16:47:30 +0800
Message-Id: <1519980450-3404-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/3] migration: use the free page hint
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

Start the free page optimization when the bulk stage starts. In case the
guest is slow in reporting, actively stops it when the bulk stage ends.
The optimization avoids sending guest free pages during the bulk stage.
Currently, the optimization is added to precopy only.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 769a0f6..f6af7e6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -51,6 +51,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "sysemu/balloon.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -208,6 +209,8 @@ struct RAMState {
     uint32_t last_version;
     /* We are in the first round */
     bool ram_bulk_stage;
+    /* The free pages optimization feature is supported */
+    bool free_page_support;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
     /* these variables are used for bitmap sync */
@@ -775,7 +778,7 @@ unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
     unsigned long *bitmap = rb->bmap;
     unsigned long next;
 
-    if (rs->ram_bulk_stage && start > 0) {
+    if (rs->ram_bulk_stage && start > 0 && !rs->free_page_support) {
         next = start + 1;
     } else {
         next = find_next_bit(bitmap, size, start);
@@ -1225,6 +1228,10 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
             /* Flag that we've looped */
             pss->complete_round = true;
             rs->ram_bulk_stage = false;
+            if (rs->free_page_support) {
+                balloon_free_page_stop();
+                rs->free_page_support = false;
+            }
             if (migrate_use_xbzrle()) {
                 /* If xbzrle is on, stop using the data compression at this
                  * point. In theory, xbzrle can do better than compression.
@@ -1656,6 +1663,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
+    rs->free_page_support = balloon_free_page_support() &
+                            !migration_in_postcopy();
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
@@ -2235,6 +2244,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             return -1;
         }
     }
+
+    if ((*rsp)->free_page_support) {
+        balloon_free_page_start();
+    }
+
     (*rsp)->f = f;
 
     rcu_read_lock();
@@ -2329,6 +2343,9 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
     ret = qemu_file_get_error(f);
     if (ret < 0) {
+        if (rs->ram_bulk_stage && rs->free_page_support) {
+                balloon_free_page_stop();
+        }
         return ret;
     }
 
-- 
1.8.3.1
