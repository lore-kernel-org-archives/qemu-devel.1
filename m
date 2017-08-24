Received: from eggs.gnu.org ([2001:4830:134:3::10]:41974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JR-G5
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003Tt-F9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:48 +0300
Message-Id: <1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 6/7] throttle: Make burst_length 64bit and
 add range checks
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

LeakyBucket.burst_length is defined as an unsigned integer but the
code never checks for overflows and it only makes sure that the value
is not 0.

In practice this means that the user can set something like
throttling.iops-total-max-length=4294967300 despite being larger than
UINT_MAX and the final value after casting to unsigned int will be 4.

This patch changes the data type to uint64_t. This does not increase
the storage size of LeakyBucket, and allows us to assign the value
directly from qemu_opt_get_number() or BlockIOThrottle and then do the
checks directly in throttle_is_valid().

The value of burst_length does not have a specific upper limit,
but since the bucket size is defined by max * burst_length we have
to prevent overflows. Instead of going for UINT64_MAX or something
similar this patch reuses THROTTLE_VALUE_MAX, which allows I/O bursts
of 1 GiB/s for 10 days in a row.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/qemu/throttle.h | 2 +-
 util/throttle.c         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 6e31155fd4..8e01885d29 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -81,7 +81,7 @@ typedef struct LeakyBucket {
     uint64_t max;             /* leaky bucket max burst in units */
     double  level;            /* bucket level in units */
     double  burst_level;      /* bucket level in units (for computing bursts) */
-    unsigned burst_length;    /* max length of the burst period, in seconds */
+    uint64_t burst_length;    /* max length of the burst period, in seconds */
 } LeakyBucket;
 
 /* The following structure is used to configure a ThrottleState
diff --git a/util/throttle.c b/util/throttle.c
index 80660ffd2c..b8c524336c 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -354,6 +354,11 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **errp)
             return false;
         }
 
+        if (bkt->max && bkt->burst_length > THROTTLE_VALUE_MAX / bkt->max) {
+            error_setg(errp, "burst length too high for this burst rate");
+            return false;
+        }
+
         if (bkt->max && !bkt->avg) {
             error_setg(errp, "bps_max/iops_max require corresponding"
                        " bps/iops values");
-- 
2.11.0
