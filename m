Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dmhR1-0001iu-Rm
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dmhQv-0004Di-H9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:07 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dmhQv-0004Cr-7D
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:24:01 -0400
Received: by mail-wr0-x241.google.com with SMTP id a47so2408389wra.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 07:23:59 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Tue, 29 Aug 2017 10:23:02 -0400
Message-Id: <1504016587-39779-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v8 1/6] throttle: factor out duplicate code
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

This patch factor out the duplicate throttle code that was present in
block and fsdev devices.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 blockdev.c                      | 44 +----------------------------------
 fsdev/qemu-fsdev-throttle.c     | 44 ++---------------------------------
 include/qemu/throttle-options.h |  4 ++++
 include/qemu/throttle.h         |  4 ++--
 include/qemu/typedefs.h         |  1 +
 util/throttle.c                 | 51 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 87 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 02cd69b..780ae58 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -388,49 +388,7 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
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
-
+        throttle_parse_options(throttle_cfg, opts);
         if (!throttle_is_valid(throttle_cfg, errp)) {
             return;
         }
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 49eebb5..0e6fb86 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
+#include "qemu/throttle-options.h"
 
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
@@ -31,48 +32,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
 
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
index 3133d1c..f63d38c 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,6 +10,8 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
 
+#include "typedefs.h"
+
 #define THROTTLE_OPTS \
           { \
             .name = "throttling.iops-total",\
@@ -89,4 +91,6 @@
             .help = "when limiting by iops max size of an I/O in bytes",\
         }
 
+void throttle_parse_options(ThrottleConfig *, QemuOpts *);
+
 #endif
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index d056008..75d930c 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -89,10 +89,10 @@ typedef struct LeakyBucket {
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
index 39bc835..90fe0f9 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+typedef struct ThrottleConfig ThrottleConfig;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
diff --git a/util/throttle.c b/util/throttle.c
index b2a52b8..95c2ecf 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -27,6 +27,7 @@
 #include "qemu/throttle.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
+#include "qemu/throttle-options.h"
 
 /* This function make a bucket leak
  *
@@ -502,3 +503,53 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
     }
 }
 
+/* parse the throttle options
+ *
+ * @opts: qemu options
+ * @throttle_cfg: throttle configuration
+ */
+void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
+{
+    throttle_config_init(throttle_cfg);
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =
+        qemu_opt_get_number(opts, "throttling.bps-total", 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =
+        qemu_opt_get_number(opts, "throttling.bps-read", 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =
+        qemu_opt_get_number(opts, "throttling.bps-write", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =
+        qemu_opt_get_number(opts, "throttling.iops-total", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =
+        qemu_opt_get_number(opts, "throttling.iops-read", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =
+        qemu_opt_get_number(opts, "throttling.iops-write", 0);
+
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =
+        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =
+        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =
+        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =
+        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].max =
+        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =
+        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
+
+    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
+    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =
+        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
+    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
+    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
+    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
+    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
+        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
+
+    throttle_cfg->op_size =
+        qemu_opt_get_number(opts, "throttling.iops-size", 0);
+}
-- 
1.8.3.1
