Received: from eggs.gnu.org ([2001:4830:134:3::10]:46628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6r2-0002Qx-21
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH6r1-00037s-4Y
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:08:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 11 May 2018 20:08:15 +0800
Message-Id: <20180511120823.7892-3-famz@redhat.com>
In-Reply-To: <20180511120823.7892-1-famz@redhat.com>
References: <20180511120823.7892-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/10] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

We don't verify the request range against s->size in the I/O callbacks
except for raw_co_pwritev. This is wrong (especially for
raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/raw-format.c | 63 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index a378547c99..803083f1a1 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -167,16 +167,36 @@ static void raw_reopen_abort(BDRVReopenState *state)
     state->opaque = NULL;
 }
 
+/* Check and adjust the offset, against 'offset' and 'size' options. */
+static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
+                                    uint64_t bytes)
+{
+    BDRVRawState *s = bs->opaque;
+
+    if (s->has_size && (*offset > s->size || bytes > (s->size - *offset))) {
+        /* There's not enough space for the data. Don't write anything and just
+         * fail to prevent leaking out of the size specified in options. */
+        return -ENOSPC;
+    }
+
+    if (*offset > UINT64_MAX - s->offset) {
+        return -EINVAL;
+    }
+    *offset += s->offset;
+
+    return 0;
+}
+
 static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
                                       uint64_t bytes, QEMUIOVector *qiov,
                                       int flags)
 {
-    BDRVRawState *s = bs->opaque;
+    int ret;
 
-    if (offset > UINT64_MAX - s->offset) {
-        return -EINVAL;
+    ret = raw_adjust_offset(bs, &offset, bytes);
+    if (ret) {
+        return ret;
     }
-    offset += s->offset;
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
@@ -186,23 +206,11 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                        uint64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
-    BDRVRawState *s = bs->opaque;
     void *buf = NULL;
     BlockDriver *drv;
     QEMUIOVector local_qiov;
     int ret;
 
-    if (s->has_size && (offset > s->size || bytes > (s->size - offset))) {
-        /* There's not enough space for the data. Don't write anything and just
-         * fail to prevent leaking out of the size specified in options. */
-        return -ENOSPC;
-    }
-
-    if (offset > UINT64_MAX - s->offset) {
-        ret = -EINVAL;
-        goto fail;
-    }
-
     if (bs->probed && offset < BLOCK_PROBE_BUF_SIZE && bytes) {
         /* Handling partial writes would be a pain - so we just
          * require that guests have 512-byte request alignment if
@@ -237,7 +245,10 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
         qiov = &local_qiov;
     }
 
-    offset += s->offset;
+    ret = raw_adjust_offset(bs, &offset, bytes);
+    if (ret) {
+        goto fail;
+    }
 
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
     ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
@@ -267,22 +278,24 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
                                              int64_t offset, int bytes,
                                              BdrvRequestFlags flags)
 {
-    BDRVRawState *s = bs->opaque;
-    if (offset > UINT64_MAX - s->offset) {
-        return -EINVAL;
+    int ret;
+
+    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes);
+    if (ret) {
+        return ret;
     }
-    offset += s->offset;
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
 
 static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
                                         int64_t offset, int bytes)
 {
-    BDRVRawState *s = bs->opaque;
-    if (offset > UINT64_MAX - s->offset) {
-        return -EINVAL;
+    int ret;
+
+    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes);
+    if (ret) {
+        return ret;
     }
-    offset += s->offset;
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
-- 
2.14.3
