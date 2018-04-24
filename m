Received: from eggs.gnu.org ([2001:4830:134:3::10]:52840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB03f-0003DK-06
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB03d-0007GN-Ue
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:40:43 -0400
Date: Tue, 24 Apr 2018 17:40:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424154026.GC4080@localhost.localdomain>
References: <20180215192829.9944-1-eblake@redhat.com>
	<20180215192829.9944-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215192829.9944-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] block: Support byte-based aio callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 15.02.2018 um 20:28 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Add new sector-based aio callbacks for read and write,
> to match the fact that bdrv_aio_pdiscard is already byte-based.
> 
> Ideally, drivers should be converted to use coroutine callbacks
> rather than aio; but that is not quite as trivial (if we do that
> conversion, the null-aio driver will disappear), so for the
> short term, converting the signature but keeping things with aio
> is easier.  Once all drivers are converted, the sector-based aio
> callbacks will be removed.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/block_int.h |  6 ++++++
>  block/io.c                | 37 +++++++++++++++++++++++++++----------
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 5ae7738cf8d..c882dc4232d 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -137,9 +137,15 @@ struct BlockDriver {
>      BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
>          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
>          BlockCompletionFunc *cb, void *opaque);
> +    BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
> +        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
> +        BlockCompletionFunc *cb, void *opaque);
>      BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
>          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
>          BlockCompletionFunc *cb, void *opaque);
> +    BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
> +        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
> +        BlockCompletionFunc *cb, void *opaque);
>      BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
>          BlockCompletionFunc *cb, void *opaque);
>      BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
> diff --git a/block/io.c b/block/io.c
> index 4d3d1f640a3..84a4caa72b7 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -934,9 +934,11 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
>      sector_num = offset >> BDRV_SECTOR_BITS;
>      nb_sectors = bytes >> BDRV_SECTOR_BITS;
> 
> -    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> -    assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
> +    if (!drv->bdrv_aio_preadv) {
> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
> +        assert((bytes >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS);
> +    }

Hm, this is kind of ugly. Previously, we handled everything byte-aligned
in the first section, now we mix both in the second section.

I can see that you do this so you don't have to duplicate the acb and
coroutine yielding code below, but can we move things into the right
place in the final patch at least? That is, calculate sector_num and
nb_sectors only if all the byte-based interfaces weren't available.

Kevin
