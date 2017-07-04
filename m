Received: from eggs.gnu.org ([2001:4830:134:3::10]:42197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSM2W-0007bE-Gj
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSM2V-0003Y9-C3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:30:44 -0400
Date: Tue, 4 Jul 2017 19:30:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704113010.GA16860@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703222015.31507-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703222015.31507-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 16/15] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, 07/03 17:20, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based. Now that the block layer exposes byte-based allocation,
> it's time to tackle the drivers.  Add a new callback that operates
> on as small as byte boundaries. Subsequent patches will then update
> individual drivers, then finally remove .bdrv_co_get_block_status().
> The old code now uses a goto in order to minimize churn at that later
> removal.
> 
> The new code also passes through the 'allocation' hint, which will
> allow subsequent patches to further optimize callers that only care
> about how much of the image is allocated, rather than which offsets
> the allocation actually maps to.
> 
> Note that most drivers give sector-aligned answers, except at
> end-of-file, even when request_alignment is smaller than a sector.
> However, bdrv_getlength() is sector-aligned (even though it gives a
> byte answer), often by exceeding the actual file size.  If we were to
> give back strict results, at least file-posix.c would report a
> transition from DATA to HOLE at the end of a file even in the middle
> of a sector, which can throw off callers; so we intentionally lie and
> state that any partial sector at the end of a file has the same
> status for the entire sector.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: improve alignment handling, add additional 'allocation' argument
> for future optimization potential, ensure all iotests still pass
> 
> Sending as an RFC as part of my third series; this patch is technically
> the start of my fourth series, but given the rebase churn I've had
> elsewhere, it can't hurt to get the interface looked at in case it
> needs tweaking
> ---
>  include/block/block_int.h |  9 ++++++++-
>  block/io.c                | 27 ++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 5f6ba5d..45ff534 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -172,13 +172,20 @@ struct BlockDriver {
>       * bdrv_is_allocated[_above].  The driver should answer only
>       * according to the current layer, and should not set
>       * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
> -     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
> +     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  As a hint,
> +     * the flag allocation is true if the caller cares more about
> +     * learning how much of the image is allocated, without regards to
> +     * a breakdown by offset (a driver may either ignore the hint, or
> +     * avoid _OFFSET_VALID to provide a larger *pnum).  The block
>       * layer guarantees input aligned to request_alignment, as well as
>       * non-NULL pnum and file.
>       */
>      int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, int *pnum,
>          BlockDriverState **file);
> +    int64_t coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,
> +        bool allocation, int64_t offset, int64_t bytes, int64_t *pnum,
> +        BlockDriverState **file);

Apart from my earlier question regarding the naming of "allocation", looks fine.

I haven't reviewed the implementation though.

Fam
