Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwU7-0003BT-8L
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwU3-0001tx-K3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:51 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dMwU3-0001sm-8Z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:47 -0400
Received: by mail-wr0-x243.google.com with SMTP id y25so11254420wrd.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 06:12:47 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon, 19 Jun 2017 09:11:36 -0400
Message-Id: <1497877896-35700-6-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v5 5/5] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch enables qmp interfaces for the fsdev
devices. This provides two interfaces one 
for querying info of all the fsdev devices. The second one
to set the IO limits for the required fsdev device.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 Makefile                    |  3 ++
 fsdev/qemu-fsdev-dummy.c    | 10 ++++++
 fsdev/qemu-fsdev-throttle.c | 75 ++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h | 12 +++++++
 fsdev/qemu-fsdev.c          | 37 ++++++++++++++++++++
 monitor.c                   |  5 +++
 qapi-schema.json            |  3 ++
 qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++++++++++
 qmp.c                       | 15 ++++++++
 9 files changed, 244 insertions(+)
 create mode 100644 qapi/fsdev.json

diff --git a/Makefile b/Makefile
index c830d7a..996b1cf 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,9 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/trace.json
+ifdef CONFIG_VIRTFS
+qapi-modules += $(SRC_PATH)/qapi/fsdev.json
+endif
 
 qapi-types.c qapi-types.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 6dc0fbc..f33305d 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -19,3 +19,13 @@ int qemu_fsdev_add(QemuOpts *opts)
 {
     return 0;
 }
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+  return;
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    abort();
+}
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index da9c225..4483533 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -29,6 +29,81 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true]);
 }
 
+void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
+{
+    ThrottleConfig cfg;
+
+    throttle_set_io_limits(&cfg, arg);
+
+    if (throttle_is_valid(&cfg, errp)) {
+        fst->cfg = cfg;
+        fsdev_throttle_init(fst);
+    }
+}
+
+void fsdev_get_io_throttle(FsThrottle *fst, IOThrottle **fs9pcfg,
+                           char *fsdevice, Error **errp)
+{
+
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
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index c493e83..a49b2e5 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -21,6 +21,12 @@
 #include "qapi/error.h"
 #include "qemu/throttle.h"
 #include "qemu/throttle-options.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qmp/types.h"
+#include "qapi-visit.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/util.h"
+#include "qmp-commands.h"
 
 typedef struct FsThrottle {
     ThrottleState ts;
@@ -37,4 +43,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+
+void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **errp);
+
+void fsdev_get_io_throttle(FsThrottle *, IOThrottle **iothp,
+                           char *, Error **errp);
+
 #endif /* _FSDEV_THROTTLE_H */
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 266e442..a99e299 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qmp-commands.h"
 
 static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
@@ -98,3 +99,39 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
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
+        return;
+    }
+
+    fsdev_set_io_throttle(arg, &fse->fst, errp);
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    IOThrottleList *head = NULL, **p_next = &head;
+    struct FsDriverListEntry *fsle;
+    Error *local_err = NULL;
+
+    QTAILQ_FOREACH(fsle, &fsdriver_entries, next) {
+        IOThrottleList *fscfg = g_malloc0(sizeof(*fscfg));
+        fsdev_get_io_throttle(&fsle->fse.fst, &fscfg->value,
+                            fsle->fse.fsdev_id, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            g_free(fscfg);
+            qapi_free_IOThrottleList(head);
+            return NULL;
+        }
+
+        *p_next = fscfg;
+        p_next = &fscfg->next;
+    }
+    return head;
+}
diff --git a/monitor.c b/monitor.c
index fcf4fad..6b8c2cb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -997,6 +997,11 @@ static void qmp_unregister_commands_hack(void)
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
index 4b50b65..dc676be 100644
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
index 0000000..eff1efe
--- /dev/null
+++ b/qapi/fsdev.json
@@ -0,0 +1,84 @@
+# -*- Mode: Python -*-
+
+##
+# == QAPI fsdev definitions
+##
+
+# QAPI common definitions
+{ 'include': 'iothrottle.json' }
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
+#          If @device is not a valid fsdev device, DeviceNotFound
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
+# Returns: a list of @IOThrottle describing io throttle values of each fsdev device
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "Execute": "query-fsdev-io-throttle" }
+# <- { "returns" : [
+#          {
+#             "id": "id0-hd0",
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
+
diff --git a/qmp.c b/qmp.c
index 7ee9bcf..7dc68a3 100644
--- a/qmp.c
+++ b/qmp.c
@@ -130,6 +130,21 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
 
+#if defined(_WIN64) || defined(_WIN32)
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+  return;
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    abort();
+}
+
+#endif
+
+
 #ifndef CONFIG_VNC
 /* If VNC support is enabled, the "true" query-vnc command is
    defined in the VNC subsystem */
-- 
1.8.3.1
