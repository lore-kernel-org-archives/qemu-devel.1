Received: from eggs.gnu.org ([2001:4830:134:3::10]:53731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6M-00021K-TQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6M-0005xR-3w
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Jun 2017 19:50:19 +0200
Message-Id: <1496857819-12466-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] block: fix external snapshot abort
 permission error
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

From: Jeff Cody <jcody@redhat.com>

In external_snapshot_abort(), we try to undo what was done in
external_snapshot_prepare() calling bdrv_replace_node() to swap the
nodes back.  However, we receive a permissions error as writers are
blocked on the old node, which is now the new node backing file.

An easy fix (initially suggested by Kevin Wolf) is to call
bdrv_set_backing_hd() on the new node, to set the backing node to NULL.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 892d768..6472548 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1803,7 +1803,11 @@ static void external_snapshot_abort(BlkActionState *common)
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->new_bs) {
         if (state->overlay_appended) {
+            bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd()
+                                          close state->old_bs; we need it */
+            bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
+            bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
         }
     }
 }
-- 
1.8.3.1
