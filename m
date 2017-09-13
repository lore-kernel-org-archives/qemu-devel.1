Received: from eggs.gnu.org ([2001:4830:134:3::10]:39789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ds32N-0000A2-Kf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ds32J-0000pN-KH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:28:47 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 13 Sep 2017 11:28:17 +0300
Message-Id: <20170913082817.24731-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] throttle: Assert that bkt->max is valid in
 throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

If bkt->max == 0 and bkt->burst_length > 1 then we could have a
division by 0 in throttle_do_compute_wait(). That configuration is
however not permitted and is already detected by throttle_is_valid(),
but let's assert it in throttle_compute_wait() to make it explicit.

Found by Coverity (CID: 1381016).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 util/throttle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/throttle.c b/util/throttle.c
index 06bf916adc..b38e742da5 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -124,6 +124,7 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
     /* If the main bucket is not full yet we still have to check the
      * burst bucket in order to enforce the burst limit */
     if (bkt->burst_length > 1) {
+        assert(bkt->max > 0); /* see throttle_is_valid() */
         extra = bkt->burst_level - burst_bucket_size;
         if (extra > 0) {
             return throttle_do_compute_wait(bkt->max, extra);
-- 
2.11.0
