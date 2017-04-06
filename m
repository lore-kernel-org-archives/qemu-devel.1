Received: from eggs.gnu.org ([2001:4830:134:3::10]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8MD-0005S4-T7
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8MD-0001eu-62
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:25:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Apr 2017 22:25:23 +0800
Message-Id: <20170406142527.25835-2-famz@redhat.com>
In-Reply-To: <20170406142527.25835-1-famz@redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/5] block: Fix unpaired
 aio_disable_external in external snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

bdrv_replace_child_noperm tries to hand over the quiesce_counter state
from old bs to the new one, but if they are not on the same aio context
this causes unbalance.

Fix this by forcing callers to move the aio context first, and assert
it.

Reported-by: Ed Swierk <eswierk@skyportsystems.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c    | 3 +++
 blockdev.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 927ba89..8893ac1 100644
--- a/block.c
+++ b/block.c
@@ -1752,6 +1752,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
 {
     BlockDriverState *old_bs = child->bs;
 
+    if (old_bs && new_bs) {
+        assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
+    }
     if (old_bs) {
         if (old_bs->quiesce_counter && child->role->drained_end) {
             child->role->drained_end(child);
diff --git a/blockdev.c b/blockdev.c
index 040c152..4927914 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1772,6 +1772,8 @@ static void external_snapshot_prepare(BlkActionState *common,
         return;
     }
 
+    bdrv_set_aio_context(state->new_bs, state->aio_context);
+
     /* This removes our old bs and adds the new bs. This is an operation that
      * can fail, so we need to do it in .prepare; undoing it for abort is
      * always possible. */
@@ -1789,8 +1791,6 @@ static void external_snapshot_commit(BlkActionState *common)
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
 
-    bdrv_set_aio_context(state->new_bs, state->aio_context);
-
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen */
-- 
2.9.3
