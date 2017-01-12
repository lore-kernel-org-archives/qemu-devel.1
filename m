Received: from eggs.gnu.org ([2001:4830:134:3::10]:40004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cRg6r-0001f4-IV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cRg6g-0006EN-Sd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:12:09 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1cRg6g-0006Dz-JI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:11:58 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so3966280wmr.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:11:58 -0800 (PST)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 12 Jan 2017 09:11:13 -0500
Message-Id: <1484230273-4597-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH V12] fsdev: add IO throttle support to fsdev
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 fsdev/Makefile.objs         |   2 +-
 fsdev/file-op-9p.h          |   3 ++
 fsdev/qemu-fsdev-opts.c     |  77 ++++++++++++++++++++++++++++-
 fsdev/qemu-fsdev-throttle.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h |  39 +++++++++++++++
 hw/9pfs/9p-local.c          |   8 +++
 hw/9pfs/9p.c                |   5 ++
 hw/9pfs/cofile.c            |   2 +
 8 files changed, 252 insertions(+), 2 deletions(-)
 create mode 100644 fsdev/qemu-fsdev-throttle.c
 create mode 100644 fsdev/qemu-fsdev-throttle.h

This adds the support for the 9p-local driver.
For now this functionality can be enabled only through qemu cli options.
QMP interface and support to other drivers need further extensions.
To make it simple for other drivers, the throttle code has been put in
separate files.

v1 -> v2:

-Fixed FsContext redeclaration issue
-Removed couple of function declarations from 9p-throttle.h
-Fixed some of the .help messages

v2 -> v3:

-Addressed follwing comments by Claudio Fontana
 -Removed redundant memset calls in fsdev_throttle_configure_iolimits function
 -Checking throttle structure validity before initializing other structures
  in fsdev_throttle_configure_iolimits

-Addressed following comments by Greg Kurz
 -Moved the code from 9pfs directory to fsdev directory, because the throttling
  is for the fsdev devices.Renamed the files and functions to fsdev_ from 9pfs_
 -Renamed throttling cli options to throttling.*, as in QMP cli options
 -Removed some of the unwanted .h files from qemu-fsdev-throttle.[ch]
 -Using throttle_enabled() function to set the thottle enabled flag for fsdev.

v3 -> v4:

-Addressed following comments by Alberto Garcia
 -Removed the unwanted locking and other data structures in qemu-fsdev-throttle.[ch]

-Addressed following comments by Greg Kurz
 -Removed fsdev_iolimitsenable/disable functions, instead using throttle_enabled function

v4 -> V5:
 -Fixed the issue with the larger block size accounting.
 (i.e, when the 9pfs mounted using msize=xxx option)

V5 -> V6:
-Addressed the comments by Alberto Garcia
 -Removed the fsdev_throttle_timer_cb()
 -Simplified the  fsdev_throttle_schedule_next_request() as suggested

V6 -> V7:
-Addressed the comments by Alberto Garcia
 -changed the  fsdev_throttle_schedule_next_request() as suggested

v7 -> v8:
-Addressed comments by Alberto Garcia
 -Fixed some indentation issues and split the configure_io_limit function
 -Inlined throttle_timer_check code

V8 -> v9:
-Addressed the comments by Greg Kurz
 -Inlined the fsdev_throttle_schedule_next_request() code into 
  fsdev_co_throttle_request ()

v9 -> v10:
-Addressed the comments by alberto garcia
 -fixed the indentation issues and minor issues

v10 -> v11:
-Addressed the comments by alberto garcia
 -renamed err variable to errp issues

v11 -> v12:
-Addressed the comments by Greg Kurz 
  -fixed the missing throttle_config_init() function call

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 1b120a4..659df6e 100644
--- a/fsdev/Makefile.objs
+++ b/fsdev/Makefile.objs
@@ -5,7 +5,7 @@ common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
 else
 common-obj-y = qemu-fsdev-dummy.o
 endif
-common-obj-y += qemu-fsdev-opts.o
+common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
 
 # Toplevel always builds this; targets without virtio will put it in
 # common-obj-y
diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 6db9fea..33fe822 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -17,6 +17,7 @@
 #include <dirent.h>
 #include <utime.h>
 #include <sys/vfs.h>
+#include "qemu-fsdev-throttle.h"
 
 #define SM_LOCAL_MODE_BITS    0600
 #define SM_LOCAL_DIR_MODE_BITS    0700
@@ -74,6 +75,7 @@ typedef struct FsDriverEntry {
     char *path;
     int export_flags;
     FileOperations *ops;
+    FsThrottle fst;
 } FsDriverEntry;
 
 typedef struct FsContext
@@ -83,6 +85,7 @@ typedef struct FsContext
     int export_flags;
     struct xattr_operations **xops;
     struct extended_ops exops;
+    FsThrottle *fst;
     /* fs driver specific data */
     void *private;
 } FsContext;
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 1dd8c7a..385423f0 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -37,8 +37,83 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "throttling.iops-total",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit total I/O operations per second",
+        }, {
+            .name = "throttling.iops-read",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit read operations per second",
+        }, {
+            .name = "throttling.iops-write",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit write operations per second",
+        }, {
+            .name = "throttling.bps-total",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit total bytes per second",
+        }, {
+            .name = "throttling.bps-read",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit read bytes per second",
+        }, {
+            .name = "throttling.bps-write",
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit write bytes per second",
+        }, {
+            .name = "throttling.iops-total-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations burst",
+        }, {
+            .name = "throttling.iops-read-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations read burst",
+        }, {
+            .name = "throttling.iops-write-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations write burst",
+        }, {
+            .name = "throttling.bps-total-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes burst",
+        }, {
+            .name = "throttling.bps-read-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes read burst",
+        }, {
+            .name = "throttling.bps-write-max",
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes write burst",
+        }, {
+            .name = "throttling.iops-total-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iops-total-max burst period, in seconds",
+        }, {
+            .name = "throttling.iops-read-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iops-read-max burst period, in seconds",
+        }, {
+            .name = "throttling.iops-write-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iops-write-max burst period, in seconds",
+        }, {
+            .name = "throttling.bps-total-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bps-total-max burst period, in seconds",
+        }, {
+            .name = "throttling.bps-read-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bps-read-max burst period, in seconds",
+        }, {
+            .name = "throttling.bps-write-max-length",
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bps-write-max burst period, in seconds",
+        }, {
+            .name = "throttling.iops-size",
+            .type = QEMU_OPT_NUMBER,
+            .help = "when limiting by iops max size of an I/O in bytes",
         },
-
         { /*End of list */ }
     },
 };
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
new file mode 100644
index 0000000..feb9af3
--- /dev/null
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -0,0 +1,118 @@
+/*
+ * Fsdev Throttle
+ *
+ * Copyright (C) 2016 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu-fsdev-throttle.h"
+#include "qemu/iov.h"
+
+static void fsdev_throttle_read_timer_cb(void *opaque)
+{
+    FsThrottle *fst = opaque;
+    qemu_co_enter_next(&fst->throttled_reqs[false]);
+}
+
+static void fsdev_throttle_write_timer_cb(void *opaque)
+{
+    FsThrottle *fst = opaque;
+    qemu_co_enter_next(&fst->throttled_reqs[true]);
+}
+
+void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
+{
+    throttle_config_init(&fst->cfg);
+    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =
+        qemu_opt_get_number(opts, "throttling.bps-total", 0);
+    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =
+        qemu_opt_get_number(opts, "throttling.bps-read", 0);
+    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =
+        qemu_opt_get_number(opts, "throttling.bps-write", 0);
+    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =
+        qemu_opt_get_number(opts, "throttling.iops-total", 0);
+    fst->cfg.buckets[THROTTLE_OPS_READ].avg =
+        qemu_opt_get_number(opts, "throttling.iops-read", 0);
+    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =
+        qemu_opt_get_number(opts, "throttling.iops-write", 0);
+
+    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =
+        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
+    fst->cfg.buckets[THROTTLE_BPS_READ].max  =
+        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
+    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =
+        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
+    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =
+        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
+    fst->cfg.buckets[THROTTLE_OPS_READ].max =
+        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
+    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =
+        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
+
+    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
+    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =
+        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
+    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
+    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
+    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
+    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
+    fst->cfg.op_size =
+        qemu_opt_get_number(opts, "throttling.iops-size", 0);
+
+    throttle_is_valid(&fst->cfg, errp);
+}
+
+void fsdev_throttle_init(FsThrottle *fst)
+{
+    if (throttle_enabled(&fst->cfg)) {
+        throttle_init(&fst->ts);
+        throttle_timers_init(&fst->tt,
+                             qemu_get_aio_context(),
+                             QEMU_CLOCK_REALTIME,
+                             fsdev_throttle_read_timer_cb,
+                             fsdev_throttle_write_timer_cb,
+                             fst);
+        throttle_config(&fst->ts, &fst->tt, &fst->cfg);
+        qemu_co_queue_init(&fst->throttled_reqs[0]);
+        qemu_co_queue_init(&fst->throttled_reqs[1]);
+    }
+}
+
+void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
+                                            struct iovec *iov, int iovcnt)
+{
+    if (throttle_enabled(&fst->cfg)) {
+        if (throttle_schedule_timer(&fst->ts, &fst->tt, is_write) ||
+            !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
+            qemu_co_queue_wait(&fst->throttled_reqs[is_write]);
+        }
+
+        throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
+
+        if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
+            !throttle_schedule_timer(&fst->ts, &fst->tt, is_write)) {
+            qemu_co_queue_next(&fst->throttled_reqs[is_write]);
+        }
+    }
+}
+
+void fsdev_throttle_cleanup(FsThrottle *fst)
+{
+    if (throttle_enabled(&fst->cfg)) {
+        throttle_timers_destroy(&fst->tt);
+    }
+}
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
new file mode 100644
index 0000000..e418643
--- /dev/null
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -0,0 +1,39 @@
+/*
+ * Fsdev Throttle
+ *
+ * Copyright (C) 2016 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ */
+
+#ifndef _FSDEV_THROTTLE_H
+#define _FSDEV_THROTTLE_H
+
+#include "block/aio.h"
+#include "qemu/main-loop.h"
+#include "qemu/coroutine.h"
+#include "qapi/error.h"
+#include "qemu/throttle.h"
+
+typedef struct FsThrottle {
+    ThrottleState ts;
+    ThrottleTimers tt;
+    ThrottleConfig cfg;
+    CoQueue      throttled_reqs[2];
+} FsThrottle;
+
+void fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
+
+void fsdev_throttle_init(FsThrottle *);
+
+void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
+                                            struct iovec *, int);
+
+void fsdev_throttle_cleanup(FsThrottle *);
+#endif /* _FSDEV_THROTTLE_H */
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 845675e..828348d 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1209,6 +1209,7 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
+    Error *err = NULL;
 
     if (!sec_model) {
         error_report("Security model not specified, local fs needs security model");
@@ -1237,6 +1238,13 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
         error_report("fsdev: No path specified");
         return -1;
     }
+
+    fsdev_throttle_parse_opts(opts, &fse->fst, &err);
+    if (err) {
+        error_reportf_err(err, "Throttle configuration is not valid: ");
+        return -1;
+    }
+
     fse->path = g_strdup(path);
 
     return 0;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e88cf25..8d46a91 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3506,6 +3506,10 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
         error_setg(errp, "share path %s is not a directory", fse->path);
         goto out;
     }
+
+    s->ctx.fst = &fse->fst;
+    fsdev_throttle_init(s->ctx.fst);
+
     v9fs_path_free(&path);
 
     rc = 0;
@@ -3520,6 +3524,7 @@ out:
 
 void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
 {
+    fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->ctx.fs_root);
     g_free(s->tag);
 }
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 120e267..88791bc 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -247,6 +247,7 @@ int coroutine_fn v9fs_co_pwritev(V9fsPDU *pdu, V9fsFidState *fidp,
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
+    fsdev_co_throttle_request(s->ctx.fst, true, iov, iovcnt);
     v9fs_co_run_in_worker(
         {
             err = s->ops->pwritev(&s->ctx, &fidp->fs, iov, iovcnt, offset);
@@ -266,6 +267,7 @@ int coroutine_fn v9fs_co_preadv(V9fsPDU *pdu, V9fsFidState *fidp,
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
+    fsdev_co_throttle_request(s->ctx.fst, false, iov, iovcnt);
     v9fs_co_run_in_worker(
         {
             err = s->ops->preadv(&s->ctx, &fidp->fs, iov, iovcnt, offset);
-- 
1.8.3.1
