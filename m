Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gADJ6-0001AF-Ox
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gADJ5-0000lS-UV
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gADJ5-0000kf-L7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 08:09:39 -0400
From: Fei Li <fli@suse.com>
Date: Wed, 10 Oct 2018 20:08:40 +0800
Message-Id: <20181010120841.13214-7-fli@suse.com>
In-Reply-To: <20181010120841.13214-1-fli@suse.com>
References: <20181010120841.13214-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v5 6/7] migration: fix some error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peterx@redhat.com, armbru@redhat.com, berrange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com

Add error handling for qemu_ram_foreach_migratable_block() when
it fails.

Always call migrate_set_error() to set the error state without relying
on whether multifd_save_cleanup() succeeds. As the passed &local_err
is never used in multifd_save_cleanup(), remove it.

Signed-off-by: Fei Li <fli@suse.com>
---
 migration/migration.c    | 5 +----
 migration/postcopy-ram.c | 3 +++
 migration/ram.c          | 7 +++----
 migration/ram.h          | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d6ae879dc8..c344bab8f1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1341,7 +1341,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        Error *local_err = NULL;
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
@@ -1352,9 +1351,7 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
 
-        if (multifd_save_cleanup(&local_err) != 0) {
-            error_report_err(local_err);
-        }
+        multifd_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 853d8b32ca..f96e0ae1f8 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1116,6 +1116,9 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 
     /* Mark so that we get notified of accesses to unwritten areas */
     if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
+        error_report("ram_block_enable_notify failed");
+        close(mis->userfault_event_fd);
+        close(mis->userfault_fd);
         return -1;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 41dc94c059..25ec8f1b54 100644
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
@@ -1076,9 +1076,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     Error *local_err = NULL;
 
     if (qio_task_propagate_error(task, &local_err)) {
-        if (multifd_save_cleanup(&local_err) != 0) {
-            migrate_set_error(migrate_get_current(), local_err);
-        }
+        multifd_save_cleanup();
+        migrate_set_error(migrate_get_current(), local_err);
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
diff --git a/migration/ram.h b/migration/ram.h
index a139066846..0b0e4d8717 100644
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
