Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fbB3Q-0003uw-3B
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fbB3O-0001XE-Fe
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:40:40 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <79b1dc41-b230-3958-8057-4061c18a7814@redhat.com>
Date: Thu, 5 Jul 2018 16:40:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180703105305.45398-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: add transaction support for
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
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, "eb >> Eric Blake" <eblake@redhat.com>



On 07/03/2018 06:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/transaction.json |  2 ++
>  blockdev.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index d7e4274550..f9da6ad47f 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -48,6 +48,7 @@
>  # - @block-dirty-bitmap-clear: since 2.5
>  # - @x-block-dirty-bitmap-enable: since 3.0
>  # - @x-block-dirty-bitmap-disable: since 3.0
> +# - @x-block-dirty-bitmap-merge: since 3.0
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
> index 63c4d33124..d0f2d1a4e9 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1946,6 +1946,13 @@ typedef struct BlockDirtyBitmapState {
>      bool was_enabled;
>  } BlockDirtyBitmapState;
>  
> +typedef struct BlockDirtyBitmapMergeState {
> +    BlkActionState common;
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *dst;
> +    BdrvDirtyBitmap *src;
> +} BlockDirtyBitmapMergeState;
> +
>  static void block_dirty_bitmap_add_prepare(BlkActionState *common,
>                                             Error **errp)
>  {
> @@ -2112,6 +2119,45 @@ static void block_dirty_bitmap_disable_abort(BlkActionState *common)
>      }
>  }
>  
> +static void block_dirty_bitmap_merge_prepare(BlkActionState *common,
> +                                             Error **errp)
> +{
> +    BlockDirtyBitmapMerge *action;
> +    BlockDirtyBitmapMergeState *state = DO_UPCAST(BlockDirtyBitmapMergeState,
> +                                                  common, common);
> +
> +    if (action_check_completion_mode(common, errp) < 0) {
> +        return;
> +    }
> +
> +    action = common->action->u.x_block_dirty_bitmap_merge.data;
> +    state->dst = block_dirty_bitmap_lookup(action->node,
> +                                           action->dst_name,
> +                                           &state->bs,
> +                                           errp);
> +    if (!state->dst) {
> +        return;
> +    }
> +
> +    state->src = bdrv_find_dirty_bitmap(state->bs, action->src_name);
> +    if (!state->src) {
> +        return;
> +    }
> +
> +    if (!bdrv_can_merge_dirty_bitmap(state->dst, state->src, errp)) {
> +        return;
> +    }
> +}
> +
> +static void block_dirty_bitmap_merge_commit(BlkActionState *common)
> +{
> +    BlockDirtyBitmapMergeState *state = DO_UPCAST(BlockDirtyBitmapMergeState,
> +                                                  common, common);
> +
> +    /* success is guaranteed by bdrv_can_merge_dirty_bitmap() */
> +    bdrv_merge_dirty_bitmap(state->dst, state->src, &error_abort);
> +}
> +
>  static void abort_prepare(BlkActionState *common, Error **errp)
>  {
>      error_setg(errp, "Transaction aborted using Abort action");
> @@ -2182,7 +2228,12 @@ static const BlkActionOps actions[] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
>          .prepare = block_dirty_bitmap_disable_prepare,
>          .abort = block_dirty_bitmap_disable_abort,
> -     }
> +    },
> +    [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_MERGE] = {
> +        .instance_size = sizeof(BlockDirtyBitmapMergeState),
> +        .prepare = block_dirty_bitmap_merge_prepare,
> +        .commit = block_dirty_bitmap_merge_commit,
> +    }
>  };
>  
>  /**
> 

It's not easy to tell, and we've had this discussion a few times on-list
now to no clear conclusion, but the ordering of bitmap manipulation in
transactions matters.

I believe it matters because drive-backup and blockdev-backup both will
create a job (but not "start" it) during the .prepare phase, but this
job creation itself takes ownership of the bitmap (freezing it, for
instance.)

If you modify a bitmap in a transaction:

[bitmap-command-x
 action-job-y]

you may expect that "bitmap-command-x" will apply to "action-job-y", but
if we were to delay the bitmap modification to .commit(), the
"action-job-y" might take ownership of the bitmap FIRST, and then the
bitmap modification command would fail. I think that's unexpected behavior.

For the same reasons, I think "merge" ought to act early and unwind if
necessary -- at least as the transaction system exists now.

Further, all of the existing bitmap modification commands are
"undo-on-abort" semantics, including add, clear, enable and disable.

We discussed this once in 2015:
https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg01229.html

"
These semantics don't work in this example:

[block-dirty-bitmap-clear,
 drive-backup]

Since drive-backup starts the blockjob in .prepare() but
block-dirty-bitmap-clear only clears the bitmap in .commit() the order
is wrong.

.prepare() has to do something non-destructive, like stashing away the
HBitmap and replacing it with an empty one.  Then .commit() can discard
the old bitmap while .abort() can move the old bitmap back to undo the
operation.
"

Although we no longer START the blockjob in .prepare(), we're still
creating it -- and that creation does freeze the bitmap, so we are still
beholden to this ordering.

...unless, perhaps, we modify the way in which other job actions consume
and utilize bitmaps. They ought not "use" them until they actually
"start" but this might leave us open to failures on .start unless we're
particularly very careful.


I think for now, the best policy is:

- Assume that the actions of transactions are strictly ordered
- Any action that can effect a subsequent action must be visible by
subsequent actions
- Since blockdev/drive-backup use bitmaps in .prepare(), all bitmap
modification commands must take effect in .prepare() as well.


Thoughts?
