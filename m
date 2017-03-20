Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cpx2T-0000yj-ES
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cpx2Q-0001Ct-0e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:07:57 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1cpx2P-0001CV-ME
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:07:53 -0400
Received: by mail-wr0-x242.google.com with SMTP id u48so18070451wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 06:07:53 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon, 20 Mar 2017 09:07:20 -0400
Message-Id: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patchset enables qmp interfaces for the 9pfs 
devices (fsdev).This provides two interfaces one 
for querying all the 9pfs devices info. The second one
to set the IO limits for the required 9pfs device.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 Makefile                    |   2 +-
 fsdev/qemu-fsdev-throttle.c | 103 +++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h |  14 ++++
 fsdev/qemu-fsdev.c          |   8 ++-
 fsdev/qemu-fsdev.h          |   3 +
 hmp-commands-info.hx        |  14 ++++
 hmp-commands.hx             |  28 ++++++++
 hmp.c                       |  70 ++++++++++++++++++
 hmp.h                       |   3 +
 hw/9pfs/9p.c                |  39 ++++++++++
 qapi-schema.json            |   3 +
 qapi/9pfs.json              | 169 ++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 454 insertions(+), 2 deletions(-)
 create mode 100644 qapi/9pfs.json

diff --git a/Makefile b/Makefile
index 73e0c12..4f387a1 100644
--- a/Makefile
+++ b/Makefile
@@ -413,7 +413,7 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.json \
-               $(SRC_PATH)/qapi/trace.json
+               $(SRC_PATH)/qapi/trace.json $(SRC_PATH)/qapi/9pfs.json
 
 qapi-types.c qapi-types.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 7ae4e86..b18d98a 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -29,6 +29,109 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
     qemu_co_enter_next(&fst->throttled_reqs[true]);
 }
 
+void fsdev_set_io_throttle(FS9PIOThrottle *arg, FsThrottle *fst, Error **errp)
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
+    if (!throttle_is_valid(&cfg, errp)) {
+        goto out;
+    }
+
+    fst->cfg = cfg;
+    fsdev_throttle_init(fst);
+
+out:
+    return;
+
+}
+
+void fsdev_get_io_throttle(FsThrottle *fst, FS9PIOThrottle **fs9pcfg,
+                           char *fsdevice, Error **errp)
+{
+
+    ThrottleConfig cfg = fst->cfg;
+    FS9PIOThrottle *fscfg = g_malloc0(sizeof(*fscfg));
+
+    fscfg->has_device = true;
+    fscfg->device = g_strdup(fsdevice);
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
+
+}
+
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
     throttle_config_init(&fst->cfg);
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index e418643..9b03f7f 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -20,6 +20,13 @@
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
 #include "qemu/throttle.h"
+#include "qapi/qmp/types.h"
+#include "qapi-visit.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qapi/util.h"
+#include "qmp-commands.h"
+
 
 typedef struct FsThrottle {
     ThrottleState ts;
@@ -28,6 +35,7 @@ typedef struct FsThrottle {
     CoQueue      throttled_reqs[2];
 } FsThrottle;
 
+
 void fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
 
 void fsdev_throttle_init(FsThrottle *);
@@ -36,4 +44,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
+
+void fsdev_set_io_throttle(FS9PIOThrottle *, FsThrottle *, Error **);
+
+void fsdev_get_io_throttle(FsThrottle *, FS9PIOThrottle **, char *, Error **);
+
+
 #endif /* _FSDEV_THROTTLE_H */
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 266e442..486b63b 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -17,9 +17,10 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 
-static QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry) fsdriver_entries =
+static struct FsDriverEntry_head fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
 
+
 static FsDriverTable FsDrivers[] = {
     { .name = "local", .ops = &local_ops},
 #ifdef CONFIG_OPEN_BY_HANDLE
@@ -98,3 +99,8 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
     }
     return NULL;
 }
+
+struct FsDriverEntry_head *get_fsdev_fsentryList(void)
+{
+  return &fsdriver_entries;
+}
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 29c9622..92f766d 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -39,6 +39,9 @@ typedef struct FsDriverListEntry {
     QTAILQ_ENTRY(FsDriverListEntry) next;
 } FsDriverListEntry;
 
+QTAILQ_HEAD(FsDriverEntry_head, FsDriverListEntry);
+
+struct FsDriverEntry_head *get_fsdev_fsentryList(void);
 int qemu_fsdev_add(QemuOpts *opts);
 FsDriverEntry *get_fsdev_fsentry(char *id);
 extern FileOperations local_ops;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index a53f105..c5b8664 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -85,6 +85,20 @@ Show block device statistics.
 ETEXI
 
     {
+        .name       = "9pthrottle",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show fsdev/9p device throttle information",
+        .cmd        = hmp_9pfs_get_io_throttle,
+    },
+
+STEXI
+@item info 9p throttle
+@findex 9pthrottleinfo
+Show 9p device throttleinfo.
+ETEXI
+
+    {
         .name       = "block-jobs",
         .args_type  = "",
         .params     = "",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8819281..e4e3478 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1637,6 +1637,34 @@ ETEXI
     },
 
 STEXI
+@item 9p_passwd @var{device} @var{password}
+@findex 9p_passwd
+Set the encrypted device @var{device} password to @var{password}
+ETEXI
+
+    {
+        .name       = "fs9p_set_io_throttle",
+        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
+        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
+        .help       = "change I/O throttle limits for a block drive",
+        .cmd        = hmp_9pfs_set_io_throttle,
+    },
+
+STEXI
+@item fs9p_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+@findex 9pfs_set_io_throttle
+Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
+ETEXI
+
+    {
+        .name       = "set_password",
+        .args_type  = "protocol:s,password:s,connected:s?",
+        .params     = "protocol password action-if-connected",
+        .help       = "set spice/vnc password",
+        .cmd        = hmp_set_password,
+    },
+
+STEXI
 @item set_password [ vnc | spice ] password [ action-if-connected ]
 @findex set_password
 Change spice/vnc password.  Use zero to make the password stay valid
diff --git a/hmp.c b/hmp.c
index edb8970..46b8d72 100644
--- a/hmp.c
+++ b/hmp.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/intc/intc.h"
+#include "fsdev/qemu-fsdev-throttle.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -1571,6 +1572,75 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_9pfs_set_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    FS9PIOThrottle throttle = {
+        .device = (char *) qdict_get_str(qdict, "device"),
+        .bps = qdict_get_int(qdict, "bps"),
+        .bps_rd = qdict_get_int(qdict, "bps_rd"),
+        .bps_wr = qdict_get_int(qdict, "bps_wr"),
+        .iops = qdict_get_int(qdict, "iops"),
+        .iops_rd = qdict_get_int(qdict, "iops_rd"),
+        .iops_wr = qdict_get_int(qdict, "iops_wr"),
+    };
+
+    qmp_fs9p_set_io_throttle(&throttle, &err);
+    hmp_handle_error(mon, &err);
+}
+
+static void print_9pfs_throttle_config(Monitor *mon, FS9PIOThrottle *fscfg,
+                                       Error *err)
+{
+    if (fscfg->bps  || fscfg->bps_rd  || fscfg->bps_wr  ||
+        fscfg->iops || fscfg->iops_rd || fscfg->iops_wr)
+    {
+        monitor_printf(mon, "%s", fscfg->device);
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
+void hmp_9pfs_get_io_throttle(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    FS9PIOThrottleList *fs9p_list, *info;
+    fs9p_list = qmp_query_9pfs_io_throttle(&err);
+
+    for (info = fs9p_list; info; info = info->next) {
+        if (info != fs9p_list) {
+            monitor_printf(mon, "\n");
+        }
+        print_9pfs_throttle_config(mon, info->value, err);
+        qapi_free_FS9PIOThrottle(info->value);
+    }
+    qapi_free_FS9PIOThrottleList(fs9p_list);
+}
+
 void hmp_block_stream(Monitor *mon, const QDict *qdict)
 {
     Error *error = NULL;
diff --git a/hmp.h b/hmp.h
index 799fd37..728ef73 100644
--- a/hmp.h
+++ b/hmp.h
@@ -56,6 +56,7 @@ void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
 void hmp_nmi(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_block_passwd(Monitor *mon, const QDict *qdict);
+void hmp_9p_passwd(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
 void hmp_block_resize(Monitor *mon, const QDict *qdict);
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
@@ -77,6 +78,8 @@ void hmp_set_password(Monitor *mon, const QDict *qdict);
 void hmp_expire_password(Monitor *mon, const QDict *qdict);
 void hmp_eject(Monitor *mon, const QDict *qdict);
 void hmp_change(Monitor *mon, const QDict *qdict);
+void hmp_9pfs_set_io_throttle(Monitor *mon, const QDict *qdict);
+void hmp_9pfs_get_io_throttle(Monitor *mon, const QDict*qdict);
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
 void hmp_block_stream(Monitor *mon, const QDict *qdict);
 void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76c9247..46393be 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3451,6 +3451,45 @@ void pdu_submit(V9fsPDU *pdu)
     qemu_coroutine_enter(co);
 }
 
+void qmp_fs9p_set_io_throttle(FS9PIOThrottle *arg, Error **errp)
+{
+
+    FsDriverEntry *fse;
+
+    fse = get_fsdev_fsentry(arg->has_device ? arg->device : NULL);
+    if (!fse) {
+        return;
+    }
+
+    fsdev_set_io_throttle(arg, &fse->fst, errp);
+}
+
+FS9PIOThrottleList *qmp_query_9pfs_io_throttle(Error **errp)
+{
+    FS9PIOThrottleList *head = NULL, **p_next = &head;
+    struct FsDriverListEntry *fsle;
+    struct FsDriverEntry_head *fsdev_entries;
+    Error *local_err = NULL;
+
+    fsdev_entries = get_fsdev_fsentryList();
+
+    QTAILQ_FOREACH(fsle, fsdev_entries, next) {
+        FS9PIOThrottleList *fscfg = g_malloc0(sizeof(*fscfg));
+        fsdev_get_io_throttle(&fsle->fse.fst, &fscfg->value,
+                            fsle->fse.fsdev_id, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            g_free(fscfg);
+            qapi_free_FS9PIOThrottleList(head);
+            return NULL;
+        }
+
+        *p_next = fscfg;
+        p_next = &fscfg->next;
+    }
+    return head;
+}
+
 /* Returns 0 on success, 1 on failure. */
 int v9fs_device_realize_common(V9fsState *s, Error **errp)
 {
diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..b7cb84a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -81,6 +81,9 @@
 # QAPI block definitions
 { 'include': 'qapi/block.json' }
 
+# QAPI 9pfs definitions
+{ 'include': 'qapi/9pfs.json' }
+
 # QAPI event definitions
 { 'include': 'qapi/event.json' }
 
diff --git a/qapi/9pfs.json b/qapi/9pfs.json
new file mode 100644
index 0000000..c068474
--- /dev/null
+++ b/qapi/9pfs.json
@@ -0,0 +1,169 @@
+# -*- Mode: Python -*-
+
+##
+# == QAPI 9p definitions
+##
+
+# QAPI common definitions
+{ 'include': 'common.json' }
+
+##
+# @fs9p_set_io_throttle:
+#
+# Change I/O limits for a 9p/fsdev device.
+#
+# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) device
+#
+# I/O limits can be disabled by setting all of them to 0.
+#
+# Returns: Nothing on success
+#          If @device is not a valid 9p device, DeviceNotFound
+#
+# Since: 2:10
+#
+# Example:
+#
+# -> { "execute": "fs9p_set_io_throttle",
+#      "arguments": { "device": "ide0-1-0",
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
+{ 'command': 'fs9p_set_io_throttle', 'boxed': true,
+  'data': 'FS9PIOThrottle' }
+##
+# @FS9PIOThrottle:
+#
+# A set of parameters describing block
+#
+# @device: Block device name
+#
+# @bps: total throughput limit in bytes per second
+#
+# @bps_rd: read throughput limit in bytes per second
+#
+# @bps_wr: write throughput limit in bytes per second
+#
+# @iops: total I/O operations per second
+#
+# @iops_rd: read I/O operations per second
+#
+# @iops_wr: write I/O operations per second
+#
+# @bps_max: total throughput limit during bursts,
+#                     in bytes (Since 1.7)
+#
+# @bps_rd_max: read throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @bps_wr_max: write throughput limit during bursts,
+#                        in bytes (Since 1.7)
+#
+# @iops_max: total I/O operations per second during bursts,
+#                      in bytes (Since 1.7)
+#
+# @iops_rd_max: read I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @iops_wr_max: write I/O operations per second during bursts,
+#                         in bytes (Since 1.7)
+#
+# @bps_max_length: maximum length of the @bps_max burst
+#                            period, in seconds. It must only
+#                            be set if @bps_max is set as well.
+#                            Defaults to 1. (Since 2.6)
+#
+# @bps_rd_max_length: maximum length of the @bps_rd_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_rd_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @bps_wr_max_length: maximum length of the @bps_wr_max
+#                               burst period, in seconds. It must only
+#                               be set if @bps_wr_max is set as well.
+#                               Defaults to 1. (Since 2.6)
+#
+# @iops_max_length: maximum length of the @iops burst
+#                             period, in seconds. It must only
+#                             be set if @iops_max is set as well.
+#                             Defaults to 1. (Since 2.6)
+#
+# @iops_rd_max_length: maximum length of the @iops_rd_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_rd_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_wr_max_length: maximum length of the @iops_wr_max
+#                                burst period, in seconds. It must only
+#                                be set if @iops_wr_max is set as well.
+#                                Defaults to 1. (Since 2.6)
+#
+# @iops_size: an I/O size in bytes (Since 1.7)
+#
+#
+# Since: 2.10
+##
+{ 'struct': 'FS9PIOThrottle',
+  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
+            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
+            '*bps_max': 'int', '*bps_rd_max': 'int',
+            '*bps_wr_max': 'int', '*iops_max': 'int',
+            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
+            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
+            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
+            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
+            '*iops_size': 'int' } }
+
+##
+# @query-9pfs-io-throttle:
+#
+# Return a list of information about each iothread
+#
+# Returns: @FS9PIOIOThrottle
+#
+# Since: 2.10
+#
+# Example:
+#
+# -> { "Execute": "query-9pfs-io-throttle" }
+# <- { "returns" : [
+#          {
+#             "device": "ide0-hd0",
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
+#              "iops_size": 0,
+#            }
+#          ]
+#      }
+#
+##
+{ 'command': 'query-9pfs-io-throttle', 'returns': [ 'FS9PIOThrottle' ] }
+
-- 
1.8.3.1
