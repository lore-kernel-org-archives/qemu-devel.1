Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQlUm-0007VX-NL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQlUl-00016m-HB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:21:52 -0400
Date: Wed, 6 Jun 2018 23:21:37 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180607032137.GO11303@localhost.localdomain>
References: <20180606182449.1607-1-jsnow@redhat.com>
	<20180606182449.1607-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606182449.1607-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/5] qapi: add
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

On Wed, Jun 06, 2018 at 02:24:46PM -0400, John Snow wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Expose the ability to turn bitmaps "on" or "off". This is experimental
> and principally for the sake of the Libvirt Checkpoints API, and it may
> or may not be committed for 3.0.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 8de95be8f4..fb402edc94 100644
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
> +    if (!bitmap) {
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
> +    if (!bitmap) {
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
> index 4b1de474a9..02de674f5f 100644
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
> +# Since: 3.0
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
> +# Since: 3.0
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
