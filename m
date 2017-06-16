Received: from eggs.gnu.org ([2001:4830:134:3::10]:52933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvC8-000613-1G
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvC7-0001Uv-2b
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:56 +0200
Message-Id: <1497634636-20230-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/31] qed: Make qed_write_table()
 synchronous
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

Note that this code is generally not running in coroutine context, so
this is an actual blocking synchronous operation. We'll fix this in a
moment.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 84 ++++++++++++++++++++-----------------------------------
 1 file changed, 30 insertions(+), 54 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index ffecbea..0cc93a7 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -52,46 +52,6 @@ out:
     return ret;
 }
 
-typedef struct {
-    GenericCB gencb;
-    BDRVQEDState *s;
-    QEDTable *orig_table;
-    QEDTable *table;
-    bool flush;             /* flush after write? */
-
-    struct iovec iov;
-    QEMUIOVector qiov;
-} QEDWriteTableCB;
-
-static void qed_write_table_cb(void *opaque, int ret)
-{
-    QEDWriteTableCB *write_table_cb = opaque;
-    BDRVQEDState *s = write_table_cb->s;
-
-    trace_qed_write_table_cb(s,
-                             write_table_cb->orig_table,
-                             write_table_cb->flush,
-                             ret);
-
-    if (ret) {
-        goto out;
-    }
-
-    if (write_table_cb->flush) {
-        /* We still need to flush first */
-        write_table_cb->flush = false;
-        qed_acquire(s);
-        bdrv_aio_flush(write_table_cb->s->bs, qed_write_table_cb,
-                       write_table_cb);
-        qed_release(s);
-        return;
-    }
-
-out:
-    qemu_vfree(write_table_cb->table);
-    gencb_complete(&write_table_cb->gencb, ret);
-}
-
 /**
  * Write out an updated part or all of a table
  *
@@ -108,10 +68,13 @@ static void qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
                             unsigned int index, unsigned int n, bool flush,
                             BlockCompletionFunc *cb, void *opaque)
 {
-    QEDWriteTableCB *write_table_cb;
     unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
     unsigned int start, end, i;
+    QEDTable *new_table;
+    struct iovec iov;
+    QEMUIOVector qiov;
     size_t len_bytes;
+    int ret;
 
     trace_qed_write_table(s, offset, table, index, n);
 
@@ -121,28 +84,41 @@ static void qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
 
     len_bytes = (end - start) * sizeof(uint64_t);
 
-    write_table_cb = gencb_alloc(sizeof(*write_table_cb), cb, opaque);
-    write_table_cb->s = s;
-    write_table_cb->orig_table = table;
-    write_table_cb->flush = flush;
-    write_table_cb->table = qemu_blockalign(s->bs, len_bytes);
-    write_table_cb->iov.iov_base = write_table_cb->table->offsets;
-    write_table_cb->iov.iov_len = len_bytes;
-    qemu_iovec_init_external(&write_table_cb->qiov, &write_table_cb->iov, 1);
+    new_table = qemu_blockalign(s->bs, len_bytes);
+    iov = (struct iovec) {
+        .iov_base = new_table->offsets,
+        .iov_len = len_bytes,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
 
     /* Byteswap table */
     for (i = start; i < end; i++) {
         uint64_t le_offset = cpu_to_le64(table->offsets[i]);
-        write_table_cb->table->offsets[i - start] = le_offset;
+        new_table->offsets[i - start] = le_offset;
     }
 
     /* Adjust for offset into table */
     offset += start * sizeof(uint64_t);
 
-    bdrv_aio_writev(s->bs->file, offset / BDRV_SECTOR_SIZE,
-                    &write_table_cb->qiov,
-                    write_table_cb->qiov.size / BDRV_SECTOR_SIZE,
-                    qed_write_table_cb, write_table_cb);
+    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
+    trace_qed_write_table_cb(s, table, flush, ret);
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (flush) {
+        qed_acquire(s);
+        ret = bdrv_flush(s->bs);
+        qed_release(s);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
+    ret = 0;
+out:
+    qemu_vfree(new_table);
+    cb(opaque, ret);
 }
 
 /**
-- 
1.8.3.1
