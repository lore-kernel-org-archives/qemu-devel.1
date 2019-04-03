Received: from eggs.gnu.org ([209.51.188.92]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDk-0000eF-Kt
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDi-0005Vv-HK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:25 -0500
Message-Id: <20190403030526.12258-7-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/7] nbd/server: Avoid unaligned
 read/block_status from backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD server code used bdrv_block_status_above() to determine where
to fragment structured read and block status replies.  However, the
protocol can only advertise the active layer's minimum block size; if
the active layer is backed by another file with smaller alignment,
then we can end up leaking unaligned results back through to the
client, in violation of the spec.

Fix this by exposing a new bdrv_block_status_aligned() function around
the recently-added internal bdrv_co_block_status_aligned, to guarantee
that all block status answers from backing layers are rounded up to
the alignment of the current layer.  Note that the underlying function
still requires aligned boundaries, but the public function copes with
unaligned inputs.

iotest 241 does not change in output, but running it manually with
traces shows the improved behavior; furthermore, reverting 737d3f5244
but leaving this patch in place lets the test pass (whereas before the
test would fail because the client had to work around the server's
non-compliance).

Note that while this fixes NBD_CMD_READ and NBD_CMD_BLOCK_STATUS for
base:allocation (because those rely on bdrv_block_status*), we still
have a theoretical compliance problem with NBD_CMD_BLOCK_STATUS for
qemu:dirty-bitmap:NN when visiting a bitmap created at a smaller
granularity than what we advertised. On the other hand, dirty bitmap
granularity cannot go below 512, and without the use of blkdebug
(which in turn needs patches before it can properly find dirty bitmaps
or track status from qcow2 backing chains), I can't provoke an NBD
server to advertise an alignment larger than 512.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  2 ++
 block/io.c            | 47 ++++++++++++++++++++++++++++++++++++++-----
 nbd/server.c          | 14 ++++++-------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa0..3f38fa57f2d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -444,6 +444,8 @@ int bdrv_block_status(BlockDriverState *bs, int64_t o=
ffset,
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base=
,
                             int64_t offset, int64_t bytes, int64_t *pnum=
,
                             int64_t *map, BlockDriverState **file);
+int bdrv_block_status_aligned(BlockDriverState *bs, int64_t offset,
+                              int64_t bytes, int64_t *pnum);
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *bas=
e,
diff --git a/block/io.c b/block/io.c
index 936877d3745..5e6c0d06018 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1981,6 +1981,7 @@ int bdrv_flush_all(void)
 typedef struct BdrvCoBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
+    uint32_t align;
     bool want_zero;
     int64_t offset;
     int64_t bytes;
@@ -2298,6 +2299,7 @@ early_out:

 static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                                    BlockDriverState *bas=
e,
+                                                   uint32_t align,
                                                    bool want_zero,
                                                    int64_t offset,
                                                    int64_t bytes,
@@ -2311,8 +2313,8 @@ static int coroutine_fn bdrv_co_block_status_above(=
BlockDriverState *bs,

     assert(bs !=3D base);
     for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
-        ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pnum, =
map,
-                                   file);
+        ret =3D bdrv_co_block_status_aligned(p, align, want_zero, offset=
, bytes,
+                                           pnum, map, file);
         if (ret < 0) {
             break;
         }
@@ -2342,7 +2344,7 @@ static void coroutine_fn bdrv_block_status_above_co=
_entry(void *opaque)
     BdrvCoBlockStatusData *data =3D opaque;

     data->ret =3D bdrv_co_block_status_above(data->bs, data->base,
-                                           data->want_zero,
+                                           data->align, data->want_zero,
                                            data->offset, data->bytes,
                                            data->pnum, data->map, data->=
file);
     data->done =3D true;
@@ -2356,6 +2358,7 @@ static void coroutine_fn bdrv_block_status_above_co=
_entry(void *opaque)
  */
 static int bdrv_common_block_status_above(BlockDriverState *bs,
                                           BlockDriverState *base,
+                                          uint32_t align,
                                           bool want_zero, int64_t offset=
,
                                           int64_t bytes, int64_t *pnum,
                                           int64_t *map,
@@ -2365,6 +2368,7 @@ static int bdrv_common_block_status_above(BlockDriv=
erState *bs,
     BdrvCoBlockStatusData data =3D {
         .bs =3D bs,
         .base =3D base,
+        .align =3D align,
         .want_zero =3D want_zero,
         .offset =3D offset,
         .bytes =3D bytes,
@@ -2389,7 +2393,7 @@ int bdrv_block_status_above(BlockDriverState *bs, B=
lockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum=
,
                             int64_t *map, BlockDriverState **file)
 {
-    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+    return bdrv_common_block_status_above(bs, base, 1, true, offset, byt=
es,
                                           pnum, map, file);
 }

@@ -2400,13 +2404,46 @@ int bdrv_block_status(BlockDriverState *bs, int64=
_t offset, int64_t bytes,
                                    offset, bytes, pnum, map, file);
 }

+/*
+ * Similar to bdrv_block_status_above(bs, NULL, ...), but ensures that
+ * the answer matches the minimum alignment of bs (smaller alignments
+ * in layers above will not leak through to the active layer). It is
+ * assumed that callers do not care about the resulting mapping of
+ * offsets to an underlying BDS.
+ */
+int bdrv_block_status_aligned(BlockDriverState *bs, int64_t offset,
+                              int64_t bytes, int64_t *pnum)
+{
+    /* Widen the request to aligned boundaries */
+    int64_t aligned_offset, aligned_bytes;
+    uint32_t align =3D bs->bl.request_alignment;
+    int ret;
+
+    assert(pnum);
+    aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
+    aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offset;
+    ret =3D bdrv_common_block_status_above(bs, NULL, align, true, aligne=
d_offset,
+                                         aligned_bytes, pnum, NULL, NULL=
);
+    if (ret < 0) {
+        *pnum =3D 0;
+        return ret;
+    }
+    assert(*pnum && QEMU_IS_ALIGNED(*pnum, align) &&
+           align > offset - aligned_offset);
+    *pnum -=3D offset - aligned_offset;
+    if (*pnum > bytes) {
+        *pnum =3D bytes;
+    }
+    return ret;
+}
+
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
     int ret;
     int64_t dummy;

-    ret =3D bdrv_common_block_status_above(bs, backing_bs(bs), false, of=
fset,
+    ret =3D bdrv_common_block_status_above(bs, backing_bs(bs), 1, false,=
 offset,
                                          bytes, pnum ? pnum : &dummy, NU=
LL,
                                          NULL);
     if (ret < 0) {
diff --git a/nbd/server.c b/nbd/server.c
index faa3c7879fd..576deb931c8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1792,7 +1792,7 @@ static int coroutine_fn nbd_co_send_structured_erro=
r(NBDClient *client,
 }

 /* Do a sparse read and send the structured reply to the client.
- * Returns -errno if sending fails. bdrv_block_status_above() failure is
+ * Returns -errno if sending fails. bdrv_block_status_aligned() failure =
is
  * reported to the client, at which point this function succeeds.
  */
 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
@@ -1808,10 +1808,9 @@ static int coroutine_fn nbd_co_send_sparse_read(NB=
DClient *client,

     while (progress < size) {
         int64_t pnum;
-        int status =3D bdrv_block_status_above(blk_bs(exp->blk), NULL,
-                                             offset + progress,
-                                             size - progress, &pnum, NUL=
L,
-                                             NULL);
+        int status =3D bdrv_block_status_aligned(blk_bs(exp->blk),
+                                               offset + progress,
+                                               size - progress, &pnum);
         bool final;

         if (status < 0) {
@@ -1864,7 +1863,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBD=
Client *client,
  * length encoded (which may be smaller than the original), and update
  * @nb_extents to the number of extents used.
  *
- * Returns zero on success and -errno on bdrv_block_status_above failure=
.
+ * Returns zero on success and -errno on bdrv_block_status_aligned failu=
re.
  */
 static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
                                   uint64_t *bytes, NBDExtent *extents,
@@ -1878,8 +1877,7 @@ static int blockstatus_to_extents(BlockDriverState =
*bs, uint64_t offset,
     while (remaining_bytes) {
         uint32_t flags;
         int64_t num;
-        int ret =3D bdrv_block_status_above(bs, NULL, offset, remaining_=
bytes,
-                                          &num, NULL, NULL);
+        int ret =3D bdrv_block_status_aligned(bs, offset, remaining_byte=
s, &num);

         if (ret < 0) {
             return ret;
--=20
2.20.1
