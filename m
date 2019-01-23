Received: from eggs.gnu.org ([209.51.188.92]:40916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvO-0006vh-IM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvN-0005TR-6g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvM-0005SU-Ru
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:45 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:23 +0000
Message-Id: <20190123155830.8459-3-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] migration: fix the multifd code when
 receiving less channels
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

In our current code, when multifd is used during migration, if there
is an error before the destination receives all new channels, the
source keeps running, however the destination does not exit but keeps
waiting until the source is killed deliberately.

Fix this by dumping the specific error and let users decide whether
to quit from the destination side when failing to receive packet via
some channel. And update the comment for multifd_recv_new_channel().

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190113140849.38339-3-lifei1214@126.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c   | 11 ++++++-----
 migration/migration.c |  9 +++++++--
 migration/migration.h |  2 +-
 migration/ram.c       | 17 ++++++++++++++---
 migration/ram.h       |  2 +-
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 33e0e9b82f..20e4c8e2dc 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -30,6 +30,7 @@
 void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationState *s =3D migrate_get_current();
+    Error *local_err =3D NULL;
=20
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
@@ -38,13 +39,13 @@ void migration_channel_process_incoming(QIOChannel *i=
oc)
         *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
                              TYPE_QIO_CHANNEL_TLS)) {
-        Error *local_err =3D NULL;
         migration_tls_channel_process_incoming(s, ioc, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
     } else {
-        migration_ioc_process_incoming(ioc);
+        migration_ioc_process_incoming(ioc, &local_err);
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
     }
 }
=20
diff --git a/migration/migration.c b/migration/migration.c
index ffc4d9e556..24cb4b9d0d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
=20
-void migration_ioc_process_incoming(QIOChannel *ioc)
+void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     bool start_migration;
@@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
          */
         start_migration =3D !migrate_use_multifd();
     } else {
+        Error *local_err =3D NULL;
         /* Multiple connections */
         assert(migrate_use_multifd());
-        start_migration =3D multifd_recv_new_channel(ioc);
+        start_migration =3D multifd_recv_new_channel(ioc, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
=20
     if (start_migration) {
diff --git a/migration/migration.h b/migration/migration.h
index e413d4d8b6..02b7304610 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -229,7 +229,7 @@ struct MigrationState
 void migrate_set_state(int *state, int old_state, int new_state);
=20
 void migration_fd_process_incoming(QEMUFile *f);
-void migration_ioc_process_incoming(QIOChannel *ioc);
+void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
=20
 bool  migration_has_all_channels(void);
diff --git a/migration/ram.c b/migration/ram.c
index 1849979fed..47c7ab2229 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1322,8 +1322,13 @@ bool multifd_recv_all_channels_created(void)
     return thread_count =3D=3D atomic_read(&multifd_recv_state->count);
 }
=20
-/* Return true if multifd is ready for the migration, otherwise false */
-bool multifd_recv_new_channel(QIOChannel *ioc)
+/*
+ * Try to receive all multifd channels to get ready for the migration.
+ * - Return true and do not set @errp when correctly receving all channe=
ls;
+ * - Return false and do not set @errp when correctly receiving the curr=
ent one;
+ * - Return false and set @errp when failing to receive the current chan=
nel.
+ */
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err =3D NULL;
@@ -1332,6 +1337,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
     id =3D multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
         multifd_recv_terminate_threads(local_err);
+        error_propagate_prepend(errp, local_err,
+                                "failed to receive packet"
+                                " via multifd channel %d: ",
+                                atomic_read(&multifd_recv_state->count))=
;
         return false;
     }
=20
@@ -1340,6 +1349,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'=
",
                    id);
         multifd_recv_terminate_threads(local_err);
+        error_propagate(errp, local_err);
         return false;
     }
     p->c =3D ioc;
@@ -1351,7 +1361,8 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    return multifd_recv_state->count =3D=3D migrate_multifd_channels();
+    return atomic_read(&multifd_recv_state->count) =3D=3D
+           migrate_multifd_channels();
 }
=20
 /**
diff --git a/migration/ram.h b/migration/ram.h
index 83ff1bc11a..046d3074be 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -47,7 +47,7 @@ int multifd_save_cleanup(Error **errp);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-bool multifd_recv_new_channel(QIOChannel *ioc);
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
=20
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_=
t len);
--=20
2.20.1
