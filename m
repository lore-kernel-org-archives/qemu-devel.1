Received: from eggs.gnu.org ([209.51.188.92]:39984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-0002ty-AI
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-0002zP-By
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
Received: from m50-110.126.com ([123.125.50.110]:42741)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRh-0002vP-9U
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:02 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:08:47 +0800
Message-Id: <20190113140849.38339-4-lifei1214@126.com>
In-Reply-To: <20190113140849.38339-1-lifei1214@126.com>
References: <20190113140849.38339-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 3/5] migration: multifd_save_cleanup()
 can't fail, simplify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Fei Li <fli@suse.com>

multifd_save_cleanup() takes an Error ** argument and returns an
error code even though it can't actually fail.  Its callers
dutifully check for failure.  Remove the useless argument and return
value, and simplify the callers.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
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
index 47c7ab2229..43c2b442af 100644
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
2.17.2 (Apple Git-113)
