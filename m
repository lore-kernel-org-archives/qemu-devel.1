Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elvox-0004wF-TV
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 07:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elvot-0003Pc-1U
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 07:05:55 -0500
Date: Wed, 14 Feb 2018 13:05:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214120525.GB4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213202701.15858-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the null driver accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> ---
> v6-v7: no change
> v5: minor fix to type of 'ret'
> v4: rebase to interface tweak
> v3: no change
> v2: rebase to mapping parameter
> ---
>  block/null.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/block/null.c b/block/null.c
> index 214d394fff4..806a8631e4d 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -223,22 +223,23 @@ static int null_reopen_prepare(BDRVReopenState *reopen_state,
>      return 0;
>  }
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
>  {
>      BDRVNullState *s = bs->opaque;
> -    off_t start = sector_num * BDRV_SECTOR_SIZE;
> +    int ret = BDRV_BLOCK_OFFSET_VALID;
> 
> -    *pnum = nb_sectors;
> +    *pnum = bytes;
> +    *map = offset;
>      *file = bs;
> 
>      if (s->read_zeroes) {
> -        return BDRV_BLOCK_OFFSET_VALID | start | BDRV_BLOCK_ZERO;
> -    } else {
> -        return BDRV_BLOCK_OFFSET_VALID | start;
> +        ret |= BDRV_BLOCK_ZERO;
>      }
> +    return ret;
>  }

Preexisting, but I think this return value is wrong. OFFSET_VALID
without DATA is to documented to have the following semantics:

 * DATA ZERO OFFSET_VALID
 *  f    t        t       sectors preallocated, read as zero, returned file not
 *                        necessarily zero at offset
 *  f    f        t       sectors preallocated but read from backing_hd,
 *                        returned file contains garbage at offset

I'm not sure what OFFSET_VALID is even supposed to mean for null.

Or in fact, what it is supposed to mean for any protocol driver, because
normally it just means I can use this offset for accessing bs->file. But
protocol drivers don't have a bs->file, so it's interesting to see that
they still all set this flag.

OFFSET_VALID | DATA might be excusable because I can see that it's
convenient that a protocol driver refers to itself as *file instead of
returning NULL there and then the offset is valid (though it would be
pointless to actually follow the file pointer), but OFFSET_VALID without
DATA probably isn't.

Kevin
