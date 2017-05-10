Received: from eggs.gnu.org ([2001:4830:134:3::10]:46220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d8NCa-0005c4-JB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d8NCZ-0007Dh-78
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:32 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1d8NCY-0007DS-Tr
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:42:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so6323461wrc.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 01:42:30 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Wed, 10 May 2017 04:41:22 -0400
Message-Id: <1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v4 3/4] qmp: refactor duplicate code
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
 blockdev.c                      | 53 +++-------------------------------------
 hmp.c                           | 21 +++++++++++-----
 include/qemu/throttle-options.h |  2 ++
 util/throttle-options.c         | 54 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 56 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a0eb2ed..a55f6be 100644
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
+    qmp_set_io_throttle(&cfg, iothrottle);
 
     if (!throttle_is_valid(&cfg, errp)) {
         goto out;
diff --git a/hmp.c b/hmp.c
index ab407d6..9660373 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1552,20 +1552,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
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
index 9b68eb8..ccf10cc 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -94,4 +94,6 @@
 
 void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);
 
+void qmp_set_io_throttle(ThrottleConfig *, IOThrottle *);
+
 #endif
diff --git a/util/throttle-options.c b/util/throttle-options.c
index 02b26b8..ded57bc 100644
--- a/util/throttle-options.c
+++ b/util/throttle-options.c
@@ -49,3 +49,57 @@ void parse_io_throttle_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
         qemu_opt_get_number(opts, "throttling.iops-size", 0);
 
 }
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
