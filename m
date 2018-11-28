Received: from eggs.gnu.org ([2001:4830:134:3::10]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gRxHZ-00037y-EK
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gRxA6-0007i8-Ej
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:33:43 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:56549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gRxA6-0007gg-5N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:33:42 -0500
From: Fei Li <fli@suse.com>
Date: Wed, 28 Nov 2018 18:33:06 +0800
Message-Id: <20181128103308.26755-4-fli@suse.com>
In-Reply-To: <20181128103308.26755-1-fli@suse.com>
References: <20181128103308.26755-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC 3/5] migration: fix the multifd code when
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

In our current code, when multifd is used during migration, if there
is an error before the destination receives all new channels, the
source keeps running, however the destination does not exit but keeps
waiting until the source is killed deliberately.

Fix this by dumping the specific error and let users decide whether
to quit from the destination side when failing to receive packet via
some channel.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 migration/channel.c   | 11 ++++++-----
 migration/migration.c |  9 +++++++--
 migration/migration.h |  2 +-
 migration/ram.c       |  7 ++++++-
 migration/ram.h       |  2 +-
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 33e0e9b82f..20e4c8e2dc 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -30,6 +30,7 @@
 void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationState *s = migrate_get_current();
+    Error *local_err = NULL;
 
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
@@ -38,13 +39,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
         *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
                              TYPE_QIO_CHANNEL_TLS)) {
-        Error *local_err = NULL;
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
 
diff --git a/migration/migration.c b/migration/migration.c
index 49ffb9997a..72106bddf0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -541,7 +541,7 @@ void migration_fd_process_incoming(QEMUFile *f)
     migration_incoming_process();
 }
 
-void migration_ioc_process_incoming(QIOChannel *ioc)
+void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     bool start_migration;
@@ -563,9 +563,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc)
          */
         start_migration = !migrate_use_multifd();
     } else {
+        Error *local_err = NULL;
         /* Multiple connections */
         assert(migrate_use_multifd());
-        start_migration = multifd_recv_new_channel(ioc);
+        start_migration = multifd_recv_new_channel(ioc, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
     if (start_migration) {
diff --git a/migration/migration.h b/migration/migration.h
index e413d4d8b6..02b7304610 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -229,7 +229,7 @@ struct MigrationState
 void migrate_set_state(int *state, int old_state, int new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
-void migration_ioc_process_incoming(QIOChannel *ioc);
+void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
 
 bool  migration_has_all_channels(void);
diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec4d8..e13b9349d0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1323,7 +1323,7 @@ bool multifd_recv_all_channels_created(void)
 }
 
 /* Return true if multifd is ready for the migration, otherwise false */
-bool multifd_recv_new_channel(QIOChannel *ioc)
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
@@ -1331,6 +1331,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
 
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
+        error_propagate_prepend(errp, local_err,
+                                "failed to receive packet"
+                                " via multifd channel %d: ",
+                                multifd_recv_state->count);
         multifd_recv_terminate_threads(local_err);
         return false;
     }
@@ -1340,6 +1344,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
         multifd_recv_terminate_threads(local_err);
+        error_propagate(errp, local_err);
         return false;
     }
     p->c = ioc;
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
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-- 
2.13.7
