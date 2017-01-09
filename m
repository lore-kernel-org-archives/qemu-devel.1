Received: from eggs.gnu.org ([2001:4830:134:3::10]:33379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFp-0006jn-Ou
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFo-0002zc-Ct
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:27 +0100
Message-Id: <1483969476-7172-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] quorum: Do cleanup in caller coroutine
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

Instead of calling quorum_aio_finalize() deeply nested in what used
to be an AIO callback, do it in the same functions that allocated the
AIOCB.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/quorum.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 6a7bd91..e044010 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -144,9 +144,8 @@ static bool quorum_vote(QuorumAIOCB *acb);
 
 static void quorum_aio_finalize(QuorumAIOCB *acb)
 {
-    acb->has_completed = true;
     g_free(acb->qcrs);
-    qemu_coroutine_enter_if_inactive(acb->co);
+    g_free(acb);
 }
 
 static bool quorum_sha256_compare(QuorumVoteValue *a, QuorumVoteValue *b)
@@ -238,7 +237,8 @@ static void quorum_rewrite_aio_cb(void *opaque, int ret)
         return;
     }
 
-    quorum_aio_finalize(acb);
+    acb->has_completed = true;
+    qemu_coroutine_enter_if_inactive(acb->co);
 }
 
 static int read_fifo_child(QuorumAIOCB *acb);
@@ -284,7 +284,7 @@ static int quorum_fifo_aio_cb(void *opaque, int ret)
     acb->vote_ret = ret;
 
     /* FIXME: rewrite failed children if acb->children_read > 1? */
-    quorum_aio_finalize(acb);
+
     return ret;
 }
 
@@ -322,7 +322,8 @@ static void quorum_aio_cb(void *opaque, int ret)
 
     /* if no rewrite is done the code will finish right away */
     if (!rewrite) {
-        quorum_aio_finalize(acb);
+        acb->has_completed = true;
+        qemu_coroutine_enter_if_inactive(acb->co);
     }
 }
 
@@ -715,7 +716,8 @@ static int quorum_co_readv(BlockDriverState *bs,
     } else {
         ret = read_fifo_child(acb);
     }
-    g_free(acb);
+    quorum_aio_finalize(acb);
+
     return ret;
 }
 
@@ -757,6 +759,7 @@ static int quorum_co_writev(BlockDriverState *bs,
     }
 
     ret = acb->vote_ret;
+    quorum_aio_finalize(acb);
 
     return ret;
 }
-- 
1.8.3.1
