Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dQb6Y-000061-LJ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dQb6S-00031B-C6
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:38 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dQb6S-00030u-37
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:11:32 -0400
Received: by mail-wr0-x243.google.com with SMTP id k67so36931845wrc.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 08:11:32 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 29 Jun 2017 11:10:53 -0400
Message-Id: <1498749056-38565-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH 3/6] throttle: move out function to reuse the
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch move out the throttle code to util/throttle.c to maximize
the reusability of the code.The same code is also used by fsdev.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 blockdev.c                      | 53 +++---------------------------------
 include/qemu/throttle-options.h |  4 +++
 util/throttle.c                 | 59 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a95ea41..8090798 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2579,6 +2579,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     BlockDriverState *bs;
     BlockBackend *blk;
     AioContext *aio_context;
+    IOThrottle *iothrottle;
 
     blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
                       arg->has_id ? arg->id : NULL,
@@ -2596,56 +2597,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
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
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 659a410..ac4f221 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,6 +10,8 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
 
+#include "qmp-commands.h"
+
 #define THROTTLE_OPTS \
           { \
             .name = "throttling.iops-total",\
@@ -91,4 +93,6 @@
 
 void throttle_parse_options(ThrottleConfig *, QemuOpts *);
 
+void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
+
 #endif
diff --git a/util/throttle.c b/util/throttle.c
index a751126..2cf9ec5 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -565,3 +565,62 @@ void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
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
