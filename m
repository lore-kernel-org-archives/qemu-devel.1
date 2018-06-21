Received: from eggs.gnu.org ([2001:4830:134:3::10]:53324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVypV-0002lO-E9
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVypQ-0005hy-H1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:36:49 -0400
References: <20180611224338.9743-1-jsnow@redhat.com>
	<20180611224338.9743-2-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <920d66fe-fcbb-4046-54ac-d86dd98726e6@virtuozzo.com>
Date: Thu, 21 Jun 2018 15:36:35 +0300
MIME-Version: 1.0
In-Reply-To: <20180611224338.9743-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

add Nikolay

12.06.2018 01:43, John Snow wrote:
> It might be nice to have an all-or-nothing merge command that either
> succeeds in merging all bitmaps or fails for all of them. This way,
> when assembling bitmaps that represent arbitrary points in time from
> component bitmaps, we always know the state of the target bitmap even
> in cases of failure.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c           | 40 ++++++++++++++++++++++++++++++----------
>   qapi/block-core.json | 10 +++++-----
>   2 files changed, 35 insertions(+), 15 deletions(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 041f5d594f..4d60d0a03c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3054,34 +3054,54 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
>       bdrv_disable_dirty_bitmap(bitmap);
>   }
>   
> -void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
> -                                    const char *src_name, Error **errp)
> +void qmp_x_block_dirty_bitmap_merge(const char *node, const char *target,
> +                                    strList *bitmaps, Error **errp)
>   {
>       BlockDriverState *bs;
> -    BdrvDirtyBitmap *dst, *src;
> +    BdrvDirtyBitmap *dst, *src, *anon;
> +    strList *lst;
> +    Error *local_err = NULL;
>   
> -    dst = block_dirty_bitmap_lookup(node, dst_name, &bs, errp);
> +    dst = block_dirty_bitmap_lookup(node, target, &bs, errp);
>       if (!dst) {
>           return;
>       }
>   
>       if (bdrv_dirty_bitmap_frozen(dst)) {
>           error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
> -                   dst_name);
> +                   target);
>           return;
>       } else if (bdrv_dirty_bitmap_readonly(dst)) {
>           error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> -                   dst_name);
> +                   target);
>           return;
>       }
>   
> -    src = bdrv_find_dirty_bitmap(bs, src_name);
> -    if (!src) {
> -        error_setg(errp, "Dirty bitmap '%s' not found", src_name);
> +    anon = bdrv_create_dirty_bitmap(bs, bdrv_dirty_bitmap_granularity(dst),
> +                                    NULL, errp);
> +    if (!anon) {
>           return;
>       }
>   
> -    bdrv_merge_dirty_bitmap(dst, src, errp);
> +    /* Aggregate bitmaps to anonymous temp bitmap */
> +    for (lst = bitmaps; lst; lst = lst->next) {
> +      src = bdrv_find_dirty_bitmap(bs, lst->value);
> +      if (!src) {
> +          error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
> +          goto out;
> +      }
> +      bdrv_merge_dirty_bitmap(anon, src, &local_err);
> +      if (local_err) {
> +          error_propagate(errp, local_err);
> +          goto out;
> +      }
> +    }
> +
> +    /* Merge into dst; dst is unchanged on failure */
> +    bdrv_merge_dirty_bitmap(dst, anon, errp);
> +
> +out:
> +    bdrv_release_dirty_bitmap(bs, anon);
>   }
>   
>   BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index fff23fc82b..83402da7e7 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1749,14 +1749,14 @@
>   #
>   # @node: name of device/node which the bitmap is tracking
>   #
> -# @dst_name: name of the destination dirty bitmap
> +# @target: name of the destination dirty bitmap
>   #
> -# @src_name: name of the source dirty bitmap
> +# @bitmaps: name(s) of the source dirty bitmap(s)
>   #
>   # Since: 3.0
>   ##
>   { 'struct': 'BlockDirtyBitmapMerge',
> -  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
> +  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
>   
>   ##
>   # @block-dirty-bitmap-add:
> @@ -1884,8 +1884,8 @@
>   # Example:
>   #
>   # -> { "execute": "x-block-dirty-bitmap-merge",
> -#      "arguments": { "node": "drive0", "dst_name": "bitmap0",
> -#                     "src_name": "bitmap1" } }
> +#      "arguments": { "node": "drive0", "target": "bitmap0",
> +#                     "bitmaps": ["bitmap1"] } }
>   # <- { "return": {} }
>   #
>   ##


-- 
Best regards,
Vladimir
