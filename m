Received: from eggs.gnu.org ([2001:4830:134:3::10]:60690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VRE-0001eb-VR
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f1VR9-00039T-V2
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:09:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Mar 2018 19:09:09 +0800
Message-Id: <20180329110914.20888-4-famz@redhat.com>
In-Reply-To: <20180329110914.20888-1-famz@redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/8] block: Introduce bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

This tries to do offloaded data copying in the same procotol (but
possibly a different BDS), or fall back to a bounce buffer if not
supported.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |   4 ++
 include/block/block_int.h |  14 +++++
 3 files changed, 166 insertions(+)

diff --git a/block/io.c b/block/io.c
index 1b4cfcacb1..64cd3a5170 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2870,3 +2870,151 @@ int coroutine_fn bdrv_co_map_range(BdrvChild *child, int64_t offset,
     }
     return -ENOTSUP;
 }
+
+typedef struct {
+    BdrvChild *child;
+    int64_t offset;
+    int64_t remaining;
+    BlockDriverState *file;
+    int64_t map;
+    int64_t pnum;
+    int status;
+} BdrvCopyRangeState;
+
+static inline void bdrv_range_advance(BdrvCopyRangeState *s, int bytes)
+{
+    s->offset += bytes;
+    s->remaining -= bytes;
+    assert(s->remaining >= 0);
+    s->map = 0;
+    s->pnum = MAX(0, s->pnum - bytes);
+    s->file = NULL;
+}
+
+static int coroutine_fn
+bdrv_co_copy_range_iteration(BdrvCopyRangeState *in, BdrvCopyRangeState *out)
+{
+    int ret;
+    int bytes = MIN(in->remaining, out->remaining);
+    QEMUIOVector qiov;
+    BlockDriverState *in_bs = in->child->bs;
+    BlockDriverState *out_bs = out->child->bs;
+    uint8_t *buf;
+
+    if (!in->pnum) {
+        in->status = bdrv_co_map_range(in->child, in->offset, in->remaining,
+                                       &in->pnum, &in->map, &in->file, 0);
+    }
+    if (in->status < 0 || !in->file ||
+        in->offset + bytes > bdrv_getlength(in->file)) {
+        goto fallback;
+    }
+
+    assert(in->pnum > 0);
+    bytes = MIN(bytes, in->pnum);
+    if (in->status & BDRV_BLOCK_ZERO) {
+        ret = bdrv_co_pwrite_zeroes(out->child, out->offset, in->pnum, 0);
+        if (ret) {
+            return ret;
+        }
+        bdrv_range_advance(in, bytes);
+        bdrv_range_advance(out, bytes);
+        return 0;
+    }
+
+    if (!(in->status & BDRV_BLOCK_OFFSET_VALID)) {
+        goto fallback;
+    }
+
+    out->status = bdrv_co_map_range(out->child, out->offset, out->remaining,
+                                    &out->pnum, &out->map, &out->file,
+                                    BDRV_REQ_ALLOCATE);
+    if (out->status < 0 || !out->file ||
+        !(out->status & BDRV_BLOCK_OFFSET_VALID)) {
+        goto fallback;
+    }
+
+    bytes = MIN(bytes, out->pnum);
+
+    if (in->file->drv->bdrv_co_copy_range) {
+        if (!in->file->drv->bdrv_co_copy_range(in->file, in->map,
+                                               out->file, out->map,
+                                               bytes)) {
+            bdrv_range_advance(in, bytes);
+            bdrv_range_advance(out, bytes);
+            return 0;
+        }
+    }
+    /* At this point we could maximize bytes again */
+    bytes = MIN(in->remaining, out->remaining);
+
+fallback:
+    buf = qemu_try_memalign(MAX(bdrv_opt_mem_align(in_bs),
+                                bdrv_opt_mem_align(out_bs)),
+                            bytes);
+    if (!buf) {
+        return -ENOMEM;
+    }
+
+    qemu_iovec_init(&qiov, 1);
+    qemu_iovec_add(&qiov, buf, bytes);
+
+    ret = bdrv_co_preadv(in->child, in->offset, bytes, &qiov, 0);
+    if (ret) {
+        goto out;
+    }
+    ret = bdrv_co_pwritev(out->child, out->offset, bytes, &qiov, 0);
+    if (!ret) {
+        bdrv_range_advance(in, bytes);
+        bdrv_range_advance(out, bytes);
+    }
+
+out:
+    qemu_vfree(buf);
+    qemu_iovec_destroy(&qiov);
+    return ret;
+}
+
+int coroutine_fn bdrv_co_copy_range(BdrvChild *child_in, int64_t off_in,
+                                    BdrvChild *child_out, int64_t off_out,
+                                    int bytes)
+{
+    BdrvTrackedRequest in_req, out_req;
+    BlockDriverState *in_bs = child_in->bs;
+    BlockDriverState *out_bs = child_out->bs;
+    int ret = 0;
+    BdrvCopyRangeState in = (BdrvCopyRangeState) {
+        .child = child_in,
+        .offset = off_in,
+        .remaining = bytes,
+    };
+    BdrvCopyRangeState out = (BdrvCopyRangeState) {
+        .child = child_out,
+        .offset = off_out,
+        .remaining = bytes,
+    };
+
+    bdrv_inc_in_flight(in_bs);
+    bdrv_inc_in_flight(out_bs);
+    tracked_request_begin(&in_req, in_bs, off_in, bytes, BDRV_TRACKED_READ);
+    tracked_request_begin(&out_req, out_bs, off_out, bytes, BDRV_TRACKED_WRITE);
+
+    wait_serialising_requests(&in_req);
+    wait_serialising_requests(&out_req);
+
+    while (in.remaining > 0) {
+        ret = bdrv_co_copy_range_iteration(&in, &out);
+        assert(in.remaining == out.remaining);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+    assert(in.remaining == 0);
+    assert(out.remaining == 0);
+out:
+    tracked_request_end(&in_req);
+    tracked_request_end(&out_req);
+    bdrv_dec_in_flight(in_bs);
+    bdrv_dec_in_flight(out_bs);
+    return ret;
+}
diff --git a/include/block/block.h b/include/block/block.h
index 21d3e9db32..7d57e53cfe 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -610,4 +610,8 @@ int bdrv_co_map_range(BdrvChild *child, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
                       BlockDriverState **file,
                       int flags);
+int bdrv_co_copy_range(BdrvChild *child_in, int64_t off_in,
+                       BdrvChild *child_out, int64_t off_out,
+                       int bytes);
+
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3f3f6f3efd..10a23b5754 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -496,6 +496,20 @@ struct BlockDriver {
                              int64_t bytes, int64_t *pnum, int64_t *map,
                              BlockDriverState **file,
                              int flags);
+    /**
+     * Do offloaded copying of data range. Must be implemented together with
+     * bdrv_co_map_range.
+     *
+     * @bs: where to copy data from
+     * @off_in: the offset to copy data from in @bs
+     * @out: where to write data to. This is guaranteed to be the same
+     *       BlockDriver as @bs
+     * @off_out: the offset to copy data to in @out
+     * @bytes: the number of bytes to copy
+     */
+    int (*bdrv_co_copy_range)(BlockDriverState *bs, int64_t off_in,
+                              BlockDriverState *out, int64_t off_out,
+                              int bytes);
     QLIST_ENTRY(BlockDriver) list;
 };
 
-- 
2.14.3
