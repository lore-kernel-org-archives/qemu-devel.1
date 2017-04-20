Received: from eggs.gnu.org ([2001:4830:134:3::10]:38626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Aml-0007ab-Nu
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amf-00033B-Lv
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:07 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:44 +0200
Message-Id: <20170420120058.28404-4-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] block: access io_limits_disabled with
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
Cc: qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/block-backend.c          | 4 ++--
 block/throttle-groups.c        | 2 +-
 include/sysemu/block-backend.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 7405024..915ccc5 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1927,7 +1927,7 @@ static void blk_root_drained_begin(BdrvChild *child)
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
 
-    if (blk->public.io_limits_disabled++ == 0) {
+    if (atomic_fetch_inc(&blk->public.io_limits_disabled) == 0) {
         throttle_group_restart_blk(blk);
     }
 }
@@ -1938,7 +1938,7 @@ static void blk_root_drained_end(BdrvChild *child)
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
index 7462228..87a43b0 100644
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
2.9.3
