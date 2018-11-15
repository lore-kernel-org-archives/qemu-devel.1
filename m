Received: from eggs.gnu.org ([2001:4830:134:3::10]:58600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNDWB-0002WQ-Iy
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNDW8-0005LD-86
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:00:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3104 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNDW7-0005FR-C7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:00:52 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Thu, 15 Nov 2018 16:54:53 +0800
Message-ID: <0fcad1d4a27bcf9066d3349e8f1a8af6dfe3bb6e.1542301855.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542301855.git.xiezhide@huawei.com>
References: <cover.1542301855.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/4] fsdev-throttle-qmp: factor out throttle
 code to reuse code
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

This patch factor out throttle parameter parse code to common function
which will be used by block and fsdev.
rename function throttle_parse_options to throttle_parse_group to resolve
function name conflict

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 block/throttle.c                |  6 ++--
 blockdev.c                      | 43 +-------------------------
 fsdev/qemu-fsdev-throttle.c     | 44 ++------------------------
 include/qemu/throttle-options.h |  2 ++
 include/qemu/throttle.h         |  4 +--
 include/qemu/typedefs.h         |  1 +
 util/throttle.c                 | 68 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 89 deletions(-)

diff --git a/block/throttle.c b/block/throttle.c
index 636c976..bd23c58 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -41,7 +41,7 @@ static QemuOptsList throttle_opts = {
  * @group and must be freed by the caller.
  * If there's an error then @group remains unmodified.
  */
-static int throttle_parse_options(QDict *options, char **group, Error **errp)
+static int throttle_parse_group(QDict *options, char **group, Error **errp)
 {
     int ret;
     const char *group_name;
@@ -90,7 +90,7 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
     bs->supported_zero_flags = bs->file->bs->supported_zero_flags |
                                BDRV_REQ_WRITE_UNCHANGED;
 
-    ret = throttle_parse_options(options, &group, errp);
+    ret = throttle_parse_group(options, &group, errp);
     if (ret == 0) {
         /* Register membership to group with name group_name */
         throttle_group_register_tgm(tgm, group, bdrv_get_aio_context(bs));
@@ -179,7 +179,7 @@ static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
     assert(reopen_state != NULL);
     assert(reopen_state->bs != NULL);
 
-    ret = throttle_parse_options(reopen_state->options, &group, errp);
+    ret = throttle_parse_group(reopen_state->options, &group, errp);
     reopen_state->opaque = group;
     return ret;
 }
diff --git a/blockdev.c b/blockdev.c
index 81f95d9..fce5d8f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -400,48 +400,7 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
     }
 
     if (throttle_cfg) {
-        throttle_config_init(throttle_cfg);
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
-            qemu_opt_get_number(opts, "throttling.bps-total", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =
-            qemu_opt_get_number(opts, "throttling.bps-read", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =
-            qemu_opt_get_number(opts, "throttling.bps-write", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =
-            qemu_opt_get_number(opts, "throttling.iops-total", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =
-            qemu_opt_get_number(opts, "throttling.iops-read", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =
-            qemu_opt_get_number(opts, "throttling.iops-write", 0);
-
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =
-            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =
-            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =
-            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =
-            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].max =
-            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =
-            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
-
-        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
-            qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
-        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
-            qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
-        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
-            qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
-        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
-            qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
-        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
-            qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
-        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
-            qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
-
-        throttle_cfg->op_size =
-            qemu_opt_get_number(opts, "throttling.iops-size", 0);
+        throttle_parse_options(throttle_cfg, opts);
 
         if (!throttle_is_valid(throttle_cfg, errp)) {
             return;
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index cfd8641..6a4108a 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -17,6 +17,7 @@
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
+#include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
@@ -32,48 +33,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
 
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
 {
-    throttle_config_init(&fst->cfg);
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =
-        qemu_opt_get_number(opts, "throttling.bps-total", 0);
-    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =
-        qemu_opt_get_number(opts, "throttling.bps-read", 0);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =
-        qemu_opt_get_number(opts, "throttling.bps-write", 0);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =
-        qemu_opt_get_number(opts, "throttling.iops-total", 0);
-    fst->cfg.buckets[THROTTLE_OPS_READ].avg =
-        qemu_opt_get_number(opts, "throttling.iops-read", 0);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =
-        qemu_opt_get_number(opts, "throttling.iops-write", 0);
-
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =
-        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
-    fst->cfg.buckets[THROTTLE_BPS_READ].max  =
-        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =
-        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =
-        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_READ].max =
-        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =
-        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
-
-    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =
-        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
-    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =
-        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
-    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =
-        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
-    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =
-        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
-    fst->cfg.op_size =
-        qemu_opt_get_number(opts, "throttling.iops-size", 0);
-
+    throttle_parse_options(&fst->cfg, opts);
     throttle_is_valid(&fst->cfg, errp);
 }
 
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 3528a8f..944a08c 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -111,4 +111,6 @@
             .help = "when limiting by iops max size of an I/O in bytes",\
         }
 
+void throttle_parse_options(ThrottleConfig *, QemuOpts *);
+
 #endif
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index abeb886..f379d91 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -90,10 +90,10 @@ typedef struct LeakyBucket {
  * However it allows to keep the code clean and the bucket field is reset to
  * zero at the right time.
  */
-typedef struct ThrottleConfig {
+struct ThrottleConfig {
     LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
     uint64_t op_size;         /* size of an operation in bytes */
-} ThrottleConfig;
+};
 
 typedef struct ThrottleState {
     ThrottleConfig cfg;       /* configuration */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3ec0e13..1d335aa 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -113,6 +113,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+typedef struct ThrottleConfig ThrottleConfig;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
diff --git a/util/throttle.c b/util/throttle.c
index b38e742..e7db2ad 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -27,6 +27,8 @@
 #include "qemu/throttle.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
+#include "qemu/option.h"
+#include "qemu/throttle-options.h"
 
 /* This function make a bucket leak
  *
@@ -636,3 +638,69 @@ void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var)
     var->has_iops_write_max_length = true;
     var->has_iops_size = true;
 }
+
+/* parse the throttle options
+ *
+ * @opts: qemu options
+ * @throttle_cfg: throttle configuration
+ */
+void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
+{
+    throttle_config_init(throttle_cfg);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].max =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE_MAX, 0);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                            QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
+    throttle_cfg->op_size =
+        qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE, 0);
+}
-- 
1.8.3.1
