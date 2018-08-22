Received: from eggs.gnu.org ([2001:4830:134:3::10]:39048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpL-0006qu-9n
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpJ-0000Ar-Mv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpJ-0000AK-8z
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:29 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:45 +0200
Message-Id: <20180822120050.12694-16-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 15/20] migration: do not wait for free thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Instead of putting the main thread to sleep state to wait for
free compression thread, we can directly post it out as normal
page that reduces the latency and uses CPUs more efficiently

A parameter, compress-wait-thread, is introduced, it can be
enabled if the user really wants the old behavior

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 |  8 ++++++++
 migration/migration.c | 21 ++++++++++++++++++++
 migration/migration.h |  1 +
 migration/ram.c       | 45 +++++++++++++++++++++++++------------------
 qapi/migration.json   | 18 +++++++++++++++++
 5 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/hmp.c b/hmp.c
index c38e8b1f78..9147037951 100644
--- a/hmp.c
+++ b/hmp.c
@@ -327,6 +327,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS),
             params->compress_threads);
+        assert(params->has_compress_wait_thread);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD),
+            params->compress_wait_thread ? "on" : "off");
         assert(params->has_decompress_threads);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
@@ -1627,6 +1631,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_compress_threads = true;
         visit_type_int(v, param, &p->compress_threads, &err);
         break;
+    case MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD:
+        p->has_compress_wait_thread = true;
+        visit_type_bool(v, param, &p->compress_wait_thread, &err);
+        break;
     case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
         p->has_decompress_threads = true;
         visit_type_int(v, param, &p->decompress_threads, &err);
diff --git a/migration/migration.c b/migration/migration.c
index 4d76bee0da..4b316ec343 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -673,6 +673,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
     params->compress_threads = s->parameters.compress_threads;
+    params->has_compress_wait_thread = true;
+    params->compress_wait_thread = s->parameters.compress_wait_thread;
     params->has_decompress_threads = true;
     params->decompress_threads = s->parameters.decompress_threads;
     params->has_cpu_throttle_initial = true;
@@ -1074,6 +1076,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->compress_threads = params->compress_threads;
     }
 
+    if (params->has_compress_wait_thread) {
+        dest->compress_wait_thread = params->compress_wait_thread;
+    }
+
     if (params->has_decompress_threads) {
         dest->decompress_threads = params->decompress_threads;
     }
@@ -1142,6 +1148,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.compress_threads = params->compress_threads;
     }
 
+    if (params->has_compress_wait_thread) {
+        s->parameters.compress_wait_thread = params->compress_wait_thread;
+    }
+
     if (params->has_decompress_threads) {
         s->parameters.decompress_threads = params->decompress_threads;
     }
@@ -1890,6 +1900,15 @@ int migrate_compress_threads(void)
     return s->parameters.compress_threads;
 }
 
+int migrate_compress_wait_thread(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->parameters.compress_wait_thread;
+}
+
 int migrate_decompress_threads(void)
 {
     MigrationState *s;
@@ -3151,6 +3170,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
                       parameters.compress_threads,
                       DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
+    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
+                      parameters.compress_wait_thread, true),
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
diff --git a/migration/migration.h b/migration/migration.h
index eb0c04a7b4..f7813f8261 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -272,6 +272,7 @@ bool migrate_use_return_path(void);
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
+int migrate_compress_wait_thread(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
diff --git a/migration/ram.c b/migration/ram.c
index 2f9e8bd7e0..498834bdbe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1896,30 +1896,34 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                                            ram_addr_t offset)
 {
     int idx, thread_count, bytes_xmit = -1, pages = -1;
+    bool wait = migrate_compress_wait_thread();
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
-    while (true) {
-        for (idx = 0; idx < thread_count; idx++) {
-            if (comp_param[idx].done) {
-                comp_param[idx].done = false;
-                bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
-                qemu_mutex_lock(&comp_param[idx].mutex);
-                set_compress_params(&comp_param[idx], block, offset);
-                qemu_cond_signal(&comp_param[idx].cond);
-                qemu_mutex_unlock(&comp_param[idx].mutex);
-                pages = 1;
-                ram_counters.normal++;
-                ram_counters.transferred += bytes_xmit;
-                break;
-            }
-        }
-        if (pages > 0) {
+retry:
+    for (idx = 0; idx < thread_count; idx++) {
+        if (comp_param[idx].done) {
+            comp_param[idx].done = false;
+            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
+            qemu_mutex_lock(&comp_param[idx].mutex);
+            set_compress_params(&comp_param[idx], block, offset);
+            qemu_cond_signal(&comp_param[idx].cond);
+            qemu_mutex_unlock(&comp_param[idx].mutex);
+            pages = 1;
+            ram_counters.normal++;
+            ram_counters.transferred += bytes_xmit;
             break;
-        } else {
-            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
         }
     }
+
+    /*
+     * wait for the free thread if the user specifies 'compress-wait-thread',
+     * otherwise we will post the page out in the main thread as normal page.
+     */
+    if (pages < 0 && wait) {
+        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
+        goto retry;
+    }
     qemu_mutex_unlock(&comp_done_lock);
 
     return pages;
@@ -2233,7 +2237,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
      * CPU resource.
      */
     if (block == rs->last_sent_block && save_page_use_compression(rs)) {
-        return compress_page_with_multi_thread(rs, block, offset);
+        res = compress_page_with_multi_thread(rs, block, offset);
+        if (res > 0) {
+            return res;
+        }
     } else if (migrate_use_multifd()) {
         return ram_save_multifd_page(rs, block, offset);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index cabe234c36..f62d3f9a4b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -461,6 +461,11 @@
 # @compress-threads: Set compression thread count to be used in live migration,
 #          the compression thread count is an integer between 1 and 255.
 #
+# @compress-wait-thread: Controls behavior when all compression threads are
+#                        currently busy. If true (default), wait for a free
+#                        compression thread to become available; otherwise,
+#                        send the page uncompressed. (Since 3.1)
+#
 # @decompress-threads: Set decompression thread count to be used in live
 #          migration, the decompression thread count is an integer between 1
 #          and 255. Usually, decompression is at least 4 times as fast as
@@ -529,6 +534,7 @@
 ##
 { 'enum': 'MigrationParameter',
   'data': ['compress-level', 'compress-threads', 'decompress-threads',
+           'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
@@ -543,6 +549,11 @@
 #
 # @compress-threads: compression thread count
 #
+# @compress-wait-thread: Controls behavior when all compression threads are
+#                        currently busy. If true (default), wait for a free
+#                        compression thread to become available; otherwise,
+#                        send the page uncompressed. (Since 3.1)
+#
 # @decompress-threads: decompression thread count
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
@@ -617,6 +628,7 @@
 { 'struct': 'MigrateSetParameters',
   'data': { '*compress-level': 'int',
             '*compress-threads': 'int',
+            '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
@@ -657,6 +669,11 @@
 #
 # @compress-threads: compression thread count
 #
+# @compress-wait-thread: Controls behavior when all compression threads are
+#                        currently busy. If true (default), wait for a free
+#                        compression thread to become available; otherwise,
+#                        send the page uncompressed. (Since 3.1)
+#
 # @decompress-threads: decompression thread count
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
@@ -727,6 +744,7 @@
 { 'struct': 'MigrationParameters',
   'data': { '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
+            '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
-- 
2.17.1
