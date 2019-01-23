Received: from eggs.gnu.org ([209.51.188.92]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvP-0006xN-PV
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvO-0005UI-UB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvO-0005Tw-KT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:46 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:24 +0000
Message-Id: <20190123155830.8459-4-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] migration: multifd_save_cleanup() can't
 fail, simplify
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

multifd_save_cleanup() takes an Error ** argument and returns an
error code even though it can't actually fail.  Its callers
dutifully check for failure.  Remove the useless argument and return
value, and simplify the callers.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190113140849.38339-4-lifei1214@126.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c |  5 +----
 migration/ram.c       | 11 ++++-------
 migration/ram.h       |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 24cb4b9d0d..5d322eb9d6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1386,7 +1386,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
=20
     if (s->to_dst_file) {
-        Error *local_err =3D NULL;
         QEMUFile *tmp;
=20
         trace_migrate_fd_cleanup();
@@ -1397,9 +1396,7 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
=20
-        if (multifd_save_cleanup(&local_err) !=3D 0) {
-            error_report_err(local_err);
-        }
+        multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp =3D s->to_dst_file;
         s->to_dst_file =3D NULL;
diff --git a/migration/ram.c b/migration/ram.c
index 47c7ab2229..43c2b442af 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -917,13 +917,12 @@ static void multifd_send_terminate_threads(Error *e=
rr)
     }
 }
=20
-int multifd_save_cleanup(Error **errp)
+void multifd_save_cleanup(void)
 {
     int i;
-    int ret =3D 0;
=20
     if (!migrate_use_multifd()) {
-        return 0;
+        return;
     }
     multifd_send_terminate_threads(NULL);
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
@@ -953,7 +952,6 @@ int multifd_save_cleanup(Error **errp)
     multifd_send_state->pages =3D NULL;
     g_free(multifd_send_state);
     multifd_send_state =3D NULL;
-    return ret;
 }
=20
 static void multifd_send_sync_main(void)
@@ -1071,9 +1069,8 @@ static void multifd_new_send_channel_async(QIOTask =
*task, gpointer opaque)
     Error *local_err =3D NULL;
=20
     if (qio_task_propagate_error(task, &local_err)) {
-        if (multifd_save_cleanup(&local_err) !=3D 0) {
-            migrate_set_error(migrate_get_current(), local_err);
-        }
+        migrate_set_error(migrate_get_current(), local_err);
+        multifd_save_cleanup();
     } else {
         p->c =3D QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
diff --git a/migration/ram.h b/migration/ram.h
index 046d3074be..936177b3e9 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
=20
 int multifd_save_setup(void);
-int multifd_save_cleanup(Error **errp);
+void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
--=20
2.20.1
