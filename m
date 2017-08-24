Received: from eggs.gnu.org ([2001:4830:134:3::10]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JU-Gh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003U1-GB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:44 +0300
Message-Id: <31aae6645f0d1fbf3860fb2b528b757236f0c0a7.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 2/7] throttle: Update the
 throttle_fix_bucket() documentation
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

The way the throttling algorithm works is that requests start being
throttled once the bucket level exceeds the burst limit. When we get
there the bucket leaks at the level set by the user (bkt->avg), and
that leak rate is what prevents guest I/O from exceeding the desired
limit.

If we don't allow bursts (i.e. bkt->max == 0) then we can start
throttling requests immediately. The problem with keeping the
threshold at 0 is that it only allows one request at a time, and as
soon as there's a bit of I/O from the guest every other request will
be throttled and performance will suffer considerably. That can even
make the guest unable to reach the throttle limit if that limit is
high enough, and that happens regardless of the block scheduler used
by the guest.

Increasing that threshold gives flexibility to the guest, allowing it
to perform short bursts of I/O before being throttled. Increasing the
threshold too much does not make a difference in the long run (because
it's the leak rate what defines the actual throughput) but it does
allow the guest to perform longer initial bursts and exceed the
throttle limit for a short while.

A burst value of bkt->avg / 10 allows the guest to perform 100ms'
worth of I/O at the target rate without being throttled.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 util/throttle.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index b2a52b8b34..9a6bda813c 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -366,14 +366,9 @@ static void throttle_fix_bucket(LeakyBucket *bkt)
     /* zero bucket level */
     bkt->level = bkt->burst_level = 0;
 
-    /* The following is done to cope with the Linux CFQ block scheduler
-     * which regroup reads and writes by block of 100ms in the guest.
-     * When they are two process one making reads and one making writes cfq
-     * make a pattern looking like the following:
-     * WWWWWWWWWWWRRRRRRRRRRRRRRWWWWWWWWWWWWWwRRRRRRRRRRRRRRRRR
-     * Having a max burst value of 100ms of the average will help smooth the
-     * throttling
-     */
+    /* If bkt->max is 0 we still want to allow short bursts of I/O
+     * from the guest, otherwise every other request will be throttled
+     * and performance will suffer considerably. */
     min = bkt->avg / 10;
     if (bkt->avg && !bkt->max) {
         bkt->max = min;
-- 
2.11.0
