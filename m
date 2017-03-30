Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYup-00067i-3x
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYun-0007LE-Cq
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:59 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1ctYun-0007Jv-1A
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:57 -0400
Received: by mail-wr0-x241.google.com with SMTP id u18so11549642wrc.0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 05:10:57 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 30 Mar 2017 08:10:12 -0400
Message-Id: <1490875813-35588-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v2 3/4] qmp: refactor duplicate code
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

This patchset factor out the duplicate qmp throttle interface code
that was present in both block and fsdev device files.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 blockdev.c                      | 53 +++----------------------------------
 fsdev/qemu-fsdev-throttle.c     | 51 +-----------------------------------
 fsdev/qemu-fsdev.c              |  1 -
 hmp.c                           | 34 ++++++++++++------------
 include/qemu/throttle-options.h |  5 ++++
 util/Makefile.objs              |  1 +
 util/throttle-options.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 118 deletions(-)
 create mode 100644 util/throttle-options.c

diff --git a/blockdev.c b/blockdev.c
index c5b2c2c..3114dc5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2635,6 +2635,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    IOThrottle *iothrottle;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2652,56 +2653,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         goto out;
     }
 
-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size = arg->iops_size;
-    }
+    iothrottle = qapi_BlockIOThrottle_base(arg);
+    qmp_set_io_throttle(&cfg, iothrottle);
 
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 43dbcd8..cd653af 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -33,56 +33,7 @@ void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **errp)
 {
     ThrottleConfig cfg;
 
-    throttle_config_init(&cfg);
-    cfg.buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
-    cfg.buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
-    cfg.buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
-
-    cfg.buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
-    cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
-    cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
-
-    if (arg->has_bps_max) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
-    }
-    if (arg->has_bps_rd_max) {
-        cfg.buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
-    }
-    if (arg->has_bps_wr_max) {
-        cfg.buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
-    }
-    if (arg->has_iops_max) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
-    }
-    if (arg->has_iops_rd_max) {
-        cfg.buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
-    }
-    if (arg->has_iops_wr_max) {
-        cfg.buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
-    }
-
-    if (arg->has_bps_max_length) {
-        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
-    }
-    if (arg->has_bps_rd_max_length) {
-        cfg.buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
-    }
-    if (arg->has_bps_wr_max_length) {
-        cfg.buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
-    }
-    if (arg->has_iops_max_length) {
-        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
-    }
-    if (arg->has_iops_rd_max_length) {
-        cfg.buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
-    }
-    if (arg->has_iops_wr_max_length) {
-        cfg.buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
-    }
-
-    if (arg->has_iops_size) {
-        cfg.op_size = arg->iops_size;
-    }
+    qmp_set_io_throttle(&cfg, arg);
 
     if (throttle_is_valid(&cfg, errp)) {
         fst->cfg = cfg;
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index a99e299..8c078b1 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -102,7 +102,6 @@ FsDriverEntry *get_fsdev_fsentry(char *id)
 
 void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
 {
-
     FsDriverEntry *fse;
 
     fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
diff --git a/hmp.c b/hmp.c
index 493f48b..cafe595 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1554,20 +1554,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdict)
+{
+    iot->has_id = true;
+    iot->id = (char *) qdict_get_str(qdict, "id");
+    iot->bps = qdict_get_int(qdict, "bps");
+    iot->bps_rd = qdict_get_int(qdict, "bps_rd");
+    iot->bps_wr = qdict_get_int(qdict, "bps_wr");
+    iot->iops = qdict_get_int(qdict, "iops");
+    iot->iops_rd = qdict_get_int(qdict, "iops_rd");
+    iot->iops_wr = qdict_get_int(qdict, "iops_wr");
+}
+
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    IOThrottle *iothrottle;
     BlockIOThrottle throttle = {
         .has_device = true,
         .device = (char *) qdict_get_str(qdict, "device"),
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
     };
 
+    iothrottle = qapi_BlockIOThrottle_base(&throttle);
+    hmp_initialize_io_throttle(iothrottle, qdict);
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
@@ -1577,17 +1586,8 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    IOThrottle throttle = {
-        .has_id = true,
-        .id = (char *) qdict_get_str(qdict, "id"),
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
-    };
-
+    IOThrottle throttle;
+    hmp_initialize_io_throttle(&throttle, qdict);
     qmp_fsdev_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 3133d1c..ca0fd7d 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,6 +10,9 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
 
+#include "qemu/throttle.h"
+#include "qmp-commands.h"
+
 #define THROTTLE_OPTS \
           { \
             .name = "throttling.iops-total",\
@@ -89,4 +92,6 @@
             .help = "when limiting by iops max size of an I/O in bytes",\
         }
 
+void qmp_set_io_throttle(ThrottleConfig *, IOThrottle *);
+
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205eb..7119ce0 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -43,3 +43,4 @@ util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += systemd.o
+util-obj-y += throttle-options.o
diff --git a/util/throttle-options.c b/util/throttle-options.c
new file mode 100644
index 0000000..47cffed
--- /dev/null
+++ b/util/throttle-options.c
@@ -0,0 +1,58 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/throttle-options.h"
+#include "qemu/iov.h"
+
+void qmp_set_io_throttle(ThrottleConfig *cfg, IOThrottle *arg)
+{
+    throttle_config_init(cfg);
+    cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
+    cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
+    cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
+
+    cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
+    cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
+    cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
+
+    if (arg->has_bps_max) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
+    }
+    if (arg->has_bps_rd_max) {
+        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
+    }
+    if (arg->has_bps_wr_max) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
+    }
+    if (arg->has_iops_max) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
+    }
+    if (arg->has_iops_rd_max) {
+        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
+    }
+    if (arg->has_iops_wr_max) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
+    }
+
+    if (arg->has_bps_max_length) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
+    }
+    if (arg->has_bps_rd_max_length) {
+        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
+    }
+    if (arg->has_bps_wr_max_length) {
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
+    }
+    if (arg->has_iops_max_length) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
+    }
+    if (arg->has_iops_rd_max_length) {
+        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
+    }
+    if (arg->has_iops_wr_max_length) {
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
+    }
+
+    if (arg->has_iops_size) {
+        cfg->op_size = arg->iops_size;
+    }
+}
-- 
1.8.3.1
