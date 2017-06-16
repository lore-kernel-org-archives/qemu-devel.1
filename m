Received: from eggs.gnu.org ([2001:4830:134:3::10]:52840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBz-0005rZ-U7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvBy-0001PR-VZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:37:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:52 +0200
Message-Id: <1497634636-20230-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/31] qed: Make
 qed_copy_from_backing_file() synchronous
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
 block/qed.c | 78 +++++++++++++++++++++++--------------------------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 1105f19..af53b8f 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -854,44 +854,6 @@ static int qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
     return 0;
 }
 
-typedef struct {
-    GenericCB gencb;
-    BDRVQEDState *s;
-    QEMUIOVector qiov;
-    QEMUIOVector *backing_qiov;
-    struct iovec iov;
-    uint64_t offset;
-} CopyFromBackingFileCB;
-
-static void qed_copy_from_backing_file_cb(void *opaque, int ret)
-{
-    CopyFromBackingFileCB *copy_cb = opaque;
-    qemu_vfree(copy_cb->iov.iov_base);
-    gencb_complete(&copy_cb->gencb, ret);
-}
-
-static void qed_copy_from_backing_file_write(void *opaque, int ret)
-{
-    CopyFromBackingFileCB *copy_cb = opaque;
-    BDRVQEDState *s = copy_cb->s;
-
-    if (copy_cb->backing_qiov) {
-        qemu_iovec_destroy(copy_cb->backing_qiov);
-        g_free(copy_cb->backing_qiov);
-        copy_cb->backing_qiov = NULL;
-    }
-
-    if (ret) {
-        qed_copy_from_backing_file_cb(copy_cb, ret);
-        return;
-    }
-
-    BLKDBG_EVENT(s->bs->file, BLKDBG_COW_WRITE);
-    bdrv_aio_writev(s->bs->file, copy_cb->offset / BDRV_SECTOR_SIZE,
-                    &copy_cb->qiov, copy_cb->qiov.size / BDRV_SECTOR_SIZE,
-                    qed_copy_from_backing_file_cb, copy_cb);
-}
-
 /**
  * Copy data from backing file into the image
  *
@@ -907,7 +869,9 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
                                        BlockCompletionFunc *cb,
                                        void *opaque)
 {
-    CopyFromBackingFileCB *copy_cb;
+    QEMUIOVector qiov;
+    QEMUIOVector *backing_qiov = NULL;
+    struct iovec iov;
     int ret;
 
     /* Skip copy entirely if there is no work to do */
@@ -916,17 +880,33 @@ static void qed_copy_from_backing_file(BDRVQEDState *s, uint64_t pos,
         return;
     }
 
-    copy_cb = gencb_alloc(sizeof(*copy_cb), cb, opaque);
-    copy_cb->s = s;
-    copy_cb->offset = offset;
-    copy_cb->backing_qiov = NULL;
-    copy_cb->iov.iov_base = qemu_blockalign(s->bs, len);
-    copy_cb->iov.iov_len = len;
-    qemu_iovec_init_external(&copy_cb->qiov, &copy_cb->iov, 1);
+    iov = (struct iovec) {
+        .iov_base = qemu_blockalign(s->bs, len),
+        .iov_len = len,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    ret = qed_read_backing_file(s, pos, &qiov, &backing_qiov);
+
+    if (backing_qiov) {
+        qemu_iovec_destroy(backing_qiov);
+        g_free(backing_qiov);
+        backing_qiov = NULL;
+    }
+
+    if (ret) {
+        goto out;
+    }
 
-    ret = qed_read_backing_file(s, pos, &copy_cb->qiov,
-                                &copy_cb->backing_qiov);
-    qed_copy_from_backing_file_write(copy_cb, ret);
+    BLKDBG_EVENT(s->bs->file, BLKDBG_COW_WRITE);
+    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
+    if (ret < 0) {
+        goto out;
+    }
+    ret = 0;
+out:
+    qemu_vfree(iov.iov_base);
+    cb(opaque, ret);
 }
 
 /**
-- 
1.8.3.1
