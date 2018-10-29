Received: from eggs.gnu.org ([2001:4830:134:3::10]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1gH4P1-0005It-Sm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1gH4Ox-0003nW-Sd
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:04:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liliang.opensource@gmail.com>)
	id 1gH4Ow-0003ml-To
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:04:03 -0400
Received: by mail-pf1-x444.google.com with SMTP id j23-v6so3761118pfi.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 03:04:02 -0700 (PDT)
From: Liang Li <liliang.opensource@gmail.com>
Date: Mon, 29 Oct 2018 18:03:55 +0800
Message-ID: <20181029100352.GA15627@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] migration: fix concurrent call of
 multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Liang Li <liliangleo@didiglobal.com>

Concurrent call of multifd_save_cleanup() is unsafe, it will lead to
null pointer dereference. 'multifd_save_cleanup()' should not be called
in multifd_new_send_channel_async(), move it to ram_save_cleanup() like
other features do.

Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 migration/migration.c | 5 -----
 migration/ram.c       | 7 +++----
 migration/ram.h       | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8b36e7f..f422218 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1372,7 +1372,6 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_savevm_state_cleanup();
 
     if (s->to_dst_file) {
-        Error *local_err = NULL;
         QEMUFile *tmp;
 
         trace_migrate_fd_cleanup();
@@ -1382,10 +1381,6 @@ static void migrate_fd_cleanup(void *opaque)
             s->migration_thread_running = false;
         }
         qemu_mutex_lock_iothread();
-
-        if (multifd_save_cleanup(&local_err) != 0) {
-            error_report_err(local_err);
-        }
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp = s->to_dst_file;
         s->to_dst_file = NULL;
diff --git a/migration/ram.c b/migration/ram.c
index 7e7deec..a232b9c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -917,7 +917,7 @@ static void multifd_send_terminate_threads(Error *err)
     }
 }
 
-int multifd_save_cleanup(Error **errp)
+int multifd_save_cleanup(void)
 {
     int i;
     int ret = 0;
@@ -1071,9 +1071,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     Error *local_err = NULL;
 
     if (qio_task_propagate_error(task, &local_err)) {
-        if (multifd_save_cleanup(&local_err) != 0) {
-            migrate_set_error(migrate_get_current(), local_err);
-        }
+        migrate_set_error(migrate_get_current(), local_err);
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
@@ -2542,6 +2540,7 @@ static void ram_save_cleanup(void *opaque)
 
     xbzrle_cleanup();
     compress_threads_save_cleanup();
+    multifd_save_cleanup();
     ram_state_cleanup(rsp);
 }
 
diff --git a/migration/ram.h b/migration/ram.h
index 83ff1bc..c4fafea 100644
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
1.8.3.1
