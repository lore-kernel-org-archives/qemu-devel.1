Received: from eggs.gnu.org ([2001:4830:134:3::10]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Jw-0001gP-BS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Jt-0001kf-5C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0Js-0001k7-S8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:08:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:35 +0800
Message-Id: <1501229198-30588-27-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 26/29] migration: synchronize dirty bitmap for
 resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This patch implements the first part of core RAM resume logic for
postcopy. ram_resume_prepare() is provided for the work.

When the migration is interrupted by network failure, the dirty bitmap
on the source side will be meaningless, because even the dirty bit is
cleared, it is still possible that the sent page was lost along the way
to destination. Here instead of continue the migration with the old
dirty bitmap on source, we ask the destination side to send back its
received bitmap, then invert it to be our initial dirty bitmap.

The source side send thread will issue the MIG_CMD_RECV_BITMAP requests,
once per ramblock, to ask for the received bitmap. On destination side,
MIG_RP_MSG_RECV_BITMAP will be issued, along with the requested bitmap.
Data will be received on the return-path thread of source, and the main
migration thread will be notified when all the ramblock bitmaps are
synchronized.

One issue to be solved here is how to synchronize the source send thread
and return-path thread. Semaphore cannot really work here since we
cannot guarantee the order of wait/post (it's possible that the reply is
very fast, even before send thread starts to wait). So conditional
variable is used to make sure the ordering is always correct.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  |  4 +++
 migration/migration.h  |  4 +++
 migration/ram.c        | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 4 files changed, 77 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 6cb0ad3..93fbc96 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1093,6 +1093,8 @@ static void migrate_fd_cleanup(void *opaque)
 
     qemu_sem_destroy(&s->postcopy_pause_sem);
     qemu_sem_destroy(&s->postcopy_pause_rp_sem);
+    qemu_mutex_destroy(&s->resume_lock);
+    qemu_cond_destroy(&s->resume_cond);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
@@ -1238,6 +1240,8 @@ MigrationState *migrate_init(void)
     s->error = NULL;
     qemu_sem_init(&s->postcopy_pause_sem, 0);
     qemu_sem_init(&s->postcopy_pause_rp_sem, 0);
+    qemu_mutex_init(&s->resume_lock);
+    qemu_cond_init(&s->resume_cond);
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/migration.h b/migration/migration.h
index 2a3f905..c270f4c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -159,6 +159,10 @@ struct MigrationState
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
     QemuSemaphore postcopy_pause_rp_sem;
+
+    /* Used to sync-up between main send thread and rp-thread */
+    QemuMutex resume_lock;
+    QemuCond resume_cond;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/ram.c b/migration/ram.c
index d543483..c695b13 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -46,6 +46,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "savevm.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -256,6 +257,8 @@ struct RAMState {
     RAMBlock *last_req_rb;
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
+    /* Ramblock counts to sync dirty bitmap. Only used for recovery */
+    int ramblock_to_sync;
     QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
 };
 typedef struct RAMState RAMState;
@@ -2731,6 +2734,57 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+/* Sync all the dirty bitmap with destination VM.  */
+static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
+{
+    RAMBlock *block;
+    QEMUFile *file = s->to_dst_file;
+    int ramblock_count = 0;
+
+    trace_ram_dirty_bitmap_sync("start");
+
+    /*
+     * We need to take the resume lock to make sure that the send
+     * thread (current thread) and the rp-thread will do their work in
+     * order.
+     */
+    qemu_mutex_lock(&s->resume_lock);
+
+    /* Request for receive-bitmap for each block */
+    RAMBLOCK_FOREACH(block) {
+        ramblock_count++;
+        qemu_savevm_send_recv_bitmap(file, block->idstr);
+    }
+
+    /* Init the ramblock count to total */
+    atomic_set(&rs->ramblock_to_sync, ramblock_count);
+
+    trace_ram_dirty_bitmap_sync("wait-bitmap");
+
+    /* Wait until all the ramblocks' dirty bitmap synced */
+    while (rs->ramblock_to_sync) {
+        qemu_cond_wait(&s->resume_cond, &s->resume_lock);
+    }
+
+    trace_ram_dirty_bitmap_sync("completed");
+
+    qemu_mutex_unlock(&s->resume_lock);
+
+    return 0;
+}
+
+static void ram_dirty_bitmap_reload_notify(MigrationState *s)
+{
+    qemu_mutex_lock(&s->resume_lock);
+    atomic_dec(&ram_state->ramblock_to_sync);
+    if (ram_state->ramblock_to_sync == 0) {
+        /* Make sure the other thread gets the latest */
+        trace_ram_dirty_bitmap_sync("notify-send");
+        qemu_cond_signal(&s->resume_cond);
+    }
+    qemu_mutex_unlock(&s->resume_lock);
+}
+
 /*
  * Read the received bitmap, revert it as the initial dirty bitmap.
  * This is only used when the postcopy migration is paused but wants
@@ -2776,9 +2830,22 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     trace_ram_dirty_bitmap_reload(block->idstr);
 
+    /*
+     * We succeeded to sync bitmap for current ramblock. If this is
+     * the last one to sync, we need to notify the main send thread.
+     */
+    ram_dirty_bitmap_reload_notify(s);
+
     return 0;
 }
 
+static int ram_resume_prepare(MigrationState *s, void *opaque)
+{
+    RAMState *rs = *(RAMState **)opaque;
+
+    return ram_dirty_bitmap_sync_all(s, rs);
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
@@ -2789,6 +2856,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_cleanup = ram_save_cleanup,
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
+    .resume_prepare = ram_resume_prepare,
 };
 
 void ram_mig_init(void)
diff --git a/migration/trace-events b/migration/trace-events
index 0fb2d1e..15ff1bf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -80,6 +80,7 @@ ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
 ram_dirty_bitmap_reload(char *str) "%s"
+ram_dirty_bitmap_sync(const char *str) "%s"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.7.4
