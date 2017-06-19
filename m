Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwU3-00036o-Do
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwU1-0001rT-M3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:47 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dMwU1-0001qf-Ch
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so13434600wrb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 06:12:45 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon, 19 Jun 2017 09:11:34 -0400
Message-Id: <1497877896-35700-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v5 3/5] qmp: refactor duplicate code
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

This patch factor out the duplicate qmp throttle interface code
that was present in both block and fsdev device files.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 blockdev.c                      | 53 +++---------------------------------
 hmp.c                           | 21 ++++++++++-----
 include/qemu/throttle-options.h |  3 +++
 util/throttle.c                 | 60 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5db9e5c..3d06e9e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2593,6 +2593,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    IOThrottle *iothrottle;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2610,56 +2611,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
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
+    throttle_set_io_limits(&cfg, iothrottle);
 
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
diff --git a/hmp.c b/hmp.c
index 8c72c58..220d301 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1749,20 +1749,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
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
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 565553a..e94ea39 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -11,6 +11,7 @@
 #define THROTTLE_OPTIONS_H
 
 #include "qemu/throttle.h"
+#include "qmp-commands.h"
 
 #define THROTTLE_OPTS \
           { \
@@ -93,4 +94,6 @@
 
 void throttle_parse_options(ThrottleConfig *, QemuOpts *);
 
+void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
+
 #endif
diff --git a/util/throttle.c b/util/throttle.c
index ebe9dd0..2cf9ec5 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -27,6 +27,7 @@
 #include "qemu/throttle.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
+#include "qemu/throttle-options.h"
 
 /* This function make a bucket leak
  *
@@ -564,3 +565,62 @@ void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
     throttle_cfg->op_size =
         qemu_opt_get_number(opts, "throttling.iops-size", 0);
 }
+
+/* set the throttle limits
+ *
+ * @arg: iothrottle limits
+ * @cfg: throttle configuration
+ */
+void throttle_set_io_limits(ThrottleConfig *cfg, IOThrottle *arg)
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
