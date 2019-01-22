Received: from eggs.gnu.org ([209.51.188.92]:59313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1MB-0002gy-7X
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1M9-0006Xk-VS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:05:07 -0500
Date: Tue, 22 Jan 2019 19:57:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190122185740.GC5220@localhost.localdomain>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 11.01.2019 um 12:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.01.2019 13:41, Kevin Wolf wrote:
> > Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> drv_co_block_status digs bs->file for additional, more accurate search
> >> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> >>
> >> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> >> knows, where are holes and where is data. But every block_status
> >> request calls lseek additionally. Assume a big disk, full of
> >> data, in any iterative copying block job (or img convert) we'll call
> >> lseek(HOLE) on every iteration, and each of these lseeks will have to
> >> iterate through all metadata up to the end of file. It's obviously
> >> ineffective behavior. And for many scenarios we don't need this lseek
> >> at all.
> >>
> >> So, let's "5daa74a6ebc" by default, leaving an option to return
> >> previous behavior, which is needed for scenarios with preallocated
> >> images.
> >>
> >> Add iotest illustrating new option semantics.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 
> > I still think that an option isn't a good solution and we should try use
> > some heuristics instead.
> 
> Do you think that heuristics would be better than fair cache for lseek results?

I just played a bit with this (qemu-img convert only), and how much
caching lseek() results helps depends completely on the image. As it
happened, my test image was the worst case where caching didn't buy us
much. Obviously, I can just as easily construct an image where it makes
a huge difference. I think that most real-world images should be able to
take good advantage of it, though, and it doesn't hurt, so maybe that's
a first thing that we can do in any case. It might not be the complete
solution, though.

Let me explain my test images: The case where all of this actually
matters for qemu-img convert is fragmented qcow2 images. If your image
isn't fragmented, we don't do lseek() a lot anyway because a single
bdrv_block_status() call already gives you the information for the whole
image. So I constructed a fragmented image, by writing to it backwards:

./qemu-img create -f qcow2 /tmp/test.qcow2 1G
for i in $(seq 16384 -1 0); do
    echo "write $((i * 65536)) 64k"
done | ./qemu-io /tmp/test.qcow2

It's not really surprising that caching the lseek() results doesn't help
much there as we're moving backwards and lseek() only returns results
about the things after the current position, not before the current
position. So this is probably the worst case.

So I constructed a second image, which is fragmented, too, but starts at
the beginning of the image file:

./qemu-img create -f qcow2 /tmp/test_forward.qcow2 1G
for i in $(seq 0 2 16384); do
    echo "write $((i * 65536)) 64k"
done | ./qemu-io /tmp/test_forward.qcow2
for i in $(seq 1 2 16384); do
    echo "write $((i * 65536)) 64k"
done | ./qemu-io /tmp/test_forward.qcow2

Here caching makes a huge difference:

    time ./qemu-img convert -p -n $IMG null-co://

                        uncached        cached
    test.qcow2             ~145s         ~70s
    test_forward.qcow2     ~110s        ~0.2s

Not completely sure why there is such a big difference even in the
uncached case, but it seems to be reproducible. I haven't looked into
that more closely.

> I don't see good heuristics, neither want to implement lseek optimizations.
> In our cases we don't need lseek under qcow2 at all, and it's obviously better
> just don't lseek in these cases.

I also did the same thing with an image where I allocated 2 MB chunks
instead of 64k (backwards), and that brings it down to ~3.5s without
caching and ~2s with caching.

So if we implemented the heuristics and lseek caching, maybe we're good?

Kevin


diff --git a/block/file-posix.c b/block/file-posix.c
index 8aee7a3fb8..7272c7c99d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -168,6 +168,12 @@ typedef struct BDRVRawState {
     bool needs_alignment;
     bool check_cache_dropped;

+    struct seek_data_cache {
+        bool        valid;
+        uint64_t    start;
+        uint64_t    end;
+    } seek_data_cache;
+
     PRManager *pr_mgr;
 } BDRVRawState;

@@ -1555,8 +1561,17 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 {
     RawPosixAIOData *aiocb = opaque;
     BDRVRawState *s G_GNUC_UNUSED = aiocb->bs->opaque;
+    struct seek_data_cache *sdc;
     int ret;

+    /* Invalidate seek_data_cache if it overlaps */
+    sdc = &s->seek_data_cache;
+    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
+                        sdc->start > aiocb->aio_offset + aiocb->aio_nbytes))
+    {
+        sdc->valid = false;
+    }
+
     /* First try to write zeros and unmap at the same time */

 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1634,11 +1649,20 @@ static int handle_aiocb_discard(void *opaque)
     RawPosixAIOData *aiocb = opaque;
     int ret = -EOPNOTSUPP;
     BDRVRawState *s = aiocb->bs->opaque;
+    struct seek_data_cache *sdc;
 
     if (!s->has_discard) {
         return -ENOTSUP;
     }
 
+    /* Invalidate seek_data_cache if it overlaps */
+    sdc = &s->seek_data_cache;
+    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
+                        sdc->start > aiocb->aio_offset + aiocb->aio_nbytes))
+    {
+        sdc->valid = false;
+    }
+
     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
 #ifdef BLKDISCARD
         do {
@@ -2424,6 +2448,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
                                             int64_t *map,
                                             BlockDriverState **file)
 {
+    BDRVRawState *s = bs->opaque;
+    struct seek_data_cache *sdc;
     off_t data = 0, hole = 0;
     int ret;
 
@@ -2439,6 +2465,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
 
+    sdc = &s->seek_data_cache;
+    if (sdc->valid && sdc->start <= offset && sdc->end > offset) {
+        *pnum = MIN(bytes, sdc->end - offset);
+        *map = offset;
+        *file = bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+    }
+
     ret = find_allocation(bs, offset, &data, &hole);
     if (ret == -ENXIO) {
         /* Trailing hole */
@@ -2451,14 +2485,27 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
     } else if (data == offset) {
         /* On a data extent, compute bytes to the end of the extent,
          * possibly including a partial sector at EOF. */
-        *pnum = MIN(bytes, hole - offset);
+        *pnum = hole - offset;
         ret = BDRV_BLOCK_DATA;
     } else {
         /* On a hole, compute bytes to the beginning of the next extent.  */
         assert(hole == offset);
-        *pnum = MIN(bytes, data - offset);
+        *pnum = data - offset;
         ret = BDRV_BLOCK_ZERO;
     }
+
+    /* Caching allocated ranges is okay even if another process writes to the
+     * same file because we allow declaring things allocated even if there is a
+     * hole. However, we cannot cache holes without risking corruption. */
+    if (ret == BDRV_BLOCK_DATA) {
+        *sdc = (struct seek_data_cache) {
+            .valid  = true,
+            .start  = offset,
+            .end    = offset + *pnum,
+        };
+    }
+
+    *pnum = MIN(*pnum, bytes);
     *map = offset;
     *file = bs;
     return ret | BDRV_BLOCK_OFFSET_VALID;
