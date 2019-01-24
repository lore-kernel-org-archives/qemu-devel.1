Received: from eggs.gnu.org ([209.51.188.92]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmfpY-0008DJ-6f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmfpS-0003jW-3Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:18:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 24 Jan 2019 15:17:31 +0100
Message-Id: <20190124141731.21509-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Depending on the exact image layout and the storage backend (tmpfs is
konwn to have very slow SEEK_HOLE/SEEK_DATA), caching lseek results can
save us a lot of time e.g. during a mirror block job or qemu-img convert
with a fragmented source image (.bdrv_co_block_status on the protocol
layer can be called for every single cluster in the extreme case).

We may only cache data regions because of possible concurrent writers.
This means that we can later treat a recently punched hole as data, but
this is safe. We can't cache holes because then we might treat recently
written data as holes, which can cause corruption.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8aee7a3fb8..7272c7c99d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -168,6 +168,12 @@ typedef struct BDRVRawState {
     bool needs_alignment;
     bool check_cache_dropped;
=20
+    struct seek_data_cache {
+        bool        valid;
+        uint64_t    start;
+        uint64_t    end;
+    } seek_data_cache;
+
     PRManager *pr_mgr;
 } BDRVRawState;
=20
@@ -1555,8 +1561,17 @@ static int handle_aiocb_write_zeroes_unmap(void *o=
paque)
 {
     RawPosixAIOData *aiocb =3D opaque;
     BDRVRawState *s G_GNUC_UNUSED =3D aiocb->bs->opaque;
+    struct seek_data_cache *sdc;
     int ret;
=20
+    /* Invalidate seek_data_cache if it overlaps */
+    sdc =3D &s->seek_data_cache;
+    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
+                        sdc->start > aiocb->aio_offset + aiocb->aio_nbyt=
es))
+    {
+        sdc->valid =3D false;
+    }
+
     /* First try to write zeros and unmap at the same time */
=20
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1634,11 +1649,20 @@ static int handle_aiocb_discard(void *opaque)
     RawPosixAIOData *aiocb =3D opaque;
     int ret =3D -EOPNOTSUPP;
     BDRVRawState *s =3D aiocb->bs->opaque;
+    struct seek_data_cache *sdc;
=20
     if (!s->has_discard) {
         return -ENOTSUP;
     }
=20
+    /* Invalidate seek_data_cache if it overlaps */
+    sdc =3D &s->seek_data_cache;
+    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
+                        sdc->start > aiocb->aio_offset + aiocb->aio_nbyt=
es))
+    {
+        sdc->valid =3D false;
+    }
+
     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
 #ifdef BLKDISCARD
         do {
@@ -2424,6 +2448,8 @@ static int coroutine_fn raw_co_block_status(BlockDr=
iverState *bs,
                                             int64_t *map,
                                             BlockDriverState **file)
 {
+    BDRVRawState *s =3D bs->opaque;
+    struct seek_data_cache *sdc;
     off_t data =3D 0, hole =3D 0;
     int ret;
=20
@@ -2439,6 +2465,14 @@ static int coroutine_fn raw_co_block_status(BlockD=
riverState *bs,
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
=20
+    sdc =3D &s->seek_data_cache;
+    if (sdc->valid && sdc->start <=3D offset && sdc->end > offset) {
+        *pnum =3D MIN(bytes, sdc->end - offset);
+        *map =3D offset;
+        *file =3D bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+    }
+
     ret =3D find_allocation(bs, offset, &data, &hole);
     if (ret =3D=3D -ENXIO) {
         /* Trailing hole */
@@ -2451,14 +2485,27 @@ static int coroutine_fn raw_co_block_status(Block=
DriverState *bs,
     } else if (data =3D=3D offset) {
         /* On a data extent, compute bytes to the end of the extent,
          * possibly including a partial sector at EOF. */
-        *pnum =3D MIN(bytes, hole - offset);
+        *pnum =3D hole - offset;
         ret =3D BDRV_BLOCK_DATA;
     } else {
         /* On a hole, compute bytes to the beginning of the next extent.=
  */
         assert(hole =3D=3D offset);
-        *pnum =3D MIN(bytes, data - offset);
+        *pnum =3D data - offset;
         ret =3D BDRV_BLOCK_ZERO;
     }
+
+    /* Caching allocated ranges is okay even if another process writes t=
o the
+     * same file because we allow declaring things allocated even if the=
re is a
+     * hole. However, we cannot cache holes without risking corruption. =
*/
+    if (ret =3D=3D BDRV_BLOCK_DATA) {
+        *sdc =3D (struct seek_data_cache) {
+            .valid  =3D true,
+            .start  =3D offset,
+            .end    =3D offset + *pnum,
+        };
+    }
+
+    *pnum =3D MIN(*pnum, bytes);
     *map =3D offset;
     *file =3D bs;
     return ret | BDRV_BLOCK_OFFSET_VALID;
--=20
2.20.1
