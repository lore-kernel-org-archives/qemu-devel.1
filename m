Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehc-0008Kv-Vw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehZ-000802-BU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:44 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gWehV-0007wF-45
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:37 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 11 Dec 2018 17:50:54 +0800
Message-Id: <20181211095057.14623-5-fli@suse.com>
In-Reply-To: <20181211095057.14623-1-fli@suse.com>
References: <20181211095057.14623-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v8 4/7] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Always call migrate_set_error() to set the error state without relying
on whether multifd_save_cleanup() succeeds.  As the passed &local_err
is never used in multifd_save_cleanup(), remove it. And make the
function be: void multifd_save_cleanup(void).

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c |  5 +----
 migration/ram.c       | 11 ++++-------
 migration/ram.h       |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 72106bddf0..0537fc0c26 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1386,7 +1386,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        Error *local_err = NULL;
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
@@ -1397,9 +1396,7 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
 
-        if (multifd_save_cleanup(&local_err) != 0) {
-            error_report_err(local_err);
-        }
+        multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
diff --git a/migration/ram.c b/migration/ram.c
index c7e3d6b0fd..658dfa88a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -917,13 +917,12 @@ static void multifd_send_terminate_threads(Error *err)
     }
 }
 
-int multifd_save_cleanup(Error **errp)
+void multifd_save_cleanup(void)
 {
     int i;
-    int ret = 0;
 
     if (!migrate_use_multifd()) {
-        return 0;
+        return;
     }
     multifd_send_terminate_threads(NULL);
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -953,7 +952,6 @@ int multifd_save_cleanup(Error **errp)
     multifd_send_state->pages = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
-    return ret;
 }
 
 static void multifd_send_sync_main(void)
@@ -1071,9 +1069,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     Error *local_err = NULL;
 
     if (qio_task_propagate_error(task, &local_err)) {
-        if (multifd_save_cleanup(&local_err) != 0) {
-            migrate_set_error(migrate_get_current(), local_err);
-        }
+        migrate_set_error(migrate_get_current(), local_err);
+        multifd_save_cleanup();
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
diff --git a/migration/ram.h b/migration/ram.h
index 046d3074be..936177b3e9 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
 int multifd_save_setup(void);
-int multifd_save_cleanup(Error **errp);
+void multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-- 
2.13.7
