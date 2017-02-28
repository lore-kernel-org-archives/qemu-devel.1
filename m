Received: from eggs.gnu.org ([2001:4830:134:3::10]:48745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cifop-0007l2-2e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cifoo-0006IS-23
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:19:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Feb 2017 11:19:35 +0000
Message-Id: <20170228111935.10826-3-stefanha@redhat.com>
In-Reply-To: <20170228111935.10826-1-stefanha@redhat.com>
References: <20170228111935.10826-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] throttle: make
 throttle_config(throttle_get_config()) symmetric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Throttling has a weird property that throttle_get_config() does not
always return the same throttling settings that were given with
throttle_config().  In other words, the set and get functions aren't
symmetric.

If .max is 0 then the throttling code assigns a default value of .avg /
10 in throttle_config().  This is an implementation detail of the
throttling algorithm.  When throttle_get_config() is called the .max
value returned should still be 0.

Users are exposed to this quirk via "info block" or "query-block"
monitor commands.  This has caused confusion because it looks like a bug
when an unexpected value is reported.

This patch hides the .max value adjustment in throttle_get_config() and
updates test-throttle.c appropriately.

Reported-by: Nini Gu <ngu@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-throttle.c |  8 ++++----
 util/throttle.c       | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 363b59a..3d6bb82 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -205,8 +205,8 @@ static void test_config_functions(void)
     orig_cfg.buckets[THROTTLE_OPS_READ].avg  = 69;
     orig_cfg.buckets[THROTTLE_OPS_WRITE].avg = 23;
 
-    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0; /* should be corrected */
-    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 1; /* should not be corrected */
+    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0;
+    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 1;
     orig_cfg.buckets[THROTTLE_BPS_WRITE].max = 120;
 
     orig_cfg.buckets[THROTTLE_OPS_TOTAL].max = 150;
@@ -246,8 +246,8 @@ static void test_config_functions(void)
     g_assert(final_cfg.buckets[THROTTLE_OPS_READ].avg  == 69);
     g_assert(final_cfg.buckets[THROTTLE_OPS_WRITE].avg == 23);
 
-    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 15.3);/* fixed */
-    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 1);   /* not fixed */
+    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 0);
+    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 1);
     g_assert(final_cfg.buckets[THROTTLE_BPS_WRITE].max == 120);
 
     g_assert(final_cfg.buckets[THROTTLE_OPS_TOTAL].max == 150);
diff --git a/util/throttle.c b/util/throttle.c
index 3817d9b..d87b421 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -380,6 +380,16 @@ static void throttle_fix_bucket(LeakyBucket *bkt)
     }
 }
 
+/* undo internal bucket parameter changes (see throttle_fix_bucket()) */
+static void throttle_unfix_bucket(LeakyBucket *bkt)
+{
+    double min = bkt->avg / 10;
+
+    if (bkt->max == min) {
+        bkt->max = 0;
+    }
+}
+
 /* take care of canceling a timer */
 static void throttle_cancel_timer(QEMUTimer *timer)
 {
@@ -420,7 +430,13 @@ void throttle_config(ThrottleState *ts,
  */
 void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg)
 {
+    int i;
+
     *cfg = ts->cfg;
+
+    for (i = 0; i < BUCKETS_COUNT; i++) {
+        throttle_unfix_bucket(&cfg->buckets[i]);
+    }
 }
 
 
-- 
2.9.3
