Received: from eggs.gnu.org ([2001:4830:134:3::10]:42684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBz-0003MF-Nl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBw-0001Mn-Kl
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBw-0001MN-FM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hmP3007417
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:35 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3h12x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:35 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:34 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:31 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-38-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/67] throttle: Correct access to wrong
 BlockBackendPublic structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

From: Alberto Garcia <berto@igalia.com>

In 27ccdd52598290f0f8b58be56e235aff7aebfaf3 the throttling fields were
moved from BlockDriverState to BlockBackend. However in a few cases
the code started using throttling fields from the active BlockBackend
instead of the round-robin token, making the algorithm behave
incorrectly.

This can cause starvation if there's a throttling group with several
drives but only one of them has I/O.

Cc: qemu-stable@nongnu.org
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6bf77e1c2dc24da1bade16e8a9a637f3b127314d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/throttle-groups.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 59545e2..17b2efb 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -168,6 +168,22 @@ static BlockBackend *throttle_group_next_blk(BlockBackend *blk)
     return blk_by_public(next);
 }
 
+/*
+ * Return whether a BlockBackend has pending requests.
+ *
+ * This assumes that tg->lock is held.
+ *
+ * @blk: the BlockBackend
+ * @is_write:  the type of operation (read/write)
+ * @ret:       whether the BlockBackend has pending requests.
+ */
+static inline bool blk_has_pending_reqs(BlockBackend *blk,
+                                        bool is_write)
+{
+    const BlockBackendPublic *blkp = blk_get_public(blk);
+    return blkp->pending_reqs[is_write];
+}
+
 /* Return the next BlockBackend in the round-robin sequence with pending I/O
  * requests.
  *
@@ -188,7 +204,7 @@ static BlockBackend *next_throttle_token(BlockBackend *blk, bool is_write)
 
     /* get next bs round in round robin style */
     token = throttle_group_next_blk(token);
-    while (token != start && !blkp->pending_reqs[is_write]) {
+    while (token != start && !blk_has_pending_reqs(token, is_write)) {
         token = throttle_group_next_blk(token);
     }
 
@@ -196,10 +212,13 @@ static BlockBackend *next_throttle_token(BlockBackend *blk, bool is_write)
      * then decide the token is the current bs because chances are
      * the current bs get the current request queued.
      */
-    if (token == start && !blkp->pending_reqs[is_write]) {
+    if (token == start && !blk_has_pending_reqs(token, is_write)) {
         token = blk;
     }
 
+    /* Either we return the original BB, or one with pending requests */
+    assert(token == blk || blk_has_pending_reqs(token, is_write));
+
     return token;
 }
 
@@ -257,7 +276,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
 
     /* Check if there's any pending request to schedule next */
     token = next_throttle_token(blk, is_write);
-    if (!blkp->pending_reqs[is_write]) {
+    if (!blk_has_pending_reqs(token, is_write)) {
         return;
     }
 
@@ -271,7 +290,7 @@ static void schedule_next_request(BlockBackend *blk, bool is_write)
             qemu_co_queue_next(&blkp->throttled_reqs[is_write])) {
             token = blk;
         } else {
-            ThrottleTimers *tt = &blkp->throttle_timers;
+            ThrottleTimers *tt = &blk_get_public(token)->throttle_timers;
             int64_t now = qemu_clock_get_ns(tt->clock_type);
             timer_mod(tt->timers[is_write], now + 1);
             tg->any_timer_armed[is_write] = true;
-- 
1.9.1
