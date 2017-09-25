Received: from eggs.gnu.org ([2001:4830:134:3::10]:37104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwc6S-0006xm-Ah
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwc6Q-0006rl-4r
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:43:52 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8ded19fb-d0dc-d816-b045-07184bf77db3@redhat.com>
Date: Mon, 25 Sep 2017 18:43:37 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/23] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> Not all callers care about which BDS owns the mapping for a given
> range of the file.  This patch merely simplifies the callers by
> consolidating the logic in the common call point, while guaranteeing
> a non-NULL file to all the driver callbacks, for no semantic change.
> The only caller that does not care about pnum is bdrv_is_allocated,
> as invoked by vvfat; we can likewise add assertions that the rest
> of the stack does not have to worry about a NULL pnum.
> 
> Furthermore, this will also set the stage for a future cleanup: when
> a caller does not care about which BDS owns an offset, it would be
> nice to allow the driver to optimize things to not have to return
> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented
> allocation (for example, it's fairly easy to create a qcow2 image
> where consecutive guest addresses are not at consecutive host
> addresses), the current contract requires bdrv_get_block_status()
> to clamp *pnum to the limit where host addresses are no longer
> consecutive, but allowing a NULL file means that *pnum could be
> set to the full length of known-allocated data.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v4: only context changes
> v3: rebase to recent changes (qcow2_measure), dropped R-b
> v2: use local variable and final transfer, rather than assignment
> of parameter to local
> [previously in different series]:
> v2: new patch, https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05645.html
> ---
>  include/block/block_int.h | 10 ++++++----
>  block/io.c                | 44 ++++++++++++++++++++++++++++----------------
>  block/mirror.c            |  3 +--
>  block/qcow2.c             |  8 ++------
>  qemu-img.c                | 10 ++++------
>  5 files changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 55c5d573d4..7f71c585a0 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -202,10 +202,12 @@ struct BlockDriver {
>          int64_t offset, int bytes);
> 
>      /*
> -     * Building block for bdrv_block_status[_above]. The driver should
> -     * answer only according to the current layer, and should not
> -     * set BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
> -     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.
> +     * Building block for bdrv_block_status[_above] and
> +     * bdrv_is_allocated[_above].  The driver should answer only
> +     * according to the current layer, and should not set
> +     * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
> +     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
> +     * layer guarantees non-NULL pnum and file.
>       */
>      int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, int *pnum,
> diff --git a/block/io.c b/block/io.c
> index 8a0cd8835a..f250029395 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -695,7 +695,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
>  {
>      int64_t target_sectors, ret, nb_sectors, sector_num = 0;
>      BlockDriverState *bs = child->bs;
> -    BlockDriverState *file;
>      int n;
> 
>      target_sectors = bdrv_nb_sectors(bs);
> @@ -708,7 +707,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
>          if (nb_sectors <= 0) {
>              return 0;
>          }
> -        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, &file);
> +        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, NULL);
>          if (ret < 0) {
>              error_report("error getting block status at sector %" PRId64 ": %s",
>                           sector_num, strerror(-ret));
> @@ -1755,8 +1754,9 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
>   * beyond the end of the disk image it will be clamped; if 'pnum' is set to
>   * the end of the image, then the returned value will include BDRV_BLOCK_EOF.
>   *
> - * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
> - * points to the BDS which the sector range is allocated in.
> + * If returned value is positive, BDRV_BLOCK_OFFSET_VALID bit is set, and
> + * 'file' is non-NULL, then '*file' points to the BDS which the sector range
> + * is allocated in.
>   */
>  static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>                                                       int64_t sector_num,
> @@ -1766,15 +1766,22 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>      int64_t total_sectors;
>      int64_t n;
>      int64_t ret, ret2;
> +    BlockDriverState *local_file = NULL;
> 
> -    *file = NULL;
> +    assert(pnum);

nice assert..

>      total_sectors = bdrv_nb_sectors(bs);
>      if (total_sectors < 0) {
> +        if (file) {
> +            *file = NULL;
> +        }

Function reads slightly worse for the wear now with all of the return
logic handled at various places within, but unifying it might be even
stranger, perhaps..

Let's see if I hate this more:

out:
bdrv_dec_in_flight(bs);
    bdrv_dec_in_flight(bs);
    if (ret >= 0 && sector_num + *pnum == total_sectors) {
        ret |= BDRV_BLOCK_EOF;
    }
early_out:
    if (file) {
        *file = local_file;
    }
    return ret;


and then earlier in the function, we can just:

if (total_sectors < 0) {
  ret = total_sectors;
  goto early_out;
}

>          return total_sectors;
>      }
> 
>      if (sector_num >= total_sectors) {
>          *pnum = 0;
> +        if (file) {
> +            *file = NULL;
> +        }

ret = BDRV_BLOCK_EOF;
goto early_out;

>          return BDRV_BLOCK_EOF;
>      }
> 
> @@ -1791,23 +1798,27 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>          }
>          if (bs->drv->protocol_name) {
>              ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
> -            *file = bs;
> +            if (file) {
> +                *file = bs;
> +            }

local_file = bs;

> +        } else if (file) {
> +            *file = NULL;

no longer needed

>          }
>          return ret;

replaced with:

goto early_out;

>      }
> 
>      bdrv_inc_in_flight(bs);
>      ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
> -                                            file);
> +                                            &local_file);
>      if (ret < 0) {
>          *pnum = 0;
>          goto out;
>      }
> 
>      if (ret & BDRV_BLOCK_RAW) {
> -        assert(ret & BDRV_BLOCK_OFFSET_VALID && *file);
> -        ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
> -                                       *pnum, pnum, file);
> +        assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
> +        ret = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
> +                                       *pnum, pnum, &local_file);
>          goto out;
>      }
> 
> @@ -1825,14 +1836,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>          }
>      }
> 
> -    if (*file && *file != bs &&
> +    if (local_file && local_file != bs &&
>          (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
>          (ret & BDRV_BLOCK_OFFSET_VALID)) {
> -        BlockDriverState *file2;
>          int file_pnum;
> 
> -        ret2 = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
> -                                        *pnum, &file_pnum, &file2);
> +        ret2 = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
> +                                        *pnum, &file_pnum, NULL);
>          if (ret2 >= 0) {
>              /* Ignore errors.  This is just providing extra information, it
>               * is useful but not necessary.
> @@ -1854,6 +1864,9 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>      }
> 
>  out:
> +    if (file) {
> +        *file = local_file;
> +    }
>      bdrv_dec_in_flight(bs);
>      if (ret >= 0 && sector_num + *pnum == total_sectors) {
>          ret |= BDRV_BLOCK_EOF;
> @@ -1957,7 +1970,6 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
>  int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>                                     int64_t bytes, int64_t *pnum)
>  {
> -    BlockDriverState *file;
>      int64_t sector_num = offset >> BDRV_SECTOR_BITS;
>      int nb_sectors = bytes >> BDRV_SECTOR_BITS;
>      int64_t ret;
> @@ -1966,7 +1978,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>      assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
>      assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) && bytes < INT_MAX);
>      ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
> -                                &file);
> +                                NULL);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/block/mirror.c b/block/mirror.c
> index 5cdaaed7be..032cfe91fa 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -390,7 +390,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          int io_sectors;
>          unsigned int io_bytes;
>          int64_t io_bytes_acct;
> -        BlockDriverState *file;
>          enum MirrorMethod {
>              MIRROR_METHOD_COPY,
>              MIRROR_METHOD_ZERO,
> @@ -401,7 +400,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          ret = bdrv_get_block_status_above(source, NULL,
>                                            offset >> BDRV_SECTOR_BITS,
>                                            nb_chunks * sectors_per_chunk,
> -                                          &io_sectors, &file);
> +                                          &io_sectors, NULL);
>          io_bytes = io_sectors * BDRV_SECTOR_SIZE;
>          if (ret < 0) {
>              io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 64dcd98a91..9a7b5cd41f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2975,7 +2975,6 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>                              uint32_t count)
>  {
>      int nr;
> -    BlockDriverState *file;
>      int64_t res;
> 
>      if (start + count > bs->total_sectors) {
> @@ -2985,8 +2984,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>      if (!count) {
>          return true;
>      }
> -    res = bdrv_get_block_status_above(bs, NULL, start, count,
> -                                      &nr, &file);
> +    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
>      return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
>  }
> 
> @@ -3654,13 +3652,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                   offset += pnum * BDRV_SECTOR_SIZE) {
>                  int nb_sectors = MIN(ssize - offset,
>                                       BDRV_REQUEST_MAX_BYTES) / BDRV_SECTOR_SIZE;
> -                BlockDriverState *file;
>                  int64_t ret;
> 
>                  ret = bdrv_get_block_status_above(in_bs, NULL,
>                                                    offset >> BDRV_SECTOR_BITS,
> -                                                  nb_sectors,
> -                                                  &pnum, &file);
> +                                                  nb_sectors, &pnum, NULL);
>                  if (ret < 0) {
>                      error_setg_errno(&local_err, -ret,
>                                       "Unable to get block status");
> diff --git a/qemu-img.c b/qemu-img.c
> index df984b11b9..0c12e1c240 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1374,7 +1374,6 @@ static int img_compare(int argc, char **argv)
> 
>      for (;;) {
>          int64_t status1, status2;
> -        BlockDriverState *file;
> 
>          nb_sectors = sectors_to_process(total_sectors, sector_num);
>          if (nb_sectors <= 0) {
> @@ -1382,7 +1381,7 @@ static int img_compare(int argc, char **argv)
>          }
>          status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
>                                                total_sectors1 - sector_num,
> -                                              &pnum1, &file);
> +                                              &pnum1, NULL);
>          if (status1 < 0) {
>              ret = 3;
>              error_report("Sector allocation test failed for %s", filename1);
> @@ -1392,7 +1391,7 @@ static int img_compare(int argc, char **argv)
> 
>          status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
>                                                total_sectors2 - sector_num,
> -                                              &pnum2, &file);
> +                                              &pnum2, NULL);
>          if (status2 < 0) {
>              ret = 3;
>              error_report("Sector allocation test failed for %s", filename2);
> @@ -1598,15 +1597,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>      n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);
> 
>      if (s->sector_next_status <= sector_num) {
> -        BlockDriverState *file;
>          if (s->target_has_backing) {
>              ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
>                                          sector_num - src_cur_offset,
> -                                        n, &n, &file);
> +                                        n, &n, NULL);
>          } else {
>              ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
>                                                sector_num - src_cur_offset,
> -                                              n, &n, &file);
> +                                              n, &n, NULL);
>          }
>          if (ret < 0) {
>              return ret;
> 

It's only shed paint, though:

Reviewed-by: John Snow <jsnow@redhat.com>

I'm looking at the rest of the series now, so please stand by.
