Received: from eggs.gnu.org ([2001:4830:134:3::10]:42516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkM-0005PZ-PM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkI-0005tr-Qh
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKkI-0005th-LE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:22:02 +0100
Message-Id: <20170831082210.8362-8-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 07/15] throttle: Make burst_length
 64bit and add range checks
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
Message-id: 1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.13.5
