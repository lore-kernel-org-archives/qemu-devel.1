Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE8C-0003gG-CK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euE87-0005ha-Dc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:16:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euE87-0005gs-7g
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:15:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:15:17 +0800
Message-Id: <20180309091535.13315-6-peterx@redhat.com>
In-Reply-To: <20180309091535.13315-1-peterx@redhat.com>
References: <20180309091535.13315-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 05/23] migration: allow src return path to
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let the thread pause for network issues.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 35 +++++++++++++++++++++++++++++++++--
 migration/migration.h  |  1 +
 migration/trace-events |  2 ++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 91a4ebba8f..b764f3b804 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1708,6 +1708,18 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1724,6 +1736,8 @@ static void *source_return_path_thread(void *opaque)
     int res;
 
     trace_source_return_path_thread_entry();
+
+retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -1815,13 +1829,28 @@ static void *source_return_path_thread(void *opaque)
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
@@ -2629,6 +2658,7 @@ static void migration_instance_finalize(Object *obj)
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
+    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
 }
 
 static void migration_instance_init(Object *obj)
@@ -2659,6 +2689,7 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size = true;
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
+    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 9a2de4ba9b..1a18d2e142 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -184,6 +184,7 @@ struct MigrationState
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
+    QemuSemaphore postcopy_pause_rp_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/trace-events b/migration/trace-events
index 8685a62c98..ca17a70222 100644
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
