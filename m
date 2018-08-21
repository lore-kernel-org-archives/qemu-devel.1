Received: from eggs.gnu.org ([2001:4830:134:3::10]:47094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kg-0003sC-II
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kd-0004VT-6o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:38457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1kX-0004ON-VB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:54 -0400
Received: by mail-pg1-x52e.google.com with SMTP id k8-v6so4056491pgq.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:10:47 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:20 +0800
Message-Id: <20180821081029.26121-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180821081029.26121-1-xiaoguangrong@tencent.com>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 01/10] migration: do not wait for free thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Instead of putting the main thread to sleep state to wait for
free compression thread, we can directly post it out as normal
page that reduces the latency and uses CPUs more efficiently

A parameter, compress-wait-thread, is introduced, it can be
enabled if the user really wants the old behavior

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hmp.c                 |  8 ++++++++
 migration/migration.c | 21 +++++++++++++++++++++
 migration/migration.h |  1 +
 migration/ram.c       | 45 ++++++++++++++++++++++++++-------------------
 qapi/migration.json   | 27 ++++++++++++++++++++++-----
 5 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2aafb50e8e..47d36e3ccf 100644
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
@@ -1623,6 +1627,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
index b7d9854bda..2ccaadc03d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -671,6 +671,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
     params->compress_threads = s->parameters.compress_threads;
+    params->has_compress_wait_thread = true;
+    params->compress_wait_thread = s->parameters.compress_wait_thread;
     params->has_decompress_threads = true;
     params->decompress_threads = s->parameters.decompress_threads;
     params->has_cpu_throttle_initial = true;
@@ -1061,6 +1063,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->compress_threads = params->compress_threads;
     }
 
+    if (params->has_compress_wait_thread) {
+        dest->compress_wait_thread = params->compress_wait_thread;
+    }
+
     if (params->has_decompress_threads) {
         dest->decompress_threads = params->decompress_threads;
     }
@@ -1126,6 +1132,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.compress_threads = params->compress_threads;
     }
 
+    if (params->has_compress_wait_thread) {
+        s->parameters.compress_wait_thread = params->compress_wait_thread;
+    }
+
     if (params->has_decompress_threads) {
         s->parameters.decompress_threads = params->decompress_threads;
     }
@@ -1871,6 +1881,15 @@ int migrate_compress_threads(void)
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
@@ -3131,6 +3150,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
                       parameters.compress_threads,
                       DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
+    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
+                      parameters.compress_wait_thread, true),
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
diff --git a/migration/migration.h b/migration/migration.h
index 64a7b33735..a46b9e6c8d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -271,6 +271,7 @@ bool migrate_use_return_path(void);
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
+int migrate_compress_wait_thread(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
diff --git a/migration/ram.c b/migration/ram.c
index 24dea2730c..ae9e83c2b6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1889,30 +1889,34 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
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
@@ -2226,7 +2230,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
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
index 186e8a7303..940cb5cbd0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -462,6 +462,11 @@
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
@@ -526,11 +531,11 @@
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['compress-level', 'compress-threads', 'decompress-threads',
-           'cpu-throttle-initial', 'cpu-throttle-increment',
-           'tls-creds', 'tls-hostname', 'max-bandwidth',
-           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-channels', 'x-multifd-page-count',
+  'data': ['compress-level', 'compress-threads', 'compress-wait-thread',
+           'decompress-threads', 'cpu-throttle-initial',
+           'cpu-throttle-increment', 'tls-creds', 'tls-hostname',
+           'max-bandwidth', 'downtime-limit', 'x-checkpoint-delay',
+           'block-incremental', 'x-multifd-channels', 'x-multifd-page-count',
            'xbzrle-cache-size', 'max-postcopy-bandwidth' ] }
 
 ##
@@ -540,6 +545,11 @@
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
@@ -610,6 +620,7 @@
 { 'struct': 'MigrateSetParameters',
   'data': { '*compress-level': 'int',
             '*compress-threads': 'int',
+            '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
@@ -649,6 +660,11 @@
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
@@ -714,6 +730,7 @@
 { 'struct': 'MigrationParameters',
   'data': { '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
+            '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
-- 
2.14.4
