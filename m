Received: from eggs.gnu.org ([2001:4830:134:3::10]:40961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMXey-0007XG-7E
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:19:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMXeu-00043z-1X
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:19:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2667 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMXeq-00042r-Kn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:19:07 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Tue, 13 Nov 2018 20:13:18 +0800
Message-ID: <4c5dd2cf9d0d77fc44cc9d057a6b3496eed4f86b.1542110461.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542110461.git.xiezhide@huawei.com>
References: <cover.1542110461.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/3] fsdev-throttle-qmp: qmp interface for
 fsdev io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, johnny.chenyi@huawei.com

provides two interfaces:
1. set the IO limits for the required fsdev device
2. query info of all the fsdev devices.

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 fsdev/qemu-fsdev-dummy.c    |  11 ++++
 fsdev/qemu-fsdev-throttle.c | 144 +++++++++++++++++++++++++++++---------------
 fsdev/qemu-fsdev-throttle.h |   6 +-
 fsdev/qemu-fsdev.c          |  29 +++++++++
 monitor.c                   |  41 ++++++-------
 qapi/fsdev.json             |  78 +++++++++++++++++++++++-
 qapi/tlimits.json           |   2 +-
 qmp.c                       |  12 ++++
 8 files changed, 249 insertions(+), 74 deletions(-)

diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 489cd29..9a90960 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -14,8 +14,19 @@
 #include "qemu-fsdev.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
+#include "qapi/qapi-commands-fsdev.h"
 
 int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
     return 0;
 }
+
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index cfd8641..fa2b0c8 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -17,6 +17,8 @@
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
+#include "qemu/main-loop.h"
+#include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
@@ -30,50 +32,99 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
 }
 
+typedef struct {
+    FsThrottle *fst;
+    bool is_write;
+} RestartData;
+
+static bool coroutine_fn throttle_co_restart_queue(FsThrottle *fst,
+                                                   bool is_write)
+{
+    return qemu_co_queue_next(&fst->throttled_reqs[is_write]);
+}
+
+static void schedule_next_request(FsThrottle *fst, bool is_write)
+{
+    bool must_wait = throttle_schedule_timer(&fst->ts, &fst->tt, is_write);
+    if (!must_wait) {
+        if (qemu_in_coroutine() &&
+            throttle_co_restart_queue(fst, is_write)) {
+            return;
+        } else {
+            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+            timer_mod(fst->tt.timers[is_write], now);
+        }
+    }
+}
+
+static void coroutine_fn throttle_restart_queue_entry(void *opaque)
+{
+    RestartData *data = opaque;
+    bool is_write = data->is_write;
+    bool empty_queue = !throttle_co_restart_queue(data->fst, is_write);
+    if (empty_queue) {
+        schedule_next_request(data->fst, is_write);
+    }
+}
+
+static void throttle_restart_queues(FsThrottle *fst)
+{
+    Coroutine *co;
+    RestartData rd = {
+        .fst = fst,
+        .is_write = true
+    };
+     co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
+    aio_co_enter(fst->ctx, co);
+     rd.is_write = false;
+     co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
+    aio_co_enter(fst->ctx, co);
+}
+
+static void coroutine_fn fsdev_throttle_config(FsThrottle *fst)
+{
+    if (throttle_enabled(&fst->cfg)) {
+        throttle_config(&fst->ts, QEMU_CLOCK_REALTIME, &fst->cfg);
+    } else {
+        throttle_restart_queues(fst);
+    }
+}
+
+void fsdev_set_io_throttle(FsdevIOThrottle *arg, FsThrottle *fst, Error **errp)
+{
+    ThrottleConfig cfg;
+    ThrottleLimits *tlimits;
+
+    throttle_get_config(&fst->ts, &cfg);
+    tlimits = qapi_FsdevIOThrottle_base(arg);
+    throttle_limits_to_config(tlimits, &cfg, errp);
+
+    if (*errp == NULL) {
+        fst->cfg = cfg;
+        if (!throttle_timers_are_initialized(&fst->tt)) {
+            fsdev_throttle_init(fst);
+        } else {
+            fsdev_throttle_config(fst);
+        }
+    }
+}
+
+void fsdev_get_io_throttle(FsThrottle *fst, FsdevIOThrottle **fs9pcfg,
+                           char *fsdevice)
+{
+    ThrottleConfig cfg = fst->cfg;
+    ThrottleLimits *tlimits;
+    FsdevIOThrottle *fscfg = g_malloc(sizeof(*fscfg));
+    tlimits = qapi_FsdevIOThrottle_base(fscfg);
+    fscfg->has_id = true;
+    fscfg->id = g_strdup(fsdevice);
+    throttle_config_to_limits(&cfg, tlimits);
+    *fs9pcfg = fscfg;
+}
+
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
-    throttle_config_init(&fst->cfg);
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =
-        qemu_opt_get_number(opts, "throttling.bps-total", 0);
-    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =
-        qemu_opt_get_number(opts, "throttling.bps-read", 0);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =
-        qemu_opt_get_number(opts, "throttling.bps-write", 0);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =
-        qemu_opt_get_number(opts, "throttling.iops-total", 0);
-    fst->cfg.buckets[THROTTLE_OPS_READ].avg =
-        qemu_opt_get_number(opts, "throttling.iops-read", 0);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =
-        qemu_opt_get_number(opts, "throttling.iops-write", 0);
-
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =
-        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
-    fst->cfg.buckets[THROTTLE_BPS_READ].max  =
-        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =
-        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =
-        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_READ].max =
-        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =
-        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
-
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =
-        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
-    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =
-        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =
-        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
-    fst->cfg.op_size =
-        qemu_opt_get_number(opts, "throttling.iops-size", 0);
-
+    throttle_parse_options(&fst->cfg, opts);
     throttle_is_valid(&fst->cfg, errp);
 }
 
@@ -81,8 +132,9 @@ void fsdev_throttle_init(FsThrottle *fst)
 {
     if (throttle_enabled(&fst->cfg)) {
         throttle_init(&fst->ts);
+        fst->ctx = qemu_get_aio_context();
         throttle_timers_init(&fst->tt,
-                             qemu_get_aio_context(),
+                             fst->ctx,
                              QEMU_CLOCK_REALTIME,
                              fsdev_throttle_read_timer_cb,
                              fsdev_throttle_write_timer_cb,
@@ -103,11 +155,7 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
         }
 
         throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
-
-        if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
-            !throttle_schedule_timer(&fst->ts, &fst->tt, is_write)) {
-            qemu_co_queue_next(&fst->throttled_reqs[is_write]);
-        }
+        schedule_next_request(fst, is_write);
     }
 }
 
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index 4e83bda..7107769 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -15,15 +15,15 @@
 #ifndef _FSDEV_THROTTLE_H
 #define _FSDEV_THROTTLE_H
 
-#include "block/aio.h"
-#include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
 #include "qemu/throttle.h"
+#include "qapi/qapi-types-fsdev.h"
 
 typedef struct FsThrottle {
     ThrottleState ts;
     ThrottleTimers tt;
     ThrottleConfig cfg;
+    AioContext *ctx;
     CoQueue      throttled_reqs[2];
 } FsThrottle;
 
@@ -35,4 +35,6 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+void fsdev_set_io_throttle(FsdevIOThrottle *, FsThrottle *, Error **errp);
+void fsdev_get_io_throttle(FsThrottle *, FsdevIOThrottle **iothp, char *);
 #endif /* _FSDEV_THROTTLE_H */
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 7a3b87c..609d8fc 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -17,6 +17,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qapi/qapi-commands-fsdev.h"
 
 static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
@@ -99,3 +100,31 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
     }
     return NULL;
 }
+
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    FsDriverEntry *fse;
+
+    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
+    if (!fse) {
+        error_setg(errp, "Not a valid fsdev device");
+        return;
+    }
+
+    fsdev_set_io_throttle(arg, &fse->fst, errp);
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    FsdevIOThrottleList *head = NULL, *p_next;
+    struct FsDriverListEntry *fsle;
+
+    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
+        p_next = g_new0(FsdevIOThrottleList, 1);
+        fsdev_get_io_throttle(&fsle->fse.fst, &p_next->value,
+                              fsle->fse.fsdev_id);
+        p_next->next = head;
+        head = p_next;
+    }
+    return head;
+}
diff --git a/monitor.c b/monitor.c
index d39390c..bbf531b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -708,14 +708,9 @@ static void monitor_qapi_event_init(void)
 
 static void handle_hmp_command(Monitor *mon, const char *cmdline);
 
-static void monitor_iothread_init(void);
-
 static void monitor_data_init(Monitor *mon, bool skip_flush,
                               bool use_io_thread)
 {
-    if (use_io_thread && !mon_iothread) {
-        monitor_iothread_init();
-    }
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
     qemu_mutex_init(&mon->qmp.qmp_queue_lock);
@@ -1174,6 +1169,10 @@ static void qmp_unregister_commands_hack(void)
     && !defined(TARGET_S390X)
     qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
 #endif
+#ifndef CONFIG_VIRTFS
+    qmp_unregister_command(&qmp_commands, "fsdev-set-io-throttle");
+    qmp_unregister_command(&qmp_commands, "query-fsdev-io-throttle");
+#endif
 }
 
 static void monitor_init_qmp_commands(void)
@@ -4297,7 +4296,7 @@ int monitor_suspend(Monitor *mon)
 
     atomic_inc(&mon->suspend_cnt);
 
-    if (monitor_is_qmp(mon) && mon->use_io_thread) {
+    if (monitor_is_qmp(mon)) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
@@ -4466,15 +4465,6 @@ static AioContext *monitor_get_aio_context(void)
 static void monitor_iothread_init(void)
 {
     mon_iothread = iothread_create("mon_iothread", &error_abort);
-}
-
-void monitor_init_globals(void)
-{
-    monitor_init_qmp_commands();
-    monitor_qapi_event_init();
-    sortcmdlist();
-    qemu_mutex_init(&monitor_lock);
-    qemu_mutex_init(&mon_fdsets_lock);
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
@@ -4486,6 +4476,16 @@ void monitor_init_globals(void)
                                    NULL);
 }
 
+void monitor_init_globals(void)
+{
+    monitor_init_qmp_commands();
+    monitor_qapi_event_init();
+    sortcmdlist();
+    qemu_mutex_init(&monitor_lock);
+    qemu_mutex_init(&mon_fdsets_lock);
+    monitor_iothread_init();
+}
+
 /* These functions just adapt the readline interface in a typesafe way.  We
  * could cast function pointers but that discards compiler checks.
  */
@@ -4628,9 +4628,7 @@ void monitor_cleanup(void)
      * we need to unregister from chardev below in
      * monitor_data_destroy(), and chardev is not thread-safe yet
      */
-    if (mon_iothread) {
-        iothread_stop(mon_iothread);
-    }
+    iothread_stop(mon_iothread);
 
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
@@ -4645,10 +4643,9 @@ void monitor_cleanup(void)
     /* QEMUBHs needs to be deleted before destroying the I/O thread */
     qemu_bh_delete(qmp_dispatcher_bh);
     qmp_dispatcher_bh = NULL;
-    if (mon_iothread) {
-        iothread_destroy(mon_iothread);
-        mon_iothread = NULL;
-    }
+
+    iothread_destroy(mon_iothread);
+    mon_iothread = NULL;
 }
 
 QemuOptsList qemu_mon_opts = {
diff --git a/qapi/fsdev.json b/qapi/fsdev.json
index c5559bb..32356b9 100644
--- a/qapi/fsdev.json
+++ b/qapi/fsdev.json
@@ -13,8 +13,84 @@
 #
 # @id: device id
 #
-# Since: 3.2
+# Since: 4.0
 ##
 { 'struct': 'FsdevIOThrottle',
   'base': 'ThrottleLimits',
   'data': { '*id': 'str' } }
+
+##
+# @fsdev-set-io-throttle:
+#
+# Change I/O limits for a 9p/fsdev device.
+#
+# I/O limits can be enabled by setting throttle value to non-zero number.
+#
+# I/O limits can be disabled by setting all throttle values to 0.
+#
+# Returns: Nothing on success
+#          If @device is not a valid fsdev device, GenericError
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "execute": "fsdev-set-io-throttle",
+#      "arguments": { "id": "id0-1-0",
+#                     "bps": 1000000,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 0,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 8000000,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 60,
+#                     "iops_size": 0 } }
+# <- { "returns": {} }
+##
+{ 'command': 'fsdev-set-io-throttle', 'boxed': true,
+  'data': 'FsdevIOThrottle' }
+##
+# @query-fsdev-io-throttle:
+#
+# Returns: a list of @IOThrottle describing I/O throttle
+#          values of each fsdev device
+#
+# Since: 4.0
+#
+# Example:
+#
+# -> { "Execute": "query-fsdev-io-throttle" }
+# <- { "returns" : [
+#          {
+#              "id": "id0-hd0",
+#              "bps":1000000,
+#              "bps_rd":0,
+#              "bps_wr":0,
+#              "iops":1000000,
+#              "iops_rd":0,
+#              "iops_wr":0,
+#              "bps_max": 8000000,
+#              "bps_rd_max": 0,
+#              "bps_wr_max": 0,
+#              "iops_max": 0,
+#              "iops_rd_max": 0,
+#              "iops_wr_max": 0,
+#              "bps_max_length": 0,
+#              "bps_rd_max_length": 0,
+#              "bps_wr_max_length": 0,
+#              "iops_max_length": 0,
+#              "iops_rd_max_length": 0,
+#              "iops_wr_max_length": 0,
+#              "iops_size": 0
+#            }
+#          ]
+#      }
+#
+##
+{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'FsdevIOThrottle' ] }
diff --git a/qapi/tlimits.json b/qapi/tlimits.json
index 1916726..6bcbaf6 100644
--- a/qapi/tlimits.json
+++ b/qapi/tlimits.json
@@ -74,7 +74,7 @@
 #
 # @iops_size: an I/O size in bytes (Since 1.7)
 #
-# Since: 3.2
+# Since: 4.0
 #
 ##
 { 'struct': 'ThrottleLimits',
diff --git a/qmp.c b/qmp.c
index e7c0a2f..18b1f0f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -737,3 +737,15 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
+
+#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
+void qmp_fsdev_set_io_throttle(FsdevIOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+FsdevIOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
+#endif
-- 
2.7.4
