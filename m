Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JQ-G1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003U8-GH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:45 +0300
Message-Id: <763ffc40a26b17d54cf93f5a999e4656049fcf0c.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 3/7] throttle: Make throttle_is_valid() a
 bit less verbose
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

Use a pointer to the bucket instead of repeating cfg->buckets[i] all
the time. This makes the code more concise and will help us expand the
checks later and save a few line breaks.

Signed-off-by: Alberto Garcia <berto@igalia.com>
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
2.11.0
