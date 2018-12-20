Received: from eggs.gnu.org ([2001:4830:134:3::10]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoO2-0006Qt-Jb
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZoO1-0002TQ-OU
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:48:34 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c6ab855-5fb3-bbe0-f7ee-528fc2aa52da@redhat.com>
Date: Wed, 19 Dec 2018 20:48:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181220022952.20493-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/11] blockdev: n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

On 12/19/18 8:29 PM, John Snow wrote:
> Especially outside of transactions, it is helpful to provide
> all-or-nothing semantics for bitmap merges. This facilitates
> the coalescing of multiple bitmaps into a single target for
> the "checkpoint" interpretation when assembling bitmaps that
> represent arbitrary points in time from component bitmaps.
> 
> This is an incompatible change from the preliminary version
> of the API.

but that doesn't matter because it was in the x- namespace, and we're 
about to rename it anyway.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c           | 75 ++++++++++++++++++++++++++++++--------------
>   qapi/block-core.json | 22 ++++++-------
>   2 files changed, 62 insertions(+), 35 deletions(-)
> 

> +static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
> +                                                    const char *target,
> +                                                    strList *bitmaps,
> +                                                    HBitmap **backup,
> +                                                    Error **errp)
>   {

> -    bdrv_merge_dirty_bitmap(dst, src, NULL, errp);
> +    for (lst = bitmaps; lst; lst = lst->next) {
> +        src = bdrv_find_dirty_bitmap(bs, lst->value);
> +        if (!src) {
> +            error_setg(errp, "Dirty bitmap '%s' not found", lst->value);
> +            dst = NULL;
> +            goto out;
> +        }
> +
> +        bdrv_merge_dirty_bitmap(anon, src, NULL, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            dst = NULL;
> +            goto out;
> +        }
> +    }

Appears to be a silent no-op when given "bitmaps":[] as the source.  An 
alternative would be requiring at least one source in the list, but I 
don't see it as worth changing the patch to special-case an empty list 
differently from a no-op.

> @@ -1943,23 +1943,23 @@
>   ##
>   # @x-block-dirty-bitmap-merge:
>   #
> -# FIXME: Rename @src_name and @dst_name to src-name and dst-name.
> -#
> -# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
> -# bitmap is unchanged. On error, @dst_name is unchanged.
> +# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
> +# The @bitmaps dirty bitmaps are unchanged.
> +# On error, @target is unchanged.
>   #
>   # Returns: nothing on success
>   #          If @node is not a valid block device, DeviceNotFound
> -#          If @dst_name or @src_name is not found, GenericError
> -#          If bitmaps has different sizes or granularities, GenericError
> +#          If any bitmap in @bitmaps or @target is not found, GenericError
> +#          If any of the bitmaps have different sizes or granularities,
> +#              GenericError
>   #
>   # Since: 3.0

Could do s/3.0/4.0/ to match the incompatible change here, but you do it 
in the later patch where your remove the x-.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
