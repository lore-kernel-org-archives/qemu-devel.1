Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2P-0006vF-2e
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2O-0002PU-0t
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi2N-0002OP-Ni
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9B7B49007
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:15 +0800
Message-Id: <20180103122017.14794-12-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/13] migration: put the finish part into a
 new function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This patch only moved the last part of migration_thread() into a new
function migration_iteration_finish() to make it much shorter.  With
previous works to remove some local variables, now it's fairly easy to
do that.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 94 +++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2b42d6c9a1..16eb24c8b3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2254,6 +2254,54 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     return MIG_ITERATE_RESUME;
 }
 
+static void migration_iteration_finish(MigrationState *s)
+{
+    /* If we enabled cpu throttling for auto-converge, turn it off. */
+    cpu_throttle_stop();
+
+    qemu_mutex_lock_iothread();
+    switch (s->state) {
+    case MIGRATION_STATUS_COMPLETED:
+        migration_calculate_complete(s);
+        runstate_set(RUN_STATE_POSTMIGRATE);
+        break;
+
+    case MIGRATION_STATUS_ACTIVE:
+        /*
+         * We should really assert here, but since it's during
+         * migration, let's try to reduce the usage of assertions.
+         */
+        if (!migrate_colo_enabled()) {
+            error_report("%s: critical error: calling COLO code without "
+                         "COLO enabled", __func__);
+        }
+        migrate_start_colo_process(s);
+        /*
+         * Fixme: we will run VM in COLO no matter its old running state.
+         * After exited COLO, we will keep running.
+         */
+        s->vm_was_running = true;
+        /* Fallthrough */
+    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_CANCELLED:
+        if (s->vm_was_running) {
+            vm_start();
+        } else {
+            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+                runstate_set(RUN_STATE_POSTMIGRATE);
+            }
+        }
+        break;
+
+    default:
+        /* Should not reach here, but if so, forgive the VM. */
+        error_report("%s: Unknown ending state %d", __func__, s->state);
+        break;
+    }
+    qemu_bh_schedule(s->cleanup_bh);
+    qemu_mutex_unlock_iothread();
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2332,51 +2380,7 @@ static void *migration_thread(void *opaque)
     }
 
     trace_migration_thread_after_loop();
-    /* If we enabled cpu throttling for auto-converge, turn it off. */
-    cpu_throttle_stop();
-
-    qemu_mutex_lock_iothread();
-    switch (s->state) {
-    case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
-        runstate_set(RUN_STATE_POSTMIGRATE);
-        break;
-
-    case MIGRATION_STATUS_ACTIVE:
-        /*
-         * We should really assert here, but since it's during
-         * migration, let's try to reduce the usage of assertions.
-         */
-        if (!migrate_colo_enabled()) {
-            error_report("%s: critical error: calling COLO code without "
-                         "COLO enabled", __func__);
-        }
-        migrate_start_colo_process(s);
-        /*
-         * Fixme: we will run VM in COLO no matter its old running state.
-         * After exited COLO, we will keep running.
-         */
-        s->vm_was_running = true;
-        /* Fallthrough */
-    case MIGRATION_STATUS_FAILED:
-    case MIGRATION_STATUS_CANCELLED:
-        if (s->vm_was_running) {
-            vm_start();
-        } else {
-            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
-                runstate_set(RUN_STATE_POSTMIGRATE);
-            }
-        }
-        break;
-
-    default:
-        /* Should not reach here, but if so, forgive the VM. */
-        error_report("%s: Unknown ending state %d", __func__, s->state);
-        break;
-    }
-    qemu_bh_schedule(s->cleanup_bh);
-    qemu_mutex_unlock_iothread();
-
+    migration_iteration_finish(s);
     rcu_unregister_thread();
     return NULL;
 }
-- 
2.14.3
