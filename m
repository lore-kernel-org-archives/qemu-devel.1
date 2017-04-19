Received: from eggs.gnu.org ([2001:4830:134:3::10]:49718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0ygU-0006Ft-8E
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 19:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0ygT-0004k9-3K
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 19:06:50 -0400
References: <20170407113404.9351-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e8e164db-ef51-63e6-3294-c43e4951a89c@redhat.com>
Date: Wed, 19 Apr 2017 19:06:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170407113404.9351-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: improve
 convert_iteration_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com



On 04/07/2017 07:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Do not do extra call to _get_block_status()
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Also, I'm not sure about last line:
> s->status = s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
> 
> (which is equal to old code)
> 

What a weird function.

So, if the target has a backing file, literally nothing changes here.

If it doesn't, we skip the initial call to get_block_status and just
call the (effectively?) recursive version to find out if we have a ZERO
or DATA type of allocation.

The else clause here properly reflects the original reading of the code.

OK.

> may be, it should be
> s->status = s->target_has_backing ? BLK_BACKING_FILE : BLK_ZERO;
> 
> as it is the case, when range is not allocated at all. Should we copy it in this case?
> 

I am not really clear on if either ZERO or DATA are correct in the case
where we do not have a backing file, because maybe this depends on
has_zero_init?

If we are copying uninitialized data when has_zero_init is true on the
source, we want zeroes on the target. If the target also has_zero_init,
we can just skip this sector. If it doesn't, we want to copy zeroes.

If has_zero_init is false and we have unallocated data on the source...
what are we doing? Copying random debris?

I'm pretty confused, but I'm pretty sure your patch doesn't actually
change anything, so:

Reviewed-by: John Snow <jsnow@redhat.com>

>  qemu-img.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf71d7..490f6e97f6 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1554,9 +1554,15 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>  
>      if (s->sector_next_status <= sector_num) {
>          BlockDriverState *file;
> -        ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
> -                                    sector_num - src_cur_offset,
> -                                    n, &n, &file);
> +        if (s->target_has_backing) {
> +            ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
> +                                        sector_num - src_cur_offset,
> +                                        n, &n, &file);
> +        } else {
> +            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
> +                                              sector_num - src_cur_offset,
> +                                              n, &n, &file);
> +        }
>          if (ret < 0) {
>              return ret;
>          }
> @@ -1565,26 +1571,8 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>              s->status = BLK_ZERO;
>          } else if (ret & BDRV_BLOCK_DATA) {
>              s->status = BLK_DATA;
> -        } else if (!s->target_has_backing) {
> -            /* Without a target backing file we must copy over the contents of
> -             * the backing file as well. */
> -            /* Check block status of the backing file chain to avoid
> -             * needlessly reading zeroes and limiting the iteration to the
> -             * buffer size */
> -            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
> -                                              sector_num - src_cur_offset,
> -                                              n, &n, &file);
> -            if (ret < 0) {
> -                return ret;
> -            }
> -
> -            if (ret & BDRV_BLOCK_ZERO) {
> -                s->status = BLK_ZERO;
> -            } else {
> -                s->status = BLK_DATA;
> -            }
>          } else {
> -            s->status = BLK_BACKING_FILE;
> +            s->status = s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
>          }
>  
>          s->sector_next_status = sector_num + n;
> 
