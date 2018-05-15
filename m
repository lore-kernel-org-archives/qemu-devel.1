Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYx-0003N8-KL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYw-0001wZ-95
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYw-0001wK-2z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC2F281FE141
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:05 +0200
Message-Id: <20180515234017.2277-29-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 28/40] migration: synchronize dirty bitmap for
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-17-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  |  2 ++
 migration/migration.h  |  1 +
 migration/ram.c        | 47 ++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events |  4 ++++
 4 files changed, 54 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b0217c4823..19ef8b05b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2967,6 +2967,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
+    qemu_sem_destroy(&ms->rp_state.rp_sem);
     error_free(ms->error);
 }
 
@@ -2999,6 +3000,7 @@ static void migration_instance_init(Object *obj)
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
+    qemu_sem_init(&ms->rp_state.rp_sem, 0);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 556964d9d9..b4438ccb65 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -135,6 +135,7 @@ struct MigrationState
         QEMUFile     *from_dst_file;
         QemuThread    rp_thread;
         bool          error;
+        QemuSemaphore rp_sem;
     } rp_state;
 
     double mbps;
diff --git a/migration/ram.c b/migration/ram.c
index 5542843adc..b16eabcfb9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -54,6 +54,7 @@
 #include "migration/block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
+#include "savevm.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -3364,6 +3365,38 @@ static bool ram_has_postcopy(void *opaque)
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
@@ -3438,12 +3471,25 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
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
@@ -3455,6 +3501,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_cleanup = ram_save_cleanup,
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
+    .resume_prepare = ram_resume_prepare,
 };
 
 void ram_mig_init(void)
diff --git a/migration/trace-events b/migration/trace-events
index be36fbccfe..53243e17ec 100644
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
2.17.0
