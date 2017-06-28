Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ9eR-0004vP-9A
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ9eO-0005xD-GJ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ9eO-0005wv-7k
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32BAA80F6C
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 09:52:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 11:52:28 +0200
Message-Id: <20170628095228.4661-6-quintela@redhat.com>
In-Reply-To: <20170628095228.4661-1-quintela@redhat.com>
References: <20170628095228.4661-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/5] migration: Make compression_threads use
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com

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
index e244876..9623dc1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -291,7 +291,6 @@ static void process_incoming_migration_bh(void *opaque)
     } else {
         runstate_set(global_state_get_runstate());
     }
-    migrate_decompress_threads_join();
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -354,7 +353,6 @@ static void process_incoming_migration_co(void *opaque)
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
-        migrate_decompress_threads_join();
         exit(EXIT_FAILURE);
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
@@ -365,7 +363,6 @@ void migration_fd_process_incoming(QEMUFile *f)
 {
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
 
-    migrate_decompress_threads_create();
     qemu_file_set_blocking(f, false);
     qemu_coroutine_enter(co);
 }
@@ -832,7 +829,6 @@ static void migrate_fd_cleanup(void *opaque)
         }
         qemu_mutex_lock_iothread();
 
-        migrate_compress_threads_join();
         qemu_fclose(s->to_dst_file);
         s->to_dst_file = NULL;
     }
@@ -1995,7 +1991,6 @@ void migrate_fd_connect(MigrationState *s)
         }
     }
 
-    migrate_compress_threads_create();
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
diff --git a/migration/ram.c b/migration/ram.c
index 73aec34..1b08296 100644
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
