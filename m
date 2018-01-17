Received: from eggs.gnu.org ([2001:4830:134:3::10]:37241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebpIW-00046G-RI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebpIS-0000yG-GH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:06:40 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6688fdd4-c820-89c7-3e39-84e9ccfb0bbf@virtuozzo.com>
Date: Wed, 17 Jan 2018 18:06:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180116125427.18540-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qmp: transaction support for
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

16.01.2018 15:54, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/transaction.json |  4 +++
>   blockdev.c            | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
>
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index bd312792da..b643d848f8 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -46,6 +46,8 @@
>   # - @abort: since 1.6
>   # - @block-dirty-bitmap-add: since 2.5
>   # - @block-dirty-bitmap-clear: since 2.5
> +# - @block-dirty-bitmap-enable: since 2.12
> +# - @block-dirty-bitmap-disable: since 2.12
>   # - @blockdev-backup: since 2.3
>   # - @blockdev-snapshot: since 2.5
>   # - @blockdev-snapshot-internal-sync: since 1.7
> @@ -59,6 +61,8 @@
>          'abort': 'Abort',
>          'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
>          'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
> +       'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
> +       'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
>          'blockdev-backup': 'BlockdevBackup',
>          'blockdev-snapshot': 'BlockdevSnapshot',
>          'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> diff --git a/blockdev.c b/blockdev.c
> index 997a6f514c..d338363d78 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1962,6 +1962,7 @@ typedef struct BlockDirtyBitmapState {
>       AioContext *aio_context;
>       HBitmap *backup;
>       bool prepared;
> +    bool was_enabled;
>   } BlockDirtyBitmapState;
>   
>   static void block_dirty_bitmap_add_prepare(BlkActionState *common,
> @@ -2069,6 +2070,74 @@ static void block_dirty_bitmap_clear_clean(BlkActionState *common)
>       }
>   }
>   
> +static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
> +                                              Error **errp)
> +{
> +    BlockDirtyBitmap *action;
> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (action_check_completion_mode(common, errp) < 0) {
> +        return;
> +    }
> +
> +    action = common->action->u.block_dirty_bitmap_enable.data;
> +    state->bitmap = block_dirty_bitmap_lookup(action->node,
> +                                              action->name,
> +                                              &state->bs,
> +                                              errp);
> +    if (!state->bitmap) {
> +        return;
> +    }
> +
> +    state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
> +    bdrv_enable_dirty_bitmap(state->bitmap);
> +}
> +
> +static void block_dirty_bitmap_enable_abort(BlkActionState *common)
> +{
> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (!state->was_enabled) {
> +        bdrv_disable_dirty_bitmap(state->bitmap);
> +    }
> +}
> +
> +static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
> +                                               Error **errp)
> +{
> +    BlockDirtyBitmap *action;
> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (action_check_completion_mode(common, errp) < 0) {
> +        return;
> +    }
> +
> +    action = common->action->u.block_dirty_bitmap_disable.data;
> +    state->bitmap = block_dirty_bitmap_lookup(action->node,
> +                                              action->name,
> +                                              &state->bs,
> +                                              errp);
> +    if (!state->bitmap) {
> +        return;
> +    }
> +
> +    state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
> +    bdrv_disable_dirty_bitmap(state->bitmap);

hm. actually, I just make it like _clear is made. But now I doubt,
why do we need disable here? we can disable in commit, and do not need
state->was_enabled..

and for _clear, we not to clear bitmap in commit? and then, we do not need
bdrv_undo_clear_dirty_bitmap at all?

or what do I miss? if nothing, I'll respin the series including _clear 
refactoring.

> +}
> +
> +static void block_dirty_bitmap_disable_abort(BlkActionState *common)
> +{
> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (state->was_enabled) {
> +        bdrv_enable_dirty_bitmap(state->bitmap);
> +    }
> +}
> +
>   static void abort_prepare(BlkActionState *common, Error **errp)
>   {
>       error_setg(errp, "Transaction aborted using Abort action");
> @@ -2130,6 +2199,16 @@ static const BlkActionOps actions[] = {
>           .commit = block_dirty_bitmap_clear_commit,
>           .abort = block_dirty_bitmap_clear_abort,
>           .clean = block_dirty_bitmap_clear_clean,
> +    },
> +    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapState),
> +        .prepare = block_dirty_bitmap_enable_prepare,
> +        .abort = block_dirty_bitmap_enable_abort,
> +    },
> +    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapState),
> +        .prepare = block_dirty_bitmap_disable_prepare,
> +        .abort = block_dirty_bitmap_disable_abort,
>       }
>   };
>   


-- 
Best regards,
Vladimir
