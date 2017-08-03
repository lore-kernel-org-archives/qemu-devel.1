Received: from eggs.gnu.org ([2001:4830:134:3::10]:44145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddE1w-0003JN-02
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddE1u-0002eS-2X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 07:11:03 -0400
Date: Thu, 3 Aug 2017 13:10:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170803111050.GF4456@dhcp-200-186.str.redhat.com>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801134907.31253-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
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
> This commit removes all I/O throttling from block/block-backend.c. In
> order to support the existing interface, it is changed to use the
> block/throttle.c filter driver.
> 
> The throttle filter node that is created by the legacy interface is
> stored in a 'throttle_node' field in the BlockBackendPublic of the
> device. The legacy throttle node is managed by the legacy interface
> completely. More advanced configurations with the filter drive are
> possible using the QMP API, but these will be ignored by the legacy
> interface.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

> -void blk_io_limits_disable(BlockBackend *blk)
> +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
>  {
> -    assert(blk->public.throttle_group_member.throttle_state);
> -    bdrv_drained_begin(blk_bs(blk));
> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
> -    bdrv_drained_end(blk_bs(blk));
> +    BlockDriverState *bs, *throttle_node;
> +
> +    throttle_node = blk_get_public(blk)->throttle_node;
> +
> +    assert(throttle_node && throttle_node->refcnt == 1);

I don't think you can assert that nobody else references the node. Once
it's there, it can be used. That doesn't really have to bother the
BlockBackend, though. Or can you think of a case that would break if the
throttle_node were kept alive by someone else?

> +    bs = throttle_node->file->bs;
> +    blk_get_public(blk)->throttle_node = NULL;
> +
> +    /* ref throttle_node's child bs so that it isn't lost when throttle_node is
> +     * destroyed */
> +    bdrv_ref(bs);
> +
> +    /* this destroys throttle_node */
> +    blk_remove_bs(blk);

Without the assertion, it doesn't necessarily destroy the node, but it
gives up our reference.

> +    blk_insert_bs(blk, bs, &error_abort);
> +    bdrv_unref(bs);
>  }
>  
>  /* should be called before blk_set_io_limits if a limit is set */
> -void blk_io_limits_enable(BlockBackend *blk, const char *group)
> +void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
>  {
> -    assert(!blk->public.throttle_group_member.throttle_state);
> -    throttle_group_register_tgm(&blk->public.throttle_group_member,
> -                                group, blk_get_aio_context(blk));
> +    BlockDriverState *bs = blk_bs(blk), *throttle_node;
> +    QDict *options = qdict_new();
> +    Error *local_err = NULL;
> +
> +    bdrv_drained_begin(bs);
> +    /*
> +     * increase bs ref count so it doesn't get deleted when removed
> +     * from the BlockBackend's root
> +     * */
> +    bdrv_ref(bs);
> +    blk_remove_bs(blk);
> +
> +    qdict_set_default_str(options, "file", bs->node_name);
> +    qdict_set_default_str(options, QEMU_OPT_THROTTLE_GROUP_NAME, group);
> +    throttle_node = bdrv_new_open_driver(bdrv_find_format("throttle"),
> +            NULL, bdrv_get_flags(bs), options, errp);
> +    QDECREF(options);
> +    if (!throttle_node) {
> +        blk_insert_bs(blk, bs, &error_abort);

Wouldn't it be easier to just do the blk_remove_bs() later?

I think &error_abort isn't entirely correct because blk_insert_bs() can
fail theoretically if image locking prevents this (some other process
would have to grab the lock between blk_remove_bs() and this, so it's
unlikely, but it's possible). So it would be nice if we could avoid it.

> +        bdrv_unref(bs);
> +        bdrv_drained_end(bs);
> +        return;
> +    }
> +    throttle_node->implicit = true;
> +    /* bs will be throttle_node's child now so unref it*/
> +    bdrv_unref(bs);

The bdrv_ref/unref() pair could be avoided if you did blk_remove_bs()
only here when the new reference already exists.

> +    blk_insert_bs(blk, throttle_node, &local_err);
> +    if (local_err) {
> +        bdrv_ref(bs);
> +        bdrv_unref(throttle_node);
> +        blk_insert_bs(blk, bs, &error_abort);
> +        bdrv_unref(bs);
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    bdrv_unref(throttle_node);
> +
> +    assert(throttle_node->file->bs == bs);
> +    assert(throttle_node->refcnt == 1);
> +
> +    bdrv_drained_end(bs);
> +
> +    blk_get_public(blk)->throttle_node = throttle_node;
>  }
>  
> -void blk_io_limits_update_group(BlockBackend *blk, const char *group)
> +void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp)
>  {
> +    ThrottleGroupMember *tgm;
> +    Error *local_err = NULL;
> +
>      /* this BB is not part of any group */
> -    if (!blk->public.throttle_group_member.throttle_state) {
> +    if (!blk->public.throttle_node) {
>          return;
>      }
>  
> +    tgm = throttle_get_tgm(blk->public.throttle_node);
>      /* this BB is a part of the same group than the one we want */
> -    if (!g_strcmp0(throttle_group_get_name(&blk->public.throttle_group_member),
> +    if (!g_strcmp0(throttle_group_get_name(tgm),
>                  group)) {
>          return;
>      }
>  
> -    /* need to change the group this bs belong to */
> -    blk_io_limits_disable(blk);
> -    blk_io_limits_enable(blk, group);
> +    /* need to change the group this bs belongs to */
> +    blk_io_limits_disable(blk, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    blk_io_limits_enable(blk, group, errp);
>  }
>  
>  static void blk_root_drained_begin(BdrvChild *child)
>  {
> +    ThrottleGroupMember *tgm;
>      BlockBackend *blk = child->opaque;
>  
>      if (++blk->quiesce_counter == 1) {
> @@ -1958,19 +1993,25 @@ static void blk_root_drained_begin(BdrvChild *child)
>  
>      /* Note that blk->root may not be accessible here yet if we are just
>       * attaching to a BlockDriverState that is drained. Use child instead. */
> -
> -    if (atomic_fetch_inc(&blk->public.throttle_group_member.io_limits_disabled) == 0) {
> -        throttle_group_restart_tgm(&blk->public.throttle_group_member);
> +    if (blk->public.throttle_node) {
> +        tgm = throttle_get_tgm(blk->public.throttle_node);
> +        if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
> +            throttle_group_restart_tgm(tgm);
> +        }
>      }
>  }
>  
>  static void blk_root_drained_end(BdrvChild *child)
>  {
> +    ThrottleGroupMember *tgm;
>      BlockBackend *blk = child->opaque;
>      assert(blk->quiesce_counter);
>  
> -    assert(blk->public.throttle_group_member.io_limits_disabled);
> -    atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
> +    if (blk->public.throttle_node) {
> +        tgm = throttle_get_tgm(blk->public.throttle_node);
> +        assert(tgm->io_limits_disabled);
> +        atomic_dec(&tgm->io_limits_disabled);
> +    }
>  
>      if (--blk->quiesce_counter == 0) {
>          if (blk->dev_ops && blk->dev_ops->drained_end) {
> diff --git a/block/qapi.c b/block/qapi.c
> index 8d18920ae1..cfc3236757 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -66,11 +66,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>  
>      info->detect_zeroes = bs->detect_zeroes;
>  
> -    if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
> +    if (blk && blk_get_public(blk)->throttle_node) {
>          ThrottleConfig cfg;
> -        BlockBackendPublic *blkp = blk_get_public(blk);
> +        ThrottleGroupMember *tgm = throttle_get_tgm(blk_get_public(blk)->throttle_node);
>  
> -        throttle_group_get_config(&blkp->throttle_group_member, &cfg);
> +        throttle_group_get_config(tgm, &cfg);
>  
>          info->bps     = cfg.buckets[THROTTLE_BPS_TOTAL].avg;
>          info->bps_rd  = cfg.buckets[THROTTLE_BPS_READ].avg;
> @@ -119,7 +119,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>  
>          info->has_group = true;
>          info->group =
> -            g_strdup(throttle_group_get_name(&blkp->throttle_group_member));
> +            g_strdup(throttle_group_get_name(tgm));
>      }
>  
>      info->write_threshold = bdrv_write_threshold_get(bs);
> @@ -148,7 +148,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>          /* Skip automatically inserted nodes that the user isn't aware of for
>           * query-block (blk != NULL), but not for query-named-block-nodes */
>          while (blk && bs0 && bs0->drv && bs0->implicit) {
> -            bs0 = backing_bs(bs0);
> +            bs0 = child_bs(bs0);
>          }
>      }
>  
> @@ -336,7 +336,7 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
>  
>      /* Skip automatically inserted nodes that the user isn't aware of */
>      while (bs && bs->drv && bs->implicit) {
> -        bs = backing_bs(bs);
> +        bs = child_bs(bs);
>      }
>  
>      info->device = g_strdup(blk_name(blk));
> @@ -465,7 +465,7 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
>       * a BlockBackend-level command. Stay at the exact node for a node-level
>       * command. */
>      while (blk_level && bs->drv && bs->implicit) {
> -        bs = backing_bs(bs);
> +        bs = child_bs(bs);
>          assert(bs);
>      }
>  
> diff --git a/block/throttle.c b/block/throttle.c
> index f3395462fb..f7d1510c79 100644
> --- a/block/throttle.c
> +++ b/block/throttle.c
> @@ -38,6 +38,14 @@ static QemuOptsList throttle_opts = {
>      },
>  };
>  
> +static BlockDriver bdrv_throttle;
> +
> +ThrottleGroupMember *throttle_get_tgm(BlockDriverState *bs)
> +{
> +    assert(bs->drv == &bdrv_throttle);
> +    return (ThrottleGroupMember *)bs->opaque;
> +}
> +
>  /* Extract ThrottleConfig options. Assumes cfg is initialized and will be
>   * checked for validity.
>   */
> diff --git a/blockdev.c b/blockdev.c
> index d903a23786..6fafd0efbc 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -607,7 +607,14 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>          if (!throttling_group) {
>              throttling_group = id;
>          }
> -        blk_io_limits_enable(blk, throttling_group);
> +        blk_io_limits_enable(blk, throttling_group, &error);
> +        if (error) {
> +            error_propagate(errp, error);
> +            blk_unref(blk);
> +            blk = NULL;
> +            goto err_no_bs_opts;
> +
> +        }
>          blk_set_io_limits(blk, &cfg);
>      }
>  
> @@ -2616,6 +2623,9 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>      BlockDriverState *bs;
>      BlockBackend *blk;
>      AioContext *aio_context;
> +    BlockDriverState *throttle_node = NULL;
> +    ThrottleGroupMember *tgm;
> +    Error *local_err = NULL;
>  
>      blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
>                        arg->has_id ? arg->id : NULL,
> @@ -2691,19 +2701,38 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>      if (throttle_enabled(&cfg)) {
>          /* Enable I/O limits if they're not enabled yet, otherwise
>           * just update the throttling group. */
> -        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
> -            blk_io_limits_enable(blk,
> -                                 arg->has_group ? arg->group :
> -                                 arg->has_device ? arg->device :
> -                                 arg->id);
> -        } else if (arg->has_group) {
> -            blk_io_limits_update_group(blk, arg->group);
> +        if (!blk_get_public(blk)->throttle_node) {
> +            blk_io_limits_enable(blk, arg->has_group ? arg->group :
> +                    arg->has_device ? arg->device : arg->id, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                goto out;
> +            }
>          }
> -        /* Set the new throttling configuration */
> -        blk_set_io_limits(blk, &cfg);
> -    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
> -        /* If all throttling settings are set to 0, disable I/O limits */
> -        blk_io_limits_disable(blk);
> +
> +        if (arg->has_group) {
> +            /* move throttle node membership to arg->group */
> +            blk_io_limits_update_group(blk, arg->group, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                goto out;
> +            }
> +        }
> +
> +        throttle_node = blk_get_public(blk)->throttle_node;
> +        tgm = throttle_get_tgm(throttle_node);
> +        throttle_group_config(tgm, &cfg);
> +    } else if (blk_get_public(blk)->throttle_node) {
> +        /*
> +         * If all throttling settings are set to 0, disable I/O limits
> +         * by deleting the legacy throttle node
> +         * */
> +        blk_io_limits_disable(blk, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            goto out;
> +        }
> +
>      }
>  
>  out:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 9eeae490f0..e19bd81498 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -514,6 +514,7 @@ extern const BdrvChildRole child_backing;
>  
>  struct BdrvChild {
>      BlockDriverState *bs;
> +    BlockDriverState *parent_bs;
>      char *name;
>      const BdrvChildRole *role;
>      void *opaque;
> @@ -695,11 +696,23 @@ typedef enum BlockMirrorBackingMode {
>      MIRROR_LEAVE_BACKING_CHAIN,
>  } BlockMirrorBackingMode;
>  
> +static inline BlockDriverState *file_bs(BlockDriverState *bs)
> +{
> +    return bs->file ? bs->file->bs : NULL;
> +}
>  static inline BlockDriverState *backing_bs(BlockDriverState *bs)
>  {
>      return bs->backing ? bs->backing->bs : NULL;
>  }
>  
> +/* Returns either bs->file->bs or bs->backing->bs. Used for filter drivers,
> + * which only have one child */
> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
> +{
> +    assert(!(file_bs(bs) && backing_bs(bs)));
> +    return backing_bs(bs) ? backing_bs(bs) : file_bs(bs);
> +}

This is the function that patch 2 should have used rather than directly
using bs->file.

Instead of adding file_bs(), consider the implementation I suggested
there:

    child = QLIST_FIRST(bs->children);
    assert(child && !QLIST_NEXT(child, next));
    return child;

Kevin
