Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdlox-0002Nh-SU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdlow-0004MN-Fq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:43:39 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-18-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <17997be9-0e5c-c681-5e28-9b9c7d171109@redhat.com>
Date: Tue, 14 Feb 2017 17:43:32 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-18-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/25] qmp: add autoload parameter to
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



On 02/14/2017 11:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Optional. Default is false.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  blockdev.c           | 18 ++++++++++++++++--
>  qapi/block-core.json |  6 +++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 40605fa..e32ac69 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1968,6 +1968,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
>      qmp_block_dirty_bitmap_add(action->node, action->name,
>                                 action->has_granularity, action->granularity,
>                                 action->has_persistent, action->persistent,
> +                               action->has_autoload, action->autoload,
>                                 &local_err);
>  
>      if (!local_err) {
> @@ -2698,6 +2699,7 @@ out:
>  void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>                                  bool has_granularity, uint32_t granularity,
>                                  bool has_persistent, bool persistent,
> +                                bool has_autoload, bool autoload,
>                                  Error **errp)
>  {
>      AioContext *aio_context;
> @@ -2731,6 +2733,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>      if (!has_persistent) {
>          persistent = false;
>      }
> +    if (!has_autoload) {
> +        autoload = false;
> +    }
> +
> +    if (has_autoload && !persistent) {
> +        error_setg(errp, "Autoload flag must be used only for persistent "
> +                         "bitmaps");
> +        goto out;
> +    }
>  

Good, glad we have this case covered.

>      if (persistent &&
>          !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
> @@ -2739,10 +2750,13 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>      }
>  
>      bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
> -    if (bitmap != NULL) {
> -        bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    if (bitmap == NULL) {
> +        goto out;
>      }
>  
> +    bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    bdrv_dirty_bitmap_set_autoload(bitmap, autoload);
> +
>   out:
>      aio_context_release(aio_context);
>  }
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 535df20..09dcf4e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1564,11 +1564,15 @@
>  #              Qcow2 disks support persistent bitmaps. Default is false.
>  #              (Since 2.9)
>  #
> +# @autoload: #optional the bitmap will be automatically loaded when the image
> +#            it is stored in is opened. This flag may only be specified for
> +#            persistent bitmaps. Default is false. (Since 2.9)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> -            '*persistent': 'bool' } }
> +            '*persistent': 'bool', '*autoload': 'bool' } }
>  
>  ##
>  # @block-dirty-bitmap-add:
> 

Looks good to me.

Reviewed-by: John Snow <jsnow@redhat.com>
