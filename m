Received: from eggs.gnu.org ([2001:4830:134:3::10]:43011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKnmL-0006WG-Qn
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKnlt-0004W4-Qd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:03:05 -0500
Date: Fri, 1 Dec 2017 17:00:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171201160054.GG4147@localhost.localdomain>
References: <20171201014242.16877-1-eblake@redhat.com>
	<20171201014242.16877-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201014242.16877-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/20] file-posix: Switch to
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
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

Am 01.12.2017 um 02:42 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the file protocol driver accordingly.
> 
> In want_zero mode, we continue to report fine-grained hole
> information (the caller wants as much mapping detail as possible);
> but when not in that mode, the caller prefers larger *pnum and
> merely cares about what offsets are allocated at this layer, rather
> than where the holes live.  Since holes still read as zeroes at
> this layer (rather than deferring to a backing layer), we can take
> the shortcut of skipping lseek(), and merely state that all bytes
> are allocated.
> 
> We can also drop redundant bounds checks that are already
> guaranteed by the block layer.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v5: drop redundant code
> v4: tweak commit message [Fam], rebase to interface tweak
> v3: no change
> v2: tweak comment, add mapping support
> ---
>  block/file-posix.c | 62 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..e847c7cdd9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2128,25 +2128,24 @@ static int find_allocation(BlockDriverState *bs, off_t start,
>  }
> 
>  /*
> - * Returns the allocation status of the specified sectors.
> + * Returns the allocation status of the specified offset.
>   *
> - * If 'sector_num' is beyond the end of the disk image the return value is 0
> - * and 'pnum' is set to 0.
> + * The block layer guarantees 'offset' and 'bytes' are within bounds.
>   *
> - * 'pnum' is set to the number of sectors (including and immediately following
> - * the specified sector) that are known to be in the same
> + * 'pnum' is set to the number of bytes (including and immediately following
> + * the specified offset) that are known to be in the same
>   * allocated/unallocated state.
>   *
> - * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
> - * beyond the end of the disk image it will be clamped.
> + * 'bytes' is the max value 'pnum' should be set to.
>   */
> -static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
> -                                                    int64_t sector_num,
> -                                                    int nb_sectors, int *pnum,
> -                                                    BlockDriverState **file)
> +static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> +                                            bool want_zero,
> +                                            int64_t offset,
> +                                            int64_t bytes, int64_t *pnum,
> +                                            int64_t *map,
> +                                            BlockDriverState **file)
>  {
> -    off_t start, data = 0, hole = 0;
> -    int64_t total_size;
> +    off_t data = 0, hole = 0;
>      int ret;
> 
>      ret = fd_open(bs);
> @@ -2154,39 +2153,36 @@ static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
>          return ret;
>      }
> 
> -    start = sector_num * BDRV_SECTOR_SIZE;
> -    total_size = bdrv_getlength(bs);
> -    if (total_size < 0) {
> -        return total_size;
> -    } else if (start >= total_size) {
> -        *pnum = 0;
> -        return 0;
> -    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
> -        nb_sectors = DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SIZE);
> +    if (!want_zero) {
> +        *pnum = bytes;
> +        *map = offset;
> +        *file = bs;
> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
>      }

The documentation for want_zero in io.c is:

 * If 'want_zero' is true, the caller is querying for mapping purposes,
 * and the result should include BDRV_BLOCK_OFFSET_VALID and
 * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
 * bits particularly if it allows for a larger value in 'pnum'.

Do we need to include BDRV_BLOCK_DATA there? Otherwise this shortcut
would be wrong because BDRV_BLOCK_DATA always needs to be exact, even for
want_zero = false.

At first I expected that we want bdrv_is_allocated() to indicate holes
in raw files, but that's already not true today, so I now think this is
a matter of tweaking the documentation rather than removing the
shortcut.


While I'm looking at documentation, commit e88ae2264 had this:

 * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
 *                       layer (as opposed to the backing file)

With this semantics, always returning BDRV_BLOCK_ALLOCATED (and
therefore bdrv_is_allocated() == true) for raw file is correct. Your
recent commit 4c41cb4 changed it into:

 * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
 *                       layer (short for DATA || ZERO), set by block layer

Its commit message also talks about doing this "for convenience". This
is not true. There are code paths that set ZERO after ALLOCATED has
already been decided. ALLOCATED was introduced to distinguish a ZERO
coming from the driver and a ZERO derived in io.c because the latter
doesn't tell us about the allocation status (see commit e88ae2264).

So this documentation should be tweaked as well (possibly just reverting
4c41cb4 for BDRV_BLOCK_ALLOCATED).

Kevin
