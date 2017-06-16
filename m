Received: from eggs.gnu.org ([2001:4830:134:3::10]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvC6-0005zs-Sk
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLvC6-0001Tn-19
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:38:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 16 Jun 2017 19:36:54 +0200
Message-Id: <1497634636-20230-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/31] qed: Make qed_write_header()
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 76 +++++++++++++++++++++++--------------------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 658b31b..2665efc 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -92,41 +92,6 @@ int qed_write_header_sync(BDRVQEDState *s)
     return 0;
 }
 
-typedef struct {
-    GenericCB gencb;
-    BDRVQEDState *s;
-    struct iovec iov;
-    QEMUIOVector qiov;
-    int nsectors;
-    uint8_t *buf;
-} QEDWriteHeaderCB;
-
-static void qed_write_header_cb(void *opaque, int ret)
-{
-    QEDWriteHeaderCB *write_header_cb = opaque;
-
-    qemu_vfree(write_header_cb->buf);
-    gencb_complete(write_header_cb, ret);
-}
-
-static void qed_write_header_read_cb(void *opaque, int ret)
-{
-    QEDWriteHeaderCB *write_header_cb = opaque;
-    BDRVQEDState *s = write_header_cb->s;
-
-    if (ret) {
-        qed_write_header_cb(write_header_cb, ret);
-        return;
-    }
-
-    /* Update header */
-    qed_header_cpu_to_le(&s->header, (QEDHeader *)write_header_cb->buf);
-
-    bdrv_aio_writev(s->bs->file, 0, &write_header_cb->qiov,
-                    write_header_cb->nsectors, qed_write_header_cb,
-                    write_header_cb);
-}
-
 /**
  * Update header in-place (does not rewrite backing filename or other strings)
  *
@@ -144,18 +109,35 @@ static void qed_write_header(BDRVQEDState *s, BlockCompletionFunc cb,
 
     int nsectors = DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len = nsectors * BDRV_SECTOR_SIZE;
-    QEDWriteHeaderCB *write_header_cb = gencb_alloc(sizeof(*write_header_cb),
-                                                    cb, opaque);
-
-    write_header_cb->s = s;
-    write_header_cb->nsectors = nsectors;
-    write_header_cb->buf = qemu_blockalign(s->bs, len);
-    write_header_cb->iov.iov_base = write_header_cb->buf;
-    write_header_cb->iov.iov_len = len;
-    qemu_iovec_init_external(&write_header_cb->qiov, &write_header_cb->iov, 1);
-
-    bdrv_aio_readv(s->bs->file, 0, &write_header_cb->qiov, nsectors,
-                   qed_write_header_read_cb, write_header_cb);
+    uint8_t *buf;
+    struct iovec iov;
+    QEMUIOVector qiov;
+    int ret;
+
+    buf = qemu_blockalign(s->bs, len);
+    iov = (struct iovec) {
+        .iov_base = buf,
+        .iov_len = len,
+    };
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    ret = bdrv_preadv(s->bs->file, 0, &qiov);
+    if (ret < 0) {
+        goto out;
+    }
+
+    /* Update header */
+    qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
+
+    ret = bdrv_pwritev(s->bs->file, 0, &qiov);
+    if (ret < 0) {
+        goto out;
+    }
+
+    ret = 0;
+out:
+    qemu_vfree(buf);
+    cb(opaque, ret);
 }
 
 static uint64_t qed_max_image_size(uint32_t cluster_size, uint32_t table_size)
-- 
1.8.3.1
