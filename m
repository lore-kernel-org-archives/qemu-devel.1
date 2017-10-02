Received: from eggs.gnu.org ([2001:4830:134:3::10]:42875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz06T-0003G8-7B
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz06Q-0002F8-KT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:45:45 -0400
Date: Mon, 2 Oct 2017 14:45:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002124528.GA4362@localhost.localdomain>
References: <20170815081854.14568-1-el13635@mail.ntua.gr>
	<20170815081854.14568-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815081854.14568-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: use internal filter node in
 backup
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Am 15.08.2017 um 10:18 hat Manos Pitsidianakis geschrieben:
> block/backup.c currently uses before write notifiers on the targeted
> node. We can create a filter node instead to intercept write requests
> for the backup job on the BDS level, instead of the BlockBackend level.
> 
> This is part of deprecating before write notifiers, which are hard coded
> into the block layer. Block filter drivers are inserted into the graph
> only when a feature is needed. This makes the block layer more modular
> and reuses the block driver abstraction that is already present.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

You make a lot of changes to add bdrv_set_file()/bdrv_append_file()
(which should be separate patches, by the way), but if we look at the
only actual user of the functions:

> @@ -606,17 +744,33 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>                           bdrv_get_device_name(bs));
>          goto error;
>      }
> +    /* Setup before write filter */
> +    filter =
> +        bdrv_new_open_driver(&backup_top,
> +                             NULL, bdrv_get_flags(bs), NULL, &error_abort);
> +    filter->implicit = true;
> +    filter->total_sectors = bs->total_sectors;
> +    bdrv_set_aio_context(filter, bdrv_get_aio_context(bs));
> +
> +    /* Insert before write notifier in the BDS chain */
> +    bdrv_ref(filter);
> +    bdrv_drained_begin(bs);
> +    bdrv_append_file(filter, bs, &error_abort);
> +    bdrv_drained_end(bs);

Is there a reason why you can't simply do:

    filter->file = bdrv_attach_child(filter, bs, "file", &child_file, &local_err);
    bdrv_replace_node(filter->file, filter, &error_abort);

Effectively these two lines are all that your new functions boil down to
because only this one special case is ever used.


Did you consider that using filter->file for the backup filter rather
than filter->backing like in mirror and commit mean that the backing
file chain is broken? Are we sure that all functions that operate on the
backing file chain can already skip filters?

For example, bdrv_co_get_block_status_above() doesn't seem to do the
right thing yet, it would consider the filter as the base file where the
chain ends.

Attaching as filter->backing feels a bit safer to me.

> @@ -532,6 +551,124 @@ static const BlockJobDriver backup_job_driver = {
>      .drain                  = backup_drain,
>  };
>  
> +static int coroutine_fn backup_top_co_preadv(BlockDriverState *bs,
> +                                             uint64_t offset,
> +                                             uint64_t bytes,
> +                                             QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn backup_top_co_pwritev(BlockDriverState *bs,
> +                                              uint64_t offset,
> +                                              uint64_t bytes,
> +                                              QEMUIOVector *qiov, int flags)
> +{
> +    int ret = 0;
> +    BackupBlockJob *job = bs->opaque;
> +    if (job) {
> +        assert(bs == blk_bs(job->common.blk));
> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> +        ret = backup_do_cow(job, offset, bytes, NULL, true);
> +    }

Is it worth making this a static inline function instead of having three
copies of the same code?

> +    return ret < 0 ? ret : bdrv_co_pwritev(bs->file, offset, bytes,
> +                                           qiov, flags);
> +}
> +
> +static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
> +                                                    int64_t offset,
> +                                                    int bytes,
> +                                                    BdrvRequestFlags flags)
> +{
> +    int ret = 0;
> +    BackupBlockJob *job = bs->opaque;
> +    if (job) {
> +        assert(bs == blk_bs(job->common.blk));
> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> +        ret = backup_do_cow(job, offset, bytes, NULL, true);
> +    }
> +
> +    return ret < 0 ? ret : bdrv_co_pwrite_zeroes(bs->file, offset, bytes,
> +                                                 flags);
> +}
> +
> +static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
> +                                               int64_t offset, int bytes)
> +{
> +    int ret = 0;
> +    BackupBlockJob *job = bs->opaque;
> +    if (job) {
> +        assert(bs == blk_bs(job->common.blk));
> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> +        ret = backup_do_cow(job, offset, bytes, NULL, true);
> +    }
> +
> +    return ret < 0 ? ret : bdrv_co_pdiscard(bs->file->bs, offset, bytes);
> +}
> +
> +static int backup_top_co_flush(BlockDriverState *bs)
> +{
> +    return bdrv_co_flush(bs->file->bs);
> +}
> +
> +static int backup_top_open(BlockDriverState *bs, QDict *options,
> +                           int flags, Error **errp)
> +{
> +    return 0;
> +}
> +
> +static void backup_top_close(BlockDriverState *bs)
> +{
> +}
> +
> +static int64_t backup_top_getlength(BlockDriverState *bs)
> +{
> +    return bs->file ? bdrv_getlength(bs->file->bs) : 0;
> +}
> +
> +static bool backup_recurse_is_first_non_filter(BlockDriverState *bs,
> +                                               BlockDriverState *candidate)
> +{
> +    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
> +}
> +
> +static int64_t coroutine_fn backup_co_get_block_status(BlockDriverState *bs,
> +                                                       int64_t sector_num,
> +                                                       int nb_sectors,
> +                                                       int *pnum,
> +                                                       BlockDriverState **file)
> +{
> +    assert(bs->file && bs->file->bs);
> +    *pnum = nb_sectors;
> +    *file = bs->file->bs;
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
> +           (sector_num << BDRV_SECTOR_BITS);
> +}

This is just a duplicate of bdrv_co_get_block_status_from_file().

Kevin
