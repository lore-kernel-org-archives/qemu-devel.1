Received: from eggs.gnu.org ([2001:4830:134:3::10]:58872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQYLo-00017z-1h
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQYLl-00017E-SV
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:19:44 -0400
Date: Wed, 6 Jun 2018 09:19:20 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180606131919.GI11303@localhost.localdomain>
References: <20180605185905.4583-1-jsnow@redhat.com>
	<20180605185905.4583-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605185905.4583-6-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/5] qapi: add disabled
 parameter to block-dirty-bitmap-add
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

On Tue, Jun 05, 2018 at 02:59:05PM -0400, John Snow wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> This is needed, for example, to create a new bitmap and merge several
> disabled bitmaps into a new one. Without this flag we will have to
> put block-dirty-bitmap-add and block-dirty-bitmap-disable into one
> transaction.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  blockdev.c           | 10 ++++++++++
>  qapi/block-core.json |  6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index b00908fdfd..03e7cbeea1 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2073,6 +2073,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionState *common,
>                                 action->has_granularity, action->granularity,
>                                 action->has_persistent, action->persistent,
>                                 action->has_autoload, action->autoload,
> +                               action->has_x_disabled, action->x_disabled,
>                                 &local_err);
>  
>      if (!local_err) {
> @@ -2880,6 +2881,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>                                  bool has_granularity, uint32_t granularity,
>                                  bool has_persistent, bool persistent,
>                                  bool has_autoload, bool autoload,
> +                                bool has_disabled, bool disabled,
>                                  Error **errp)
>  {
>      BlockDriverState *bs;
> @@ -2914,6 +2916,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>          warn_report("Autoload option is deprecated and its value is ignored");
>      }
>  
> +    if (!has_disabled) {
> +        disabled = false;
> +    }
> +
>      if (persistent &&
>          !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
>      {
> @@ -2925,6 +2931,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>          return;
>      }
>  
> +    if (disabled) {
> +        bdrv_disable_dirty_bitmap(bitmap);
> +    }
> +
>      bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
>  }
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3999175c23..f06a43bfb2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1734,11 +1734,15 @@
>  #            Currently, all dirty tracking bitmaps are loaded from Qcow2 on
>  #            open.
>  #
> +# @x-disabled: the bitmap is created in the disabled state, which means that
> +#              it will not track drive changes. The bitmap may be enabled with
> +#              x-block-dirty-bitmap-enable. Default is false. (Since: 3.0)
> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> -            '*persistent': 'bool', '*autoload': 'bool' } }
> +            '*persistent': 'bool', '*autoload': 'bool', '*x-disabled': 'bool' } }
>  
>  ##
>  # @BlockDirtyBitmapMerge:
> -- 
> 2.14.3
> 
> 
