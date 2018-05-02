Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIw-0006Ln-7J
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIv-0002m6-5C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpIu-0002ld-U8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:09 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:21 +0800
Message-Id: <20180502104740.12123-6-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 05/24] migration: allow src return path to
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let the thread pause for network issues.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h  |  1 +
 migration/migration.c  | 35 +++++++++++++++++++++++++++++++++--
 migration/trace-events |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index ad96cc2c85..db28a66a92 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -200,6 +200,7 @@ struct MigrationState
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
+    QemuSemaphore postcopy_pause_rp_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/migration.c b/migration/migration.c
index 5ad3a79354..09dbf5350c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1774,6 +1774,18 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1790,6 +1802,8 @@ static void *source_return_path_thread(void *opaque)
     int res;
 
     trace_source_return_path_thread_entry();
+
+retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -1881,13 +1895,28 @@ static void *source_return_path_thread(void *opaque)
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
@@ -2695,6 +2724,7 @@ static void migration_instance_finalize(Object *obj)
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
+    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
     error_free(ms->error);
 }
 
@@ -2726,6 +2756,7 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
+    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
 }
 
 /*
diff --git a/migration/trace-events b/migration/trace-events
index e23ec019be..cd971bf9fe 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -99,6 +99,8 @@ migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
+postcopy_pause_return_path(void) ""
+postcopy_pause_return_path_continued(void) ""
 postcopy_pause_continued(void) ""
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
-- 
2.14.3
