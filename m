Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCH-0006AD-Bs
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCG-0001g5-3S
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:58 +0200
Message-Id: <1497634636-20230-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/31] qed: Remove callback from
 qed_write_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 47 ++++++++++++-----------------------------------
 block/qed.c       | 12 +++++++-----
 block/qed.h       |  8 +++-----
 3 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index 0cc93a7..ebee2c5 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -61,12 +61,9 @@ out:
  * @index:      Index of first element
  * @n:          Number of elements
  * @flush:      Whether or not to sync to disk
- * @cb:         Completion function
- * @opaque:     Argument for completion function
  */
-static void qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
-                            unsigned int index, unsigned int n, bool flush,
-                            BlockCompletionFunc *cb, void *opaque)
+static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
+                           unsigned int index, unsigned int n, bool flush)
 {
     unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
     unsigned int start, end, i;
@@ -118,15 +115,7 @@ static void qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     ret = 0;
 out:
     qemu_vfree(new_table);
-    cb(opaque, ret);
-}
-
-/**
- * Propagate return value from async callback
- */
-static void qed_sync_cb(void *opaque, int ret)
-{
-    *(int *)opaque = ret;
+    return ret;
 }
 
 int qed_read_l1_table_sync(BDRVQEDState *s)
@@ -134,23 +123,17 @@ int qed_read_l1_table_sync(BDRVQEDState *s)
     return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
 
-void qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n,
-                        BlockCompletionFunc *cb, void *opaque)
+int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
-    qed_write_table(s, s->header.l1_table_offset,
-                    s->l1_table, index, n, false, cb, opaque);
+    return qed_write_table(s, s->header.l1_table_offset,
+                           s->l1_table, index, n, false);
 }
 
 int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
                             unsigned int n)
 {
-    int ret = -EINPROGRESS;
-
-    qed_write_l1_table(s, index, n, qed_sync_cb, &ret);
-    BDRV_POLL_WHILE(s->bs, ret == -EINPROGRESS);
-
-    return ret;
+    return qed_write_l1_table(s, index, n);
 }
 
 int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
@@ -197,22 +180,16 @@ int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset
     return qed_read_l2_table(s, request, offset);
 }
 
-void qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                        unsigned int index, unsigned int n, bool flush,
-                        BlockCompletionFunc *cb, void *opaque)
+int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
+                       unsigned int index, unsigned int n, bool flush)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L2_UPDATE);
-    qed_write_table(s, request->l2_table->offset,
-                    request->l2_table->table, index, n, flush, cb, opaque);
+    return qed_write_table(s, request->l2_table->offset,
+                           request->l2_table->table, index, n, flush);
 }
 
 int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
                             unsigned int index, unsigned int n, bool flush)
 {
-    int ret = -EINPROGRESS;
-
-    qed_write_l2_table(s, request, index, n, flush, qed_sync_cb, &ret);
-    BDRV_POLL_WHILE(s->bs, ret == -EINPROGRESS);
-
-    return ret;
+    return qed_write_l2_table(s, request, index, n, flush);
 }
diff --git a/block/qed.c b/block/qed.c
index 95f1050..8c493bb 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1000,7 +1000,8 @@ static void qed_aio_write_l1_update(void *opaque, int ret)
     index = qed_l1_index(s, acb->cur_pos);
     s->l1_table->offsets[index] = acb->request.l2_table->offset;
 
-    qed_write_l1_table(s, index, 1, qed_commit_l2_update, acb);
+    ret = qed_write_l1_table(s, index, 1);
+    qed_commit_l2_update(acb, ret);
 }
 
 /**
@@ -1027,12 +1028,13 @@ static void qed_aio_write_l2_update(QEDAIOCB *acb, int ret, uint64_t offset)
 
     if (need_alloc) {
         /* Write out the whole new L2 table */
-        qed_write_l2_table(s, &acb->request, 0, s->table_nelems, true,
-                           qed_aio_write_l1_update, acb);
+        ret = qed_write_l2_table(s, &acb->request, 0, s->table_nelems, true);
+        qed_aio_write_l1_update(acb, ret);
     } else {
         /* Write out only the updated part of the L2 table */
-        qed_write_l2_table(s, &acb->request, index, acb->cur_nclusters, false,
-                           qed_aio_next_io_cb, acb);
+        ret = qed_write_l2_table(s, &acb->request, index, acb->cur_nclusters,
+                                 false);
+        qed_aio_next_io(acb, ret);
     }
     return;
 
diff --git a/block/qed.h b/block/qed.h
index 46843c4..51443fa 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -220,16 +220,14 @@ void qed_commit_l2_cache_entry(L2TableCache *l2_cache, CachedL2Table *l2_table);
  * Table I/O functions
  */
 int qed_read_l1_table_sync(BDRVQEDState *s);
-void qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n,
-                        BlockCompletionFunc *cb, void *opaque);
+int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n);
 int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
                             unsigned int n);
 int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
                            uint64_t offset);
 int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset);
-void qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
-                        unsigned int index, unsigned int n, bool flush,
-                        BlockCompletionFunc *cb, void *opaque);
+int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
+                       unsigned int index, unsigned int n, bool flush);
 int qed_write_l2_table_sync(BDRVQEDState *s, QEDRequest *request,
                             unsigned int index, unsigned int n, bool flush);
 
-- 
1.8.3.1
