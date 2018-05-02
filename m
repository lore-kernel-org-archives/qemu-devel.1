Received: from eggs.gnu.org ([2001:4830:134:3::10]:35019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJf-0006vg-4q
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJe-00034a-AK
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJe-00034L-4N
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:54 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:33 +0800
Message-Id: <20180502104740.12123-18-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 17/24] migration: setup ramstate for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

After we updated the dirty bitmaps of ramblocks, we also need to update
the critical fields in RAMState to make sure it is ready for a resume.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 118460109b..2821e15cc2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2291,6 +2291,41 @@ static int ram_init_all(RAMState **rsp)
     return 0;
 }
 
+static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
+{
+    RAMBlock *block;
+    uint64_t pages = 0;
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
+    /*
+     * Disable the bulk stage, otherwise we'll resend the whole RAM no
+     * matter what we have sent.
+     */
+    rs->ram_bulk_stage = false;
+
+    /* Update RAMState cache of output QEMUFile */
+    rs->f = out;
+
+    trace_ram_state_resume_prepare(pages);
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3286,8 +3321,16 @@ out:
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
+    ram_state_resume_prepare(rs, s->to_dst_file);
+
+    return 0;
 }
 
 static SaveVMHandlers savevm_ram_handlers = {
diff --git a/migration/trace-events b/migration/trace-events
index 53243e17ec..46c5ca1dba 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,6 +88,7 @@ ram_dirty_bitmap_reload_complete(char *str) "%s"
 ram_dirty_bitmap_sync_start(void) ""
 ram_dirty_bitmap_sync_wait(void) ""
 ram_dirty_bitmap_sync_complete(void) ""
+ram_state_resume_prepare(uint64_t v) "%ld"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
