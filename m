Received: from eggs.gnu.org ([2001:4830:134:3::10]:44933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFE-0005uN-JH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUFD-0003XJ-VJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:43 +0200
Message-Id: <1491572865-8549-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] block: Fix unpaired aio_disable_external
 in external snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

bdrv_replace_child_noperm tries to hand over the quiesce_counter state
from old bs to the new one, but if they are not on the same aio context
this causes unbalance.

Fix this by setting the correct aio context before calling
bdrv_append().

Reported-by: Ed Swierk <eswierk@skyportsystems.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
1.8.3.1
