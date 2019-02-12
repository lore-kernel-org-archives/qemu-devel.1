Received: from eggs.gnu.org ([209.51.188.92]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtZLm-0006B1-UG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtZLl-0000an-Mv
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:47:54 -0500
Date: Tue, 12 Feb 2019 15:47:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212144747.GC5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<ae441a8c27cae1a80e57fb6d291fe95667da0c76.1547739122.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae441a8c27cae1a80e57fb6d291fe95667da0c76.1547739122.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 01/13] block: Allow freezing BdrvChild links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.01.2019 um 16:33 hat Alberto Garcia geschrieben:
> Our permission system is useful to define what operations are allowed
> on a certain block node and includes things like BLK_PERM_WRITE or
> BLK_PERM_RESIZE among others.
> 
> One of the permissions is BLK_PERM_GRAPH_MOD which allows "changing
> the node that this BdrvChild points to". The exact meaning of this has
> never been very clear, but it can be understood as "change any of the
> links connected to the node". This can be used to prevent changing a
> backing link, but it's too coarse.
> 
> This patch adds a new 'frozen' attribute to BdrvChild, which forbids
> detaching the link from the node it points to, and new API to freeze
> and unfreeze a backing chain.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                   | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/block/block.h     |  5 ++++
>  include/block/block_int.h |  5 ++++
>  3 files changed, 76 insertions(+)

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index f605622216..fd0e88d17a 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -661,6 +661,11 @@ struct BdrvChild {
>       */
>      uint64_t shared_perm;
>  
> +    /*
> +     * This link is frozen: the child cannot be detached from the parent.
> +     */
> +    bool frozen;
> +
>      QLIST_ENTRY(BdrvChild) next;
>      QLIST_ENTRY(BdrvChild) next_parent;
>  };

Is this enough, or should it prevent both detaching from the parent _and_
changing the child node it points to?

> diff --git a/block.c b/block.c
> index 4f5ff2cc12..51fac086c7 100644
> --- a/block.c
> +++ b/block.c
> @@ -2062,6 +2062,8 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
>      BlockDriverState *old_bs = child->bs;
>      int i;
>  
> +    assert(!child->frozen);
> +
>      if (old_bs && new_bs) {
>          assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
>      }

Okay, this does forbid both, so I think it's just the comment that needs
to be changed in the hunk above.

In order to avoid running into an assertion failure, we need to detect
the situation in all callers, or audit that it can never happen:

* bdrv_replace_child()
    * bdrv_root_attach_child(): Creates a new BdrvChild, never frozen
    * bdrv_detach_child()
        * bdrv_root_unref_child()
            * blk_remove_bs(): Not a backing child, safe
            * block_job_remove_all_bdrv(): Not a backing child, safe
            * bdrv_unref_child()
                * bdrv_set_backing_hd(): Adds a check
                * bdrv_close():  Not a backing child, safe
                * bdrv_open_driver(): Not a backing child, safe
    * bdrv_drop_intermediate(): Adds a check, though see below

* bdrv_replace_node(): Missing check?
    * bdrv_append()
      For example, mirror_start_job() calls it to insert the
      mirror_top_bs node above the source, which could be anywhere in
      the graph. This may involve changing the target of backing links.
    * Other callers looks questionable, too

bdrv_replace_node() can return an error, so I think we should add a
check there.

For the bdrv_replace_child() call chain, the state looks better, but it
was tedious to verify and future additions could easily forget to add
the check. I wonder if we should allow some function there to return
errors so that we don't have to add the checks in the outermost
functions of the call chain.

> @@ -3813,6 +3819,62 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
>  }
>  
>  /*
> + * Return true if at least one of the backing links between @bs and
> + * @base is frozen. @errp is set if that's the case.
> + */
> +bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
> +                                  Error **errp)
> +{
> +    BlockDriverState *i;
> +
> +    for (i = bs; i != base && i->backing; i = backing_bs(i)) {
> +        if (i->backing->frozen) {
> +            error_setg(errp, "Cannot remove link from '%s' to '%s'",

Maybe s/remove/change/?

Might also be worth including the BdrvChild name in the error message.

> +                       i->node_name, backing_bs(i)->node_name);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}

> @@ -3861,6 +3923,10 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
>          goto exit;
>      }
>  
> +    if (bdrv_is_backing_chain_frozen(top, base, NULL)) {
> +        goto exit;
> +    }
> +
>      /* If 'base' recursively inherits from 'top' then we should set
>       * base->inherits_from to top->inherits_from after 'top' and all
>       * other intermediate nodes have been dropped.

bdrv_drop_intermediate() doesn't change the links between in the chain
between top and base, but the links between the parents of top and top
are changed to point to base instead.

I think this is checking the wrong thing.

Kevin
