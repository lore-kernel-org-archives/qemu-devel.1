Received: from eggs.gnu.org ([2001:4830:134:3::10]:42791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zHc-0001Q6-St
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zHb-0002kR-W0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zHb-0002ji-PA
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:53:51 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2017 14:52:05 +0800
Message-Id: <20171016065216.18162-22-peterx@redhat.com>
In-Reply-To: <20171016065216.18162-1-peterx@redhat.com>
References: <20171016065216.18162-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 21/32] migration: setup ramstate for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

After we updated the dirty bitmaps of ramblocks, we also need to update
the critical fields in RAMState to make sure it is ready for a resume.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 37 ++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a7431a802e..79c52631b9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2185,6 +2185,33 @@ static int ram_state_init(RAMState **rsp)
     return 0;
 }
 
+static void ram_state_resume_prepare(RAMState *rs)
+{
+    RAMBlock *block;
+    long pages = 0;
+
+    /*
+     * Postcopy is not using xbzrle/compression, so no need for that.
+     * Also, since source are already halted, we don't need to care
+     * about dirty page logging as well.
+     */
+
+    RAMBLOCK_FOREACH(block) {
+        pages += bitmap_count_one(block->bmap,
+                                  block->used_length >> TARGET_PAGE_BITS);
+    }
+
+    /* This may not be aligned with current bitmaps. Recalculate. */
+    rs->migration_dirty_pages = pages;
+
+    rs->last_seen_block = NULL;
+    rs->last_sent_block = NULL;
+    rs->last_page = 0;
+    rs->last_version = ram_list.version;
+
+    trace_ram_state_resume_prepare(pages);
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3106,8 +3133,16 @@ out:
 static int ram_resume_prepare(MigrationState *s, void *opaque)
 {
     RAMState *rs = *(RAMState **)opaque;
+    int ret;
 
-    return ram_dirty_bitmap_sync_all(s, rs);
+    ret = ram_dirty_bitmap_sync_all(s, rs);
+    if (ret) {
+        return ret;
+    }
+
+    ram_state_resume_prepare(rs);
+
+    return 0;
 }
 
 static SaveVMHandlers savevm_ram_handlers = {
diff --git a/migration/trace-events b/migration/trace-events
index 804f18d492..98c2e4de58 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,6 +88,7 @@ ram_dirty_bitmap_reload_complete(char *str) "%s"
 ram_dirty_bitmap_sync_start(void) ""
 ram_dirty_bitmap_sync_wait(void) ""
 ram_dirty_bitmap_sync_complete(void) ""
+ram_state_resume_prepare(long v) "%ld"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.13.5
