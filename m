Received: from eggs.gnu.org ([2001:4830:134:3::10]:48802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzobt-0005h7-07
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 15:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzobn-0007GF-Rc
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 15:46:04 -0400
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
	<20180706113630.25222-5-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a606cb87-a4f5-53ed-6048-ef8fb8c798bc@redhat.com>
Date: Tue, 11 Sep 2018 15:45:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180706113630.25222-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qapi: add transaction support for
 x-block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org



On 07/06/2018 07:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> New action is like clean action: do the whole thing in .prepare and
> undo in .abort. This behavior for bitmap-changing actions is needed
> because backup job actions use bitmap in .prepare.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/transaction.json |  2 ++
>  blockdev.c            | 38 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index d7e4274550..5875cdb16c 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -48,6 +48,7 @@
>  # - @block-dirty-bitmap-clear: since 2.5
>  # - @x-block-dirty-bitmap-enable: since 3.0
>  # - @x-block-dirty-bitmap-disable: since 3.0
> +# - @x-block-dirty-bitmap-merge: since 3.1
>  # - @blockdev-backup: since 2.3
>  # - @blockdev-snapshot: since 2.5
>  # - @blockdev-snapshot-internal-sync: since 1.7
> @@ -63,6 +64,7 @@
>         'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
>         'x-block-dirty-bitmap-enable': 'BlockDirtyBitmap',
>         'x-block-dirty-bitmap-disable': 'BlockDirtyBitmap',
> +       'x-block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
>         'blockdev-backup': 'BlockdevBackup',
>         'blockdev-snapshot': 'BlockdevSnapshot',
>         'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
> diff --git a/blockdev.c b/blockdev.c
> index 5348e8ba9b..feebbb9a9a 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1940,6 +1940,7 @@ static void blockdev_backup_clean(BlkActionState *common)
>  typedef struct BlockDirtyBitmapState {
>      BlkActionState common;
>      BdrvDirtyBitmap *bitmap;
> +    BdrvDirtyBitmap *merge_source;

Is this necessary?

>      BlockDriverState *bs;
>      HBitmap *backup;
>      bool prepared;
> @@ -2112,6 +2113,35 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
>      }
>  }
>  
> +static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
> +                                             Error **errp)
> +{
> +    BlockDirtyBitmapMerge *action;
> +    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
> +                                             common, common);
> +
> +    if (action_check_completion_mode(common, errp) < 0) {
> +        return;
> +    }
> +
> +    action = common->action->u.x_block_dirty_bitmap_merge.data;
> +    state->bitmap = block_dirty_bitmap_lookup(action->node,
> +                                              action->dst_name,
> +                                              &state->bs,
> +                                              errp);
> +    if (!state->bitmap) {
> +        return;
> +    }
> +
> +    state->merge_source = bdrv_find_dirty_bitmap(state->bs, action->src_name);
> +    if (!state->merge_source) {
> +        return;
> +    }
> +
> +    bdrv_merge_dirty_bitmap(state->bitmap, state->merge_source, &state->backup,
> +                            errp);
> +}
> +
>  static void abort_prepare(BlkActionState *common, Error **errp)
>  {
>      error_setg(errp, "Transaction aborted using Abort action");
> @@ -2182,7 +2212,13 @@ static const BlkActionOps actions[] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
>          .prepare = block_dirty_bitmap_disable_prepare,
>          .abort = block_dirty_bitmap_disable_abort,
> -     }
> +    },
> +    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapState),
> +        .prepare = block_dirty_bitmap_merge_prepare,
> +        .commit = block_dirty_bitmap_free_backup,
> +        .abort = block_dirty_bitmap_restore,
> +    }
>  };
>  
>  /**
> 

If the new state is not necessary and you remove it:

Reviewed-by: John Snow <jsnow@redhat.com>
