Received: from eggs.gnu.org ([2001:4830:134:3::10]:48143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbnm-0003MS-2r
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWbni-0001Be-RX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWbni-0001BG-Ig
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 00:41:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B988681DE9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 05:41:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 13:40:43 +0800
Message-Id: <20180103054043.25719-12-peterx@redhat.com>
In-Reply-To: <20180103054043.25719-1-peterx@redhat.com>
References: <20180103054043.25719-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] migration: put the finish part into a
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 80 +++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c6c39738d2..51379bba2c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2244,6 +2244,47 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
+        assert(migrate_colo_enabled());
+        migrate_start_colo_process(s);
+        /*
+         * Fixme: we will run VM in COLO no matter its old running state.
+         * After exited COLO, we will keep running.
+         */
+        s->old_vm_running = true;
+        /* Fallthrough */
+    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_CANCELLED:
+        if (s->old_vm_running) {
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
@@ -2322,44 +2363,7 @@ static void *migration_thread(void *opaque)
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
-        assert(migrate_colo_enabled());
-        migrate_start_colo_process(s);
-        /*
-         * Fixme: we will run VM in COLO no matter its old running state.
-         * After exited COLO, we will keep running.
-         */
-        s->old_vm_running = true;
-        /* Fallthrough */
-    case MIGRATION_STATUS_FAILED:
-    case MIGRATION_STATUS_CANCELLED:
-        if (s->old_vm_running) {
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
