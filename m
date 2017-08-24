Received: from eggs.gnu.org ([2001:4830:134:3::10]:41976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JT-GH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003Tp-Eu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:46 +0300
Message-Id: <5b0b9e1ac6eb208d709eddc7b09e7669a523bff3.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 4/7] throttle: Remove throttle_fix_bucket()
 / throttle_unfix_bucket()
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

The throttling code can change internally the value of bkt->max if it
hasn't been set by the user. The problem with this is that if we want
to retrieve the original value we have to undo this change first. This
is ugly and unnecessary: this patch removes the throttle_fix_bucket()
and throttle_unfix_bucket() functions completely and moves the logic
to throttle_compute_wait().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 util/throttle.c | 62 +++++++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index bde56fe3de..4e80a7ea54 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -95,23 +95,36 @@ static int64_t throttle_do_compute_wait(double limit, double extra)
 int64_t throttle_compute_wait(LeakyBucket *bkt)
 {
     double extra; /* the number of extra units blocking the io */
+    double bucket_size;   /* I/O before throttling to bkt->avg */
+    double burst_bucket_size; /* Before throttling to bkt->max */
 
     if (!bkt->avg) {
         return 0;
     }
 
-    /* If the bucket is full then we have to wait */
-    extra = bkt->level - bkt->max * bkt->burst_length;
+    if (!bkt->max) {
+        /* If bkt->max is 0 we still want to allow short bursts of I/O
+         * from the guest, otherwise every other request will be throttled
+         * and performance will suffer considerably. */
+        bucket_size = bkt->avg / 10;
+        burst_bucket_size = 0;
+    } else {
+        /* If we have a burst limit then we have to wait until all I/O
+         * at burst rate has finished before throttling to bkt->avg */
+        bucket_size = bkt->max * bkt->burst_length;
+        burst_bucket_size = bkt->max / 10;
+    }
+
+    /* If the main bucket is full then we have to wait */
+    extra = bkt->level - bucket_size;
     if (extra > 0) {
         return throttle_do_compute_wait(bkt->avg, extra);
     }
 
-    /* If the bucket is not full yet we have to make sure that we
-     * fulfill the goal of bkt->max units per second. */
+    /* If the main bucket is not full yet we still have to check the
+     * burst bucket in order to enforce the burst limit */
     if (bkt->burst_length > 1) {
-        /* We use 1/10 of the max value to smooth the throttling.
-         * See throttle_fix_bucket() for more details. */
-        extra = bkt->burst_level - bkt->max / 10;
+        extra = bkt->burst_level - burst_bucket_size;
         if (extra > 0) {
             return throttle_do_compute_wait(bkt->max, extra);
         }
@@ -357,31 +370,6 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp)
     return true;
 }
 
-/* fix bucket parameters */
-static void throttle_fix_bucket(LeakyBucket *bkt)
-{
-    double min;
-
-    /* zero bucket level */
-    bkt->level = bkt->burst_level = 0;
-
-    /* If bkt->max is 0 we still want to allow short bursts of I/O
-     * from the guest, otherwise every other request will be throttled
-     * and performance will suffer considerably. */
-    min = bkt->avg / 10;
-    if (bkt->avg && !bkt->max) {
-        bkt->max = min;
-    }
-}
-
-/* undo internal bucket parameter changes (see throttle_fix_bucket()) */
-static void throttle_unfix_bucket(LeakyBucket *bkt)
-{
-    if (bkt->max < bkt->avg) {
-        bkt->max = 0;
-    }
-}
-
 /* Used to configure the throttle
  *
  * @ts: the throttle state we are working on
@@ -396,8 +384,10 @@ void throttle_config(ThrottleState *ts,
 
     ts->cfg = *cfg;
 
+    /* Zero bucket level */
     for (i = 0; i < BUCKETS_COUNT; i++) {
-        throttle_fix_bucket(&ts->cfg.buckets[i]);
+        ts->cfg.buckets[i].level = 0;
+        ts->cfg.buckets[i].burst_level = 0;
     }
 
     ts->previous_leak = qemu_clock_get_ns(clock_type);
@@ -410,13 +400,7 @@ void throttle_config(ThrottleState *ts,
  */
 void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg)
 {
-    int i;
-
     *cfg = ts->cfg;
-
-    for (i = 0; i < BUCKETS_COUNT; i++) {
-        throttle_unfix_bucket(&cfg->buckets[i]);
-    }
 }
 
 
-- 
2.11.0
