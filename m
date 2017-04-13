Received: from eggs.gnu.org ([2001:4830:134:3::10]:58522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyTVG-0003r6-N0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyTVF-0006Dn-JW
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:24:54 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-11-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ac3c618b-7be0-d681-0873-e0bc7fd9d31c@redhat.com>
Date: Wed, 12 Apr 2017 21:24:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-11-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/12] mirror: Switch mirror_dirty_init()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 21b4f5d..846e392 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -601,15 +601,13 @@ static void mirror_throttle(MirrorBlockJob *s)
> 
>  static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>  {
> -    int64_t sector_num, end;
> +    int64_t offset;
>      BlockDriverState *base = s->base;
>      BlockDriverState *bs = s->source;
>      BlockDriverState *target_bs = blk_bs(s->target);
> -    int ret, n;
> +    int ret;
>      int64_t count;
> 
> -    end = s->bdev_length / BDRV_SECTOR_SIZE;
> -
>      if (base == NULL && !bdrv_has_zero_init(target_bs)) {
>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
> @@ -617,9 +615,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>          }
> 
>          s->initial_zeroing_ongoing = true;
> -        for (sector_num = 0; sector_num < end; ) {
> -            int nb_sectors = MIN(end - sector_num,
> -                QEMU_ALIGN_DOWN(INT_MAX, s->granularity) >> BDRV_SECTOR_BITS);
> +        for (offset = 0; offset < s->bdev_length; ) {
> +            int bytes = MIN(s->bdev_length - offset,
> +                            QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> 
>              mirror_throttle(s);
> 
> @@ -635,9 +633,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>                  continue;
>              }
> 
> -            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
> -                                      nb_sectors * BDRV_SECTOR_SIZE, false);
> -            sector_num += nb_sectors;
> +            mirror_do_zero_or_discard(s, offset, bytes, false);
> +            offset += bytes;
>          }
> 
>          mirror_wait_for_all_io(s);
> @@ -645,10 +642,10 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>      }
> 
>      /* First part, loop on the sectors and initialize the dirty bitmap.  */
> -    for (sector_num = 0; sector_num < end; ) {
> +    for (offset = 0; offset < s->bdev_length; ) {
>          /* Just to make sure we are not exceeding int limit. */
> -        int nb_sectors = MIN(INT_MAX >> BDRV_SECTOR_BITS,
> -                             end - sector_num);
> +        int bytes = MIN(s->bdev_length - offset,
> +                        QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
> 
>          mirror_throttle(s);
> 
> @@ -656,20 +653,16 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              return 0;
>          }
> 
> -        ret = bdrv_is_allocated_above(bs, base, sector_num * BDRV_SECTOR_SIZE,
> -                                      nb_sectors * BDRV_SECTOR_SIZE, &count);
> +        ret = bdrv_is_allocated_above(bs, base, offset, bytes, &count);
>          if (ret < 0) {
>              return ret;
>          }
> 
> -        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
> -        assert(n > 0);
> +        count = QEMU_ALIGN_UP(count, BDRV_SECTOR_SIZE);
>          if (ret == 1) {
> -            bdrv_set_dirty_bitmap(s->dirty_bitmap,
> -                                  sector_num * BDRV_SECTOR_SIZE,
> -                                  n * BDRV_SECTOR_SIZE);
> +            bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, count);
>          }
> -        sector_num += n;
> +        offset += count;
>      }
>      return 0;
>  }
> 

Reviewed-by: John Snow <jsnow@redhat.com>
