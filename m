Received: from eggs.gnu.org ([2001:4830:134:3::10]:52683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBm-0005hC-9q
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBl-0001E6-CF
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:47 +0200
Message-Id: <1497634636-20230-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/31] qed: Make qed_read_table() synchronous
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 56 ++++++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index b12c298..f330538 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -18,59 +18,39 @@
 #include "qed.h"
 #include "qemu/bswap.h"
 
-typedef struct {
-    GenericCB gencb;
-    BDRVQEDState *s;
-    QEDTable *table;
-
-    struct iovec iov;
+static void qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
+                           BlockCompletionFunc *cb, void *opaque)
+{
     QEMUIOVector qiov;
-} QEDReadTableCB;
+    int noffsets;
+    int i, ret;
 
-static void qed_read_table_cb(void *opaque, int ret)
-{
-    QEDReadTableCB *read_table_cb = opaque;
-    QEDTable *table = read_table_cb->table;
-    BDRVQEDState *s = read_table_cb->s;
-    int noffsets = read_table_cb->qiov.size / sizeof(uint64_t);
-    int i;
+    struct iovec iov = {
+        .iov_base = table->offsets,
+        .iov_len = s->header.cluster_size * s->header.table_size,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
 
-    /* Handle I/O error */
-    if (ret) {
+    trace_qed_read_table(s, offset, table);
+
+    ret = bdrv_preadv(s->bs->file, offset, &qiov);
+    if (ret < 0) {
         goto out;
     }
 
     /* Byteswap offsets */
     qed_acquire(s);
+    noffsets = qiov.size / sizeof(uint64_t);
     for (i = 0; i < noffsets; i++) {
         table->offsets[i] = le64_to_cpu(table->offsets[i]);
     }
     qed_release(s);
 
+    ret = 0;
 out:
     /* Completion */
-    trace_qed_read_table_cb(s, read_table_cb->table, ret);
-    gencb_complete(&read_table_cb->gencb, ret);
-}
-
-static void qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
-                           BlockCompletionFunc *cb, void *opaque)
-{
-    QEDReadTableCB *read_table_cb = gencb_alloc(sizeof(*read_table_cb),
-                                                cb, opaque);
-    QEMUIOVector *qiov = &read_table_cb->qiov;
-
-    trace_qed_read_table(s, offset, table);
-
-    read_table_cb->s = s;
-    read_table_cb->table = table;
-    read_table_cb->iov.iov_base = table->offsets,
-    read_table_cb->iov.iov_len = s->header.cluster_size * s->header.table_size,
-
-    qemu_iovec_init_external(qiov, &read_table_cb->iov, 1);
-    bdrv_aio_readv(s->bs->file, offset / BDRV_SECTOR_SIZE, qiov,
-                   qiov->size / BDRV_SECTOR_SIZE,
-                   qed_read_table_cb, read_table_cb);
+    trace_qed_read_table_cb(s, table, ret);
+    cb(opaque, ret);
 }
 
 typedef struct {
-- 
1.8.3.1
