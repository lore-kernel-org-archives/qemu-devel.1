Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgV-0001kc-Mv
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgQ-0002D1-Nk
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhgQ-0002CU-HW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Jun 2017 16:11:05 +0800
Message-Id: <20170602081120.3497-8-famz@redhat.com>
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/22] block: access io_limits_disabled with
 atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-4-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 4 ++--
 block/throttle-groups.c        | 2 +-
 include/sysemu/block-backend.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f3a6008..e50ec03 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1953,7 +1953,7 @@ static void blk_root_drained_begin(BdrvChild *child)
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
-    if (blk->public.io_limits_disabled++ == 0) {
+    if (atomic_fetch_inc(&blk->public.io_limits_disabled) == 0) {
         throttle_group_restart_blk(blk);
     }
 }
@@ -1964,7 +1964,7 @@ static void blk_root_drained_end(BdrvChild *child)
     assert(blk->quiesce_counter);
 
     assert(blk->public.io_limits_disabled);
-    --blk->public.io_limits_disabled;
+    atomic_dec(&blk->public.io_limits_disabled);
 
     if (--blk->quiesce_counter == 0) {
         if (blk->dev_ops && blk->dev_ops->drained_end) {
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index b73e7a8..69bfbd4 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -240,7 +240,7 @@ static bool throttle_group_schedule_timer(BlockBackend *blk, bool is_write)
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     bool must_wait;
 
-    if (blkp->io_limits_disabled) {
+    if (atomic_read(&blkp->io_limits_disabled)) {
         return false;
     }
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 840ad61..24b63d6 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -80,7 +80,8 @@ typedef struct BlockBackendPublic {
     CoQueue      throttled_reqs[2];
 
     /* Nonzero if the I/O limits are currently being ignored; generally
-     * it is zero.  */
+     * it is zero.  Accessed with atomic operations.
+     */
     unsigned int io_limits_disabled;
 
     /* The following fields are protected by the ThrottleGroup lock.
-- 
2.9.4
