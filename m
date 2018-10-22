Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5c-00013L-He
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5Y-000166-FC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:37152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gEY5W-0000yi-Mf
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:36 -0400
From: Fei Li <fli@suse.com>
Date: Mon, 22 Oct 2018 19:08:54 +0800
Message-Id: <20181022110854.10284-3-fli@suse.com>
In-Reply-To: <20181022110854.10284-1-fli@suse.com>
References: <20181022110854.10284-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC 2/2] migration: fix some error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com

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
index 7696729340..ca07c243be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1372,7 +1372,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        Error *local_err = NULL;
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
@@ -1383,9 +1382,7 @@ static void migrate_fd_cleanup(void *opaque)
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
index e5c02a32c5..4ca2bc02b3 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1117,6 +1117,9 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 
     /* Mark so that we get notified of accesses to unwritten areas */
     if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
+        error_report("ram_block_enable_notify failed");
+        close(mis->userfault_event_fd);
+        close(mis->userfault_fd);
         return -1;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 2dd873ba35..e7c8ccb38a 100644
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
@@ -1080,9 +1080,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
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
index 83ff1bc11a..c4fafea368 100644
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
