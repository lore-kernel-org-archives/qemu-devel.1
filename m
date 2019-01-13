Received: from eggs.gnu.org ([209.51.188.92]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRk-0002uJ-Mc
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-00031A-Vl
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:04 -0500
Received: from m50-110.126.com ([123.125.50.110]:42736)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-0002vN-D5
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:08:49 +0800
Message-Id: <20190113140849.38339-6-lifei1214@126.com>
In-Reply-To: <20190113140849.38339-1-lifei1214@126.com>
References: <20190113140849.38339-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 5/5] migration: unify error handling
 for process_incoming_migration_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Fei Li <fli@suse.com>

In the current code, if process_incoming_migration_co() fails we do
the same error handing: set the error state, close the source file,
do the cleanup for multifd, and then exit(EXIT_FAILURE). To make the
code clearer, add a "goto fail" to unify the error handling.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5d322eb9d6..ded151b1bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -438,15 +438,13 @@ static void process_incoming_migration_co(void *opaque)
         /* Make sure all file formats flush their mutable metadata */
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
-            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                    MIGRATION_STATUS_FAILED);
             error_report_err(local_err);
-            exit(EXIT_FAILURE);
+            goto fail;
         }
 
         if (colo_init_ram_cache() < 0) {
             error_report("Init ram cache failed");
-            exit(EXIT_FAILURE);
+            goto fail;
         }
 
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
@@ -461,20 +459,22 @@ static void process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        Error *local_err = NULL;
-
-        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
-        qemu_fclose(mis->from_src_file);
-        if (multifd_load_cleanup(&local_err) != 0) {
-            error_report_err(local_err);
-        }
-        exit(EXIT_FAILURE);
+        goto fail;
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
     mis->migration_incoming_co = NULL;
+    return;
+fail:
+    local_err = NULL;
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
+    qemu_fclose(mis->from_src_file);
+    if (multifd_load_cleanup(&local_err) != 0) {
+        error_report_err(local_err);
+    }
+    exit(EXIT_FAILURE);
 }
 
 static void migration_incoming_setup(QEMUFile *f)
-- 
2.17.2 (Apple Git-113)
