Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dekhK-0000fo-MY
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dekhC-0002jo-8c
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:16:03 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  7 Aug 2017 19:15:29 +0300
Message-Id: <20170807161529.3779-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg and
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Both the throttling limits set with the throttling.iops-* and
throttling.bps-* options and their QMP equivalents defined in the
BlockIOThrottle struct are integer values.

Those limits are also reported in the BlockDeviceInfo struct and they
are integers there as well.

Therefore there's no reason to store them internally as double and do
the conversion everytime we're setting or querying them, so this patch
uses int64_t for those types.

LeakyBucket.level and LeakyBucket.burst_level do however remain double
because their value changes depending on the fraction of time elapsed
since the previous I/O operation.

There's one particular instance of the previous code where bkt->max
could have a non-integer value: that's in throttle_fix_bucket() when
bkt->max is initialized to bkt->avg / 10. This is now an integer
division and the result is rounded. We don't need to worry about this
because:

   a) with the magnitudes we're dealing with (bytes per second, I/O
      operations per second) the limits are likely to be always
      multiples of 10.

   b) even if they weren't this doesn't affect the actual limits, only
      the algorithm that makes the throttling smoother.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/qemu/throttle.h | 4 ++--
 util/throttle.c         | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index d056008c18..ec37ac0fcb 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -77,8 +77,8 @@ typedef enum {
  */
 
 typedef struct LeakyBucket {
-    double  avg;              /* average goal in units per second */
-    double  max;              /* leaky bucket max burst in units */
+    int64_t avg;              /* average goal in units per second */
+    int64_t max;              /* leaky bucket max burst in units */
     double  level;            /* bucket level in units */
     double  burst_level;      /* bucket level in units (for computing bursts) */
     unsigned burst_length;    /* max length of the burst period, in seconds */
diff --git a/util/throttle.c b/util/throttle.c
index b2a52b8b34..7856931f67 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -111,7 +111,7 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
     if (bkt->burst_length > 1) {
         /* We use 1/10 of the max value to smooth the throttling.
          * See throttle_fix_bucket() for more details. */
-        extra = bkt->burst_level - bkt->max / 10;
+        extra = bkt->burst_level - (double) bkt->max / 10;
         if (extra > 0) {
             return throttle_do_compute_wait(bkt->max, extra);
         }
@@ -361,8 +361,6 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp)
 /* fix bucket parameters */
 static void throttle_fix_bucket(LeakyBucket *bkt)
 {
-    double min;
-
     /* zero bucket level */
     bkt->level = bkt->burst_level = 0;
 
@@ -374,9 +372,8 @@ static void throttle_fix_bucket(LeakyBucket *bkt)
      * Having a max burst value of 100ms of the average will help smooth the
      * throttling
      */
-    min = bkt->avg / 10;
     if (bkt->avg && !bkt->max) {
-        bkt->max = min;
+        bkt->max = (bkt->avg + 5) / 10;
     }
 }
 
-- 
2.11.0
