Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJS1-0000Kw-Nx
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJS0-00072g-Jn
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJS0-00072N-BI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:00 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:18 +0800
Message-Id: <20171108060130.3772-21-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 20/32] migration: synchronize dirty bitmap
 for resume
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  |  3 +++
 migration/migration.h  |  1 +
 migration/ram.c        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  4 ++++
 4 files changed, 55 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 4dc34ed8ce..5b1fbe5b98 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2843,6 +2843,7 @@ static void migration_instance_finalize(Object *obj)
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
+    qemu_sem_destroy(&ms->rp_state.rp_sem);
 }
 
 static void migration_instance_init(Object *obj)
@@ -2871,6 +2872,8 @@ static void migration_instance_init(Object *obj)
     params->has_x_multifd_channels = true;
     params->has_x_multifd_page_count = true;
     params->has_xbzrle_cache_size = true;
+
+    qemu_sem_init(&ms->rp_state.rp_sem, 0);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 11fbfebba1..82dd7d9820 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -108,6 +108,7 @@ struct MigrationState
         QEMUFile     *from_dst_file;
         QemuThread    rp_thread;
         bool          error;
+        QemuSemaphore rp_sem;
     } rp_state;
 
     double mbps;
diff --git a/migration/ram.c b/migration/ram.c
index b30c669476..49627ca9fc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -49,6 +49,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "migration/block.h"
+#include "savevm.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -3049,6 +3050,38 @@ static bool ram_has_postcopy(void *opaque)
     return migrate_postcopy_ram();
 }
 
+/* Sync all the dirty bitmap with destination VM.  */
+static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
+{
+    RAMBlock *block;
+    QEMUFile *file = s->to_dst_file;
+    int ramblock_count = 0;
+
+    trace_ram_dirty_bitmap_sync_start();
+
+    RAMBLOCK_FOREACH(block) {
+        qemu_savevm_send_recv_bitmap(file, block->idstr);
+        trace_ram_dirty_bitmap_request(block->idstr);
+        ramblock_count++;
+    }
+
+    trace_ram_dirty_bitmap_sync_wait();
+
+    /* Wait until all the ramblocks' dirty bitmap synced */
+    while (ramblock_count--) {
+        qemu_sem_wait(&s->rp_state.rp_sem);
+    }
+
+    trace_ram_dirty_bitmap_sync_complete();
+
+    return 0;
+}
+
+static void ram_dirty_bitmap_reload_notify(MigrationState *s)
+{
+    qemu_sem_post(&s->rp_state.rp_sem);
+}
+
 /*
  * Read the received bitmap, revert it as the initial dirty bitmap.
  * This is only used when the postcopy migration is paused but wants
@@ -3123,12 +3156,25 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     trace_ram_dirty_bitmap_reload_complete(block->idstr);
 
+    /*
+     * We succeeded to sync bitmap for current ramblock. If this is
+     * the last one to sync, we need to notify the main send thread.
+     */
+    ram_dirty_bitmap_reload_notify(s);
+
     ret = 0;
 out:
     free(le_bitmap);
     return ret;
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
@@ -3140,6 +3186,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_cleanup = ram_save_cleanup,
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
+    .resume_prepare = ram_resume_prepare,
 };
 
 void ram_mig_init(void)
diff --git a/migration/trace-events b/migration/trace-events
index eadabf03e8..804f18d492 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -82,8 +82,12 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+ram_dirty_bitmap_request(char *str) "%s"
 ram_dirty_bitmap_reload_begin(char *str) "%s"
 ram_dirty_bitmap_reload_complete(char *str) "%s"
+ram_dirty_bitmap_sync_start(void) ""
+ram_dirty_bitmap_sync_wait(void) ""
+ram_dirty_bitmap_sync_complete(void) ""
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.13.6
