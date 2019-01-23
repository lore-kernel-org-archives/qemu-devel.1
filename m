Received: from eggs.gnu.org ([209.51.188.92]:40968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvT-000745-9O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvS-0005WX-Ei
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvS-0005WB-99
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:50 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:26 +0000
Message-Id: <20190123155830.8459-6-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] migration: unify error handling for
 process_incoming_migration_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Fei Li <fli@suse.com>

In the current code, if process_incoming_migration_co() fails we do
the same error handing: set the error state, close the source file,
do the cleanup for multifd, and then exit(EXIT_FAILURE). To make the
code clearer, add a "goto fail" to unify the error handling.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190113140849.38339-6-lifei1214@126.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5d322eb9d6..ded151b1bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -438,15 +438,13 @@ static void process_incoming_migration_co(void *opa=
que)
         /* Make sure all file formats flush their mutable metadata */
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
-            migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                    MIGRATION_STATUS_FAILED);
             error_report_err(local_err);
-            exit(EXIT_FAILURE);
+            goto fail;
         }
=20
         if (colo_init_ram_cache() < 0) {
             error_report("Init ram cache failed");
-            exit(EXIT_FAILURE);
+            goto fail;
         }
=20
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
@@ -461,20 +459,22 @@ static void process_incoming_migration_co(void *opa=
que)
     }
=20
     if (ret < 0) {
-        Error *local_err =3D NULL;
-
-        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
-        qemu_fclose(mis->from_src_file);
-        if (multifd_load_cleanup(&local_err) !=3D 0) {
-            error_report_err(local_err);
-        }
-        exit(EXIT_FAILURE);
+        goto fail;
     }
     mis->bh =3D qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
     mis->migration_incoming_co =3D NULL;
+    return;
+fail:
+    local_err =3D NULL;
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
+    qemu_fclose(mis->from_src_file);
+    if (multifd_load_cleanup(&local_err) !=3D 0) {
+        error_report_err(local_err);
+    }
+    exit(EXIT_FAILURE);
 }
=20
 static void migration_incoming_setup(QEMUFile *f)
--=20
2.20.1
