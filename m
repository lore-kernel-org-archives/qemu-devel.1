Received: from eggs.gnu.org ([2001:4830:134:3::10]:37517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elwrK-0004hV-4c
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elwrJ-000887-6R
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:12:26 -0500
Date: Wed, 14 Feb 2018 14:12:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214131215.GD4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-21-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213202701.15858-21-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 20/21] vvfat: Switch to
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

Am 13.02.2018 um 21:27 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the vvfat driver accordingly.  Note that we
> can rely on the block driver having already clamped limits to our
> block size, and simplify accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> ---
> v5-v7: no change
> v4: rebase to interface tweak
> v3: no change
> v2: rebase to earlier changes, simplify
> ---
>  block/vvfat.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 7e06ebacf61..4a17a49e128 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -3088,15 +3088,13 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      return ret;
>  }
> 
> -static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *bs,
> -        int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
> +static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
> +                                              bool want_zero, int64_t offset,
> +                                              int64_t bytes, int64_t *n,
> +                                              int64_t *map,
> +                                              BlockDriverState **file)
>  {
> -    *n = bs->total_sectors - sector_num;
> -    if (*n > nb_sectors) {
> -        *n = nb_sectors;
> -    } else if (*n < 0) {
> -        return 0;
> -    }
> +    *n = bytes;
>      return BDRV_BLOCK_DATA;
>  }

Preexisting, but this is inconsistent with other protocol drivers as far
as OFFSET_VALID is concerned (as I hinted in another mail, I like it
better this way, but it's still inconsistent).

Do we actually need any callback here or could the solution be to simply
remove it like with nvme?

Kevin
