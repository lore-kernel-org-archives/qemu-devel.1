Received: from eggs.gnu.org ([209.51.188.92]:57850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqSD-0002gm-VV
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ghqSB-0007hL-Om
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:05 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ghqS9-0007fr-Ur
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:38:03 -0500
Received: by mail-pf1-x441.google.com with SMTP id c73so6480726pfe.13
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 22:38:01 -0800 (PST)
From: guangrong.xiao@gmail.com
Date: Fri, 11 Jan 2019 14:37:32 +0800
Message-Id: <20190111063732.10484-4-xiaoguangrong@tencent.com>
In-Reply-To: <20190111063732.10484-1-xiaoguangrong@tencent.com>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 3/3] migration: introduce adaptive model for
 waiting thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Currently we have two behaviors if all threads are busy to do compression,
the main thread mush wait one of them becoming free if @compress-wait-thread
set to on or the main thread can directly return without wait and post
the page out as normal one

Both of them have its profits and short-comes, however, if the bandwidth is
not limited extremely so that compression can not use out all of it bandwidth,
at the same time, the migration process is easily throttled if we posted too
may pages as normal pages. None of them can work properly under this case

In order to use the bandwidth more effectively, we introduce the third
behavior, adaptive, which make the main thread wait if there is no bandwidth
left or let the page go out as normal page if there has enough bandwidth to
make sure the migration process will not be throttled

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 hmp.c                 |   6 ++-
 migration/migration.c | 116 ++++++++++++++++++++++++++++++++++++++++++++------
 migration/migration.h |  13 ++++++
 migration/ram.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++-----
 qapi/migration.json   |  39 +++++++++++------
 5 files changed, 251 insertions(+), 39 deletions(-)

diff --git a/hmp.c b/hmp.c
index 944e3e072d..0705833e14 100644
--- a/hmp.c
+++ b/hmp.c
@@ -284,6 +284,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->compression->compressed_size);
         monitor_printf(mon, "compression rate: %0.2f\n",
                        info->compression->compression_rate);
+        monitor_printf(mon, "compress-no-wait-weight: %"PRIu64"\n",
+                       info->compression->compress_no_wait_weight);
     }
 
     if (info->has_cpu_throttle_percentage) {
@@ -345,7 +347,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         assert(params->has_compress_wait_thread);
         monitor_printf(mon, "%s: %s\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD),
-            params->compress_wait_thread ? "on" : "off");
+            params->compress_wait_thread);
         assert(params->has_decompress_threads);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
@@ -1679,7 +1681,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         break;
     case MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD:
         p->has_compress_wait_thread = true;
-        visit_type_bool(v, param, &p->compress_wait_thread, &err);
+        visit_type_str(v, param, &p->compress_wait_thread, &err);
         break;
     case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
         p->has_decompress_threads = true;
diff --git a/migration/migration.c b/migration/migration.c
index fb39d7bec1..0be0b02c8a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,6 +31,7 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
+#include "qapi/string-input-visitor.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
@@ -705,7 +706,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->has_compress_threads = true;
     params->compress_threads = s->parameters.compress_threads;
     params->has_compress_wait_thread = true;
-    params->compress_wait_thread = s->parameters.compress_wait_thread;
+    params->compress_wait_thread = g_strdup(s->parameters.compress_wait_thread);
     params->has_decompress_threads = true;
     params->decompress_threads = s->parameters.decompress_threads;
     params->has_cpu_throttle_initial = true;
@@ -800,6 +801,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
                                     compression_counters.compressed_size;
         info->compression->compression_rate =
                                     compression_counters.compression_rate;
+        info->compression->compress_no_wait_weight =
+                                compression_counters.compress_no_wait_weight;
     }
 
     if (cpu_throttle_active()) {
@@ -1016,6 +1019,68 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
     }
 }
 
+static int get_compress_wait_thread(const MigrationParameters *params)
+{
+    Visitor *v = string_input_visitor_new(params->compress_wait_thread);
+    Error *err = NULL;
+    int wait_thread = COMPRESS_WAIT_THREAD_ERR;
+    char *value;
+    bool wait;
+
+    visit_type_str(v, "compress-wait-thread", &value, &err);
+    if (err) {
+        goto exit;
+    }
+
+    if (!strcmp(value, "adaptive")) {
+        wait_thread = COMPRESS_WAIT_THREAD_ADAPTIVE;
+        goto free_value;
+    }
+
+    visit_type_bool(v, "compress-wait-thread", &wait, &err);
+    if (!err) {
+        wait_thread = wait;
+    }
+
+free_value:
+    g_free(value);
+exit:
+    visit_free(v);
+    error_free(err);
+    return wait_thread;
+}
+
+static bool
+check_compress_wait_thread(MigrationParameters *params, Error **errp)
+{
+    if (!params->has_compress_wait_thread) {
+        return true;
+    }
+
+    if (get_compress_wait_thread(params) == COMPRESS_WAIT_THREAD_ERR) {
+        error_setg(errp,
+         "Parameter 'compress-wait-thread' expects 'adaptive' or a bool value");
+        return false;
+    }
+
+    return true;
+}
+
+static void update_compress_wait_thread(MigrationState *s)
+{
+    s->compress_wait_thread = get_compress_wait_thread(&s->parameters);
+    assert(s->compress_wait_thread != COMPRESS_WAIT_THREAD_ERR);
+}
+
+int migrate_compress_wait_thread(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->compress_wait_thread;
+}
+
 /*
  * Check whether the parameters are valid. Error will be put into errp
  * (if provided). Return true if valid, otherwise false.
@@ -1036,6 +1101,10 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
+    if (!check_compress_wait_thread(params, errp)) {
+        return false;
+    }
+
     if (params->has_decompress_threads && (params->decompress_threads < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "decompress_threads",
@@ -1130,7 +1199,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->has_compress_wait_thread) {
-        dest->compress_wait_thread = params->compress_wait_thread;
+        dest->compress_wait_thread = g_strdup(params->compress_wait_thread);
     }
 
     if (params->has_decompress_threads) {
@@ -1177,6 +1246,14 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 }
 
+static void migrate_params_test_destroy(MigrateSetParameters *params,
+                                        MigrationParameters *dest)
+{
+    if (params->has_compress_wait_thread) {
+        g_free(dest->compress_wait_thread);
+    }
+}
+
 static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
 {
     MigrationState *s = migrate_get_current();
@@ -1192,7 +1269,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->has_compress_wait_thread) {
-        s->parameters.compress_wait_thread = params->compress_wait_thread;
+        g_free(s->parameters.compress_wait_thread);
+        s->parameters.compress_wait_thread =
+                                        g_strdup(params->compress_wait_thread);
+        update_compress_wait_thread(s);
     }
 
     if (params->has_decompress_threads) {
@@ -1282,10 +1362,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 
     if (!migrate_params_check(&tmp, errp)) {
         /* Invalid parameter */
-        return;
+        goto exit;
     }
 
     migrate_params_apply(params, errp);
+exit:
+    migrate_params_test_destroy(params, &tmp);
 }
 
 
@@ -1571,6 +1653,7 @@ void migrate_init(MigrationState *s)
     s->vm_was_running = false;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    update_compress_wait_thread(s);
 }
 
 static GSList *migration_blockers;
@@ -1917,40 +2000,40 @@ bool migrate_postcopy_blocktime(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
 }
 
-bool migrate_use_compression(void)
+int64_t migrate_max_bandwidth(void)
 {
     MigrationState *s;
 
     s = migrate_get_current();
 
-    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
+    return s->parameters.max_bandwidth;
 }
 
-int migrate_compress_level(void)
+bool migrate_use_compression(void)
 {
     MigrationState *s;
 
     s = migrate_get_current();
 
-    return s->parameters.compress_level;
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
 }
 
-int migrate_compress_threads(void)
+int migrate_compress_level(void)
 {
     MigrationState *s;
 
     s = migrate_get_current();
 
-    return s->parameters.compress_threads;
+    return s->parameters.compress_level;
 }
 
-int migrate_compress_wait_thread(void)
+int migrate_compress_threads(void)
 {
     MigrationState *s;
 
     s = migrate_get_current();
 
-    return s->parameters.compress_wait_thread;
+    return s->parameters.compress_threads;
 }
 
 int migrate_decompress_threads(void)
@@ -2895,6 +2978,8 @@ static void migration_update_counters(MigrationState *s,
     s->pages_per_second = (double) transferred_pages /
                              (((double) time_spent / 1000.0));
 
+    compress_adaptive_update(s->mbps);
+
     /*
      * if we haven't sent anything, we don't want to
      * recalculate. 10000 is a small enough number for our purposes
@@ -3228,8 +3313,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
                       parameters.compress_threads,
                       DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
-    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
-                      parameters.compress_wait_thread, true),
+    DEFINE_PROP_STRING("x-compress-wait-thread", MigrationState,
+                       parameters.compress_wait_thread),
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
@@ -3297,6 +3382,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
+    g_free(params->compress_wait_thread);
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
@@ -3318,10 +3404,12 @@ static void migration_instance_init(Object *obj)
 
     params->tls_hostname = g_strdup("");
     params->tls_creds = g_strdup("");
+    params->compress_wait_thread = g_strdup("on");
 
     /* Set has_* up only for parameter checks */
     params->has_compress_level = true;
     params->has_compress_threads = true;
+    params->has_compress_wait_thread = true;
     params->has_decompress_threads = true;
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
diff --git a/migration/migration.h b/migration/migration.h
index 810effc384..f4958a9354 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -146,6 +146,8 @@ struct MigrationState
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
 
+    int compress_wait_thread;
+
     int state;
 
     /* State related to return path */
@@ -276,13 +278,24 @@ bool migrate_use_block(void);
 bool migrate_use_block_incremental(void);
 int migrate_max_cpu_throttle(void);
 bool migrate_use_return_path(void);
+int64_t migrate_max_bandwidth(void);
 
 uint64_t ram_get_total_transferred_pages(void);
 
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
+
+enum {
+    COMPRESS_WAIT_THREAD_OFF = 0,
+    COMPRESS_WAIT_THREAD_ON = 1,
+    COMPRESS_WAIT_THREAD_ADAPTIVE = 2,
+    COMPRESS_WAIT_THREAD_ERR = 3,
+};
 int migrate_compress_wait_thread(void);
+
+void compress_adaptive_update(double mbps);
+
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
 bool migrate_postcopy_blocktime(void);
diff --git a/migration/ram.c b/migration/ram.c
index 7e429b0502..869724a70e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -276,6 +276,8 @@ struct RAMSrcPageRequest {
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
+#define COMPRESS_BUSY_COUNT_PERIOD 200
+
 /* State of RAM for migration */
 struct RAMState {
     /* QEMUFile used for this migration */
@@ -292,6 +294,19 @@ struct RAMState {
     bool ram_bulk_stage;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
+
+    /* used by by compress-wait-thread-adaptive */
+    /*
+     * the count for the case that all compress threads are busy to
+     * handle a page in a period
+     */
+    uint8_t compress_busy_count;
+    /*
+     * the number of pages that can be directly posted as normal page when
+     * all compress threads are busy in a period
+     */
+    uint8_t compress_no_wait_left;
+
     /* these variables are used for bitmap sync */
     /* last time we did a full bitmap_sync */
     int64_t time_last_bitmap_sync;
@@ -470,6 +485,8 @@ static void compress_threads_save_cleanup(void)
     comp_param = NULL;
 }
 
+static void compress_adaptive_init(void);
+
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
@@ -477,6 +494,9 @@ static int compress_threads_save_setup(void)
     if (!migrate_use_compression()) {
         return 0;
     }
+
+    compress_adaptive_init();
+
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
     comp_param = g_new0(CompressParam, thread_count);
@@ -1599,6 +1619,68 @@ uint64_t ram_get_total_transferred_pages(void)
                 compression_counters.pages + xbzrle_counters.pages;
 }
 
+static void compress_adaptive_init(void)
+{
+    /* fully wait on default. */
+     compression_counters.compress_no_wait_weight = 0;
+     ram_state->compress_no_wait_left = 0;
+     ram_state->compress_busy_count = 0;
+}
+
+void compress_adaptive_update(double mbps)
+{
+    int64_t rate_limit, remain_bw, max_bw = migrate_max_bandwidth();
+    int compress_wait_thread = migrate_compress_wait_thread();
+
+    if (!migrate_use_compression() ||
+        !(compress_wait_thread == COMPRESS_WAIT_THREAD_ADAPTIVE)) {
+        return;
+    }
+
+    /* no bandwith is set to the file then we can not do adaptive adjustment */
+    rate_limit = qemu_file_get_rate_limit(migrate_get_current()->to_dst_file);
+    if (rate_limit == 0 || rate_limit == INT64_MAX) {
+        return;
+    }
+
+    max_bw = (max_bw >> 20) * 8;
+    remain_bw = abs(max_bw - (int64_t)(mbps));
+    if (remain_bw <= (max_bw / 20)) {
+        /* if we have used all the bandwidth, let's compress more. */
+        if (compression_counters.compress_no_wait_weight) {
+            compression_counters.compress_no_wait_weight--;
+        }
+        goto exit;
+    }
+
+    /* have enough bandwidth left, do not need to compress so aggressively */
+    if (compression_counters.compress_no_wait_weight !=
+        COMPRESS_BUSY_COUNT_PERIOD) {
+        compression_counters.compress_no_wait_weight++;
+    }
+
+exit:
+    ram_state->compress_busy_count = 0;
+    ram_state->compress_no_wait_left =
+                            compression_counters.compress_no_wait_weight;
+}
+
+static bool compress_adaptive_need_wait(void)
+{
+    if (++ram_state->compress_busy_count == COMPRESS_BUSY_COUNT_PERIOD) {
+        ram_state->compress_busy_count = 0;
+        ram_state->compress_no_wait_left =
+                    compression_counters.compress_no_wait_weight;
+    }
+
+    if (ram_state->compress_no_wait_left) {
+        ram_state->compress_no_wait_left--;
+        return false;
+    }
+
+    return true;
+}
+
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
@@ -1975,7 +2057,11 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
                                            ram_addr_t offset)
 {
     int idx, thread_count, bytes_xmit = -1, pages = -1;
-    bool wait = migrate_compress_wait_thread();
+    int compress_wait_thread = migrate_compress_wait_thread();
+    bool wait, adaptive;
+
+    wait = (adaptive == COMPRESS_WAIT_THREAD_ON);
+    adaptive = (adaptive == COMPRESS_WAIT_THREAD_ADAPTIVE);
 
     thread_count = migrate_compress_threads();
     qemu_mutex_lock(&comp_done_lock);
@@ -1990,20 +2076,29 @@ retry:
             qemu_mutex_unlock(&comp_param[idx].mutex);
             pages = 1;
             update_compress_thread_counts(&comp_param[idx], bytes_xmit);
-            break;
+            goto exit;
         }
     }
 
+    if (adaptive && !wait) {
+        /* it is the first time go to the loop */
+        wait = compress_adaptive_need_wait();
+    }
+
     /*
-     * wait for the free thread if the user specifies 'compress-wait-thread',
-     * otherwise we will post the page out in the main thread as normal page.
+     * wait for the free thread if the user specifies
+     * 'compress-wait-thread-adaptive' that detected the bandwidth is
+     * not enough or compress-wait-thread', otherwise we will post the
+     * page out in the main thread as normal page.
      */
-    if (pages < 0 && wait) {
+    if (wait) {
         qemu_cond_wait(&comp_done_cond, &comp_done_lock);
         goto retry;
     }
-    qemu_mutex_unlock(&comp_done_lock);
 
+
+exit:
+    qemu_mutex_unlock(&comp_done_lock);
     return pages;
 }
 
@@ -3153,19 +3248,18 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
-    if (compress_threads_save_setup()) {
-        return -1;
-    }
-
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
-            compress_threads_save_cleanup();
             return -1;
         }
     }
     (*rsp)->f = f;
 
+    if (compress_threads_save_setup()) {
+        return -1;
+    }
+
     rcu_read_lock();
 
     qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
diff --git a/qapi/migration.json b/qapi/migration.json
index c5babd03b0..0220a0945b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -93,11 +93,16 @@
 #
 # @compression-rate: rate of compressed size
 #
+# @compress-no-wait-weight: it controls how many pages are directly posted
+#     out as normal page when all compression threads are currently busy.
+#     Only available if compress-wait-thread = adaptive. (Since 3.2)
+#
 # Since: 3.1
 ##
 { 'struct': 'CompressionStats',
   'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
-	   'compressed-size': 'int', 'compression-rate': 'number' } }
+	   'compressed-size': 'int', 'compression-rate': 'number',
+	   'compress-no-wait-weight': 'int'} }
 
 ##
 # @MigrationStatus:
@@ -489,9 +494,13 @@
 #          the compression thread count is an integer between 1 and 255.
 #
 # @compress-wait-thread: Controls behavior when all compression threads are
-#                        currently busy. If true (default), wait for a free
-#                        compression thread to become available; otherwise,
-#                        send the page uncompressed. (Since 3.1)
+#          currently busy. If 'true/on' (default), wait for a free
+#          compression thread to become available; if 'false/off', send the
+#          page uncompressed. (Since 3.1)
+#          If it is 'adaptive',  the behavior is adaptively controlled based on
+#          the rate limit. If it has enough bandwidth, it acts as
+#          compress-wait-thread is off. (Since 3.2)
+#
 #
 # @decompress-threads: Set decompression thread count to be used in live
 #          migration, the decompression thread count is an integer between 1
@@ -577,9 +586,12 @@
 # @compress-threads: compression thread count
 #
 # @compress-wait-thread: Controls behavior when all compression threads are
-#                        currently busy. If true (default), wait for a free
-#                        compression thread to become available; otherwise,
-#                        send the page uncompressed. (Since 3.1)
+#          currently busy. If 'true/on' (default), wait for a free
+#          compression thread to become available; if 'false/off', send the
+#          page uncompressed. (Since 3.1)
+#          If it is 'adaptive',  the behavior is adaptively controlled based on
+#          the rate limit. If it has enough bandwidth, it acts as
+#          compress-wait-thread is off. (Since 3.2)
 #
 # @decompress-threads: decompression thread count
 #
@@ -655,7 +667,7 @@
 { 'struct': 'MigrateSetParameters',
   'data': { '*compress-level': 'int',
             '*compress-threads': 'int',
-            '*compress-wait-thread': 'bool',
+            '*compress-wait-thread': 'str',
             '*decompress-threads': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
@@ -697,9 +709,12 @@
 # @compress-threads: compression thread count
 #
 # @compress-wait-thread: Controls behavior when all compression threads are
-#                        currently busy. If true (default), wait for a free
-#                        compression thread to become available; otherwise,
-#                        send the page uncompressed. (Since 3.1)
+#          currently busy. If 'true/on' (default), wait for a free
+#          compression thread to become available; if 'false/off', send the
+#          page uncompressed. (Since 3.1)
+#          If it is 'adaptive',  the behavior is adaptively controlled based on
+#          the rate limit. If it has enough bandwidth, it acts as
+#          compress-wait-thread is off. (Since 3.2)
 #
 # @decompress-threads: decompression thread count
 #
@@ -771,7 +786,7 @@
 { 'struct': 'MigrationParameters',
   'data': { '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
-            '*compress-wait-thread': 'bool',
+            '*compress-wait-thread': 'str',
             '*decompress-threads': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
-- 
2.14.5
