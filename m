Received: from eggs.gnu.org ([2001:4830:134:3::10]:42467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkB-0005Ih-Mi
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkA-0005rP-PW
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKkA-0005qJ-KV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:21:59 +0100
Message-Id: <20170831082210.8362-5-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 04/15] throttle: Make
 throttle_is_valid() a bit less verbose
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alberto Garcia <berto@igalia.com>

Use a pointer to the bucket instead of repeating cfg->buckets[i] all
the time. This makes the code more concise and will help us expand the
checks later and save a few line breaks.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/throttle.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index 9a6bda813c..bde56fe3de 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -324,32 +324,31 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp)
     }
 
     for (i = 0; i < BUCKETS_COUNT; i++) {
-        if (cfg->buckets[i].avg < 0 ||
-            cfg->buckets[i].max < 0 ||
-            cfg->buckets[i].avg > THROTTLE_VALUE_MAX ||
-            cfg->buckets[i].max > THROTTLE_VALUE_MAX) {
+        LeakyBucket *bkt = &cfg->buckets[i];
+        if (bkt->avg < 0 || bkt->max < 0 ||
+            bkt->avg > THROTTLE_VALUE_MAX || bkt->max > THROTTLE_VALUE_MAX) {
             error_setg(errp, "bps/iops/max values must be within [0, %lld]",
                        THROTTLE_VALUE_MAX);
             return false;
         }
 
-        if (!cfg->buckets[i].burst_length) {
+        if (!bkt->burst_length) {
             error_setg(errp, "the burst length cannot be 0");
             return false;
         }
 
-        if (cfg->buckets[i].burst_length > 1 && !cfg->buckets[i].max) {
+        if (bkt->burst_length > 1 && !bkt->max) {
             error_setg(errp, "burst length set without burst rate");
             return false;
         }
 
-        if (cfg->buckets[i].max && !cfg->buckets[i].avg) {
+        if (bkt->max && !bkt->avg) {
             error_setg(errp, "bps_max/iops_max require corresponding"
                        " bps/iops values");
             return false;
         }
 
-        if (cfg->buckets[i].max && cfg->buckets[i].max < cfg->buckets[i].avg) {
+        if (bkt->max && bkt->max < bkt->avg) {
             error_setg(errp, "bps_max/iops_max cannot be lower than bps/iops");
             return false;
         }
-- 
2.13.5
