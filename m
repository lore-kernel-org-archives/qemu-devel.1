Received: from eggs.gnu.org ([2001:4830:134:3::10]:47627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEcgy-0004qX-4I
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEcgt-00025n-D1
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:55:28 -0500
Date: Wed, 7 Dec 2016 14:55:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207135510.GE4773@noname.str.redhat.com>
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202192223.15153-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
> In order to test the effects of artificial geometry constraints
> on operations like write zero or discard, we first need blkdebug
> to manage these actions.  It also allows us to inject errors on
> those operations, just like we can for read/write/flush.
> 
> We can also test the contract promised by the block layer; namely,
> if a device has specified limits on alignment or maximum size,
> then those limits must be obeyed (for now, the blkdebug driver
> merely inherits limits from whatever it is wrapping, but the next
> patch will further enhance it to allow specific limit overrides).
> 
> This patch intentionally refuses to service requests smaller than
> the requested alignments; this is because an upcoming patch adds
> a qemu-iotest to prove that the block layer is correctly handling
> fragmentation, but the test only works if there is a way to tell
> the difference at artificial alignment boundaries when blkdebug is
> using a larger-than-default alignment.  If we let the blkdebug
> layer always defer to the underlying layer, which potentially has
> a smaller granularity, the iotest will be thwarted.
> 
> Tested by setting up an NBD server with export 'foo', then invoking:
> $ ./qemu-io
> qemu-io> open -o driver=blkdebug blkdebug::nbd://localhost:10809/foo
> qemu-io> d 0 15M
> qemu-io> w -z 0 15M
> 
> Pre-patch, the server never sees the discard (it was silently
> eaten by the block layer); post-patch it is passed across the
> wire.  Likewise, pre-patch the write is always passed with
> NBD_WRITE (with 15M of zeroes on the wire), while post-patch
> it can utilize NBD_WRITE_ZEROES (for less traffic).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v3: rebase to byte-based read/write, improve docs on why no
> partial write zero passthrough
> v2: new patch
> ---
>  block/blkdebug.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 37094a2..aac8184 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -1,6 +1,7 @@
>  /*
>   * Block protocol for I/O error injection
>   *
> + * Copyright (C) 2016 Red Hat, Inc.
>   * Copyright (c) 2010 Kevin Wolf <kwolf@redhat.com>
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
> @@ -382,6 +383,11 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>          goto out;
>      }
> 
> +    bs->supported_write_flags = BDRV_REQ_FUA &
> +        bs->file->bs->supported_write_flags;
> +    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->file->bs->supported_zero_flags;
> +
>      /* Set request alignment */
>      align = qemu_opt_get_size(opts, "align", 0);
>      if (align < INT_MAX && is_power_of_2(align)) {
> @@ -512,6 +518,79 @@ static int blkdebug_co_flush(BlockDriverState *bs)
>  }
> 
> 
> +static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
> +                                                  int64_t offset, int count,
> +                                                  BdrvRequestFlags flags)
> +{
> +    BDRVBlkdebugState *s = bs->opaque;
> +    BlkdebugRule *rule = NULL;
> +    uint32_t align = MAX(bs->bl.request_alignment,
> +                         bs->bl.pwrite_zeroes_alignment);
> +
> +    /* Only pass through requests that are larger than requested
> +     * preferred alignment (so that we test the fallback to writes on
> +     * unaligned portions), and check that the block layer never hands
> +     * us anything crossing an alignment boundary.  */
> +    if (count < align) {
> +        return -ENOTSUP;
> +    }
> +    assert(QEMU_IS_ALIGNED(offset, align));
> +    assert(QEMU_IS_ALIGNED(count, align));
> +    if (bs->bl.max_pwrite_zeroes) {
> +        assert(count <= bs->bl.max_pwrite_zeroes);
> +    }
> +
> +    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
> +        if (rule->options.inject.offset == -1) {

We do have offset and bytes parameters in this function, so I guess we
should check overlaps like in the read/write functions instead of only
executing the rule if it doesn't specify an offset.

> +            break;
> +        }
> +    }
> +
> +    if (rule && rule->options.inject.error) {
> +        return inject_error(bs, rule);
> +    }
> +
> +    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
> +}
> +
> +

Why two newlines?

> +static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
> +                                             int64_t offset, int count)
> +{
> +    BDRVBlkdebugState *s = bs->opaque;
> +    BlkdebugRule *rule = NULL;
> +    uint32_t align = bs->bl.pdiscard_alignment;
> +
> +    /* Only pass through requests that are larger than requested
> +     * minimum alignment, and ensure that unaligned requests do not
> +     * cross optimum discard boundaries. */
> +    if (count < bs->bl.request_alignment) {
> +        return -ENOTSUP;
> +    }
> +    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
> +    assert(QEMU_IS_ALIGNED(count, bs->bl.request_alignment));
> +    if (align && count >= align) {
> +        assert(QEMU_IS_ALIGNED(offset, align));
> +        assert(QEMU_IS_ALIGNED(count, align));
> +    }
> +    if (bs->bl.max_pdiscard) {
> +        assert(count <= bs->bl.max_pdiscard);
> +    }
> +
> +    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
> +        if (rule->options.inject.offset == -1) {

Same thing as above.

> +            break;
> +        }
> +    }
> +
> +    if (rule && rule->options.inject.error) {
> +        return inject_error(bs, rule);
> +    }
> +
> +    return bdrv_co_pdiscard(bs->file->bs, offset, count);
> +}

Kevin
