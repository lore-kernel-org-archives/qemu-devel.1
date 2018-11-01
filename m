Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIA3A-0007R6-OW
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIA39-00080H-2i
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:18:04 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gIA38-0007zt-PO
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:18:03 -0400
From: Fei Li <fli@suse.com>
Date: Thu,  1 Nov 2018 18:17:13 +0800
Message-Id: <20181101101715.9443-8-fli@suse.com>
In-Reply-To: <20181101101715.9443-1-fli@suse.com>
References: <20181101101715.9443-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v7 7/9] migration: remove unused &local_err
 parameter in migrate_set_error
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

Always call migrate_set_error() to set the error state without relying
on whether multifd_save_cleanup() succeeds. As the passed &local_err
is never used in multifd_save_cleanup(), remove it.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 migration/migration.c | 5 +----
 migration/ram.c       | 7 +++----
 migration/ram.h       | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 87dfc7374f..3b8b7ab4f9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1377,7 +1377,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        Error *local_err = NULL;
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
@@ -1388,9 +1387,7 @@ static void migrate_fd_cleanup(void *opaque)
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
index 5008a9ab02..cea255d9b9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -922,7 +922,7 @@ static void multifd_send_terminate_threads(Error *err)
     }
 }
 
-int multifd_save_cleanup(Error **errp)
+int multifd_save_cleanup(void)
 {
     int i;
     int ret = 0;
@@ -1081,10 +1081,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     if (qio_task_propagate_error(task, &local_err)) {
-        if (multifd_save_cleanup(&local_err) != 0) {
-            migrate_set_error(migrate_get_current(), local_err);
-        }
+        migrate_set_error(migrate_get_current(), local_err);
         migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        multifd_save_cleanup();
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
diff --git a/migration/ram.h b/migration/ram.h
index 046d3074be..0d1215209e 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
 int multifd_save_setup(void);
-int multifd_save_cleanup(Error **errp);
+int multifd_save_cleanup(void);
 int multifd_load_setup(void);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
-- 
2.13.7
