Received: from eggs.gnu.org ([2001:4830:134:3::10]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dptfq-0004XP-23
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dptfo-00024V-TH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:04:38 -0400
Date: Thu, 7 Sep 2017 12:04:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907100420.GD4461@dhcp-200-186.str.redhat.com>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132332.6734-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block: skip implicit nodes in
 snapshots, blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:23 hat Manos Pitsidianakis geschrieben:
> Implicit filter nodes added at the top of nodes can interfere with block
> jobs. This is not a problem when they are added by other jobs since
> adding another job will issue a QERR_DEVICE_IN_USE, but it can happen in
> the next commit which introduces an implicitly created throttle filter
> node below BlockBackend, which we want to be skipped during automatic
> operations on the graph since the user does not necessarily know about
> their existence.
> 
> All implicit filters will have either bs->file or bs->backing set. This
> is a needed assumption so we can know which direction we will skip down
> the graph.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/block/block_int.h | 17 +++++++++++++++++
>  block.c                   | 10 ++++++++++
>  block/qapi.c              | 14 +++++---------
>  blockdev.c                | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 7571c0aaaf..9e0f70e055 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -699,6 +699,21 @@ static inline BlockDriverState *backing_bs(BlockDriverState *bs)
>      return bs->backing ? bs->backing->bs : NULL;
>  }
>  
> +static inline BlockDriverState *file_bs(BlockDriverState *bs)
> +{
> +    return bs->file ? bs->file->bs : NULL;
> +}
> +
> +/* This is a convenience function to get either bs->file->bs or
> + * bs->backing->bs * */
> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
> +{
> +    BlockDriverState *backing = backing_bs(bs);
> +    BlockDriverState *file = file_bs(bs);
> +    assert(!(file && backing));
> +    return backing ?: file;
> +}

I still think you should just get the only child and not restrict it to
bs->file or bs->backing.

child = QLIST_FIRST(&bs->children);
assert(!QLIST_NEXT(child, next));
return child->bs;

file_bs() isn't needed at all then. And Berto is probably
right that this is simple enough that it can just be inlined in
bdrv_get_first_explicit().

> diff --git a/blockdev.c b/blockdev.c
> index 23475abb72..fc7b65c3f0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1300,6 +1300,10 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
>      if (!bs) {
>          return NULL;
>      }
> +
> +    /* Skip implicit filter nodes */
> +    bs = bdrv_get_first_explicit(bs);
> +
> [...]

Most, if not all, of the commands that you change accept both node names
and BlockBackend names, which function as aliases for their root node.
If a node name is given, the user claims that they know the graph
structure and it is supposed to be exact. We should not skip the
implicit filter node then. (For example, for creating an external
snapshot, creating the snapshot above the filter is meaningful. It
requires that the user knows about the filter node, but by using a node
name they tell us that they do.)

Please make sure that your qemu-iotests case covers all of the cases for
which you add a bdrv_get_first_explicit() call in this patch. So far, we
seem to be completely missing:

* Create external snapshot
* Create internal snapshot
* Delete internal snapshot
* blockdev-backup
* blockdev-mirror

All of them should cover the case where a BlockBackend name is given as
well as the cases with a node name.

Kevin
