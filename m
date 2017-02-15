Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce8sZ-00024f-1T
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce8sY-0007Lw-00
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:20:55 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-17-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <46a40186-ed42-eeba-5d4c-0257fa3d9821@redhat.com>
Date: Wed, 15 Feb 2017 18:20:47 -0500
MIME-Version: 1.0
In-Reply-To: <1487153430-17260-17-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 16/25] qmp: add persistent flag to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/15/2017 05:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
> Default is false.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  blockdev.c           | 18 +++++++++++++++++-
>  qapi/block-core.json |  8 +++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 245e1e1..40605fa 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1967,6 +1967,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
>      /* AIO context taken and released within qmp_block_dirty_bitmap_add */
>      qmp_block_dirty_bitmap_add(action->node, action->name,
>                                 action->has_granularity, action->granularity,
> +                               action->has_persistent, action->persistent,
>                                 &local_err);
>  
>      if (!local_err) {
> @@ -2696,10 +2697,12 @@ out:
>  
>  void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>                                  bool has_granularity, uint32_t granularity,
> +                                bool has_persistent, bool persistent,
>                                  Error **errp)
>  {
>      AioContext *aio_context;
>      BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
>  
>      if (!name || name[0] == '\0') {
>          error_setg(errp, "Bitmap name cannot be empty");
> @@ -2725,7 +2728,20 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>          granularity = bdrv_get_default_bitmap_granularity(bs);
>      }
>  
> -    bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> +    if (!has_persistent) {
> +        persistent = false;
> +    }
> +
> +    if (persistent &&
> +        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
> +    {
> +        goto out;
> +    }
> +
> +    bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> +    if (bitmap != NULL) {
> +        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    }
>  
>   out:
>      aio_context_release(aio_context);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 932f5bb..535df20 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1559,10 +1559,16 @@
>  # @granularity: #optional the bitmap granularity, default is 64k for
>  #               block-dirty-bitmap-add
>  #
> +# @persistent: #optional the bitmap is persistent, i.e. it will be saved to the
> +#              corresponding block device image file on its close. For now only
> +#              Qcow2 disks support persistent bitmaps. Default is false.
> +#              (Since 2.9)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
> -  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }
> +  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> +            '*persistent': 'bool' } }
>  
>  ##
>  # @block-dirty-bitmap-add:
> 
