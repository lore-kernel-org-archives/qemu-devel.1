Received: from eggs.gnu.org ([2001:4830:134:3::10]:34169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRH-0007KF-ML
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRC-0003MP-QA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyRC-0003Lz-Hn
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:26 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:08 +0800
Message-Id: <1504081950-2528-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 11/33] migration: allow src return path to
 pause
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

Let the thread pause for network issues.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 35 +++++++++++++++++++++++++++++++++--
 migration/migration.h  |  1 +
 migration/trace-events |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 80de212..b3cd8be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -996,6 +996,7 @@ static void migrate_fd_cleanup(void *opaque)
     block_cleanup_parameters(s);
 
     qemu_sem_destroy(&s->postcopy_pause_sem);
+    qemu_sem_destroy(&s->postcopy_pause_rp_sem);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
@@ -1140,6 +1141,7 @@ MigrationState *migrate_init(void)
     error_free(s->error);
     s->error = NULL;
     qemu_sem_init(&s->postcopy_pause_sem, 0);
+    qemu_sem_init(&s->postcopy_pause_rp_sem, 0);
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
@@ -1527,6 +1529,18 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
     }
 }
 
+/* Return true to retry, false to quit */
+static bool postcopy_pause_return_path_thread(MigrationState *s)
+{
+    trace_postcopy_pause_return_path();
+
+    qemu_sem_wait(&s->postcopy_pause_rp_sem);
+
+    trace_postcopy_pause_return_path_continued();
+
+    return true;
+}
+
 /*
  * Handles messages sent on the return path towards the source VM
  *
@@ -1543,6 +1557,8 @@ static void *source_return_path_thread(void *opaque)
     int res;
 
     trace_source_return_path_thread_entry();
+
+retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -1634,13 +1650,28 @@ static void *source_return_path_thread(void *opaque)
             break;
         }
     }
-    if (qemu_file_get_error(rp)) {
+
+out:
+    res = qemu_file_get_error(rp);
+    if (res) {
+        if (res == -EIO) {
+            /*
+             * Maybe there is something we can do: it looks like a
+             * network down issue, and we pause for a recovery.
+             */
+            if (postcopy_pause_return_path_thread(ms)) {
+                /* Reload rp, reset the rest */
+                rp = ms->rp_state.from_dst_file;
+                ms->rp_state.error = false;
+                goto retry;
+            }
+        }
+
         trace_source_return_path_thread_bad_end();
         mark_source_rp_bad(ms);
     }
 
     trace_source_return_path_thread_end();
-out:
     ms->rp_state.from_dst_file = NULL;
     qemu_fclose(rp);
     return NULL;
diff --git a/migration/migration.h b/migration/migration.h
index c423682..323d88d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -155,6 +155,7 @@ struct MigrationState
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
+    QemuSemaphore postcopy_pause_rp_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/trace-events b/migration/trace-events
index 7764c6f..1a83f60 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -98,6 +98,8 @@ migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
+postcopy_pause_return_path(void) ""
+postcopy_pause_return_path_continued(void) ""
 postcopy_pause_continued(void) ""
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
-- 
2.7.4
