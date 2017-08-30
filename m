Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmySv-0000Ti-15
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmySu-0004Ej-5F
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmySt-0004EH-W1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:35:12 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:22 +0800
Message-Id: <1504081950-2528-26-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 25/33] migration: setup ramstate for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

After we updated the dirty bitmaps of ramblocks, we also need to update
the critical fields in RAMState to make sure it is ready for a resume.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 37 ++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index afabcf5..c5d9028 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1986,6 +1986,33 @@ static int ram_state_init(RAMState **rsp)
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
@@ -2909,8 +2936,16 @@ out:
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
index 8962916..6e06283 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -85,6 +85,7 @@ ram_dirty_bitmap_sync_start(void) ""
 ram_dirty_bitmap_sync_wait(void) ""
 ram_dirty_bitmap_sync_notify(void) ""
 ram_dirty_bitmap_sync_complete(void) ""
+ram_state_resume_prepare(long v) "%ld"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.7.4
