Received: from eggs.gnu.org ([2001:4830:134:3::10]:33514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFx-0006xI-St
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFw-00033E-8q
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:01 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:30 +0100
Message-Id: <1483969476-7172-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/14] quorum: Implement
 .bdrv_co_preadv/pwritev()
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

This enables byte granularity requests on quorum nodes.

Note that the QMP events emitted by the driver are an external API that
we were careless enough to define as sector based. The offset and length
of requests reported in events are rounded therefore.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 81 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 690fd36..4bba9fd 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -114,8 +114,8 @@ struct QuorumAIOCB {
     Coroutine *co;
 
     /* Request metadata */
-    uint64_t sector_num;
-    int nb_sectors;
+    uint64_t offset;
+    uint64_t bytes;
 
     QEMUIOVector *qiov;         /* calling IOV */
 
@@ -157,8 +157,8 @@ static bool quorum_64bits_compare(QuorumVoteValue *a, QuorumVoteValue *b)
 
 static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
                                    QEMUIOVector *qiov,
-                                   uint64_t sector_num,
-                                   int nb_sectors)
+                                   uint64_t offset,
+                                   uint64_t bytes)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = g_new(QuorumAIOCB, 1);
@@ -166,8 +166,8 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
 
     acb->co = qemu_coroutine_self();
     acb->bs = bs;
-    acb->sector_num = sector_num;
-    acb->nb_sectors = nb_sectors;
+    acb->offset = offset;
+    acb->bytes = bytes;
     acb->qiov = qiov;
     acb->qcrs = g_new0(QuorumChildRequest, s->num_children);
     acb->count = 0;
@@ -187,23 +187,30 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
     return acb;
 }
 
-static void quorum_report_bad(QuorumOpType type, uint64_t sector_num,
-                              int nb_sectors, char *node_name, int ret)
+static void quorum_report_bad(QuorumOpType type, uint64_t offset,
+                              uint64_t bytes, char *node_name, int ret)
 {
     const char *msg = NULL;
+    int64_t start_sector = offset / BDRV_SECTOR_SIZE;
+    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
+
     if (ret < 0) {
         msg = strerror(-ret);
     }
 
-    qapi_event_send_quorum_report_bad(type, !!msg, msg, node_name,
-                                      sector_num, nb_sectors, &error_abort);
+    qapi_event_send_quorum_report_bad(type, !!msg, msg, node_name, start_sector,
+                                      end_sector - start_sector, &error_abort);
 }
 
 static void quorum_report_failure(QuorumAIOCB *acb)
 {
     const char *reference = bdrv_get_device_or_node_name(acb->bs);
-    qapi_event_send_quorum_failure(reference, acb->sector_num,
-                                   acb->nb_sectors, &error_abort);
+    int64_t start_sector = acb->offset / BDRV_SECTOR_SIZE;
+    int64_t end_sector = DIV_ROUND_UP(acb->offset + acb->bytes,
+                                      BDRV_SECTOR_SIZE);
+
+    qapi_event_send_quorum_failure(reference, start_sector,
+                                   end_sector - start_sector, &error_abort);
 }
 
 static int quorum_vote_error(QuorumAIOCB *acb);
@@ -240,8 +247,7 @@ static void quorum_report_bad_acb(QuorumChildRequest *sacb, int ret)
 {
     QuorumAIOCB *acb = sacb->parent;
     QuorumOpType type = acb->is_read ? QUORUM_OP_TYPE_READ : QUORUM_OP_TYPE_WRITE;
-    quorum_report_bad(type, acb->sector_num, acb->nb_sectors,
-                      sacb->bs->node_name, ret);
+    quorum_report_bad(type, acb->offset, acb->bytes, sacb->bs->node_name, ret);
 }
 
 static int quorum_fifo_aio_cb(void *opaque, int ret)
@@ -280,8 +286,7 @@ static void quorum_report_bad_versions(BDRVQuorumState *s,
             continue;
         }
         QLIST_FOREACH(item, &version->items, next) {
-            quorum_report_bad(QUORUM_OP_TYPE_READ, acb->sector_num,
-                              acb->nb_sectors,
+            quorum_report_bad(QUORUM_OP_TYPE_READ, acb->offset, acb->bytes,
                               s->children[item->index]->bs->node_name, 0);
         }
     }
@@ -295,9 +300,7 @@ static void quorum_rewrite_entry(void *opaque)
 
     /* Ignore any errors, it's just a correction attempt for already
      * corrupted data. */
-    bdrv_co_pwritev(s->children[co->idx],
-                    acb->sector_num * BDRV_SECTOR_SIZE,
-                    acb->nb_sectors * BDRV_SECTOR_SIZE,
+    bdrv_co_pwritev(s->children[co->idx], acb->offset, acb->bytes,
                     acb->qiov, 0);
 
     /* Wake up the caller after the last rewrite */
@@ -462,8 +465,8 @@ static void GCC_FMT_ATTR(2, 3) quorum_err(QuorumAIOCB *acb,
     va_list ap;
 
     va_start(ap, fmt);
-    fprintf(stderr, "quorum: sector_num=%" PRId64 " nb_sectors=%d ",
-            acb->sector_num, acb->nb_sectors);
+    fprintf(stderr, "quorum: offset=%" PRIu64 " bytes=%" PRIu64 " ",
+            acb->offset, acb->bytes);
     vfprintf(stderr, fmt, ap);
     fprintf(stderr, "\n");
     va_end(ap);
@@ -481,9 +484,8 @@ static bool quorum_compare(QuorumAIOCB *acb,
     if (s->is_blkverify) {
         offset = qemu_iovec_compare(a, b);
         if (offset != -1) {
-            quorum_err(acb, "contents mismatch in sector %" PRId64,
-                       acb->sector_num +
-                       (uint64_t)(offset / BDRV_SECTOR_SIZE));
+            quorum_err(acb, "contents mismatch at offset %" PRIu64,
+                       acb->offset + offset);
         }
         return true;
     }
@@ -612,9 +614,7 @@ static void read_quorum_children_entry(void *opaque)
     QuorumChildRequest *sacb = &acb->qcrs[i];
 
     sacb->bs = s->children[i]->bs;
-    sacb->ret = bdrv_co_preadv(s->children[i],
-                               acb->sector_num * BDRV_SECTOR_SIZE,
-                               acb->nb_sectors * BDRV_SECTOR_SIZE,
+    sacb->ret = bdrv_co_preadv(s->children[i], acb->offset, acb->bytes,
                                &acb->qcrs[i].qiov, 0);
 
     if (sacb->ret == 0) {
@@ -683,19 +683,17 @@ static int read_fifo_child(QuorumAIOCB *acb)
     int ret;
 
     acb->qcrs[n].bs = s->children[n]->bs;
-    ret = bdrv_co_preadv(s->children[n], acb->sector_num * BDRV_SECTOR_SIZE,
-                         acb->nb_sectors * BDRV_SECTOR_SIZE, acb->qiov, 0);
+    ret = bdrv_co_preadv(s->children[n], acb->offset, acb->bytes, acb->qiov, 0);
     ret = quorum_fifo_aio_cb(&acb->qcrs[n], ret);
 
     return ret;
 }
 
-static int quorum_co_readv(BlockDriverState *bs,
-                           int64_t sector_num, int nb_sectors,
-                           QEMUIOVector *qiov)
+static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
+                            uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors);
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes);
     int ret;
 
     acb->is_read = true;
@@ -720,9 +718,7 @@ static void write_quorum_entry(void *opaque)
     QuorumChildRequest *sacb = &acb->qcrs[i];
 
     sacb->bs = s->children[i]->bs;
-    sacb->ret = bdrv_co_pwritev(s->children[i],
-                                acb->sector_num * BDRV_SECTOR_SIZE,
-                                acb->nb_sectors * BDRV_SECTOR_SIZE,
+    sacb->ret = bdrv_co_pwritev(s->children[i], acb->offset, acb->bytes,
                                 acb->qiov, 0);
     if (sacb->ret == 0) {
         acb->success_count++;
@@ -739,12 +735,11 @@ static void write_quorum_entry(void *opaque)
     }
 }
 
-static int quorum_co_writev(BlockDriverState *bs,
-                            int64_t sector_num, int nb_sectors,
-                            QEMUIOVector *qiov)
+static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                             uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors);
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes);
     int i, ret;
 
     for (i = 0; i < s->num_children; i++) {
@@ -811,7 +806,7 @@ static coroutine_fn int quorum_co_flush(BlockDriverState *bs)
         result = bdrv_co_flush(s->children[i]->bs);
         if (result) {
             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
-                              bdrv_nb_sectors(s->children[i]->bs),
+                              bdrv_getlength(s->children[i]->bs),
                               s->children[i]->bs->node_name, result);
             result_value.l = result;
             quorum_count_vote(&error_votes, &result_value, i);
@@ -1144,8 +1139,8 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_getlength                     = quorum_getlength,
 
-    .bdrv_co_readv                      = quorum_co_readv,
-    .bdrv_co_writev                     = quorum_co_writev,
+    .bdrv_co_preadv                     = quorum_co_preadv,
+    .bdrv_co_pwritev                    = quorum_co_pwritev,
 
     .bdrv_add_child                     = quorum_add_child,
     .bdrv_del_child                     = quorum_del_child,
-- 
1.8.3.1
