Received: from eggs.gnu.org ([2001:4830:134:3::10]:54489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDmML-0000ta-LQ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDmMK-0005n2-Dj
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:34:57 -0400
Date: Thu, 25 May 2017 14:34:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170525063444.GC27936@lemon.lan>
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524202842.26724-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

On Wed, 05/24 15:28, Eric Blake wrote:
> Not all callers care about which BDS owns the mapping for a given
> range of the file.  This patch merely simplifies the callers by
> consolidating the logic in the common call point, while guaranteeing
> a non-NULL file to all the driver callbacks, for no semantic change.
> 
> However, this will also set the stage for a future cleanup: when a
> caller does not care about which BDS owns an offset, it would be
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
> v2: new patch

Yes. any particular reason why this patch is useful, besides simplifying
callers?


> ---
>  block/io.c     | 15 +++++++++------
>  block/mirror.c |  3 +--
>  block/qcow2.c  |  4 +---
>  qemu-img.c     | 10 ++++------
>  4 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 8e6c3fe..eea74cb 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -706,7 +706,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
>  {
>      int64_t target_sectors, ret, nb_sectors, sector_num = 0;
>      BlockDriverState *bs = child->bs;
> -    BlockDriverState *file;
>      int n;
> 
>      target_sectors = bdrv_nb_sectors(bs);
> @@ -719,7 +718,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
>          if (nb_sectors <= 0) {
>              return 0;
>          }
> -        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, &file);
> +        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, NULL);
>          if (ret < 0) {
>              error_report("error getting block status at sector %" PRId64 ": %s",
>                           sector_num, strerror(-ret));
> @@ -1737,8 +1736,9 @@ typedef struct BdrvCoGetBlockStatusData {
>   * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
>   * beyond the end of the disk image it will be clamped.
>   *
> - * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
> - * points to the BDS which the sector range is allocated in.
> + * If returned value is positive, BDRV_BLOCK_OFFSET_VALID bit is set, and
> + * 'file' is non-NULL, then '*file' points to the BDS which the sector range
> + * is allocated in.

Sounds good.

>   */
>  static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>                                                       int64_t sector_num,
> @@ -1748,7 +1748,11 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
>      int64_t total_sectors;
>      int64_t n;
>      int64_t ret, ret2;
> +    BlockDriverState *tmpfile;
> 
> +    if (!file) {
> +        file = &tmpfile;
> +    }

I don't like this hunk. Instead, how about replacing all "*file = ..." with
"tmpfile = ..." and add "if (file) { *file = tmpfile; }" before returning?

>      *file = NULL;
>      total_sectors = bdrv_nb_sectors(bs);
>      if (total_sectors < 0) {
> @@ -1916,9 +1920,8 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
>  int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t sector_num,
>                                     int nb_sectors, int *pnum)
>  {
> -    BlockDriverState *file;
>      int64_t ret = bdrv_get_block_status(bs, sector_num, nb_sectors, pnum,
> -                                        &file);
> +                                        NULL);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/block/mirror.c b/block/mirror.c
> index e86f8f8..4563ba7 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -392,7 +392,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>      while (nb_chunks > 0 && sector_num < end) {
>          int64_t ret;
>          int io_sectors, io_sectors_acct;
> -        BlockDriverState *file;
>          enum MirrorMethod {
>              MIRROR_METHOD_COPY,
>              MIRROR_METHOD_ZERO,
> @@ -402,7 +401,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>          assert(!(sector_num % sectors_per_chunk));
>          ret = bdrv_get_block_status_above(source, NULL, sector_num,
>                                            nb_chunks * sectors_per_chunk,
> -                                          &io_sectors, &file);
> +                                          &io_sectors, NULL);
>          if (ret < 0) {
>              io_sectors = MIN(nb_chunks * sectors_per_chunk, max_io_sectors);
>          } else if (ret & BDRV_BLOCK_DATA) {
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b3ba5da..8e9e29b 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2448,7 +2448,6 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>                              uint32_t count)
>  {
>      int nr;
> -    BlockDriverState *file;
>      int64_t res;
> 
>      if (start + count > bs->total_sectors) {
> @@ -2458,8 +2457,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
>      if (!count) {
>          return true;
>      }
> -    res = bdrv_get_block_status_above(bs, NULL, start, count,
> -                                      &nr, &file);
> +    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
>      return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
>  }
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 5aef8ef..cb78696 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1398,7 +1398,6 @@ static int img_compare(int argc, char **argv)
> 
>      for (;;) {
>          int64_t status1, status2;
> -        BlockDriverState *file;
> 
>          nb_sectors = sectors_to_process(total_sectors, sector_num);
>          if (nb_sectors <= 0) {
> @@ -1406,7 +1405,7 @@ static int img_compare(int argc, char **argv)
>          }
>          status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
>                                                total_sectors1 - sector_num,
> -                                              &pnum1, &file);
> +                                              &pnum1, NULL);
>          if (status1 < 0) {
>              ret = 3;
>              error_report("Sector allocation test failed for %s", filename1);
> @@ -1416,7 +1415,7 @@ static int img_compare(int argc, char **argv)
> 
>          status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
>                                                total_sectors2 - sector_num,
> -                                              &pnum2, &file);
> +                                              &pnum2, NULL);
>          if (status2 < 0) {
>              ret = 3;
>              error_report("Sector allocation test failed for %s", filename2);
> @@ -1615,15 +1614,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
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
> -- 
> 2.9.4
> 

Otherwise looks good.

Fam
