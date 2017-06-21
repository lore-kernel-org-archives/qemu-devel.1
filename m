Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckN-0002Sq-3u
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckK-000545-RN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNckK-00052x-Ji
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFF5333459A
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 10:20:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 21 Jun 2017 12:20:05 +0200
Message-Id: <20170621102005.18701-6-quintela@redhat.com>
In-Reply-To: <20170621102005.18701-1-quintela@redhat.com>
References: <20170621102005.18701-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/5] migration: Make compression_threads use
 save/load_setup/cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

Once there, be consistent and use
compress_thread_{save,load}_{setup,cleanup}.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c |  5 -----
 migration/ram.c       | 12 ++++++++----
 migration/ram.h       |  5 -----
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index aaaf7ff..f6b7404 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -284,7 +284,6 @@ static void process_incoming_migration_bh(void *opaque)
     } else {
         runstate_set(global_state_get_runstate());
     }
-    migrate_decompress_threads_join();
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -347,7 +346,6 @@ static void process_incoming_migration_co(void *opaque)
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
-        migrate_decompress_threads_join();
         exit(EXIT_FAILURE);
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
@@ -358,7 +356,6 @@ void migration_fd_process_incoming(QEMUFile *f)
 {
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
 
-    migrate_decompress_threads_create();
     qemu_file_set_blocking(f, false);
     qemu_coroutine_enter(co);
 }
@@ -825,7 +822,6 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
 
-        migrate_compress_threads_join();
         qemu_fclose(s->to_dst_file);
         s->to_dst_file = NULL;
     }
@@ -1978,7 +1974,6 @@ void migrate_fd_connect(MigrationState *s)
         }
     }
 
-    migrate_compress_threads_create();
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index a619e0b..26393df 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -306,7 +306,7 @@ static inline void terminate_compression_threads(void)
     }
 }
 
-void migrate_compress_threads_join(void)
+static void compress_threads_save_cleanup(void)
 {
     int i, thread_count;
 
@@ -329,7 +329,7 @@ void migrate_compress_threads_join(void)
     comp_param = NULL;
 }
 
-void migrate_compress_threads_create(void)
+static void compress_threads_save_setup(void)
 {
     int i, thread_count;
 
@@ -1390,6 +1390,7 @@ static void ram_save_cleanup(void *opaque)
     }
     XBZRLE_cache_unlock();
     migration_page_queue_free(*rsp);
+    compress_threads_save_cleanup();
     g_free(*rsp);
     *rsp = NULL;
 }
@@ -1923,6 +1924,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     rcu_read_unlock();
+    compress_threads_save_setup();
 
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
@@ -2231,7 +2233,7 @@ static void wait_for_decompress_done(void)
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
-void migrate_decompress_threads_create(void)
+static void compress_threads_load_setup(void)
 {
     int i, thread_count;
 
@@ -2255,7 +2257,7 @@ void migrate_decompress_threads_create(void)
     }
 }
 
-void migrate_decompress_threads_join(void)
+static void compress_threads_load_cleanup(void)
 {
     int i, thread_count;
 
@@ -2321,12 +2323,14 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
 static int ram_load_setup(QEMUFile *f, void *opaque)
 {
     xbzrle_load_setup();
+    compress_threads_load_setup();
     return 0;
 }
 
 static int ram_load_cleanup(void *opaque)
 {
     xbzrle_load_cleanup();
+    compress_threads_load_cleanup();
     return 0;
 }
 
diff --git a/migration/ram.h b/migration/ram.h
index a8b79a4..c081fde 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -39,11 +39,6 @@ int64_t xbzrle_cache_resize(int64_t new_size);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
 
-void migrate_compress_threads_create(void);
-void migrate_compress_threads_join(void);
-void migrate_decompress_threads_create(void);
-void migrate_decompress_threads_join(void);
-
 uint64_t ram_pagesize_summary(void);
 int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
-- 
2.9.4
