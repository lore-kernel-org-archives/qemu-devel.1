Received: from eggs.gnu.org ([2001:4830:134:3::10]:56368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQlUI-0007Bd-6i
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQlUG-0000ik-V6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:21:22 -0400
Date: Wed, 6 Jun 2018 23:21:08 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180607032108.GN11303@localhost.localdomain>
References: <20180606182449.1607-1-jsnow@redhat.com>
	<20180606182449.1607-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606182449.1607-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/5] qmp: transaction
 support for x-block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Jun 06, 2018 at 02:24:47PM -0400, John Snow wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [Added x- prefix. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  blockdev.c            | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  qapi/transaction.json |  4 +++
>  2 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index fb402edc94..af705738cd 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2052,6 +2052,7 @@ typedef struct BlockDirtyBitmapState {
>      BlockDriverState *bs;
>      HBitmap *backup;
>      bool prepared;
> +    bool was_enabled;
>  } BlockDirtyBitmapState;
>  
>  static void block_dirty_bitmap_add_prepare(BlkActionState *common,
> @@ -2151,6 +2152,74 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
>      hbitmap_free(state->backup);
>  }
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
> +    action = common->action->u.x_block_dirty_bitmap_enable.data;
> +    state->bitmap = block_dirty_bitmap_lookup(action->node,
> +                                              action->name,
> +                                              NULL,
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
> +    action = common->action->u.x_block_dirty_bitmap_disable.data;
> +    state->bitmap = block_dirty_bitmap_lookup(action->node,
> +                                              action->name,
> +                                              NULL,
> +                                              errp);
> +    if (!state->bitmap) {
> +        return;
> +    }
> +
> +    state->was_enabled = bdrv_dirty_bitmap_enabled(state->bitmap);
> +    bdrv_disable_dirty_bitmap(state->bitmap);
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
>  static void abort_prepare(BlkActionState *common, Error **errp)
>  {
>      error_setg(errp, "Transaction aborted using Abort action");
> @@ -2211,7 +2280,17 @@ static const BlkActionOps actions[] = {
>          .prepare = block_dirty_bitmap_clear_prepare,
>          .commit = block_dirty_bitmap_clear_commit,
>          .abort = block_dirty_bitmap_clear_abort,
> -    }
> +    },
> +    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapState),
> +        .prepare = block_dirty_bitmap_enable_prepare,
> +        .abort = block_dirty_bitmap_enable_abort,
> +    },
> +    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_DISABLE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapState),
> +        .prepare = block_dirty_bitmap_disable_prepare,
> +        .abort = block_dirty_bitmap_disable_abort,
> +     }
>  };
>  
>  /**
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index bd312792da..d7e4274550 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -46,6 +46,8 @@
>  # - @abort: since 1.6
>  # - @block-dirty-bitmap-add: since 2.5
>  # - @block-dirty-bitmap-clear: since 2.5
> +# - @x-block-dirty-bitmap-enable: since 3.0
> +# - @x-block-dirty-bitmap-disable: since 3.0
>  # - @blockdev-backup: since 2.3
>  # - @blockdev-snapshot: since 2.5
>  # - @blockdev-snapshot-internal-sync: since 1.7
> @@ -59,6 +61,8 @@
>         'abort': 'Abort',
>         'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
>         'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
> +       'x-block-dirty-bitmap-enable': 'BlockDirtyBitmap',
> +       'x-block-dirty-bitmap-disable': 'BlockDirtyBitmap',
>         'blockdev-backup': 'BlockdevBackup',
>         'blockdev-snapshot': 'BlockdevSnapshot',
>         'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> -- 
> 2.14.3
> 
> 
