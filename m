Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dotvN-0007Mh-Ga
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dotvH-0008SM-Sb
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:08:33 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dotvH-0008S9-IQ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:08:27 -0400
Received: by mail-wm0-x241.google.com with SMTP id p17so708524wmd.3
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 09:08:27 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon,  4 Sep 2017 12:07:46 -0400
Message-Id: <1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch introduces qmp interfaces for the fsdev
devices. This provides two interfaces one
for querying info of all the fsdev devices. The second one
to set the IO limits for the required fsdev device.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 Makefile                    |   4 ++
 fsdev/qemu-fsdev-dummy.c    |  11 ++++
 fsdev/qemu-fsdev-throttle.c | 145 ++++++++++++++++++++++++++++++++++++++++++--
 fsdev/qemu-fsdev-throttle.h |   9 ++-
 fsdev/qemu-fsdev.c          |  30 +++++++++
 monitor.c                   |   5 ++
 qapi-schema.json            |   3 +
 qapi/fsdev.json             |  81 +++++++++++++++++++++++++
 qmp.c                       |  14 +++++
 9 files changed, 294 insertions(+), 8 deletions(-)
 create mode 100644 qapi/fsdev.json

diff --git a/Makefile b/Makefile
index 81447b1..ec31ffa 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,10 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/trace.json
 
+ifdef CONFIG_VIRTFS
+qapi-modules += $(SRC_PATH)/qapi/fsdev.json
+endif
+
 qapi-types.c qapi-types.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 6dc0fbc..28c82d2 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -14,8 +14,19 @@
 #include "qemu-fsdev.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
+#include "qmp-commands.h"
 
 int qemu_fsdev_add(QemuOpts *opts)
 {
     return 0;
 }
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 0e6fb86..525352e 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
@@ -30,6 +31,141 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true]);
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
+
+    co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
+    aio_co_enter(fst->ctx, co);
+
+    rd.is_write = false;
+
+    co = qemu_coroutine_create(throttle_restart_queue_entry, &rd);
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
+void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
+{
+    ThrottleConfig cfg;
+
+    throttle_set_io_limits(&cfg, arg);
+
+    if (throttle_is_valid(&cfg, errp)) {
+        fst->cfg = cfg;
+        fsdev_throttle_config(fst);
+    }
+}
+
+void fsdev_get_io_throttle(FsThrottle *fst, IOThrottle **fs9pcfg,
+                           char *fsdevice)
+{
+    ThrottleConfig cfg = fst->cfg;
+    IOThrottle *fscfg = g_malloc0(sizeof(*fscfg));
+
+    fscfg->has_id = true;
+    fscfg->id = g_strdup(fsdevice);
+    fscfg->bps = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
+    fscfg->bps_rd = cfg.buckets[THROTTLE_BPS_READ].avg;
+    fscfg->bps_wr = cfg.buckets[THROTTLE_BPS_WRITE].avg;
+
+    fscfg->iops = cfg.buckets[THROTTLE_OPS_TOTAL].avg;
+    fscfg->iops_rd = cfg.buckets[THROTTLE_OPS_READ].avg;
+    fscfg->iops_wr = cfg.buckets[THROTTLE_OPS_WRITE].avg;
+
+    fscfg->has_bps_max     = cfg.buckets[THROTTLE_BPS_TOTAL].max;
+    fscfg->bps_max         = cfg.buckets[THROTTLE_BPS_TOTAL].max;
+    fscfg->has_bps_rd_max  = cfg.buckets[THROTTLE_BPS_READ].max;
+    fscfg->bps_rd_max      = cfg.buckets[THROTTLE_BPS_READ].max;
+    fscfg->has_bps_wr_max  = cfg.buckets[THROTTLE_BPS_WRITE].max;
+    fscfg->bps_wr_max      = cfg.buckets[THROTTLE_BPS_WRITE].max;
+
+    fscfg->has_iops_max    = cfg.buckets[THROTTLE_OPS_TOTAL].max;
+    fscfg->iops_max        = cfg.buckets[THROTTLE_OPS_TOTAL].max;
+    fscfg->has_iops_rd_max = cfg.buckets[THROTTLE_OPS_READ].max;
+    fscfg->iops_rd_max     = cfg.buckets[THROTTLE_OPS_READ].max;
+    fscfg->has_iops_wr_max = cfg.buckets[THROTTLE_OPS_WRITE].max;
+    fscfg->iops_wr_max     = cfg.buckets[THROTTLE_OPS_WRITE].max;
+
+    fscfg->has_bps_max_length     = fscfg->has_bps_max;
+    fscfg->bps_max_length         =
+         cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
+    fscfg->has_bps_rd_max_length  = fscfg->has_bps_rd_max;
+    fscfg->bps_rd_max_length      =
+         cfg.buckets[THROTTLE_BPS_READ].burst_length;
+    fscfg->has_bps_wr_max_length  = fscfg->has_bps_wr_max;
+    fscfg->bps_wr_max_length      =
+         cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
+
+    fscfg->has_iops_max_length    = fscfg->has_iops_max;
+    fscfg->iops_max_length        =
+         cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
+    fscfg->has_iops_rd_max_length = fscfg->has_iops_rd_max;
+    fscfg->iops_rd_max_length     =
+         cfg.buckets[THROTTLE_OPS_READ].burst_length;
+    fscfg->has_iops_wr_max_length = fscfg->has_iops_wr_max;
+    fscfg->iops_wr_max_length     =
+         cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
+
+    fscfg->bps_max_length = cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
+    fscfg->bps_rd_max_length = cfg.buckets[THROTTLE_BPS_READ].burst_length;
+    fscfg->bps_wr_max_length = cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
+    fscfg->iops_max_length = cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
+    fscfg->iops_rd_max_length = cfg.buckets[THROTTLE_OPS_READ].burst_length;
+    fscfg->iops_wr_max_length = cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
+
+    fscfg->iops_size = cfg.op_size;
+
+    *fs9pcfg = fscfg;
+}
+
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
     throttle_parse_options(&fst->cfg, opts);
@@ -40,8 +176,9 @@ void fsdev_throttle_init(FsThrottle *fst)
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
@@ -62,11 +199,7 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
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
index e418643..bfeab40 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -15,8 +15,6 @@
 #ifndef _FSDEV_THROTTLE_H
 #define _FSDEV_THROTTLE_H
 
-#include "block/aio.h"
-#include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
 #include "qemu/throttle.h"
@@ -25,6 +23,7 @@ typedef struct FsThrottle {
     ThrottleState ts;
     ThrottleTimers tt;
     ThrottleConfig cfg;
+    AioContext *ctx;
     CoQueue      throttled_reqs[2];
 } FsThrottle;
 
@@ -36,4 +35,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+
+void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **errp);
+
+void fsdev_get_io_throttle(FsThrottle *, IOThrottle **iothp,
+                           char *);
+
 #endif /* _FSDEV_THROTTLE_H */
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 266e442..0f701fc 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qmp-commands.h"
 
 static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
@@ -98,3 +99,32 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
     }
     return NULL;
 }
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+
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
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    IOThrottleList *head = NULL, *p_next;
+    struct FsDriverListEntry *fsle;
+
+    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
+        p_next = g_new0(IOThrottleList, 1);
+        fsdev_get_io_throttle(&fsle->fse.fst, &p_next->value,
+                              fsle->fse.fsdev_id);
+        p_next->next = head;
+        head = p_next;
+    }
+    return head;
+}
diff --git a/monitor.c b/monitor.c
index e0f8801..eebda1c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -998,6 +998,11 @@ static void qmp_unregister_commands_hack(void)
     && !defined(TARGET_S390X)
     qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
 #endif
+#ifndef CONFIG_VIRTFS
+    qmp_unregister_command(&qmp_commands, "fsdev-set-io-throttle");
+    qmp_unregister_command(&qmp_commands, "query-fsdev-io-throttle");
+#endif
+
 }
 
 void monitor_init_qmp_commands(void)
diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53..8cf8140 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -81,6 +81,9 @@
 # QAPI block definitions
 { 'include': 'qapi/block.json' }
 
+# QAPI fsdev definitions
+{ 'include': 'qapi/fsdev.json' }
+
 # QAPI event definitions
 { 'include': 'qapi/event.json' }
 
diff --git a/qapi/fsdev.json b/qapi/fsdev.json
new file mode 100644
index 0000000..21d074d
--- /dev/null
+++ b/qapi/fsdev.json
@@ -0,0 +1,81 @@
+# -*- Mode: Python -*-
+
+##
+# == QAPI fsdev definitions
+##
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
+# Since: 2.10
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
+  'data': 'IOThrottle' }
+##
+# @query-fsdev-io-throttle:
+#
+# Returns: a list of @IOThrottle describing I/O throttle
+#          values of each fsdev device
+#
+# Since: 2.10
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
+{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
diff --git a/qmp.c b/qmp.c
index b86201e..eed91e5 100644
--- a/qmp.c
+++ b/qmp.c
@@ -130,6 +130,20 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
 
+#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+    return;
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    return NULL;
+}
+
+#endif
+
 #ifndef CONFIG_VNC
 /* If VNC support is enabled, the "true" query-vnc command is
    defined in the VNC subsystem */
-- 
1.8.3.1
