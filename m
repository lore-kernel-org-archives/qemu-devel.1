Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mF-000403-OZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mE-0007CG-TR
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Mar 2017 11:50:26 +0000
Message-Id: <20170301115026.22621-4-stefanha@redhat.com>
In-Reply-To: <20170301115026.22621-1-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] throttle: make
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
 util/throttle.c       | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 8531809..2a8bf64 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -205,8 +205,8 @@ static void test_config_functions(void)
     orig_cfg.buckets[THROTTLE_OPS_READ].avg  = 69;
     orig_cfg.buckets[THROTTLE_OPS_WRITE].avg = 23;
 
-    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0;  /* should be corrected */
-    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 56; /* should not be corrected */
+    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0;
+    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 56;
     orig_cfg.buckets[THROTTLE_BPS_WRITE].max = 120;
 
     orig_cfg.buckets[THROTTLE_OPS_TOTAL].max = 150;
@@ -246,8 +246,8 @@ static void test_config_functions(void)
     g_assert(final_cfg.buckets[THROTTLE_OPS_READ].avg  == 69);
     g_assert(final_cfg.buckets[THROTTLE_OPS_WRITE].avg == 23);
 
-    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 15.3); /* fixed */
-    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 56);   /* not fixed */
+    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 0);
+    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 56);
     g_assert(final_cfg.buckets[THROTTLE_BPS_WRITE].max == 120);
 
     g_assert(final_cfg.buckets[THROTTLE_OPS_TOTAL].max == 150);
diff --git a/util/throttle.c b/util/throttle.c
index 3817d9b..3570ed2 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -380,6 +380,14 @@ static void throttle_fix_bucket(LeakyBucket *bkt)
     }
 }
 
+/* undo internal bucket parameter changes (see throttle_fix_bucket()) */
+static void throttle_unfix_bucket(LeakyBucket *bkt)
+{
+    if (bkt->max < bkt->avg) {
+        bkt->max = 0;
+    }
+}
+
 /* take care of canceling a timer */
 static void throttle_cancel_timer(QEMUTimer *timer)
 {
@@ -420,7 +428,13 @@ void throttle_config(ThrottleState *ts,
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
