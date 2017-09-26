Received: from eggs.gnu.org ([2001:4830:134:3::10]:32982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqka-0001b6-OK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkR-0005O5-A4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:18 +0200
Message-Id: <20170926142133.2498-10-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/24] throttle: Assert that bkt->max is valid
 in throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

If bkt->max == 0 and bkt->burst_length > 1 then we could have a
division by 0 in throttle_do_compute_wait(). That configuration is
however not permitted and is already detected by throttle_is_valid(),
but let's assert it in throttle_compute_wait() to make it explicit.

Found by Coverity (CID: 1381016).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.5
