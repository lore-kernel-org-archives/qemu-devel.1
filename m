Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNDWq-0002tE-VT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNDWa-0005gO-EO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:01:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3105 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNDWZ-0005f5-JT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:01:20 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Thu, 15 Nov 2018 16:55:29 +0800
Message-ID: <7a6a8b521adac5f2965e87cd8110f43f6ba468f7.1542301855.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542301855.git.xiezhide@huawei.com>
References: <cover.1542301855.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/4] fsdev-throttle-qmp: qmp interface for
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
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

provides two interfaces:
1. set the IO limits for the required fsdev device
2. query info of all the fsdev devices.

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 Makefile                    |  9 +++++
 Makefile.objs               |  4 ++
 fsdev/qemu-fsdev-dummy.c    | 11 +++++
 fsdev/qemu-fsdev-throttle.c | 98 ++++++++++++++++++++++++++++++++++++++++++---
 fsdev/qemu-fsdev-throttle.h |  6 ++-
 fsdev/qemu-fsdev.c          | 29 ++++++++++++++
 qapi/fsdev.json             | 96 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json       |  1 +
 qmp.c                       | 13 ++++++
 9 files changed, 259 insertions(+), 8 deletions(-)
 create mode 100644 qapi/fsdev.json

diff --git a/Makefile b/Makefile
index 8990081..4b71efd 100644
--- a/Makefile
+++ b/Makefile
@@ -107,6 +107,7 @@ GENERATED_FILES += qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
 GENERATED_FILES += qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES += qapi/qapi-types-transaction.h qapi/qapi-types-transaction.c
 GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c
+GENERATED_FILES += qapi/qapi-types-fsdev.h qapi/qapi-types-fsdev.c
 GENERATED_FILES += qapi/qapi-types-ui.h qapi/qapi-types-ui.c
 GENERATED_FILES += qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
 GENERATED_FILES += qapi/qapi-visit.h qapi/qapi-visit.c
@@ -127,6 +128,7 @@ GENERATED_FILES += qapi/qapi-visit-tpm.h qapi/qapi-visit-tpm.c
 GENERATED_FILES += qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES += qapi/qapi-visit-transaction.h qapi/qapi-visit-transaction.c
 GENERATED_FILES += qapi/qapi-visit-tlimits.h qapi/qapi-visit-tlimits.c
+GENERATED_FILES += qapi/qapi-visit-fsdev.h qapi/qapi-visit-fsdev.c
 GENERATED_FILES += qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
 GENERATED_FILES += qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES += qapi/qapi-commands-block-core.h qapi/qapi-commands-block-core.c
@@ -146,6 +148,7 @@ GENERATED_FILES += qapi/qapi-commands-tpm.h qapi/qapi-commands-tpm.c
 GENERATED_FILES += qapi/qapi-commands-trace.h qapi/qapi-commands-trace.c
 GENERATED_FILES += qapi/qapi-commands-transaction.h qapi/qapi-commands-transaction.c
 GENERATED_FILES += qapi/qapi-commands-tlimits.h qapi/qapi-commands-tlimits.c
+GENERATED_FILES += qapi/qapi-commands-fsdev.h qapi/qapi-commands-fsdev.c
 GENERATED_FILES += qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
 GENERATED_FILES += qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES += qapi/qapi-events-block-core.h qapi/qapi-events-block-core.c
@@ -165,6 +168,7 @@ GENERATED_FILES += qapi/qapi-events-tpm.h qapi/qapi-events-tpm.c
 GENERATED_FILES += qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES += qapi/qapi-events-transaction.h qapi/qapi-events-transaction.c
 GENERATED_FILES += qapi/qapi-events-tlimits.h qapi/qapi-events-tlimits.c
+GENERATED_FILES += qapi/qapi-events-fsdev.h qapi/qapi-events-fsdev.c
 GENERATED_FILES += qapi/qapi-events-ui.h qapi/qapi-events-ui.c
 GENERATED_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_FILES += qapi/qapi-doc.texi
@@ -603,6 +607,7 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/tlimits.json \
+               $(SRC_PATH)/qapi/fsdev.json \
                $(SRC_PATH)/qapi/ui.json
 
 qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
@@ -624,6 +629,7 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-tlimits.c qapi/qapi-types-tlimits.h \
+qapi/qapi-types-fsdev.c qapi/qapi-types-fsdev.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
 qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
 qapi/qapi-visit.c qapi/qapi-visit.h \
@@ -644,6 +650,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-tlimits.c qapi/qapi-visit-tlimits.h \
+qapi/qapi-visit-fsdev.c qapi/qapi-visit-fsdev.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
 qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
@@ -663,6 +670,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-tlimits.c qapi/qapi-commands-tlimits.h \
+qapi/qapi-commands-fsdev.c qapi/qapi-commands-fsdev.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
 qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
@@ -682,6 +690,7 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-tlimits.c qapi/qapi-events-tlimits.h \
+qapi/qapi-events-fsdev.c qapi/qapi-events-fsdev.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
 qapi/qapi-introspect.h qapi/qapi-introspect.c \
 qapi/qapi-doc.texi: \
diff --git a/Makefile.objs b/Makefile.objs
index 682e6ba..72946f2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,7 @@ util-obj-y += qapi/qapi-types-tpm.o
 util-obj-y += qapi/qapi-types-trace.o
 util-obj-y += qapi/qapi-types-transaction.o
 util-obj-y += qapi/qapi-types-tlimits.o
+util-obj-y += qapi/qapi-types-fsdev.o
 util-obj-y += qapi/qapi-types-ui.o
 util-obj-y += qapi/qapi-builtin-visit.o
 util-obj-y += qapi/qapi-visit.o
@@ -41,6 +42,7 @@ util-obj-y += qapi/qapi-visit-tpm.o
 util-obj-y += qapi/qapi-visit-trace.o
 util-obj-y += qapi/qapi-visit-transaction.o
 util-obj-y += qapi/qapi-visit-tlimits.o
+util-obj-y += qapi/qapi-visit-fsdev.o
 util-obj-y += qapi/qapi-visit-ui.o
 util-obj-y += qapi/qapi-events.o
 util-obj-y += qapi/qapi-events-block-core.o
@@ -60,6 +62,7 @@ util-obj-y += qapi/qapi-events-tpm.o
 util-obj-y += qapi/qapi-events-trace.o
 util-obj-y += qapi/qapi-events-transaction.o
 util-obj-y += qapi/qapi-events-tlimits.o
+util-obj-y += qapi/qapi-visit-fsdev.o
 util-obj-y += qapi/qapi-events-ui.o
 util-obj-y += qapi/qapi-introspect.o
 
@@ -158,6 +161,7 @@ common-obj-y += qapi/qapi-commands-tpm.o
 common-obj-y += qapi/qapi-commands-trace.o
 common-obj-y += qapi/qapi-commands-transaction.o
 common-obj-y += qapi/qapi-commands-tlimits.o
+common-obj-y += qapi/qapi-commands-fsdev.o
 common-obj-y += qapi/qapi-commands-ui.o
 common-obj-y += qapi/qapi-introspect.o
 common-obj-y += qmp.o hmp.o
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
index 6a4108a..720fea9 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -17,6 +17,7 @@
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
+#include "qemu/main-loop.h"
 #include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
@@ -31,6 +32,94 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
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
+
+    throttle_get_config(&fst->ts, &cfg);
+    throttle_limits_to_config(qapi_FsdevIOThrottle_base(arg), &cfg, errp);
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
     throttle_parse_options(&fst->cfg, opts);
@@ -41,8 +130,9 @@ void fsdev_throttle_init(FsThrottle *fst)
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
@@ -63,11 +153,7 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
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
diff --git a/qapi/fsdev.json b/qapi/fsdev.json
new file mode 100644
index 0000000..5c8e7de
--- /dev/null
+++ b/qapi/fsdev.json
@@ -0,0 +1,96 @@
+# -*- Mode: Python -*-
+
+##
+# == QAPI fsdev definitions
+##
+
+{ 'include': 'tlimits.json' }
+
+##
+# @FsdevIOThrottle:
+#
+# A set of parameters describing fsdev throttling.
+#
+# @id: device id
+#
+# Since: 3.2
+##
+{ 'struct': 'FsdevIOThrottle',
+  'base': 'ThrottleLimits',
+  'data': { '*id': 'str' } }
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
+# Since: 3.2
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
+# Since: 3.2
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
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 13d7c0f..7bfda5e 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -95,3 +95,4 @@
 { 'include': 'introspect.json' }
 { 'include': 'misc.json' }
 { 'include': 'tlimits.json' }
+{ 'include': 'fsdev.json' }
diff --git a/qmp.c b/qmp.c
index e7c0a2f..3f3171a 100644
--- a/qmp.c
+++ b/qmp.c
@@ -32,6 +32,7 @@
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-commands-fsdev.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
@@ -737,3 +738,15 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
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
1.8.3.1
