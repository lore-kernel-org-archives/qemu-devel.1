Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH78J-0000HI-64
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gH78I-0002fb-6S
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:59:03 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:49561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gH78H-0002eM-Ss
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:59:02 -0400
From: Fei Li <fli@suse.com>
Date: Mon, 29 Oct 2018 20:58:16 +0800
Message-Id: <20181029125818.28720-6-fli@suse.com>
In-Reply-To: <20181029125818.28720-1-fli@suse.com>
References: <20181029125818.28720-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v6 5/7] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com, quintela@redhat.com

In our current code, when multifd is used during migration, if there
is an error before the destination receives all new channels, the
source keeps running, however the destination does not exit but keeps
waiting until the source is killed deliberately.

Fix this by simply killing the destination when it fails to receive
packet via some channel.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 migration/channel.c   |  7 ++++++-
 migration/migration.c |  9 +++++++--
 migration/migration.h |  2 +-
 migration/ram.c       | 17 ++++++++++++++---
 migration/ram.h       |  2 +-
 5 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 33e0e9b82f..572be4245a 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -44,7 +44,12 @@ void migration_channel_process_incoming(QIOChannel *ioc)
             error_report_err(local_err);
         }
     } else {
-        migration_ioc_process_incoming(ioc);
+        Error *local_err = NULL;
+        migration_ioc_process_incoming(ioc, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            exit(EXIT_FAILURE);
+        }
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 8b36e7f184..87dfc7374f 100644
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
index f7813f8261..7df4d426d0 100644
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
index 4db3b3e8f4..8f03afe228 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1072,6 +1072,7 @@ out:
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
+    MigrationState *s = migrate_get_current();
     QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
 
@@ -1080,6 +1081,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     if (qio_task_propagate_error(task, &local_err)) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
         if (multifd_save_cleanup(&local_err) != 0) {
             migrate_set_error(migrate_get_current(), local_err);
         }
@@ -1337,16 +1339,20 @@ bool multifd_recv_all_channels_created(void)
 }
 
 /* Return true if multifd is ready for the migration, otherwise false */
-bool multifd_recv_new_channel(QIOChannel *ioc)
+bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
+    MigrationIncomingState *mis = migration_incoming_get_current();
     MultiFDRecvParams *p;
     Error *local_err = NULL;
     int id;
 
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
+        error_propagate_prepend(errp, local_err,
+                        "failed to receive packet via multifd channel %x: ",
+                        multifd_recv_state->count);
         multifd_recv_terminate_threads(local_err, false);
-        return false;
+        goto fail;
     }
 
     p = &multifd_recv_state->params[id];
@@ -1354,7 +1360,8 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
         multifd_recv_terminate_threads(local_err, true);
-        return false;
+        error_propagate(errp, local_err);
+        goto fail;
     }
     p->c = ioc;
     object_ref(OBJECT(ioc));
@@ -1366,6 +1373,10 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
     return multifd_recv_state->count == migrate_multifd_channels();
+fail:
+    qemu_fclose(mis->from_src_file);
+    mis->from_src_file = NULL;
+    return false;
 }
 
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
 
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
-- 
2.13.7
