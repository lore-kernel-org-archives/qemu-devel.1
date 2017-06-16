Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCd-0006WF-Mp
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvCc-000290-TJ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:37:09 +0200
Message-Id: <1497634636-20230-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/31] qed: Remove recursion in
 qed_aio_next_io()
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

Instead of calling itself recursively as the last thing, just convert
qed_aio_next_io() into a loop.

This patch is best reviewed with 'git show -w' because most of it is
just whitespace changes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 63 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index db80987..e762169 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1280,45 +1280,46 @@ static void qed_aio_next_io(QEDAIOCB *acb)
     size_t len;
     int ret;
 
-    trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
+    while (1) {
+        trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
 
-    if (acb->backing_qiov) {
-        qemu_iovec_destroy(acb->backing_qiov);
-        g_free(acb->backing_qiov);
-        acb->backing_qiov = NULL;
-    }
+        if (acb->backing_qiov) {
+            qemu_iovec_destroy(acb->backing_qiov);
+            g_free(acb->backing_qiov);
+            acb->backing_qiov = NULL;
+        }
 
-    acb->qiov_offset += acb->cur_qiov.size;
-    acb->cur_pos += acb->cur_qiov.size;
-    qemu_iovec_reset(&acb->cur_qiov);
+        acb->qiov_offset += acb->cur_qiov.size;
+        acb->cur_pos += acb->cur_qiov.size;
+        qemu_iovec_reset(&acb->cur_qiov);
 
-    /* Complete request */
-    if (acb->cur_pos >= acb->end_pos) {
-        qed_aio_complete(acb, 0);
-        return;
-    }
+        /* Complete request */
+        if (acb->cur_pos >= acb->end_pos) {
+            qed_aio_complete(acb, 0);
+            return;
+        }
 
-    /* Find next cluster and start I/O */
-    len = acb->end_pos - acb->cur_pos;
-    ret = qed_find_cluster(s, &acb->request, acb->cur_pos, &len, &offset);
-    if (ret < 0) {
-        qed_aio_complete(acb, ret);
-        return;
-    }
+        /* Find next cluster and start I/O */
+        len = acb->end_pos - acb->cur_pos;
+        ret = qed_find_cluster(s, &acb->request, acb->cur_pos, &len, &offset);
+        if (ret < 0) {
+            qed_aio_complete(acb, ret);
+            return;
+        }
 
-    if (acb->flags & QED_AIOCB_WRITE) {
-        ret = qed_aio_write_data(acb, ret, offset, len);
-    } else {
-        ret = qed_aio_read_data(acb, ret, offset, len);
-    }
+        if (acb->flags & QED_AIOCB_WRITE) {
+            ret = qed_aio_write_data(acb, ret, offset, len);
+        } else {
+            ret = qed_aio_read_data(acb, ret, offset, len);
+        }
 
-    if (ret < 0) {
-        if (ret != -EINPROGRESS) {
-            qed_aio_complete(acb, ret);
+        if (ret < 0) {
+            if (ret != -EINPROGRESS) {
+                qed_aio_complete(acb, ret);
+            }
+            return;
         }
-        return;
     }
-    qed_aio_next_io(acb);
 }
 
 static BlockAIOCB *qed_aio_setup(BlockDriverState *bs,
-- 
1.8.3.1
