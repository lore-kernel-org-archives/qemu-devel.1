Received: from eggs.gnu.org ([208.118.235.92]:33177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKu-0001Ns-8b
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKr-0003o6-N1
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:32 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:60622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKr-0003lH-DH
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:29 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:38 +0800
Message-Id: <20181225140449.15786-6-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 05/16] migration: unify error
 handling for process_incoming_migration_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

In the current code, if process_incoming_migration_co() fails we do
the same error handing: set the error state, close the source file,
do the cleanup for multifd, and then exit(EXIT_FAILURE). To make the
code clearer, add a "goto fail" to unify the error handling.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
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
2.13.7
