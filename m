Received: from eggs.gnu.org ([2001:4830:134:3::10]:41975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JS-GD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003U3-FN
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:47 +0300
Message-Id: <f29b840422767b5be2c41c2dfdbbbf6c5f8fedf8.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 5/7] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

Both the throttling limits set with the throttling.iops-* and
throttling.bps-* options and their QMP equivalents defined in the
BlockIOThrottle struct are integer values.

Those limits are also reported in the BlockDeviceInfo struct and they
are integers there as well.

Therefore there's no reason to store them internally as double and do
the conversion everytime we're setting or querying them, so this patch
uses uint64_t for those types. Let's also use an unsigned type because
we don't allow negative values anyway.

LeakyBucket.level and LeakyBucket.burst_level do however remain double
because their value changes depending on the fraction of time elapsed
since the previous I/O operation.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/qemu/throttle.h | 4 ++--
 tests/test-throttle.c   | 3 ++-
 util/throttle.c         | 7 +++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 66a8ac10a4..6e31155fd4 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -77,8 +77,8 @@ typedef enum {
  */
 
 typedef struct LeakyBucket {
-    double  avg;              /* average goal in units per second */
-    double  max;              /* leaky bucket max burst in units */
+    uint64_t avg;             /* average goal in units per second */
+    uint64_t max;             /* leaky bucket max burst in units */
     double  level;            /* bucket level in units */
     double  burst_level;      /* bucket level in units (for computing bursts) */
     unsigned burst_length;    /* max length of the burst period, in seconds */
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 768f11dfed..41c0dd2529 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -284,13 +284,14 @@ static void test_enabled(void)
     for (i = 0; i < BUCKETS_COUNT; i++) {
         throttle_config_init(&cfg);
         set_cfg_value(false, i, 150);
+        g_assert(throttle_is_valid(&cfg, NULL));
         g_assert(throttle_enabled(&cfg));
     }
 
     for (i = 0; i < BUCKETS_COUNT; i++) {
         throttle_config_init(&cfg);
         set_cfg_value(false, i, -150);
-        g_assert(!throttle_enabled(&cfg));
+        g_assert(!throttle_is_valid(&cfg, NULL));
     }
 }
 
diff --git a/util/throttle.c b/util/throttle.c
index 4e80a7ea54..80660ffd2c 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -106,13 +106,13 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
         /* If bkt->max is 0 we still want to allow short bursts of I/O
          * from the guest, otherwise every other request will be throttled
          * and performance will suffer considerably. */
-        bucket_size = bkt->avg / 10;
+        bucket_size = (double) bkt->avg / 10;
         burst_bucket_size = 0;
     } else {
         /* If we have a burst limit then we have to wait until all I/O
          * at burst rate has finished before throttling to bkt->avg */
         bucket_size = bkt->max * bkt->burst_length;
-        burst_bucket_size = bkt->max / 10;
+        burst_bucket_size = (double) bkt->max / 10;
     }
 
     /* If the main bucket is full then we have to wait */
@@ -338,8 +338,7 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp)
 
     for (i = 0; i < BUCKETS_COUNT; i++) {
         LeakyBucket *bkt = &cfg->buckets[i];
-        if (bkt->avg < 0 || bkt->max < 0 ||
-            bkt->avg > THROTTLE_VALUE_MAX || bkt->max > THROTTLE_VALUE_MAX) {
+        if (bkt->avg > THROTTLE_VALUE_MAX || bkt->max > THROTTLE_VALUE_MAX) {
             error_setg(errp, "bps/iops/max values must be within [0, %lld]",
                        THROTTLE_VALUE_MAX);
             return false;
-- 
2.11.0
