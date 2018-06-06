Received: from eggs.gnu.org ([2001:4830:134:3::10]:59425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQYNt-0002Lc-EB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQYNs-0002Ym-9n
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:21:53 -0400
Date: Wed, 6 Jun 2018 09:21:41 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180606132141.GJ11303@localhost.localdomain>
References: <20180605185905.4583-1-jsnow@redhat.com>
	<20180605185905.4583-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605185905.4583-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] qapi: add
 x-block-dirty-bitmap-enable/disable
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

On Tue, Jun 05, 2018 at 02:59:02PM -0400, John Snow wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [Added x- prefix. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 8de95be8f4..5f059cedcb 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2923,6 +2923,48 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
>      bdrv_clear_dirty_bitmap(bitmap, NULL);
>  }
>  
> +void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
> +                                   Error **errp)
> +{
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +
> +    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
> +    if (!bitmap || !bs) {

Same comment on !bs here as on patch 4.

> +        return;
> +    }
> +
> +    if (bdrv_dirty_bitmap_frozen(bitmap)) {
> +        error_setg(errp,
> +                   "Bitmap '%s' is currently frozen and cannot be enabled",
> +                   name);
> +        return;
> +    }
> +
> +    bdrv_enable_dirty_bitmap(bitmap);
> +}
> +
> +void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
> +                                    Error **errp)
> +{
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *bitmap;
> +
> +    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
> +    if (!bitmap || !bs) {

Ditto

> +        return;
> +    }
> +
> +    if (bdrv_dirty_bitmap_frozen(bitmap)) {
> +        error_setg(errp,
> +                   "Bitmap '%s' is currently frozen and cannot be disabled",
> +                   name);
> +        return;
> +    }
> +
> +    bdrv_disable_dirty_bitmap(bitmap);
> +}
> +
>  BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
>                                                                const char *name,
>                                                                Error **errp)
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4b1de474a9..c061884a0e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1808,6 +1808,48 @@
>  { 'command': 'block-dirty-bitmap-clear',
>    'data': 'BlockDirtyBitmap' }
>  
> +##
> +# @x-block-dirty-bitmap-enable:
> +#
> +# Enables a dirty bitmap so that it will begin tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: 2.12

Since: 3.00

> +#
> +# Example:
> +#
> +# -> { "execute": "x-block-dirty-bitmap-enable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +  { 'command': 'x-block-dirty-bitmap-enable',
> +    'data': 'BlockDirtyBitmap' }
> +
> +##
> +# @x-block-dirty-bitmap-disable:
> +#
> +# Disables a dirty bitmap so that it will stop tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: 2.12

Since: 3.00

> +#
> +# Example:
> +#
> +# -> { "execute": "x-block-dirty-bitmap-disable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +    { 'command': 'x-block-dirty-bitmap-disable',
> +      'data': 'BlockDirtyBitmap' }
> +
>  ##
>  # @BlockDirtyBitmapSha256:
>  #
> -- 
> 2.14.3
> 
> 
