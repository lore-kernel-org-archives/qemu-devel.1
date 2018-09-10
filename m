Received: from eggs.gnu.org ([2001:4830:134:3::10]:45823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzUDd-0003vL-2Q
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzUDc-0006P3-6e
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 17:59:40 -0400
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
	<20180706113630.25222-4-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c6720bde-d7e5-902b-e4fd-6a71347b4ec5@redhat.com>
Date: Mon, 10 Sep 2018 17:59:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180706113630.25222-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] blockdev: rename
 block-dirty-bitmap-clear transaction handlers
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
> Rename block-dirty-bitmap-clear transaction handlers to reuse them for
> x-block-dirty-bitmap-merge transaction in the following patch.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 9cb29ca63e..5348e8ba9b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2026,7 +2026,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
>      bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
>  }
>  
> -static void block_dirty_bitmap_clear_abort(BlkActionState *common)
> +static void block_dirty_bitmap_restore(BlkActionState *common)
>  {
>      BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
> @@ -2036,7 +2036,7 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
>      }
>  }
>  
> -static void block_dirty_bitmap_clear_commit(BlkActionState *common)
> +static void block_dirty_bitmap_free_backup(BlkActionState *common)
>  {
>      BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
> @@ -2170,8 +2170,8 @@ static const BlkActionOps actions[] = {
>      [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_CLEAR] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
>          .prepare = block_dirty_bitmap_clear_prepare,
> -        .commit = block_dirty_bitmap_clear_commit,
> -        .abort = block_dirty_bitmap_clear_abort,
> +        .commit = block_dirty_bitmap_free_backup,
> +        .abort = block_dirty_bitmap_restore,
>      },
>      [TRANSACTION_ACTION_KIND_X_BLOCK_DIRTY_BITMAP_ENABLE] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
> 

Reviewed-by: John Snow <jsnow@redhat.com>
