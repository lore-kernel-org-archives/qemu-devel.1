Received: from eggs.gnu.org ([2001:4830:134:3::10]:50287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwU2-00035t-9x
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dMwTz-0001qC-P2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:46 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dMwTz-0001pL-Fb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:12:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id 77so13435894wrb.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 06:12:43 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon, 19 Jun 2017 09:11:32 -0400
Message-Id: <1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v5 1/5] throttle: factor out duplicate code
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

This patch factor out the duplicate throttle code that was present in
block and fsdev devices.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 blockdev.c                      | 44 +-----------------------------------
 fsdev/qemu-fsdev-throttle.c     | 43 +----------------------------------
 fsdev/qemu-fsdev-throttle.h     |  1 +
 include/qemu/throttle-options.h |  4 ++++
 util/throttle.c                 | 50 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 85 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6472548..5db9e5c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -386,49 +386,7 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
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
index 7ae4e86..da9c225 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -31,48 +31,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
 
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
 
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index e418643..c493e83 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -20,6 +20,7 @@
 #include "qemu/coroutine.h"
 #include "qapi/error.h"
 #include "qemu/throttle.h"
+#include "qemu/throttle-options.h"
 
 typedef struct FsThrottle {
     ThrottleState ts;
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 3133d1c..565553a 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,6 +10,8 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
 
+#include "qemu/throttle.h"
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
diff --git a/util/throttle.c b/util/throttle.c
index 3570ed2..ebe9dd0 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -514,3 +514,53 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
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
