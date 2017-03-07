Received: from eggs.gnu.org ([2001:4830:134:3::10]:42393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEa-000227-Bm
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEZ-0002Xl-H1
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:29 +0100
Message-Id: <1488901251-16214-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/27] block: Fix blockdev-snapshot error
 handling
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

For blockdev-snapshot, external_snapshot_prepare() accepts an arbitrary
node reference at first and only checks later whether it already has a
backing file. Between those places, other errors can occur.

Therefore checking in external_snapshot_abort() whether state->new_bs
has a backing file is not sufficient to tell whether bdrv_append() was
already completed or not. Trying to undo the bdrv_append() when it
wasn't even executed is wrong.

Introduce a new boolean flag in the state to fix this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 8eb4e84..af67ce4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1614,6 +1614,7 @@ typedef struct ExternalSnapshotState {
     BlockDriverState *old_bs;
     BlockDriverState *new_bs;
     AioContext *aio_context;
+    bool overlay_appended;
 } ExternalSnapshotState;
 
 static void external_snapshot_prepare(BlkActionState *common,
@@ -1780,6 +1781,7 @@ static void external_snapshot_prepare(BlkActionState *common,
         error_propagate(errp, local_err);
         return;
     }
+    state->overlay_appended = true;
 }
 
 static void external_snapshot_commit(BlkActionState *common)
@@ -1803,7 +1805,7 @@ static void external_snapshot_abort(BlkActionState *common)
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->new_bs) {
-        if (state->new_bs->backing) {
+        if (state->overlay_appended) {
             bdrv_replace_in_backing_chain(state->new_bs, state->old_bs);
         }
     }
-- 
1.8.3.1
