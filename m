Received: from eggs.gnu.org ([2001:4830:134:3::10]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaG1-00072w-IT
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFx-00034Z-Ds
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:32 +0100
Message-Id: <1483969476-7172-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] quorum: Clean up quorum_aio_get()
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

Make sure that all fields of the new QuorumAIOCB are zeroed when the
function returns even without explicitly setting them. This will protect
us when new fields are added, removes some explicit zero assignment and
makes the code a little nicer to read.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index e244389..86e2072 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -164,20 +164,17 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
     QuorumAIOCB *acb = g_new(QuorumAIOCB, 1);
     int i;
 
-    acb->co = qemu_coroutine_self();
-    acb->bs = bs;
-    acb->offset = offset;
-    acb->bytes = bytes;
-    acb->qiov = qiov;
-    acb->qcrs = g_new0(QuorumChildRequest, s->num_children);
-    acb->count = 0;
-    acb->success_count = 0;
-    acb->rewrite_count = 0;
-    acb->votes.compare = quorum_sha256_compare;
-    QLIST_INIT(&acb->votes.vote_list);
-    acb->is_read = false;
-    acb->vote_ret = 0;
+    *acb = (QuorumAIOCB) {
+        .co                 = qemu_coroutine_self(),
+        .bs                 = bs,
+        .offset             = offset,
+        .bytes              = bytes,
+        .qiov               = qiov,
+        .votes.compare      = quorum_sha256_compare,
+        .votes.vote_list    = QLIST_HEAD_INITIALIZER(acb.votes.vote_list),
+    };
 
+    acb->qcrs = g_new0(QuorumChildRequest, s->num_children);
     for (i = 0; i < s->num_children; i++) {
         acb->qcrs[i].buf = NULL;
         acb->qcrs[i].ret = 0;
-- 
1.8.3.1
