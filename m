Received: from eggs.gnu.org ([2001:4830:134:3::10]:41572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdfq4-0000Ba-6V
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdfq1-0003qY-Vi
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:20:24 -0500
Date: Tue, 14 Feb 2017 17:20:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170214162012.GC6189@noname.redhat.com>
References: <1487079565-3548-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487079565-3548-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, ct@flyingcircus.io

Am 14.02.2017 um 14:39 hat Peter Lieven geschrieben:
> this is something I have been thinking about for almost 2 years now.
> we heavily have the following two use cases when using qemu-img convert.
> 
> a) reading from NFS and writing to iSCSI for deploying templates
> b) reading from iSCSI and writing to NFS for backups
> 
> In both processes we use libiscsi and libnfs so we have no kernel pagecache.
> As qemu-img convert is implemented with sync operations that means we
> read one buffer and then write it. No parallelism and each sync request
> takes as long as it takes until it is completed.
> 
> This is version 3 of the approach using coroutine worker "threads".
> 
> So far I have the following runtimes when reading an uncompressed QCOW2 from
> NFS and writing it to iSCSI (raw):
> 
> qemu-img (master)
>  nfs -> iscsi 22.8 secs
>  nfs -> ram   11.7 secs
>  ram -> iscsi 12.3 secs
> 
> qemu-img-async
>  nfs -> iscsi 12.3 secs
>  nfs -> ram   10.5 secs
>  ram -> iscsi 11.7 secs
> 
> Comments appreciated.
> 
> Thank you,
> Peter
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> v2->v3: - updated stats in the commit msg from a host with a better network card
>         - only wake up the coroutine that is acutally waiting for a write to complete.
>           this was not only overhead, but also breaking at least linux AIO.
>         - fix coding style complaints
>         - rename some variables and structs
> 
> v1->v2: - using coroutine as worker "threads". [Max]
>         - keeping the request queue as otherwise it happens
>           that we wait on BLK_ZERO chunks while keeping the write order.
>           it also avoids redundant calls to get_block_status and helps
>           to skip some conditions for fully allocated imaged (!s->min_sparse)
> 
>  qemu-img.c | 213 +++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 145 insertions(+), 68 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index cff22e3..970863f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1448,6 +1448,16 @@ enum ImgConvertBlockStatus {
>      BLK_BACKING_FILE,
>  };
>  
> +typedef struct ImgConvertRequest {
> +    int64_t sector_num;
> +    enum ImgConvertBlockStatus status;
> +    int nb_sectors;
> +    QSIMPLEQ_ENTRY(ImgConvertRequest) next;
> +} ImgConvertRequest;

If I understand your code correctly, you first go through the image and
create an ImgConvertRequest for every chunk with the same allocation
status (well, actually not every chunk, but that may be a bug, see
below).

So let's assume a 1 TB image with every other cluster allocated:

    1T / (64k * 2) = 8M

A list with 8 million entries (requiring 8 million mallocs) feels
relatively large. Not counting malloc overhead (which might be
considerable here), I think we're at 192 MB memory usage for this case.
Not as bad as I was afraid, but not really nice either. And 1 TB isn't
even close to the maximum image size.

Is it really necessary to create this list at the beginning? Why can't
we just get the next chunk as the old code used to?

> +/* XXX: this should be a cmdline parameter */
> +#define NUM_COROUTINES 8
> +
>  typedef struct ImgConvertState {
>      BlockBackend **src;
>      int64_t *src_sectors;
> @@ -1455,6 +1465,8 @@ typedef struct ImgConvertState {
>      int64_t src_cur_offset;
>      int64_t total_sectors;
>      int64_t allocated_sectors;
> +    int64_t allocated_done;
> +    int64_t wr_offs;
>      enum ImgConvertBlockStatus status;
>      int64_t sector_next_status;
>      BlockBackend *target;
> @@ -1464,11 +1476,16 @@ typedef struct ImgConvertState {
>      int min_sparse;
>      size_t cluster_sectors;
>      size_t buf_sectors;
> +    Coroutine *co[NUM_COROUTINES];
> +    int64_t wait_sector_num[NUM_COROUTINES];
> +    QSIMPLEQ_HEAD(, ImgConvertRequest) queue;
> +    int ret;
>  } ImgConvertState;
>  
>  static void convert_select_part(ImgConvertState *s, int64_t sector_num)
>  {
> -    assert(sector_num >= s->src_cur_offset);
> +    s->src_cur_offset = 0;
> +    s->src_cur = 0;
>      while (sector_num - s->src_cur_offset >= s->src_sectors[s->src_cur]) {
>          s->src_cur_offset += s->src_sectors[s->src_cur];
>          s->src_cur++;

Is this necessary because we can effectively go backwards now when one
coroutine works already on the next part, but another one is still
processing the previous one? Worth a comment?

> @@ -1544,11 +1561,13 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>      return n;
>  }
>  
> -static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
> -                        uint8_t *buf)
> +static int convert_co_read(ImgConvertState *s, ImgConvertRequest *req,
> +                           uint8_t *buf, QEMUIOVector *qiov)

This is a weird interface: You want to get a created, but empty qiov
from the caller. There's no real point in that. The traditional approch
is having a struct iovec on the stack here locally and then using
qemu_iovec_init_external().

>  {
>      int n;
>      int ret;
> +    int64_t sector_num = req->sector_num;
> +    int nb_sectors = req->nb_sectors;
>  
>      assert(nb_sectors <= s->buf_sectors);
>      while (nb_sectors > 0) {
> @@ -1562,10 +1581,13 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>          blk = s->src[s->src_cur];
>          bs_sectors = s->src_sectors[s->src_cur];
>  
> +        qemu_iovec_reset(qiov);
>          n = MIN(nb_sectors, bs_sectors - (sector_num - s->src_cur_offset));
> -        ret = blk_pread(blk,
> -                        (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
> -                        buf, n << BDRV_SECTOR_BITS);
> +        qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
> +
> +        ret = blk_co_preadv(
> +                blk, (sector_num - s->src_cur_offset) << BDRV_SECTOR_BITS,
> +                n << BDRV_SECTOR_BITS, qiov, 0);
>          if (ret < 0) {
>              return ret;
>          }
> @@ -1578,15 +1600,18 @@ static int convert_read(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>      return 0;
>  }
>  
> -static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
> -                         const uint8_t *buf)
> +
> +static int convert_co_write(ImgConvertState *s, ImgConvertRequest *req,
> +                            uint8_t *buf, QEMUIOVector *qiov)

Same thing here.

Note that convert_write() used to be called unconditionally. This is not
the case any more because you don't create ImgConvertRequests
unconditionally. In particular, BLK_ZERO is skipped without -S 0 instead
of doing a blk_co_pwrite_zeroes(). This is a bug. The assertion in the
BLK_BACKING_FILE branch of the switch is also dead code now.

>  {
>      int ret;
> +    int64_t sector_num = req->sector_num;
> +    int nb_sectors = req->nb_sectors;
>  
>      while (nb_sectors > 0) {
>          int n = nb_sectors;
> -
> -        switch (s->status) {
> +        qemu_iovec_reset(qiov);
> +        switch (req->status) {
>          case BLK_BACKING_FILE:
>              /* If we have a backing file, leave clusters unallocated that are
>               * unallocated in the source image, so that the backing file is
> @@ -1607,9 +1632,10 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>                      break;
>                  }
>  
> -                ret = blk_pwrite_compressed(s->target,
> -                                            sector_num << BDRV_SECTOR_BITS,
> -                                            buf, n << BDRV_SECTOR_BITS);
> +                qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
> +                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
> +                                     n << BDRV_SECTOR_BITS, qiov,
> +                                     BDRV_REQ_WRITE_COMPRESSED);
>                  if (ret < 0) {
>                      return ret;
>                  }
> @@ -1622,8 +1648,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>              if (!s->min_sparse ||
>                  is_allocated_sectors_min(buf, n, &n, s->min_sparse))
>              {
> -                ret = blk_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
> -                                 buf, n << BDRV_SECTOR_BITS, 0);
> +                qemu_iovec_add(qiov, buf, n << BDRV_SECTOR_BITS);
> +                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
> +                                     n << BDRV_SECTOR_BITS, qiov, 0);
>                  if (ret < 0) {
>                      return ret;
>                  }
> @@ -1635,8 +1662,9 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>              if (s->has_zero_init) {
>                  break;
>              }
> -            ret = blk_pwrite_zeroes(s->target, sector_num << BDRV_SECTOR_BITS,
> -                                    n << BDRV_SECTOR_BITS, 0);
> +            ret = blk_co_pwrite_zeroes(s->target,
> +                                       sector_num << BDRV_SECTOR_BITS,
> +                                       n << BDRV_SECTOR_BITS, 0);
>              if (ret < 0) {
>                  return ret;
>              }
> @@ -1651,12 +1679,92 @@ static int convert_write(ImgConvertState *s, int64_t sector_num, int nb_sectors,
>      return 0;
>  }
>  
> -static int convert_do_copy(ImgConvertState *s)
> +static void convert_co_do_copy(void *opaque)
>  {
> +    ImgConvertState *s = opaque;
>      uint8_t *buf = NULL;
> -    int64_t sector_num, allocated_done;
> +    int ret, i;
> +    ImgConvertRequest *req, *next_req;
> +    QEMUIOVector qiov;
> +    int index = -1;
> +
> +    for (i = 0; i < NUM_COROUTINES; i++) {
> +        if (s->co[i] == qemu_coroutine_self()) {
> +            index = i;
> +            break;
> +        }
> +    }
> +    assert(index >= 0);
> +
> +    qemu_iovec_init(&qiov, 1);
> +    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
> +
> +    while (s->ret == -EINPROGRESS && (req = QSIMPLEQ_FIRST(&s->queue))) {
> +        QSIMPLEQ_REMOVE_HEAD(&s->queue, next);
> +        next_req = QSIMPLEQ_FIRST(&s->queue);
> +
> +        s->allocated_done += req->nb_sectors;
> +        qemu_progress_print(100.0 * s->allocated_done / s->allocated_sectors,
> +                            0);
> +
> +        if (req->status == BLK_DATA) {
> +            ret = convert_co_read(s, req, buf, &qiov);
> +            if (ret < 0) {
> +                error_report("error while reading sector %" PRId64
> +                             ": %s", req->sector_num, strerror(-ret));
> +                s->ret = ret;
> +                goto out;
> +            }
> +        }
> +
> +        /* keep writes in order */
> +        while (s->wr_offs != req->sector_num) {
> +            if (s->ret != -EINPROGRESS) {
> +                goto out;
> +            }
> +            s->wait_sector_num[index] = req->sector_num;
> +            qemu_coroutine_yield();
> +        }
> +        s->wait_sector_num[index] = -1;

Okay, so may this is the most important part of the patch.

If we need to keep writes in order, we can only have a single coroutine
that is currently writing. Then how likely is it that more than one
other coroutine could actually be reading at the same time rather than
just waiting for the current writer to be finished?

My assumption is that it effectively degenerates to exactly one reader
and one writer, which means that we don't actually need a command line
option to configure the number of coroutines, and that our default of 8
is already higher than useful.

The big question is then if the code could become simpler if we can
assume exactly two coroutines. Possibly even not two coroutines that do
the same thing, but one that reads and another one that writes,
coordinated with the usual coroutine locking mechanisms. (I haven't
thought enough about it to be sure that it would be an improvement, but
it doesn't feel too unlikely.)

On the other hand, if keeping writes in order is only actually needed in
specific cases, other cases could benefit from actual parallelism, even
though this is not implemented in this patch.

> +        ret = convert_co_write(s, req, buf, &qiov);
> +        if (ret < 0) {
> +            error_report("error while writing sector %" PRId64
> +                         ": %s", req->sector_num, strerror(-ret));
> +            s->ret = ret;
> +            goto out;
> +        }
> +
> +        if (!next_req) {
> +            /* the convert job is completed */
> +            s->ret = 0;
> +            s->wr_offs = s->total_sectors;
> +        } else {
> +            s->wr_offs = next_req->sector_num;
> +            /* reenter the coroutine that might have waited
> +             * for this write completion */
> +            for (i = 0; i < NUM_COROUTINES; i++) {
> +                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
> +                    qemu_coroutine_enter(s->co[i]);
> +                    break;
> +                }
> +            }
> +        }
> +
> +        g_free(req);
> +    }
> +
> +out:
> +    qemu_iovec_destroy(&qiov);
> +    qemu_vfree(buf);
> +    s->co[index] = NULL;
> +}

Kevin
