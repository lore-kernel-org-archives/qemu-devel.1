Received: from eggs.gnu.org ([2001:4830:134:3::10]:57873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coZ9d-0001iw-QB
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coZ9c-0001b5-Ne
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:25:37 -0400
Date: Thu, 16 Mar 2017 18:25:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170316172525.GI4995@noname.redhat.com>
References: <20170316004603.20609-1-jsnow@redhat.com>
	<20170316004603.20609-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316004603.20609-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC patch 2/3] block-backend: add drained_begin /
 drained_end ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 16.03.2017 um 01:46 hat John Snow geschrieben:
> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> ---
> 
> RFC questions:
> 
> - Does the presence of blk->quiesce_counter relieve the burden of needing
>   blk->public.io_limits_disabled? I could probably eliminate this counter
>   entirely and just spy on the root node's quiescent state at key moments
>   instead. I am confident I'm traipsing on delicate drain semantics.

Not for 2.9 anyway. :-)

> - Should I treat the separation of a quisced BDS/BB as a drained_end request
>   as an analogue to how blk_insert_bs (in this patch) handles this?

It's already taken care of, you don't need to add anything for that
(see below).

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/block-backend.c          | 25 +++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  8 ++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 5742c09..eb85e8b 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -65,6 +65,8 @@ struct BlockBackend {
>      bool allow_write_beyond_eof;
>  
>      NotifierList remove_bs_notifiers, insert_bs_notifiers;
> +
> +    int quiesce_counter;
>  };
>  
>  typedef struct BlockBackendAIOCB {
> @@ -559,6 +561,11 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
>      }
>      bdrv_ref(bs);
>  
> +    /* The new BDS may be quiescent, we should attempt to match */
> +    if (bs->quiesce_counter) {
> +        blk_root_drained_begin(blk->root);
> +    }

Do you really need this hunk? BB and BDS should already be kept in sync,
it's just the BB and its user that aren't. This is the call chain that
already leads to blk_root_drained_begin():

blk_insert_bs
    bdrv_root_attach_child
        bdrv_replace_child
            bdrv_replace_child_noperm
                child->role->drained_begin(child)

Did you check whether blk->public.io_limits_disabled ever goes back to 0
with your patch? I think it's increased twice and decreased only once.

To answer your RFC question, bdrv_replace_child_noperm() also takes care
of calling drained_end() when the BDS is detached from the BB.

>      notifier_list_notify(&blk->insert_bs_notifiers, blk);
>      if (blk->public.throttle_state) {
>          throttle_timers_attach_aio_context(
> @@ -705,6 +712,11 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops,
>  
>      blk->dev_ops = ops;
>      blk->dev_opaque = opaque;
> +
> +    /* Are we currently quiesced? Should we enforce this right now? */
> +    if (blk->quiesce_counter && ops->drained_begin) {
> +        ops->drained_begin(opaque);
> +    }
>  }
>  
>  /*
> @@ -1870,9 +1882,15 @@ static void blk_root_drained_begin(BdrvChild *child)
>  {
>      BlockBackend *blk = child->opaque;
>  
> +    blk->quiesce_counter++;
> +
>      /* Note that blk->root may not be accessible here yet if we are just
>       * attaching to a BlockDriverState that is drained. Use child instead. */
>  
> +    if (blk->dev_ops && blk->dev_ops->drained_begin) {
> +        blk->dev_ops->drained_begin(blk->dev_opaque);
> +    }

Should we do this only if blk->quiesce_counter was 0? (And
dev_ops->drained_end() when it reaches 0 again.)

The difference is that the implementation of the callback would have to
have its own counter as it is in this patch. Not really that bad, but at
the moment I don't see a reason why we would need to support nested
drained sections for dev_ops.

> +
>      if (blk->public.io_limits_disabled++ == 0) {
>          throttle_group_restart_blk(blk);
>      }
> @@ -1882,6 +1900,13 @@ static void blk_root_drained_end(BdrvChild *child)
>  {
>      BlockBackend *blk = child->opaque;
>  
> +    assert(blk->quiesce_counter);
> +    blk->quiesce_counter--;
> +
>      assert(blk->public.io_limits_disabled);
>      --blk->public.io_limits_disabled;
> +
> +    if (blk->dev_ops && blk->dev_ops->drained_end) {
> +        blk->dev_ops->drained_end(blk->dev_opaque);
> +    }

The basic idea looks good to me.

Kevin
