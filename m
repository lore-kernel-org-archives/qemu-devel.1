Received: from eggs.gnu.org ([2001:4830:134:3::10]:46018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT9EW-0001AN-Cw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT9ET-0002wp-Io
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:02:24 -0400
Date: Thu, 6 Jul 2017 18:02:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706160203.GM5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-20-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 19/21] block: Make bdrv_is_allocated()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the signature of the function to use int64_t *pnum ensures
> that the compiler enforces that all callers are updated.  For now,
> the io.c layer still assert()s that all callers are sector-aligned
> on input and that *pnum is sector-aligned on return to the caller,
> but that can be relaxed when a later patch implements byte-based
> block status.  Therefore, this code adds usages like
> DIV_ROUND_UP(,BDRV_SECTOR_SIZE) to callers that still want aligned
> values, where the call might reasonbly give non-aligned results
> in the future; on the other hand, no rounding is needed for callers
> that should just continue to work with byte alignment.
> 
> For the most part this patch is just the addition of scaling at the
> callers followed by inverse scaling at bdrv_is_allocated().  But
> some code, particularly bdrv_commit(), gets a lot simpler because it
> no longer has to mess with sectors; also, it is now possible to pass
> NULL if the caller does not care how much of the image is allocated
> beyond the initial offset.
> 
> For ease of review, bdrv_is_allocated_above() will be tackled
> separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

> diff --git a/block/io.c b/block/io.c
> index f662c97..cb40069 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1036,14 +1036,15 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>          int64_t start_sector = offset >> BDRV_SECTOR_BITS;
>          int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
>          unsigned int nb_sectors = end_sector - start_sector;
> -        int pnum;
> +        int64_t pnum;
> 
> -        ret = bdrv_is_allocated(bs, start_sector, nb_sectors, &pnum);
> +        ret = bdrv_is_allocated(bs, start_sector << BDRV_SECTOR_BITS,
> +                                nb_sectors << BDRV_SECTOR_BITS, &pnum);
>          if (ret < 0) {
>              goto out;
>          }
> 
> -        if (!ret || pnum != nb_sectors) {
> +        if (!ret || pnum != nb_sectors << BDRV_SECTOR_BITS) {
>              ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
>              goto out;
>          }

This code would become a lot simpler if you just removed the local
variables start_sector/end_sector and used the byte offsets instead that
are available in this function. (And even simpler once sector alignment
isn't required any more for bdrv_is_allocated(). Should we leave a
comment here so we won't forget the conversion?)

> @@ -1904,15 +1905,26 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
>                                         sector_num, nb_sectors, pnum, file);
>  }
> 
> -int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t sector_num,
> -                                   int nb_sectors, int *pnum)
> +int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
> +                                   int64_t bytes, int64_t *pnum)
>  {
>      BlockDriverState *file;
> -    int64_t ret = bdrv_get_block_status(bs, sector_num, nb_sectors, pnum,
> -                                        &file);
> +    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
> +    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
> +    int64_t ret;
> +    int psectors;
> +
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
> +           bytes < INT_MAX * BDRV_SECTOR_SIZE);

I think we can actually assert bytes <= INT_MAX. Both ways to write the
assertion are only true because of BDRV_REQUEST_MAX_SECTORS, which
ensures that the byte counts fit in an int.

Some of the places that call bdrv_is_allocated() actually depend on this
because your patches tend to use nb_sectors << BDRV_SECTOR_BITS (which
truncates) rather than nb_sectors * BDRV_SECTOR_BYTES (which is always a
64 bit calculation).

> +    ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
> +                                &file);
>      if (ret < 0) {
>          return ret;
>      }
> +    if (pnum) {
> +        *pnum = psectors * BDRV_SECTOR_SIZE;
> +    }
>      return !!(ret & BDRV_BLOCK_ALLOCATED);
>  }

> diff --git a/block/stream.c b/block/stream.c
> index e3dd2ac..e5f2a08 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -137,6 +137,7 @@ static void coroutine_fn stream_run(void *opaque)
> 
>      for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
>          bool copy;
> +        int64_t count = 0;
> 
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
> @@ -148,8 +149,8 @@ static void coroutine_fn stream_run(void *opaque)
> 
>          copy = false;
> 
> -        ret = bdrv_is_allocated(bs, offset / BDRV_SECTOR_SIZE,
> -                                STREAM_BUFFER_SIZE / BDRV_SECTOR_SIZE, &n);
> +        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &count);
> +        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>          if (ret == 1) {
>              /* Allocated in the top, no need to copy.  */
>          } else if (ret >= 0) {

I'm not sure if I agree with rounding up here. If ret == 0, it could
mean that we skip some data that is actually allocated. So I'd like an
assertion better.

The last patch of the series gets rid of this by switching the whole
function to bytes, so not that important.

> diff --git a/migration/block.c b/migration/block.c
> index 7674ae1..4a48e5c 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -34,7 +34,7 @@
>  #define BLK_MIG_FLAG_PROGRESS           0x04
>  #define BLK_MIG_FLAG_ZERO_BLOCK         0x08
> 
> -#define MAX_IS_ALLOCATED_SEARCH 65536
> +#define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
> 
>  #define MAX_INFLIGHT_IO 512
> 
> @@ -267,6 +267,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>      BlockBackend *bb = bmds->blk;
>      BlkMigBlock *blk;
>      int nr_sectors;
> +    int64_t count;
> 
>      if (bmds->shared_base) {
>          qemu_mutex_lock_iothread();
> @@ -274,9 +275,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>          /* Skip unallocated sectors; intentionally treats failure as
>           * an allocated sector */
>          while (cur_sector < total_sectors &&
> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
> -            cur_sector += nr_sectors;
> +               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTOR_SIZE,
> +                                  MAX_IS_ALLOCATED_SEARCH, &count)) {
> +            cur_sector += DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>          }
>          aio_context_release(blk_get_aio_context(bb));
>          qemu_mutex_unlock_iothread();

This one stays and it has the same problem. I think you need to round
down if you don't want to accidentally skip migrating allocated data.

> diff --git a/qemu-img.c b/qemu-img.c
> index d5a1560..5271b41 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3229,6 +3229,7 @@ static int img_rebase(int argc, char **argv)
>          int64_t new_backing_num_sectors = 0;
>          uint64_t sector;
>          int n;
> +        int64_t count;
>          float local_progress = 0;
> 
>          buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> @@ -3276,12 +3277,14 @@ static int img_rebase(int argc, char **argv)
>              }
> 
>              /* If the cluster is allocated, we don't need to take action */
> -            ret = bdrv_is_allocated(bs, sector, n, &n);
> +            ret = bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,
> +                                    n << BDRV_SECTOR_BITS, &count);
>              if (ret < 0) {
>                  error_report("error while reading image metadata: %s",
>                               strerror(-ret));
>                  goto out;
>              }
> +            n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>              if (ret) {
>                  continue;
>              }

Same thing. Sectors that are half allocated and half free must be
considered completely allocated if the caller can't do byte alignment.
Just rounding up without looking at ret isn't correct.

> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index b0ea327..e529b8f 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1894,15 +1889,14 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
>          }
> 
>          retstr = ret ? "    allocated" : "not allocated";
> -        cvtstr(num << BDRV_SECTOR_BITS, s1, sizeof(s1));
> -        cvtstr(offset << BDRV_SECTOR_BITS, s2, sizeof(s2));
> +        cvtstr(num, s1, sizeof(s1));
> +        cvtstr(offset, s2, sizeof(s2));
>          printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64 ")\n",
> -               s1, num << BDRV_SECTOR_BITS, retstr,
> -               s2, offset << BDRV_SECTOR_BITS);
> +               s1, num, retstr, s2, offset);
> 
>          offset += num;
> -        nb_sectors -= num;
> -    } while (offset < total_sectors);
> +        bytes -= num;
> +    };

This semicolon isn't needed.

Kevin
