Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIM-0001X2-Uv
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIL-0002an-Ev
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:02 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:27 -0500
Message-Id: <20180723201748.25573-19-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 18/99] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

We don't verify the request range against s->size in the I/O callbacks
except for raw_co_pwritev. This is inconsistent (especially for
raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them, in the meanwhile
make the helper reusable by the coming new callbacks.

Note that in most cases the block layer already verifies the request
byte range against our reported image length, before invoking the driver
callbacks.  The exception is during image creating, after
blk_set_allow_write_beyond_eof(blk, true) is called. But in that case,
the requests are not directly from the user or guest. So there is no
visible behavior change in adding the check code.

The int64_t -> uint64_t inconsistency, as shown by the type casting, is
pre-existing due to the interface.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180601092648.24614-3-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 384455385248762e74a080978f18f0c8f74757fe)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/raw-format.c | 64 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index a378547c99..17b9d4e052 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -167,16 +167,37 @@ static void raw_reopen_abort(BDRVReopenState *state)
     state->opaque = NULL;
 }
 
+/* Check and adjust the offset, against 'offset' and 'size' options. */
+static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
+                                    uint64_t bytes, bool is_write)
+{
+    BDRVRawState *s = bs->opaque;
+
+    if (s->has_size && (*offset > s->size || bytes > (s->size - *offset))) {
+        /* There's not enough space for the write, or the read request is
+         * out-of-range. Don't read/write anything to prevent leaking out of
+         * the size specified in options. */
+        return is_write ? -ENOSPC : -EINVAL;;
+    }
+
+    if (*offset > INT64_MAX - s->offset) {
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
+    ret = raw_adjust_offset(bs, &offset, bytes, false);
+    if (ret) {
+        return ret;
     }
-    offset += s->offset;
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
@@ -186,23 +207,11 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
@@ -237,7 +246,10 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
         qiov = &local_qiov;
     }
 
-    offset += s->offset;
+    ret = raw_adjust_offset(bs, &offset, bytes, true);
+    if (ret) {
+        goto fail;
+    }
 
     BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
     ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
@@ -267,22 +279,24 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
                                              int64_t offset, int bytes,
                                              BdrvRequestFlags flags)
 {
-    BDRVRawState *s = bs->opaque;
-    if (offset > UINT64_MAX - s->offset) {
-        return -EINVAL;
+    int ret;
+
+    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
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
+    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
+    if (ret) {
+        return ret;
     }
-    offset += s->offset;
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
-- 
2.17.1
