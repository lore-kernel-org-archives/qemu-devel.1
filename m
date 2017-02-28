Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cieMh-0004Oj-HB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cieMc-0005wR-BP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cieMb-0005wJ-WA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:34 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1S9i0aO018111
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 04:46:32 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vm1wtegp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 04:46:32 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 09:46:29 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 10:46:15 +0100
In-Reply-To: <1488275176-16613-1-git-send-email-groug@kaod.org>
References: <1488275176-16613-1-git-send-email-groug@kaod.org>
Message-Id: <1488275176-16613-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/3] fsdev: add IO throttle support to fsdev
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

This patchset adds the throttle support for the 9p-local driver.
For now this functionality can be enabled only through qemu cli options.
QMP interface and support to other drivers need further extensions.
To make it simple for other 9p drivers, the throttle code has been put in
separate files.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
(pass extra NULL CoMutex * argument to qemu_co_queue_wait(),
 added options to qemu-options.hx, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/Makefile.objs         |   2 +-
 fsdev/file-op-9p.h          |   3 ++
 fsdev/qemu-fsdev-opts.c     |  77 ++++++++++++++++++++++++++++-
 fsdev/qemu-fsdev-throttle.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h |  39 +++++++++++++++
 hw/9pfs/9p-local.c          |   8 +++
 hw/9pfs/9p.c                |   5 ++
 hw/9pfs/cofile.c            |   2 +
 qemu-options.hx             |   7 ++-
 9 files changed, 258 insertions(+), 3 deletions(-)
 create mode 100644 fsdev/qemu-fsdev-throttle.c
 create mode 100644 fsdev/qemu-fsdev-throttle.h

diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
index 1b120a4a7d47..659df6e18767 100644
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
index a56dc8488dfc..0844a403dcd4 100644
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
index 1dd8c7a24c9c..385423f02db6 100644
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
index 000000000000..7ae4e866461b
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
+            qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
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
index 000000000000..e418643ccbea
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
index 7de07e1ba67f..2369b918aa3f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1208,6 +1208,7 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
+    Error *err = NULL;
 
     if (!sec_model) {
         error_report("Security model not specified, local fs needs security model");
@@ -1236,6 +1237,13 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
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
index d99abc46025e..76c9247c777d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3529,6 +3529,10 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
         error_setg(errp, "share path %s is not a directory", fse->path);
         goto out;
     }
+
+    s->ctx.fst = &fse->fst;
+    fsdev_throttle_init(s->ctx.fst);
+
     v9fs_path_free(&path);
 
     rc = 0;
@@ -3549,6 +3553,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     if (s->ops->cleanup) {
         s->ops->cleanup(&s->ctx);
     }
+    fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
     g_free(s->ctx.fs_root);
 }
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 120e2671080b..88791bc327ac 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index bf458f83c32d..82528804c3cc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -744,7 +744,12 @@ ETEXI
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
-    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n",
+    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n"
+    " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
+    " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
+    " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
+    " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
+    " [[,throttling.iops-size=is]]\n",
     QEMU_ARCH_ALL)
 
 STEXI
-- 
2.7.4
