Received: from eggs.gnu.org ([2001:4830:134:3::10]:33503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFx-0006vc-C2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFw-00033K-9S
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:31 +0100
Message-Id: <1483969476-7172-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/14] quorum: Inline quorum_fifo_aio_cb()
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

Inlining the function removes some boilerplace code and replaces
recursion by a simple loop, so the code becomes somewhat easier to
understand.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/quorum.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 4bba9fd..e244389 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -250,30 +250,6 @@ static void quorum_report_bad_acb(QuorumChildRequest *sacb, int ret)
     quorum_report_bad(type, acb->offset, acb->bytes, sacb->bs->node_name, ret);
 }
 
-static int quorum_fifo_aio_cb(void *opaque, int ret)
-{
-    QuorumChildRequest *sacb = opaque;
-    QuorumAIOCB *acb = sacb->parent;
-    BDRVQuorumState *s = acb->bs->opaque;
-
-    assert(acb->is_read && s->read_pattern == QUORUM_READ_PATTERN_FIFO);
-
-    if (ret < 0) {
-        quorum_report_bad_acb(sacb, ret);
-
-        /* We try to read next child in FIFO order if we fail to read */
-        if (acb->children_read < s->num_children) {
-            return read_fifo_child(acb);
-        }
-    }
-
-    acb->vote_ret = ret;
-
-    /* FIXME: rewrite failed children if acb->children_read > 1? */
-
-    return ret;
-}
-
 static void quorum_report_bad_versions(BDRVQuorumState *s,
                                        QuorumAIOCB *acb,
                                        QuorumVoteValue *value)
@@ -679,12 +655,20 @@ static int read_quorum_children(QuorumAIOCB *acb)
 static int read_fifo_child(QuorumAIOCB *acb)
 {
     BDRVQuorumState *s = acb->bs->opaque;
-    int n = acb->children_read++;
-    int ret;
+    int n, ret;
+
+    /* We try to read the next child in FIFO order if we failed to read */
+    do {
+        n = acb->children_read++;
+        acb->qcrs[n].bs = s->children[n]->bs;
+        ret = bdrv_co_preadv(s->children[n], acb->offset, acb->bytes,
+                             acb->qiov, 0);
+        if (ret < 0) {
+            quorum_report_bad_acb(&acb->qcrs[n], ret);
+        }
+    } while (ret < 0 && acb->children_read < s->num_children);
 
-    acb->qcrs[n].bs = s->children[n]->bs;
-    ret = bdrv_co_preadv(s->children[n], acb->offset, acb->bytes, acb->qiov, 0);
-    ret = quorum_fifo_aio_cb(&acb->qcrs[n], ret);
+    /* FIXME: rewrite failed children if acb->children_read > 1? */
 
     return ret;
 }
-- 
1.8.3.1
