Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFr-0006mT-Is
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFq-00030s-2U
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:28 +0100
Message-Id: <1483969476-7172-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] quorum: Inline quorum_aio_cb()
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

This is a conversion to a more natural coroutine style and improves the
readability of the driver.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/quorum.c | 128 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 59 insertions(+), 69 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index e044010..2c280bb 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -130,7 +130,6 @@ struct QuorumAIOCB {
     QuorumVotes votes;
 
     bool is_read;
-    bool has_completed;
     int vote_ret;
     int children_read;          /* how many children have been read from */
 };
@@ -140,8 +139,6 @@ typedef struct QuorumCo {
     int idx;
 } QuorumCo;
 
-static bool quorum_vote(QuorumAIOCB *acb);
-
 static void quorum_aio_finalize(QuorumAIOCB *acb)
 {
     g_free(acb->qcrs);
@@ -178,7 +175,6 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
     acb->rewrite_count = 0;
     acb->votes.compare = quorum_sha256_compare;
     QLIST_INIT(&acb->votes.vote_list);
-    acb->has_completed = false;
     acb->is_read = false;
     acb->vote_ret = 0;
 
@@ -231,13 +227,6 @@ static void quorum_rewrite_aio_cb(void *opaque, int ret)
 
     /* one less rewrite to do */
     acb->rewrite_count--;
-
-    /* wait until all rewrite callbacks have completed */
-    if (acb->rewrite_count) {
-        return;
-    }
-
-    acb->has_completed = true;
     qemu_coroutine_enter_if_inactive(acb->co);
 }
 
@@ -288,45 +277,6 @@ static int quorum_fifo_aio_cb(void *opaque, int ret)
     return ret;
 }
 
-static void quorum_aio_cb(void *opaque, int ret)
-{
-    QuorumChildRequest *sacb = opaque;
-    QuorumAIOCB *acb = sacb->parent;
-    BDRVQuorumState *s = acb->bs->opaque;
-    bool rewrite = false;
-    int i;
-
-    sacb->ret = ret;
-    if (ret == 0) {
-        acb->success_count++;
-    } else {
-        quorum_report_bad_acb(sacb, ret);
-    }
-    acb->count++;
-    assert(acb->count <= s->num_children);
-    assert(acb->success_count <= s->num_children);
-    if (acb->count < s->num_children) {
-        return;
-    }
-
-    /* Do the vote on read */
-    if (acb->is_read) {
-        rewrite = quorum_vote(acb);
-        for (i = 0; i < s->num_children; i++) {
-            qemu_vfree(acb->qcrs[i].buf);
-            qemu_iovec_destroy(&acb->qcrs[i].qiov);
-        }
-    } else {
-        quorum_has_too_much_io_failed(acb);
-    }
-
-    /* if no rewrite is done the code will finish right away */
-    if (!rewrite) {
-        acb->has_completed = true;
-        qemu_coroutine_enter_if_inactive(acb->co);
-    }
-}
-
 static void quorum_report_bad_versions(BDRVQuorumState *s,
                                        QuorumAIOCB *acb,
                                        QuorumVoteValue *value)
@@ -557,17 +507,16 @@ static int quorum_vote_error(QuorumAIOCB *acb)
     return ret;
 }
 
-static bool quorum_vote(QuorumAIOCB *acb)
+static void quorum_vote(QuorumAIOCB *acb)
 {
     bool quorum = true;
-    bool rewrite = false;
     int i, j, ret;
     QuorumVoteValue hash;
     BDRVQuorumState *s = acb->bs->opaque;
     QuorumVoteVersion *winner;
 
     if (quorum_has_too_much_io_failed(acb)) {
-        return false;
+        return;
     }
 
     /* get the index of the first successful read */
@@ -595,7 +544,7 @@ static bool quorum_vote(QuorumAIOCB *acb)
     /* Every successful read agrees */
     if (quorum) {
         quorum_copy_qiov(acb->qiov, &acb->qcrs[i].qiov);
-        return false;
+        return;
     }
 
     /* compute hashes for each successful read, also store indexes */
@@ -630,13 +579,12 @@ static bool quorum_vote(QuorumAIOCB *acb)
 
     /* corruption correction is enabled */
     if (s->rewrite_corrupted) {
-        rewrite = quorum_rewrite_bad_versions(s, acb, &winner->value);
+        quorum_rewrite_bad_versions(s, acb, &winner->value);
     }
 
 free_exit:
     /* free lists */
     quorum_free_vote_list(&acb->votes);
-    return rewrite;
 }
 
 static void read_quorum_children_entry(void *opaque)
@@ -645,13 +593,28 @@ static void read_quorum_children_entry(void *opaque)
     QuorumAIOCB *acb = co->acb;
     BDRVQuorumState *s = acb->bs->opaque;
     int i = co->idx;
-    int ret;
+    QuorumChildRequest *sacb = &acb->qcrs[i];
+
+    sacb->bs = s->children[i]->bs;
+    sacb->ret = bdrv_co_preadv(s->children[i],
+                               acb->sector_num * BDRV_SECTOR_SIZE,
+                               acb->nb_sectors * BDRV_SECTOR_SIZE,
+                               &acb->qcrs[i].qiov, 0);
+
+    if (sacb->ret == 0) {
+        acb->success_count++;
+    } else {
+        quorum_report_bad_acb(sacb, sacb->ret);
+    }
 
-    acb->qcrs[i].bs = s->children[i]->bs;
-    ret = bdrv_co_preadv(s->children[i], acb->sector_num * BDRV_SECTOR_SIZE,
-                         acb->nb_sectors * BDRV_SECTOR_SIZE,
-                         &acb->qcrs[i].qiov, 0);
-    quorum_aio_cb(&acb->qcrs[i], ret);
+    acb->count++;
+    assert(acb->count <= s->num_children);
+    assert(acb->success_count <= s->num_children);
+
+    /* Wake up the caller after the last read */
+    if (acb->count == s->num_children) {
+        qemu_coroutine_enter_if_inactive(acb->co);
+    }
 }
 
 static int read_quorum_children(QuorumAIOCB *acb)
@@ -677,7 +640,18 @@ static int read_quorum_children(QuorumAIOCB *acb)
         qemu_coroutine_enter(co);
     }
 
-    if (!acb->has_completed) {
+    while (acb->count < s->num_children) {
+        qemu_coroutine_yield();
+    }
+
+    /* Do the vote on read */
+    quorum_vote(acb);
+    for (i = 0; i < s->num_children; i++) {
+        qemu_vfree(acb->qcrs[i].buf);
+        qemu_iovec_destroy(&acb->qcrs[i].qiov);
+    }
+
+    while (acb->rewrite_count) {
         qemu_coroutine_yield();
     }
 
@@ -727,12 +701,26 @@ static void write_quorum_entry(void *opaque)
     QuorumAIOCB *acb = co->acb;
     BDRVQuorumState *s = acb->bs->opaque;
     int i = co->idx;
-    int ret;
+    QuorumChildRequest *sacb = &acb->qcrs[i];
+
+    sacb->bs = s->children[i]->bs;
+    sacb->ret = bdrv_co_pwritev(s->children[i],
+                                acb->sector_num * BDRV_SECTOR_SIZE,
+                                acb->nb_sectors * BDRV_SECTOR_SIZE,
+                                acb->qiov, 0);
+    if (sacb->ret == 0) {
+        acb->success_count++;
+    } else {
+        quorum_report_bad_acb(sacb, sacb->ret);
+    }
+    acb->count++;
+    assert(acb->count <= s->num_children);
+    assert(acb->success_count <= s->num_children);
 
-    acb->qcrs[i].bs = s->children[i]->bs;
-    ret = bdrv_co_pwritev(s->children[i], acb->sector_num * BDRV_SECTOR_SIZE,
-                          acb->nb_sectors * BDRV_SECTOR_SIZE, acb->qiov, 0);
-    quorum_aio_cb(&acb->qcrs[i], ret);
+    /* Wake up the caller after the last write */
+    if (acb->count == s->num_children) {
+        qemu_coroutine_enter_if_inactive(acb->co);
+    }
 }
 
 static int quorum_co_writev(BlockDriverState *bs,
@@ -754,10 +742,12 @@ static int quorum_co_writev(BlockDriverState *bs,
         qemu_coroutine_enter(co);
     }
 
-    if (!acb->has_completed) {
+    while (acb->count < s->num_children) {
         qemu_coroutine_yield();
     }
 
+    quorum_has_too_much_io_failed(acb);
+
     ret = acb->vote_ret;
     quorum_aio_finalize(acb);
 
-- 
1.8.3.1
