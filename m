Received: from eggs.gnu.org ([2001:4830:134:3::10]:38546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddDGt-0002Ln-Fe
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddDGs-0003B0-ID
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:22:27 -0400
Date: Thu, 3 Aug 2017 12:22:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803102213.GE4456@dhcp-200-186.str.redhat.com>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801134907.31253-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: skip implicit nodes in
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

Am 01.08.2017 um 15:49 hat Manos Pitsidianakis geschrieben:
> Implicit filter nodes added at the top of nodes can interfere with block
> jobs. This is not a problem when they are added by other jobs since
> adding another job will issue a QERR_DEVICE_IN_USE, but it can happen in
> the next commit which introduces an implicitly created throttle filter
> node below BlockBackend, which we want to be skipped during automatic
> operations on the graph since the user does not necessarily know about
> their existence.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 17 +++++++++++++++++
>  blockdev.c                | 12 ++++++++++++
>  include/block/block_int.h |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 886a457ab0..9ebdba28b0 100644
> --- a/block.c
> +++ b/block.c
> @@ -4947,3 +4947,20 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>  
>      return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp);
>  }
> +
> +/* Get first non-implicit node down a bs chain. */
> +BlockDriverState *bdrv_get_first_non_implicit(BlockDriverState *bs)
> +{
> +    if (!bs) {
> +        return NULL;
> +    }
> +
> +    if (!bs->implicit) {
> +        return bs;
> +    }
> +
> +    /* at this point bs is implicit and must have a child */
> +    assert(bs->file);
> +
> +    return bdrv_get_first_non_implicit(bs->file->bs);
> +}

mirror_top/commit_top use bs->backing instead of bs->file, so this
assertion would fail for them.

It's probably better to assert that the implicit node has only one child
and then use that child, whatever it may be.

I'd also prefer the function to work iteratively rather than recursively
because chains can be rather long. (I know that we recurse in many
places anyway, so it's not a strong argument, but I think it would also
look a bit nicer.)

Kevin
