Received: from eggs.gnu.org ([2001:4830:134:3::10]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHv-0008K9-G2
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHu-0005o2-Kr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHu-0005nB-FT
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:14 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BDAC3D953
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:52 +0200
Message-Id: <20170605123908.18777-4-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/19] block: access io_limits_disabled with
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
Cc: famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/block-backend.c          | 4 ++--
 block/throttle-groups.c        | 2 +-
 include/sysemu/block-backend.h | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f3a60081a7..e50ec03f30 100644
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
index b73e7a800b..69bfbd44d9 100644
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
index 840ad6134c..24b63d6b03 100644
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
2.13.0
