Received: from eggs.gnu.org ([2001:4830:134:3::10]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ6-0003Ww-JT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZ4-000207-4I
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjZ3-0001zs-V7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85E1281FE141
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:41:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:11 +0200
Message-Id: <20180515234017.2277-35-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 34/40] migration: introduce lock for to_dst_file
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

Let's introduce a lock for that QEMUFile since we are going to operate
on it in multiple threads.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-23-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/channel.c   |  3 ++-
 migration/migration.c | 22 +++++++++++++++++++---
 migration/migration.h |  6 ++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index c5eaf0fa0e..716192bf75 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -74,8 +74,9 @@ void migration_channel_connect(MigrationState *s,
         } else {
             QEMUFile *f = qemu_fopen_channel_output(ioc);
 
+            qemu_mutex_lock(&s->qemu_file_lock);
             s->to_dst_file = f;
-
+            qemu_mutex_unlock(&s->qemu_file_lock);
         }
     }
     migrate_fd_connect(s, error);
diff --git a/migration/migration.c b/migration/migration.c
index 1beb5e07fb..3deded90e5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1234,6 +1234,7 @@ static void migrate_fd_cleanup(void *opaque)
 
     if (s->to_dst_file) {
         Error *local_err = NULL;
+        QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
         qemu_mutex_unlock_iothread();
@@ -1246,8 +1247,15 @@ static void migrate_fd_cleanup(void *opaque)
         if (multifd_save_cleanup(&local_err) != 0) {
             error_report_err(local_err);
         }
-        qemu_fclose(s->to_dst_file);
+        qemu_mutex_lock(&s->qemu_file_lock);
+        tmp = s->to_dst_file;
         s->to_dst_file = NULL;
+        qemu_mutex_unlock(&s->qemu_file_lock);
+        /*
+         * Close the file handle without the lock to make sure the
+         * critical section won't block for long.
+         */
+        qemu_fclose(tmp);
     }
 
     assert((s->state != MIGRATION_STATUS_ACTIVE) &&
@@ -2531,14 +2539,20 @@ static MigThrError postcopy_pause(MigrationState *s)
     assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     while (true) {
+        QEMUFile *file;
+
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
 
         /* Current channel is possibly broken. Release it. */
         assert(s->to_dst_file);
-        qemu_file_shutdown(s->to_dst_file);
-        qemu_fclose(s->to_dst_file);
+        qemu_mutex_lock(&s->qemu_file_lock);
+        file = s->to_dst_file;
         s->to_dst_file = NULL;
+        qemu_mutex_unlock(&s->qemu_file_lock);
+
+        qemu_file_shutdown(file);
+        qemu_fclose(file);
 
         error_report("Detected IO failure for postcopy. "
                      "Migration paused.");
@@ -3007,6 +3021,7 @@ static void migration_instance_finalize(Object *obj)
     MigrationParameters *params = &ms->parameters;
 
     qemu_mutex_destroy(&ms->error_mutex);
+    qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
@@ -3046,6 +3061,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
+    qemu_mutex_init(&ms->qemu_file_lock);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index f83f1064b5..8f0c82159b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -114,6 +114,12 @@ struct MigrationState
     QemuThread thread;
     QEMUBH *cleanup_bh;
     QEMUFile *to_dst_file;
+    /*
+     * Protects to_dst_file pointer.  We need to make sure we won't
+     * yield or hang during the critical section, since this lock will
+     * be used in OOB command handler.
+     */
+    QemuMutex qemu_file_lock;
 
     /* bytes already send at the beggining of current interation */
     uint64_t iteration_initial_bytes;
-- 
2.17.0
