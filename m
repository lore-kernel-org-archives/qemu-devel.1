Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYuo-00067h-Tr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYul-0007JA-HX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:58 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1ctYul-0007IK-5k
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:55 -0400
Received: by mail-wr0-x241.google.com with SMTP id u18so11549306wrc.0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 05:10:55 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 30 Mar 2017 08:10:11 -0400
Message-Id: <1490875813-35588-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v2 2/4] fsdev: QMP interface for throttling
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

This patchset enables qmp interfaces for the fsdev
devices. This provides two interfaces one 
for querying info of all the fsdev devices. The second one
to set the IO limits for the required fsdev device.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 Makefile                    |  3 ++
 fsdev/qemu-fsdev-throttle.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h | 13 ++++++
 fsdev/qemu-fsdev.c          | 37 +++++++++++++++++
 hmp-commands-info.hx        | 19 +++++++++
 hmp-commands.hx             | 19 +++++++++
 hmp.c                       | 75 +++++++++++++++++++++++++++++++++++
 hmp.h                       |  5 +++
 qapi-schema.json            |  3 ++
 qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++++
 qapi/iothrottle.json        |  1 +
 qmp.c                       | 14 +++++++
 12 files changed, 369 insertions(+)
 create mode 100644 qapi/fsdev.json

v0 -> v1:
 Addressed comments by Eric Blake, Greg Kurz and Daniel P.Berrange
 Mainly renaming the functions and removing the redundant code.

v1 -> v2:
 Addressed the comments by Eric Blake and Greg Kurz.
 As per the suggestion I split the patches into smaller patches.
 Removed some more duplicate code.


diff --git a/Makefile b/Makefile
index 6c359b2..88de1f6 100644
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
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 7ae4e86..43dbcd8 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -29,6 +29,102 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true]);
 }
 
+void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
+{
+    ThrottleConfig cfg;
+
+    throttle_config_init(&cfg);
+    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
+    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
+    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
+
+    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
+    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
+    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
+
+    if (arg->has_bps_max) {
+        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
+    }
+    if (arg->has_bps_rd_max) {
+        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
+    }
+    if (arg->has_bps_wr_max) {
+        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
+    }
+    if (arg->has_iops_max) {
+        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
+    }
+    if (arg->has_iops_rd_max) {
+        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
+    }
+    if (arg->has_iops_wr_max) {
+        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
+    }
+
+    if (arg->has_bps_max_length) {
+        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
+    }
+    if (arg->has_bps_rd_max_length) {
+        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
+    }
+    if (arg->has_bps_wr_max_length) {
+        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
+    }
+    if (arg->has_iops_max_length) {
+        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
+    }
+    if (arg->has_iops_rd_max_length) {
+        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
+    }
+    if (arg->has_iops_wr_max_length) {
+        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
+    }
+
+    if (arg->has_iops_size) {
+        cfg.op_size = arg->iops_size;
+    }
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
+    fscfg->bps_max = cfg.buckets[THROTTLE_BPS_TOTAL].max;
+    fscfg->bps_rd_max = cfg.buckets[THROTTLE_BPS_READ].max;
+    fscfg->bps_wr_max = cfg.buckets[THROTTLE_BPS_WRITE].max;
+    fscfg->bps_max = cfg.buckets[THROTTLE_OPS_TOTAL].max;
+    fscfg->iops_rd_max = cfg.buckets[THROTTLE_OPS_READ].max;
+    fscfg->iops_wr_max = cfg.buckets[THROTTLE_OPS_WRITE].max;
+
+    fscfg->bps_max_length = cfg.buckets[THROTTLE_BPS_TOTAL].burst_length;
+    fscfg->bps_rd_max_length = cfg.buckets[THROTTLE_BPS_READ].burst_length;
+    fscfg->bps_wr_max_length = cfg.buckets[THROTTLE_BPS_WRITE].burst_length;
+    fscfg->iops_max_length = cfg.buckets[THROTTLE_OPS_TOTAL].burst_length;
+    fscfg->iops_rd_max_length = cfg.buckets[THROTTLE_OPS_READ].burst_length;
+    fscfg->iops_wr_max_length = cfg.buckets[THROTTLE_OPS_WRITE].burst_length;
+    fscfg->iops_size = cfg.op_size;
+
+    *fs9pcfg = fscfg;
+}
+
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
     throttle_config_init(&fst->cfg);
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index e418643..0abba43 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -19,7 +19,14 @@
 #include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/throttle.h"
+#include "qapi/qmp/types.h"
+#include "qapi-visit.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/util.h"
+#include "qmp-commands.h"
+#include "qemu/throttle-options.h"
 
 typedef struct FsThrottle {
     ThrottleState ts;
@@ -36,4 +43,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+
+void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **);
+
+void fsdev_get_io_throttle(FsThrottle *, IOThrottle **, char *, Error **);
+
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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index a53f105..8c1c33e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -84,6 +84,25 @@ STEXI
 Show block device statistics.
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "query-fsdev-iothrottle",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show fsdev device throttle information",
+        .cmd        = hmp_fsdev_get_io_throttle,
+    },
+
+#endif
+
+STEXI
+@item info fsdev throttle
+@findex fsdevthrottleinfo
+Show fsdev device throttleinfo.
+
+ETEXI
+
     {
         .name       = "block-jobs",
         .args_type  = "",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8819281..56ed73a 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1628,6 +1628,25 @@ STEXI
 Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
 ETEXI
 
+#if defined(CONFIG_VIRTFS)
+
+    {
+        .name       = "fsdev-set-io-throttle",
+        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
+        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
+        .help       = "change I/O throttle limits for a block drive",
+        .cmd        = hmp_fsdev_set_io_throttle,
+    },
+
+#endif
+
+STEXI
+@item fsdev_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+@findex fsdev_set_io_throttle
+Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+
+ETEXI
+
     {
         .name       = "set_password",
         .args_type  = "protocol:s,password:s,connected:s?",
diff --git a/hmp.c b/hmp.c
index edb8970..493f48b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/intc/intc.h"
+#include "fsdev/qemu-fsdev-throttle.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -1571,6 +1572,80 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+#ifdef CONFIG_VIRTFS
+
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    IOThrottle throttle = {
+        .has_id = true,
+        .id = (char *) qdict_get_str(qdict, "id"),
+        .bps = qdict_get_int(qdict, "bps"),
+        .bps_rd = qdict_get_int(qdict, "bps_rd"),
+        .bps_wr = qdict_get_int(qdict, "bps_wr"),
+        .iops = qdict_get_int(qdict, "iops"),
+        .iops_rd = qdict_get_int(qdict, "iops_rd"),
+        .iops_wr = qdict_get_int(qdict, "iops_wr"),
+    };
+
+    qmp_fsdev_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_fsdev_throttle_config(Monitor *mon, IOThrottle *fscfg,
+                                       Error *err)
+{
+    if (fscfg->bps  || fscfg->bps_rd  || fscfg->bps_wr  ||
+        fscfg->iops || fscfg->iops_rd || fscfg->iops_wr)
+    {
+        monitor_printf(mon, "%s", fscfg->id);
+        monitor_printf(mon, "    I/O throttling:"
+                        " bps=%" PRId64
+                        " bps_rd=%" PRId64  " bps_wr=%" PRId64
+                        " bps_max=%" PRId64
+                        " bps_rd_max=%" PRId64
+                        " bps_wr_max=%" PRId64
+                        " iops=%" PRId64 " iops_rd=%" PRId64
+                        " iops_wr=%" PRId64
+                        " iops_max=%" PRId64
+                        " iops_rd_max=%" PRId64
+                        " iops_wr_max=%" PRId64
+                        " iops_size=%" PRId64,
+                        fscfg->bps,
+                        fscfg->bps_rd,
+                        fscfg->bps_wr,
+                        fscfg->bps_max,
+                        fscfg->bps_rd_max,
+                        fscfg->bps_wr_max,
+                        fscfg->iops,
+                        fscfg->iops_rd,
+                        fscfg->iops_wr,
+                        fscfg->iops_max,
+                        fscfg->iops_rd_max,
+                        fscfg->iops_wr_max,
+                        fscfg->iops_size);
+   }
+   hmp_handle_error(mon, &err);
+}
+
+void hmp_fsdev_get_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    IOThrottleList *fs9p_list, *info;
+    fs9p_list = qmp_query_fsdev_io_throttle(&err);
+
+    for (info = fs9p_list; info; info = info->next) {
+        if (info != fs9p_list) {
+            monitor_printf(mon, "\n");
+        }
+        print_fsdev_throttle_config(mon, info->value, err);
+        qapi_free_IOThrottle(info->value);
+    }
+    qapi_free_IOThrottleList(fs9p_list);
+}
+
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
diff --git a/hmp.h b/hmp.h
index 799fd37..acce4c1 100644
--- a/hmp.h
+++ b/hmp.h
@@ -78,6 +78,11 @@ void hmp_expire_password(Monitor *mon, const QDict *qdict);
 void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
+#ifdef CONFIG_VIRTFS
+void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_fsdev_get_io_throttle(Monitor *mon, const QDict *qdict);
+#endif
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict);
 void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
 void hmp_block_job_cancel(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..c5c1947 100644
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
diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
index 3c54678..8367f03 100644
--- a/qapi/iothrottle.json
+++ b/qapi/iothrottle.json
@@ -3,6 +3,7 @@
 ##
 # == QAPI IOThrottle definitions
 ##
+##
 # @IOThrottle:
 #
 # A set of parameters describing block
diff --git a/qmp.c b/qmp.c
index fa82b59..743ed37 100644
--- a/qmp.c
+++ b/qmp.c
@@ -162,6 +162,20 @@ SpiceInfo *qmp_query_spice(Error **errp)
 };
 #endif
 
+#ifndef CONFIG_VIRTFS
+
+void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
+{
+
+}
+
+IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
+{
+    abort();
+}
+
+#endif
+
 void qmp_cont(Error **errp)
 {
     Error *local_err = NULL;
-- 
1.8.3.1
