Received: from eggs.gnu.org ([2001:4830:134:3::10]:46629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKVQ-00039C-7E
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKKVP-0002aH-Bk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:47:40 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <03ff33c9-9873-6cc1-8bc8-785a6a246153@virtuozzo.com>
Date: Thu, 30 Nov 2017 11:47:22 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 08/20] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

12.10.2017 21:59, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the null driver accordingly.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v4: rebase to interface tweak
> v3: no change
> v2: rebase to mapping parameter
> ---
>   block/null.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/block/null.c b/block/null.c
> index dd9c13f9ba..20c7eb0ee2 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -223,22 +223,23 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
>       return 0;
>   }
>
> -static int64_t coroutine_fn null_co_get_block_status(BlockDriverState *bs,
> -                                                     int64_t sector_num,
> -                                                     int nb_sectors, int *pnum,
> -                                                     BlockDriverState **file)
> +static int coroutine_fn null_co_block_status(BlockDriverState *bs,
> +                                             bool want_zero, int64_t offset,
> +                                             int64_t bytes, int64_t *pnum,
> +                                             int64_t *map,
> +                                             BlockDriverState **file)
>   {
>       BDRVNullState *s = bs->opaque;
> -    off_t start = sector_num * BDRV_SECTOR_SIZE;
> +    int64_t ret = BDRV_BLOCK_OFFSET_VALID;

int ret =

with that:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>
> -    *pnum = nb_sectors;
> +    *pnum = bytes;
> +    *map = offset;
>       *file = bs;
>
>       if (s->read_zeroes) {
> -        return BDRV_BLOCK_OFFSET_VALID | start | BDRV_BLOCK_ZERO;
> -    } else {
> -        return BDRV_BLOCK_OFFSET_VALID | start;
> +        ret |= BDRV_BLOCK_ZERO;
>       }
> +    return ret;
>   }
>
>   static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
> @@ -270,7 +271,7 @@ static BlockDriver bdrv_null_co = {
>       .bdrv_co_flush_to_disk  = null_co_flush,
>       .bdrv_reopen_prepare    = null_reopen_prepare,
>
> -    .bdrv_co_get_block_status   = null_co_get_block_status,
> +    .bdrv_co_block_status   = null_co_block_status,
>
>       .bdrv_refresh_filename  = null_refresh_filename,
>   };
> @@ -290,7 +291,7 @@ static BlockDriver bdrv_null_aio = {
>       .bdrv_aio_flush         = null_aio_flush,
>       .bdrv_reopen_prepare    = null_reopen_prepare,
>
> -    .bdrv_co_get_block_status   = null_co_get_block_status,
> +    .bdrv_co_block_status   = null_co_block_status,
>
>       .bdrv_refresh_filename  = null_refresh_filename,
>   };


-- 
Best regards,
Vladimir
