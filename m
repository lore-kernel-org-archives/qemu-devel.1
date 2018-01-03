Received: from eggs.gnu.org ([2001:4830:134:3::10]:56760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2J-0006r7-T2
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2G-0002GZ-KC
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi2G-0002Fk-Db
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95C0787649
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:12 +0800
Message-Id: <20180103122017.14794-9-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/13] migration: use switch at the end of
 migration
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

It converts the old if clauses into switch, explicitly mentions the
possible migration states.  The old nested "if"s are not clear on what
we do on different states.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 72f0b586f7..4dd21f8636 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2302,26 +2302,30 @@ static void *migration_thread(void *opaque)
     cpu_throttle_stop();
 
     qemu_mutex_lock_iothread();
-    if (s->state == MIGRATION_STATUS_COMPLETED) {
+    switch (s->state) {
+    case MIGRATION_STATUS_COMPLETED:
         migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
-    } else {
-        if (s->state == MIGRATION_STATUS_ACTIVE) {
-            /*
-             * We should really assert here, but since it's during
-             * migration, let's try to reduce the usage of assertions.
-             */
-            if (!migrate_colo_enabled()) {
-                error_report("%s: critical error: calling COLO code without "
-                             "COLO enabled", __func__);
-            }
-            migrate_start_colo_process(s);
-            /*
-            * Fixme: we will run VM in COLO no matter its old running state.
-            * After exited COLO, we will keep running.
-            */
-            s->vm_was_running = true;
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
         }
+        migrate_start_colo_process(s);
+        /*
+         * Fixme: we will run VM in COLO no matter its old running state.
+         * After exited COLO, we will keep running.
+         */
+        s->vm_was_running = true;
+        /* Fallthrough */
+    case MIGRATION_STATUS_FAILED:
+    case MIGRATION_STATUS_CANCELLED:
         if (s->vm_was_running) {
             vm_start();
         } else {
@@ -2329,6 +2333,12 @@ static void *migration_thread(void *opaque)
                 runstate_set(RUN_STATE_POSTMIGRATE);
             }
         }
+        break;
+
+    default:
+        /* Should not reach here, but if so, forgive the VM. */
+        error_report("%s: Unknown ending state %d", __func__, s->state);
+        break;
     }
     qemu_bh_schedule(s->cleanup_bh);
     qemu_mutex_unlock_iothread();
-- 
2.14.3
