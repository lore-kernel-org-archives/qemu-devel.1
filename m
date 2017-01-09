Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFq-0006kY-Ck
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFo-0002zs-KH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:26 +0100
Message-Id: <1483969476-7172-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] quorum: Implement .bdrv_co_readv/writev
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

This converts the quorum block driver from implementing callback-based
interfaces for read/write to coroutine-based ones. This is the first
step that will allow us further simplification of the code.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 192 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 115 insertions(+), 77 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index dfa9fd3..6a7bd91 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -97,7 +97,7 @@ typedef struct QuorumAIOCB QuorumAIOCB;
  * $children_count QuorumChildRequest.
  */
 typedef struct QuorumChildRequest {
-    BlockAIOCB *aiocb;
+    BlockDriverState *bs;
     QEMUIOVector qiov;
     uint8_t *buf;
     int ret;
@@ -110,7 +110,8 @@ typedef struct QuorumChildRequest {
  * used to do operations on each children and track overall progress.
  */
 struct QuorumAIOCB {
-    BlockAIOCB common;
+    BlockDriverState *bs;
+    Coroutine *co;
 
     /* Request metadata */
     uint64_t sector_num;
@@ -129,36 +130,23 @@ struct QuorumAIOCB {
     QuorumVotes votes;
 
     bool is_read;
+    bool has_completed;
     int vote_ret;
     int children_read;          /* how many children have been read from */
 };
 
-static bool quorum_vote(QuorumAIOCB *acb);
-
-static void quorum_aio_cancel(BlockAIOCB *blockacb)
-{
-    QuorumAIOCB *acb = container_of(blockacb, QuorumAIOCB, common);
-    BDRVQuorumState *s = acb->common.bs->opaque;
-    int i;
-
-    /* cancel all callbacks */
-    for (i = 0; i < s->num_children; i++) {
-        if (acb->qcrs[i].aiocb) {
-            bdrv_aio_cancel_async(acb->qcrs[i].aiocb);
-        }
-    }
-}
+typedef struct QuorumCo {
+    QuorumAIOCB *acb;
+    int idx;
+} QuorumCo;
 
-static AIOCBInfo quorum_aiocb_info = {
-    .aiocb_size         = sizeof(QuorumAIOCB),
-    .cancel_async       = quorum_aio_cancel,
-};
+static bool quorum_vote(QuorumAIOCB *acb);
 
 static void quorum_aio_finalize(QuorumAIOCB *acb)
 {
-    acb->common.cb(acb->common.opaque, acb->vote_ret);
+    acb->has_completed = true;
     g_free(acb->qcrs);
-    qemu_aio_unref(acb);
+    qemu_coroutine_enter_if_inactive(acb->co);
 }
 
 static bool quorum_sha256_compare(QuorumVoteValue *a, QuorumVoteValue *b)
@@ -174,14 +162,14 @@ static bool quorum_64bits_compare(QuorumVoteValue *a, QuorumVoteValue *b)
 static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
                                    QEMUIOVector *qiov,
                                    uint64_t sector_num,
-                                   int nb_sectors,
-                                   BlockCompletionFunc *cb,
-                                   void *opaque)
+                                   int nb_sectors)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = qemu_aio_get(&quorum_aiocb_info, bs, cb, opaque);
+    QuorumAIOCB *acb = g_new(QuorumAIOCB, 1);
     int i;
 
+    acb->co = qemu_coroutine_self();
+    acb->bs = bs;
     acb->sector_num = sector_num;
     acb->nb_sectors = nb_sectors;
     acb->qiov = qiov;
@@ -191,6 +179,7 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
     acb->rewrite_count = 0;
     acb->votes.compare = quorum_sha256_compare;
     QLIST_INIT(&acb->votes.vote_list);
+    acb->has_completed = false;
     acb->is_read = false;
     acb->vote_ret = 0;
 
@@ -217,7 +206,7 @@ static void quorum_report_bad(QuorumOpType type, uint64_t sector_num,
 
 static void quorum_report_failure(QuorumAIOCB *acb)
 {
-    const char *reference = bdrv_get_device_or_node_name(acb->common.bs);
+    const char *reference = bdrv_get_device_or_node_name(acb->bs);
     qapi_event_send_quorum_failure(reference, acb->sector_num,
                                    acb->nb_sectors, &error_abort);
 }
@@ -226,7 +215,7 @@ static int quorum_vote_error(QuorumAIOCB *acb);
 
 static bool quorum_has_too_much_io_failed(QuorumAIOCB *acb)
 {
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
 
     if (acb->success_count < s->threshold) {
         acb->vote_ret = quorum_vote_error(acb);
@@ -252,7 +241,7 @@ static void quorum_rewrite_aio_cb(void *opaque, int ret)
     quorum_aio_finalize(acb);
 }
 
-static BlockAIOCB *read_fifo_child(QuorumAIOCB *acb);
+static int read_fifo_child(QuorumAIOCB *acb);
 
 static void quorum_copy_qiov(QEMUIOVector *dest, QEMUIOVector *source)
 {
@@ -272,14 +261,14 @@ static void quorum_report_bad_acb(QuorumChildRequest *sacb, int ret)
     QuorumAIOCB *acb = sacb->parent;
     QuorumOpType type = acb->is_read ? QUORUM_OP_TYPE_READ : QUORUM_OP_TYPE_WRITE;
     quorum_report_bad(type, acb->sector_num, acb->nb_sectors,
-                      sacb->aiocb->bs->node_name, ret);
+                      sacb->bs->node_name, ret);
 }
 
-static void quorum_fifo_aio_cb(void *opaque, int ret)
+static int quorum_fifo_aio_cb(void *opaque, int ret)
 {
     QuorumChildRequest *sacb = opaque;
     QuorumAIOCB *acb = sacb->parent;
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
 
     assert(acb->is_read && s->read_pattern == QUORUM_READ_PATTERN_FIFO);
 
@@ -288,8 +277,7 @@ static void quorum_fifo_aio_cb(void *opaque, int ret)
 
         /* We try to read next child in FIFO order if we fail to read */
         if (acb->children_read < s->num_children) {
-            read_fifo_child(acb);
-            return;
+            return read_fifo_child(acb);
         }
     }
 
@@ -297,13 +285,14 @@ static void quorum_fifo_aio_cb(void *opaque, int ret)
 
     /* FIXME: rewrite failed children if acb->children_read > 1? */
     quorum_aio_finalize(acb);
+    return ret;
 }
 
 static void quorum_aio_cb(void *opaque, int ret)
 {
     QuorumChildRequest *sacb = opaque;
     QuorumAIOCB *acb = sacb->parent;
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
     bool rewrite = false;
     int i;
 
@@ -518,7 +507,7 @@ static bool quorum_compare(QuorumAIOCB *acb,
                            QEMUIOVector *a,
                            QEMUIOVector *b)
 {
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
     ssize_t offset;
 
     /* This driver will replace blkverify in this particular case */
@@ -538,7 +527,7 @@ static bool quorum_compare(QuorumAIOCB *acb,
 /* Do a vote to get the error code */
 static int quorum_vote_error(QuorumAIOCB *acb)
 {
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
     QuorumVoteVersion *winner = NULL;
     QuorumVotes error_votes;
     QuorumVoteValue result_value;
@@ -573,7 +562,7 @@ static bool quorum_vote(QuorumAIOCB *acb)
     bool rewrite = false;
     int i, j, ret;
     QuorumVoteValue hash;
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
     QuorumVoteVersion *winner;
 
     if (quorum_has_too_much_io_failed(acb)) {
@@ -649,10 +638,25 @@ free_exit:
     return rewrite;
 }
 
-static BlockAIOCB *read_quorum_children(QuorumAIOCB *acb)
+static void read_quorum_children_entry(void *opaque)
 {
-    BDRVQuorumState *s = acb->common.bs->opaque;
-    int i;
+    QuorumCo *co = opaque;
+    QuorumAIOCB *acb = co->acb;
+    BDRVQuorumState *s = acb->bs->opaque;
+    int i = co->idx;
+    int ret;
+
+    acb->qcrs[i].bs = s->children[i]->bs;
+    ret = bdrv_co_preadv(s->children[i], acb->sector_num * BDRV_SECTOR_SIZE,
+                         acb->nb_sectors * BDRV_SECTOR_SIZE,
+                         &acb->qcrs[i].qiov, 0);
+    quorum_aio_cb(&acb->qcrs[i], ret);
+}
+
+static int read_quorum_children(QuorumAIOCB *acb)
+{
+    BDRVQuorumState *s = acb->bs->opaque;
+    int i, ret;
 
     acb->children_read = s->num_children;
     for (i = 0; i < s->num_children; i++) {
@@ -662,65 +666,99 @@ static BlockAIOCB *read_quorum_children(QuorumAIOCB *acb)
     }
 
     for (i = 0; i < s->num_children; i++) {
-        acb->qcrs[i].aiocb = bdrv_aio_readv(s->children[i], acb->sector_num,
-                                            &acb->qcrs[i].qiov, acb->nb_sectors,
-                                            quorum_aio_cb, &acb->qcrs[i]);
+        Coroutine *co;
+        QuorumCo data = {
+            .acb = acb,
+            .idx = i,
+        };
+
+        co = qemu_coroutine_create(read_quorum_children_entry, &data);
+        qemu_coroutine_enter(co);
     }
 
-    return &acb->common;
+    if (!acb->has_completed) {
+        qemu_coroutine_yield();
+    }
+
+    ret = acb->vote_ret;
+
+    return ret;
 }
 
-static BlockAIOCB *read_fifo_child(QuorumAIOCB *acb)
+static int read_fifo_child(QuorumAIOCB *acb)
 {
-    BDRVQuorumState *s = acb->common.bs->opaque;
+    BDRVQuorumState *s = acb->bs->opaque;
     int n = acb->children_read++;
+    int ret;
 
-    acb->qcrs[n].aiocb = bdrv_aio_readv(s->children[n], acb->sector_num,
-                                        acb->qiov, acb->nb_sectors,
-                                        quorum_fifo_aio_cb, &acb->qcrs[n]);
+    acb->qcrs[n].bs = s->children[n]->bs;
+    ret = bdrv_co_preadv(s->children[n], acb->sector_num * BDRV_SECTOR_SIZE,
+                         acb->nb_sectors * BDRV_SECTOR_SIZE, acb->qiov, 0);
+    ret = quorum_fifo_aio_cb(&acb->qcrs[n], ret);
 
-    return &acb->common;
+    return ret;
 }
 
-static BlockAIOCB *quorum_aio_readv(BlockDriverState *bs,
-                                    int64_t sector_num,
-                                    QEMUIOVector *qiov,
-                                    int nb_sectors,
-                                    BlockCompletionFunc *cb,
-                                    void *opaque)
+static int quorum_co_readv(BlockDriverState *bs,
+                           int64_t sector_num, int nb_sectors,
+                           QEMUIOVector *qiov)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num,
-                                      nb_sectors, cb, opaque);
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors);
+    int ret;
+
     acb->is_read = true;
     acb->children_read = 0;
 
     if (s->read_pattern == QUORUM_READ_PATTERN_QUORUM) {
-        return read_quorum_children(acb);
+        ret = read_quorum_children(acb);
+    } else {
+        ret = read_fifo_child(acb);
     }
+    g_free(acb);
+    return ret;
+}
 
-    return read_fifo_child(acb);
+static void write_quorum_entry(void *opaque)
+{
+    QuorumCo *co = opaque;
+    QuorumAIOCB *acb = co->acb;
+    BDRVQuorumState *s = acb->bs->opaque;
+    int i = co->idx;
+    int ret;
+
+    acb->qcrs[i].bs = s->children[i]->bs;
+    ret = bdrv_co_pwritev(s->children[i], acb->sector_num * BDRV_SECTOR_SIZE,
+                          acb->nb_sectors * BDRV_SECTOR_SIZE, acb->qiov, 0);
+    quorum_aio_cb(&acb->qcrs[i], ret);
 }
 
-static BlockAIOCB *quorum_aio_writev(BlockDriverState *bs,
-                                     int64_t sector_num,
-                                     QEMUIOVector *qiov,
-                                     int nb_sectors,
-                                     BlockCompletionFunc *cb,
-                                     void *opaque)
+static int quorum_co_writev(BlockDriverState *bs,
+                            int64_t sector_num, int nb_sectors,
+                            QEMUIOVector *qiov)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors,
-                                      cb, opaque);
-    int i;
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors);
+    int i, ret;
 
     for (i = 0; i < s->num_children; i++) {
-        acb->qcrs[i].aiocb = bdrv_aio_writev(s->children[i], sector_num,
-                                             qiov, nb_sectors, &quorum_aio_cb,
-                                             &acb->qcrs[i]);
+        Coroutine *co;
+        QuorumCo data = {
+            .acb = acb,
+            .idx = i,
+        };
+
+        co = qemu_coroutine_create(write_quorum_entry, &data);
+        qemu_coroutine_enter(co);
     }
 
-    return &acb->common;
+    if (!acb->has_completed) {
+        qemu_coroutine_yield();
+    }
+
+    ret = acb->vote_ret;
+
+    return ret;
 }
 
 static int64_t quorum_getlength(BlockDriverState *bs)
@@ -1097,8 +1135,8 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_getlength                     = quorum_getlength,
 
-    .bdrv_aio_readv                     = quorum_aio_readv,
-    .bdrv_aio_writev                    = quorum_aio_writev,
+    .bdrv_co_readv                      = quorum_co_readv,
+    .bdrv_co_writev                     = quorum_co_writev,
 
     .bdrv_add_child                     = quorum_add_child,
     .bdrv_del_child                     = quorum_del_child,
-- 
1.8.3.1
