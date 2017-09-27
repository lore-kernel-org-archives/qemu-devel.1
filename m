Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxHee-0002Ls-W6
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxHed-0001WR-GS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:05:56 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-14-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6cc0f8a8-6c3f-fd53-6167-82244b1633fa@redhat.com>
Date: Wed, 27 Sep 2017 15:05:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/23] qemu-img: Simplify logic in
 img_compare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> As long as we are querying the status for a chunk smaller than
> the known image size, we are guaranteed that a successful return
> will have set pnum to a non-zero size (pnum is zero only for
> queries beyond the end of the file).  Use that to slightly
> simplify the calculation of the current chunk size being compared.
> Likewise, we don't have to shrink the amount of data operated on
> until we know we have to read the file, and therefore have to fit
> in the bounds of our buffer.  Also, note that 'total_sectors_over'
> is equivalent to 'progress_base'.
> 
> With these changes in place, sectors_to_process() is now dead code,
> and can be removed.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: new patch
> ---
>  qemu-img.c | 40 +++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index b91133b922..f8423e9b3f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1171,11 +1171,6 @@ static int64_t sectors_to_bytes(int64_t sectors)
>      return sectors << BDRV_SECTOR_BITS;
>  }
> 
> -static int64_t sectors_to_process(int64_t total, int64_t from)
> -{
> -    return MIN(total - from, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
> -}
> -
>  /*
>   * Check if passed sectors are empty (not allocated or contain only 0 bytes)
>   *
> @@ -1372,13 +1367,9 @@ static int img_compare(int argc, char **argv)
>          goto out;
>      }
> 
> -    for (;;) {
> +    while (sector_num < total_sectors) {
>          int64_t status1, status2;
> 
> -        nb_sectors = sectors_to_process(total_sectors, sector_num);
> -        if (nb_sectors <= 0) {
> -            break;
> -        }
>          status1 = bdrv_block_status_above(bs1, NULL,
>                                            sector_num * BDRV_SECTOR_SIZE,
>                                            (total_sectors1 - sector_num) *
> @@ -1402,14 +1393,9 @@ static int img_compare(int argc, char **argv)
>              goto out;
>          }
>          allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
> -        if (pnum1) {
> -            nb_sectors = MIN(nb_sectors,
> -                             DIV_ROUND_UP(pnum1, BDRV_SECTOR_SIZE));
> -        }
> -        if (pnum2) {
> -            nb_sectors = MIN(nb_sectors,
> -                             DIV_ROUND_UP(pnum2, BDRV_SECTOR_SIZE));
> -        }
> +
> +        assert(pnum1 && pnum2);
> +        nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);

In the apocalyptic future where non-sector sized returns are possible,
does this math make sense?

e.g. say the return is zeroes, but it's not aligned anymore, so we
assume we have an extra half a sector's worth of zeroes here.

> 
>          if (strict) {
>              if ((status1 & ~BDRV_BLOCK_OFFSET_MASK) !=
> @@ -1422,9 +1408,10 @@ static int img_compare(int argc, char **argv)
>              }
>          }
>          if ((status1 & BDRV_BLOCK_ZERO) && (status2 & BDRV_BLOCK_ZERO)) {
> -            nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);
> +            /* nothing to do */
>          } else if (allocated1 == allocated2) {
>              if (allocated1) {
> +                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
>                  ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
>                                  nb_sectors << BDRV_SECTOR_BITS);
>                  if (ret < 0) {
> @@ -1453,7 +1440,7 @@ static int img_compare(int argc, char **argv)
>                  }
>              }
>          } else {
> -
> +            nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
>              if (allocated1) {
>                  ret = check_empty_sectors(blk1, sector_num, nb_sectors,
>                                            filename1, buf1, quiet);
> @@ -1476,30 +1463,24 @@ static int img_compare(int argc, char **argv)
> 
>      if (total_sectors1 != total_sectors2) {
>          BlockBackend *blk_over;
> -        int64_t total_sectors_over;
>          const char *filename_over;
> 
>          qprintf(quiet, "Warning: Image size mismatch!\n");
>          if (total_sectors1 > total_sectors2) {
> -            total_sectors_over = total_sectors1;
>              blk_over = blk1;
>              filename_over = filename1;
>          } else {
> -            total_sectors_over = total_sectors2;
>              blk_over = blk2;
>              filename_over = filename2;
>          }
> 
> -        for (;;) {
> +        while (sector_num < progress_base) {
>              int64_t count;
> 
> -            nb_sectors = sectors_to_process(total_sectors_over, sector_num);
> -            if (nb_sectors <= 0) {
> -                break;
> -            }
>              ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
>                                            sector_num * BDRV_SECTOR_SIZE,
> -                                          nb_sectors * BDRV_SECTOR_SIZE,
> +                                          (progress_base - sector_num) *
> +                                          BDRV_SECTOR_SIZE,
>                                            &count);
>              if (ret < 0) {
>                  ret = 3;
> @@ -1513,6 +1494,7 @@ static int img_compare(int argc, char **argv)
>              assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
>              nb_sectors = count >> BDRV_SECTOR_BITS;
>              if (ret) {
> +                nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
>                  ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
>                                            filename_over, buf1, quiet);
>                  if (ret) {
> 

Rest looks right to me.
