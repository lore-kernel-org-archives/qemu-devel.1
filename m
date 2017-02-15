Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnZ2-0007jx-0K
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnZ0-0005W8-M0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:35:20 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-26-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <00d45252-11c7-638a-03b9-ba51bffae99b@redhat.com>
Date: Tue, 14 Feb 2017 19:35:09 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-26-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
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
> Add detailed error messages.
> 

yay

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 63 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 22 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 7ad1f7c..113d48c 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -160,28 +160,49 @@ static int check_table_entry(uint64_t entry, int cluster_size)
>  
>  static int check_constraints_on_bitmap(BlockDriverState *bs,
>                                         const char *name,
> -                                       uint32_t granularity)
> +                                       uint32_t granularity,
> +                                       Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int granularity_bits = ctz32(granularity);
>      int64_t len = bdrv_getlength(bs);
> -    bool fail;
>  
>      assert(granularity > 0);
>      assert((granularity & (granularity - 1)) == 0);
>  
>      if (len < 0) {
> +        error_setg_errno(errp, -len, "Failed to get size of '%s'",
> +                         bdrv_get_device_or_node_name(bs));
>          return len;
>      }
>  
> -    fail = (granularity_bits > BME_MAX_GRANULARITY_BITS) ||
> -           (granularity_bits < BME_MIN_GRANULARITY_BITS) ||
> -           (len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
> -           (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
> -                  granularity_bits) ||
> -           (strlen(name) > BME_MAX_NAME_SIZE);
> +    if (granularity_bits > BME_MAX_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity exceeds maximum (%u bytes)",
> +                   1 << BME_MAX_GRANULARITY_BITS);
> +        return -EINVAL;
> +    }
> +    if (granularity_bits < BME_MIN_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity is under minimum (%u bytes)",
> +                   1 << BME_MIN_GRANULARITY_BITS);
> +        return -EINVAL;
> +    }
>  
> -    return fail ? -EINVAL : 0;
> +    if ((len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
> +        (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
> +               granularity_bits))
> +    {
> +        error_setg(errp, "Too much space will be occupied by the bitmap. "
> +                   "Use larger granularity");
> +        return -EINVAL;
> +    }
> +
> +    if (strlen(name) > BME_MAX_NAME_SIZE) {
> +        error_setg(errp, "Name length exceeds maximum (%u characters)",
> +                   BME_MAX_NAME_SIZE);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
>  }
>  
>  static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_table,
> @@ -1142,9 +1163,9 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>              continue;
>          }
>  
> -        if (check_constraints_on_bitmap(bs, name, granularity) < 0) {
> -            error_setg(errp, "Bitmap '%s' doesn't satisfy the constraints",
> -                       name);
> +        if (check_constraints_on_bitmap(bs, name, granularity, errp) < 0) {
> +            error_prepend(errp, "Bitmap '%s' doesn't satisfy the constraints: ",
> +                          name);
>              goto fail;
>          }
>  
> @@ -1230,13 +1251,11 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>                                        Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
> -    const char *reason = NULL;
>      bool found;
>      Qcow2BitmapList *bm_list;
>  
> -    if (check_constraints_on_bitmap(bs, name, granularity) != 0) {
> -        reason = "it doesn't satisfy the constraints";
> -        goto common_errp;
> +    if (check_constraints_on_bitmap(bs, name, granularity, errp) != 0) {
> +        goto fail;
>      }
>  
>      if (s->nb_bitmaps == 0) {
> @@ -1246,21 +1265,21 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>      bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>                                 s->bitmap_directory_size, errp);
>      if (bm_list == NULL) {
> -        return false;
> +        goto fail;
>      }
>  
>      found = find_bitmap_by_name(bm_list, name);
>      bitmap_list_free(bm_list);
>      if (found) {
> -        reason = "bitmap with the same name is already stored";
> -        goto common_errp;
> +        error_setg(errp, "Bitmap with the same name is already stored");
> +        goto fail;
>      }
>  
>      return true;
>  
> -common_errp:
> -    error_setg(errp, "Can't make bitmap '%s' persistent in '%s', as %s.",
> -               name, bdrv_get_device_or_node_name(bs), reason);
> +fail:
> +    error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
> +                  name, bdrv_get_device_or_node_name(bs));
>      return false;
>  }
>  
> 

Sorry I made it less efficient :)

Reviewed-by: John Snow <jsnow@redhat.com>
