Received: from eggs.gnu.org ([2001:4830:134:3::10]:49982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTALN-0001VA-50
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTALL-0007k4-Cv
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:13:33 -0400
Date: Thu, 6 Jul 2017 19:13:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706171314.GO5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-22-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/21] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  In the common case, allocation is unlikely to ever use
> values that are not naturally sector-aligned, but it is possible
> that byte-based values will let us be more precise about allocation
> at the end of an unaligned file that can do byte-based access.
> 
> Changing the signature of the function to use int64_t *pnum ensures
> that the compiler enforces that all callers are updated.  For now,
> the io.c layer still assert()s that all callers are sector-aligned,
> but that can be relaxed when a later patch implements byte-based
> block status.  Therefore, for the most part this patch is just the
> addition of scaling at the callers followed by inverse scaling at
> bdrv_is_allocated().  But some code, particularly stream_run(),
> gets a lot simpler because it no longer has to mess with sectors.
> 
> For ease of review, bdrv_is_allocated() was tackled separately.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com> [replication part]
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> 
> ---
> v3-v4: no change
> v2: tweak function comments, favor bdrv_getlength() over ->total_sectors
> ---
>  include/block/block.h |  2 +-
>  block/commit.c        | 20 ++++++++------------
>  block/io.c            | 42 ++++++++++++++++++++----------------------
>  block/mirror.c        |  5 ++++-
>  block/replication.c   | 17 ++++++++++++-----
>  block/stream.c        | 21 +++++++++------------
>  qemu-img.c            | 10 +++++++---
>  7 files changed, 61 insertions(+), 56 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index d3e01fb..f0fdbe8 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -430,7 +430,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
>  int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
>                        int64_t *pnum);
>  int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
> -                            int64_t sector_num, int nb_sectors, int *pnum);
> +                            int64_t offset, int64_t bytes, int64_t *pnum);
> 
>  bool bdrv_is_read_only(BlockDriverState *bs);
>  bool bdrv_is_writable(BlockDriverState *bs);
> diff --git a/block/commit.c b/block/commit.c
> index 241aa95..774a8a5 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -146,7 +146,7 @@ static void coroutine_fn commit_run(void *opaque)
>      int64_t offset;
>      uint64_t delay_ns = 0;
>      int ret = 0;
> -    int n = 0; /* sectors */
> +    int64_t n = 0; /* bytes */
>      void *buf = NULL;
>      int bytes_written = 0;
>      int64_t base_len;
> @@ -171,7 +171,7 @@ static void coroutine_fn commit_run(void *opaque)
> 
>      buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
> 
> -    for (offset = 0; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
> +    for (offset = 0; offset < s->common.len; offset += n) {
>          bool copy;
> 
>          /* Note that even when no rate limit is applied we need to yield
> @@ -183,15 +183,12 @@ static void coroutine_fn commit_run(void *opaque)
>          }
>          /* Copy if allocated above the base */
>          ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
> -                                      offset / BDRV_SECTOR_SIZE,
> -                                      COMMIT_BUFFER_SIZE / BDRV_SECTOR_SIZE,
> -                                      &n);
> +                                      offset, COMMIT_BUFFER_SIZE, &n);
>          copy = (ret == 1);
> -        trace_commit_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
> +        trace_commit_one_iteration(s, offset, n, ret);
>          if (copy) {
> -            ret = commit_populate(s->top, s->base, offset,
> -                                  n * BDRV_SECTOR_SIZE, buf);
> -            bytes_written += n * BDRV_SECTOR_SIZE;
> +            ret = commit_populate(s->top, s->base, offset, n, buf);
> +            bytes_written += n;
>          }
>          if (ret < 0) {
>              BlockErrorAction action =
> @@ -204,11 +201,10 @@ static void coroutine_fn commit_run(void *opaque)
>              }
>          }
>          /* Publish progress */
> -        s->common.offset += n * BDRV_SECTOR_SIZE;
> +        s->common.offset += n;
> 
>          if (copy && s->common.speed) {
> -            delay_ns = ratelimit_calculate_delay(&s->limit,
> -                                                 n * BDRV_SECTOR_SIZE);
> +            delay_ns = ratelimit_calculate_delay(&s->limit, n);
>          }
>      }
> 
> diff --git a/block/io.c b/block/io.c
> index fb8d1c7..569c503 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1931,54 +1931,52 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>  /*
>   * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
>   *
> - * Return true if the given sector is allocated in any image between
> - * BASE and TOP (inclusive).  BASE can be NULL to check if the given
> - * sector is allocated in any image of the chain.  Return false otherwise,
> + * Return true if the (prefix of the) given range is allocated in any image

(a prefix of) the given range

> + * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
> + * offset is allocated in any image of the chain.  Return false otherwise,
>   * or negative errno on failure.
>   *
> - * 'pnum' is set to the number of sectors (including and immediately following
> - *  the specified sector) that are known to be in the same
> - *  allocated/unallocated state.
> + * 'pnum' is set to the number of bytes (including and immediately
> + * following the specified offset) that are known to be in the same
> + * allocated/unallocated state.  Note that a subsequent call starting
> + * at 'offset + *pnum' may return the same allocation status (in other
> + * words, the result is not necessarily the maximum possible range);
> + * but 'pnum' will only be 0 when end of file is reached.
>   *
>   */
>  int bdrv_is_allocated_above(BlockDriverState *top,
>                              BlockDriverState *base,
> -                            int64_t sector_num,
> -                            int nb_sectors, int *pnum)
> +                            int64_t offset, int64_t bytes, int64_t *pnum)
>  {
>      BlockDriverState *intermediate;
> -    int ret, n = nb_sectors;
> +    int ret;
> +    int64_t n = bytes;
> 
>      intermediate = top;
>      while (intermediate && intermediate != base) {
>          int64_t pnum_inter;
>          int64_t size_inter;
> -        int psectors_inter;
> 
> -        ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
> -                                nb_sectors * BDRV_SECTOR_SIZE,
> -                                &pnum_inter);
> +        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
>          if (ret < 0) {
>              return ret;
>          }
> -        assert(pnum_inter < INT_MAX * BDRV_SECTOR_SIZE);
> -        psectors_inter = pnum_inter >> BDRV_SECTOR_BITS;
>          if (ret) {
> -            *pnum = psectors_inter;
> +            *pnum = pnum_inter;
>              return 1;
>          }
> 
>          /*
> -         * [sector_num, nb_sectors] is unallocated on top but intermediate
> -         * might have [sector_num+x, nb_sectors-x] allocated.
> +         * [offset, bytes] is unallocated on top but intermediate
> +         * might have [offset+x, bytes-x] allocated.
>           */

The comment still doesn't make sense. It already starts with the fact
that [offset, pnum_inter] is the unallocated range, not [offset, bytes],
and doesn't end with offset + x never actually being looked at.

> -        size_inter = bdrv_nb_sectors(intermediate);
> +        size_inter = bdrv_getlength(intermediate);
>          if (size_inter < 0) {
>              return size_inter;
>          }
> -        if (n > psectors_inter &&
> -            (intermediate == top || sector_num + psectors_inter < size_inter)) {
> -            n = psectors_inter;
> +        if (n > pnum_inter &&
> +            (intermediate == top || offset + pnum_inter < size_inter)) {
> +            n = pnum_inter;
>          }
> 
>          intermediate = backing_bs(intermediate);
> diff --git a/block/mirror.c b/block/mirror.c
> index f54a8d7..c717f60 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -621,6 +621,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>      BlockDriverState *bs = s->source;
>      BlockDriverState *target_bs = blk_bs(s->target);
>      int ret, n;
> +    int64_t count;
> 
>      end = s->bdev_length / BDRV_SECTOR_SIZE;
> 
> @@ -670,11 +671,13 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              return 0;
>          }
> 
> -        ret = bdrv_is_allocated_above(bs, base, sector_num, nb_sectors, &n);
> +        ret = bdrv_is_allocated_above(bs, base, sector_num * BDRV_SECTOR_SIZE,
> +                                      nb_sectors * BDRV_SECTOR_SIZE, &count);
>          if (ret < 0) {
>              return ret;
>          }
> 
> +        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);

The usual thing again. Partially allocated sectors need to be considered
fully allocated rather than using whatever the status of the first part
is.

>          assert(n > 0);
>          if (ret == 1) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, sector_num, n);
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 5271b41..960f42a 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1477,12 +1477,16 @@ static int img_compare(int argc, char **argv)
>          }
> 
>          for (;;) {
> +            int64_t count;
> +
>              nb_sectors = sectors_to_process(total_sectors_over, sector_num);
>              if (nb_sectors <= 0) {
>                  break;
>              }
> -            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL, sector_num,
> -                                          nb_sectors, &pnum);
> +            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
> +                                          sector_num * BDRV_SECTOR_SIZE,
> +                                          nb_sectors * BDRV_SECTOR_SIZE,
> +                                          &count);
>              if (ret < 0) {
>                  ret = 3;
>                  error_report("Sector allocation test failed for %s",
> @@ -1490,7 +1494,7 @@ static int img_compare(int argc, char **argv)
>                  goto out;
> 
>              }
> -            nb_sectors = pnum;
> +            nb_sectors = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
>              if (ret) {
>                  ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
>                                            filename_over, buf1, quiet);

And one final instance of the same bug.

Kevin
