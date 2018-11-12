Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMKWx-0005hS-2i
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMKWs-00068p-Pz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:18:02 -0500
From: Eric Blake <eblake@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-4-mreitz@redhat.com>
Message-ID: <e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
Date: Mon, 12 Nov 2018 16:17:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Filtered children access
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 8/9/18 5:31 PM, Max Reitz wrote:
> What bs->file and bs->backing mean depends on the node.  For filter
> nodes, both signify a node that will eventually receive all R/W
> accesses.  For format nodes, bs->file contains metadata and data, and
> bs->backing will not receive writes -- instead, writes are COWed to
> bs->file.  Usually.
> 
> In any case, it is not trivial to guess what a child means exactly with
> our currently limited form of expression.  It is better to introduce
> some functions that actually guarantee a meaning:
> 
> - bdrv_filtered_cow_child() will return the child that receives requests
>    filtered through COW.  That is, reads may or may not be forwarded
>    (depending on the overlay's allocation status), but writes never go to
>    this child.
> 
> - bdrv_filtered_rw_child() will return the child that receives requests
>    filtered through some very plain process.  Reads and writes issued to
>    the parent will go to the child as well (although timing, etc. may be
>    modified).
> 
> - All drivers but quorum (but quorum is pretty opaque to the general
>    block layer anyway) always only have one of these children: All read
>    requests must be served from the filtered_rw_child (if it exists), so
>    if there was a filtered_cow_child in addition, it would not receive
>    any requests at all.
>    (The closest here is mirror, where all requests are passed on to the
>    source, but with write-blocking, write requests are "COWed" to the
>    target.  But that just means that the target is a special child that
>    cannot be introspected by the generic block layer functions, and that
>    source is a filtered_rw_child.)
>    Therefore, we can also add bdrv_filtered_child() which returns that
>    one child (or NULL, if there is no filtered child).
> 
> Also, many places in the current block layer should be skipping filters
> (all filters or just the ones added implicitly, it depends) when going
> through a block node chain.  They do not do that currently, but this
> patch makes them.

The description makes sense; now on to the code.

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json           |   4 +
>   include/block/block.h          |   1 +
>   include/block/block_int.h      |  33 +++++-
>   block.c                        | 184 ++++++++++++++++++++++++++++-----
>   block/backup.c                 |   8 +-
>   block/block-backend.c          |  16 ++-
>   block/commit.c                 |  36 ++++---
>   block/io.c                     |  27 ++---
>   block/mirror.c                 |  37 ++++---
>   block/qapi.c                   |  26 ++---
>   block/stream.c                 |  15 ++-
>   blockdev.c                     |  84 ++++++++++++---
>   migration/block-dirty-bitmap.c |   4 +-
>   nbd/server.c                   |   8 +-
>   qemu-img.c                     |  12 ++-
>   15 files changed, 363 insertions(+), 132 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f20efc97f7..a71df88eb2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2248,6 +2248,10 @@
>   # On successful completion the image file is updated to drop the backing file
>   # and the BLOCK_JOB_COMPLETED event is emitted.

Context: this is part of block-stream.

>   #
> +# In case @device is a filter node, block-stream modifies the first non-filter
> +# overlay node below it to point to base's backing node (or NULL if @base was
> +# not specified) instead of modifying @device itself.

That is, if we have:

base <- filter1 <- active <- filter2

and request a block-stream with "top":"filter2", it is no different in 
effect than if we had requested "top":"active", since filter nodes can't 
be stream targets.  Makes sense.

What happens if we request "base":"filter1"? Do we want to require base 
to be a non-filter node?

> +++ b/include/block/block_int.h
> @@ -91,6 +91,7 @@ struct BlockDriver {
>        * certain callbacks that refer to data (see block.c) to their bs->file if
>        * the driver doesn't implement them. Drivers that do not wish to forward
>        * must implement them and return -ENOTSUP.
> +     * Note that filters are not allowed to modify data.

They can modify offsets and timing, but not data?  Even if it is an 
encryption filter?  I'm trying to figure out if LUKS behaves like a filter.

> +++ b/block.c
> @@ -532,11 +532,12 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
>   int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
>   {
>       BlockDriver *drv = bs->drv;
> +    BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);

Is it worth a micro-optimization of not calling this...

>   
>       if (drv && drv->bdrv_probe_blocksizes) {
>           return drv->bdrv_probe_blocksizes(bs, bsz);

...until after checking drv->bdrv_probe_blocksizes?

> -    } else if (drv && drv->is_filter && bs->file) {
> -        return bdrv_probe_blocksizes(bs->file->bs, bsz);
> +    } else if (filtered) {
> +        return bdrv_probe_blocksizes(filtered, bsz);
>       }

But I don't mind if you leave it as written.

Is blkdebug a filter, or something else?  That's a case of something 
that DOES change block sizes in relation to the child that it is 
filtering.  If we have qcow2 -> blkdebug -> file, and the qcow2 format 
layer wants to know the blocksizes of its child, does it really always 
want the sizes of 'file' rather than the (possibly changed) sizes of 
'blkdebug'?

>   
>       return -ENOTSUP;
> @@ -551,11 +552,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
>   int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
>   {
>       BlockDriver *drv = bs->drv;
> +    BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);
>   
>       if (drv && drv->bdrv_probe_geometry) {
>           return drv->bdrv_probe_geometry(bs, geo);
> -    } else if (drv && drv->is_filter && bs->file) {
> -        return bdrv_probe_geometry(bs->file->bs, geo);
> +    } else if (filtered) {
> +        return bdrv_probe_geometry(filtered, geo);
>       }

At least you're consistent on skipping filters.

> @@ -4068,7 +4074,19 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
>   bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
>   {
>       while (top && top != base) {
> -        top = backing_bs(top);
> +        top = bdrv_filtered_bs(top);
> +    }
> +
> +    return top != NULL;
> +}
> +
> +/* Same as bdrv_chain_contains(), but skip implicitly added R/W filter
> + * nodes and do not move past explicitly added R/W filters. */
> +bool bdrv_legacy_chain_contains(BlockDriverState *top, BlockDriverState *base)
> +{
> +    top = bdrv_skip_implicit_filters(top);
> +    while (top && top != base) {
> +        top = bdrv_skip_implicit_filters(bdrv_filtered_cow_bs(top));
>       }

Is there a goal of getting rid of bdrv_legacy_chain_contains() in the 
future?  If so, should the commit message and/or code comments mention that?

>   
>       return top != NULL;
> @@ -4140,20 +4158,24 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
>   
>   int bdrv_has_zero_init(BlockDriverState *bs)
>   {
> +    BlockDriverState *filtered;
> +
>       if (!bs->drv) {
>           return 0;
>       }
>   
>       /* If BS is a copy on write image, it is initialized to
>          the contents of the base image, which may not be zeroes.  */
> -    if (bs->backing) {
> +    if (bdrv_filtered_cow_child(bs)) {
>           return 0;

Not for this patch, but should we ask the filtered_cow_child if it is 
known to be all-zero content before blindly returning 0 here? Some 
children may be able to efficiently report if they have all-zero content 
[for example, see the recent thread about NBD performace drop due to 
explicitly zeroing the remote device, which could be skipped if it is 
known that the remote device started life uninitialized]

>       }
>       if (bs->drv->bdrv_has_zero_init) {
>           return bs->drv->bdrv_has_zero_init(bs);
>       }
> -    if (bs->file && bs->drv->is_filter) {
> -        return bdrv_has_zero_init(bs->file->bs);
> +
> +    filtered = bdrv_filtered_rw_bs(bs);
> +    if (filtered) {
> +        return bdrv_has_zero_init(filtered);
>       }

You argued earlier that a filter can't change contents - but is that 
just guest-visible contents? If LUKS is a filter node, then a file that 
is zero-initialized is NOT zero-initialized after passing through LUKS 
encryption (decrypting the zeros returns garbage; conversely, writing 
zeros into LUKS results in random-looking bits in the file).  I guess 
I'm leaning more and more towards LUKS is not a filter, but a format.

> @@ -4198,8 +4220,9 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>           return -ENOMEDIUM;
>       }
>       if (!drv->bdrv_get_info) {
> -        if (bs->file && drv->is_filter) {
> -            return bdrv_get_info(bs->file->bs, bdi);
> +        BlockDriverState *filtered = bdrv_filtered_rw_bs(bs);
> +        if (filtered) {
> +            return bdrv_get_info(filtered, bdi);

Is this right for blkdebug?

> @@ -5487,3 +5519,105 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>   
>       return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
>   }
> +
> +/*
> + * Return the child that @bs acts as an overlay for, and from which data may be
> + * copied in COW or COR operations.  Usually this is the backing file.
> + */
> +BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs)
> +{
> +    if (!bs || !bs->drv) {
> +        return NULL;
> +    }
> +
> +    if (bs->drv->is_filter) {
> +        return NULL;
> +    }

Here, filters end the search...

> +
> +    return bs->backing;
> +}
> +
> +/*
> + * If @bs acts as a pass-through filter for one of its children,
> + * return that child.  "Pass-through" means that write operations to
> + * @bs are forwarded to that child instead of triggering COW.
> + */
> +BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs)
> +{
> +    if (!bs || !bs->drv) {
> +        return NULL;
> +    }
> +
> +    if (!bs->drv->is_filter) {
> +        return NULL;
> +    }

...while here, non-filters end the search. I think I follow your 
semantics (we were abusing bs->backing for filters, and your code is now 
trying to distinguish what was really meant)

> +
> +    return bs->backing ?: bs->file;
> +}
> +
> +/*
> + * Return any filtered child, independently on how it reacts to write

s/on/of/

> + * accesses and whether data is copied onto this BDS through COR.
> + */
> +BdrvChild *bdrv_filtered_child(BlockDriverState *bs)
> +{
> +    BdrvChild *cow_child = bdrv_filtered_cow_child(bs);
> +    BdrvChild *rw_child = bdrv_filtered_rw_child(bs);
> +
> +    /* There can only be one filtered child at a time */
> +    assert(!(cow_child && rw_child));
> +
> +    return cow_child ?: rw_child;
> +}
> +
> +static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
> +                                           bool stop_on_explicit_filter)
> +{
> +    BdrvChild *filtered;
> +
> +    if (!bs) {
> +        return NULL;
> +    }
> +
> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
> +        filtered = bdrv_filtered_rw_child(bs);
> +        if (!filtered) {
> +            break;
> +        }
> +        bs = filtered->bs;
> +    }
> +    /* Note that this treats nodes with bs->drv == NULL as not being
> +     * R/W filters (bs->drv == NULL should be replaced by something
> +     * else anyway).
> +     * The advantage of this behavior is that this function will thus
> +     * always return a non-NULL value (given a non-NULL @bs). */
> +
> +    return bs;
> +}
> +
> +/*
> + * Return the first BDS that has not been added implicitly or that
> + * does not have an RW-filtered child down the chain starting from @bs
> + * (including @bs itself).
> + */
> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
> +{
> +    return bdrv_skip_filters(bs, true);
> +}
> +
> +/*
> + * Return the first BDS that does not have an RW-filtered child down
> + * the chain starting from @bs (including @bs itself).
> + */
> +BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
> +{
> +    return bdrv_skip_filters(bs, false);
> +}
> +
> +/*
> + * For a backing chain, return the first non-filter backing image.
> + */
> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
> +{
> +    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs)));
> +}

Makes sense to me.

> diff --git a/block/backup.c b/block/backup.c
> index 8630d32926..4ddc0bb632 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -618,6 +618,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>       int64_t len;
>       BlockDriverInfo bdi;
>       BackupBlockJob *job = NULL;
> +    bool target_does_cow;
>       int ret;
>   
>       assert(bs);
> @@ -712,8 +713,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>       /* If there is no backing file on the target, we cannot rely on COW if our
>        * backup cluster size is smaller than the target cluster size. Even for
>        * targets with a backing file, try to avoid COW if possible. */
> +    target_does_cow = bdrv_filtered_cow_child(target);
>       ret = bdrv_get_info(target, &bdi);
> -    if (ret == -ENOTSUP && !target->backing) {
> +    if (ret == -ENOTSUP && !target_does_cow) {

And now we're starting to see the bug fixes - a backup job to a 
throttled node should behave the same as backing up to the original node 
before throttling was added.

> @@ -410,20 +413,23 @@ int bdrv_commit(BlockDriverState *bs)
>       if (!drv)
>           return -ENOMEDIUM;
>   
> -    if (!bs->backing) {
> +    backing_file_bs = bdrv_filtered_cow_bs(bs);
> +
> +    if (!backing_file_bs) {
>           return -ENOTSUP;
>       }

Here, the old code exits early without bs->backing...

>   
>       if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
> -        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL)) {
> +        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
> +    {
>           return -EBUSY;
>       }
>   
> -    ro = bs->backing->bs->read_only;
> -    open_flags =  bs->backing->bs->open_flags;
> +    ro = backing_file_bs->read_only;
> +    open_flags =  backing_file_bs->open_flags;
>   
>       if (ro) {
> -        if (bdrv_reopen(bs->backing->bs, open_flags | BDRV_O_RDWR, NULL)) {
> +        if (bdrv_reopen(backing_file_bs, open_flags | BDRV_O_RDWR, NULL)) {
>               return -EACCES;
>           }
>       }
> @@ -438,8 +444,6 @@ int bdrv_commit(BlockDriverState *bs)
>       }
>   
>       /* Insert commit_top block node above backing, so we can write to it */
> -    backing_file_bs = backing_bs(bs);
> -

...then set backing_file_bs (presumably to something always non-null)...

>       commit_top_bs = bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV_O_RDWR,
>                                            &local_err);
>       if (commit_top_bs == NULL) {
> @@ -525,15 +529,13 @@ ro_cleanup:
>       qemu_vfree(buf);
>   
>       blk_unref(backing);
> -    if (backing_file_bs) {
> -        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
> -    }
> +    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);

...then looks like it has a dead always-true conditional. The new code 
is thus a bit smarter.

> +++ b/block/io.c
> @@ -120,6 +120,7 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
>   void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>   {
>       BlockDriver *drv = bs->drv;
> +    BlockDriverState *cow_bs = bdrv_filtered_cow_bs(bs);
>       Error *local_err = NULL;
>   
>       memset(&bs->bl, 0, sizeof(bs->bl));
> @@ -148,13 +149,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>           bs->bl.max_iov = IOV_MAX;
>       }
>   
> -    if (bs->backing) {
> -        bdrv_refresh_limits(bs->backing->bs, &local_err);
> +    if (cow_bs) {
> +        bdrv_refresh_limits(cow_bs, &local_err);
>           if (local_err) {
>               error_propagate(errp, local_err);
>               return;
>           }
> -        bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
> +        bdrv_merge_limits(&bs->bl, &cow_bs->bl);

Is this doing the right things with blkdebug?

> +++ b/blockdev.c

> @@ -3293,6 +3300,12 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>           error_setg(errp, "cannot commit an image into itself");
>           goto out;
>       }
> +    if (!bdrv_legacy_chain_contains(top_bs, base_bs)) {
> +        /* We have to disallow this until the user can give explicit
> +         * consent */
> +        error_setg(errp, "Cannot commit through explicit filter nodes");
> +        goto out;
> +    }

Makes sense. I guess the argument here is that the API now fails where 
it could previously succeed, but the earlier success was questionable 
and probably broke rather than doing what the user thought it might.

> @@ -3722,8 +3752,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>       }
>   
>       flags = bs->open_flags | BDRV_O_RDWR;
> -    source = backing_bs(bs);
> +    source = bdrv_filtered_cow_bs(unfiltered_bs);
>       if (!source && arg->sync == MIRROR_SYNC_MODE_TOP) {
> +        if (bdrv_filtered_bs(unfiltered_bs)) {
> +            /* @unfiltered_bs is an explicit filter */
> +            error_setg(errp, "Cannot perform sync=top mirror through an "
> +                       "explicitly added filter node on the source");
> +            goto out;
> +        }

Again, a failure now where the previous code was probably questionable. 
Seems okay.

> +++ b/nbd/server.c
> @@ -2415,13 +2415,9 @@ void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
>           return;
>       }
>   
> -    while (true) {
> +    while (bs && !bm) {
>           bm = bdrv_find_dirty_bitmap(bs, bitmap);
> -        if (bm != NULL || bs->backing == NULL) {
> -            break;
> -        }
> -
> -        bs = bs->backing->bs;
> +        bs = bdrv_filtered_bs(bs);

Yep, this is the rewrite that I recently realized I need for using 
blkdebug to artificially change block limits during NBD testing.

Overall looks good, but I'm not sure if any of my questions, or rebasing 
to master, will require a respin, so I'll wait a bit before giving R-b 
in case you want to respond to my comments first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
