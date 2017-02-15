Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce8ra-0001V5-IE
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce8rZ-0006lY-J6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:19:54 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-16-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b53a4307-b673-8e3f-dc06-15798e78764a@redhat.com>
Date: Wed, 15 Feb 2017 18:19:46 -0500
MIME-Version: 1.0
In-Reply-To: <1487153430-17260-16-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 15/25] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
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
> Realize .bdrv_can_store_new_dirty_bitmap interface.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks,

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  block/qcow2-bitmap.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  4 ++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b177a95..1ee89e4 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1182,3 +1182,55 @@ fail:
>  
>      bitmap_list_free(bm_list);
>  }
> +
> +bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
> +                                      const char *name,
> +                                      uint32_t granularity,
> +                                      Error **errp)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    bool found;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (check_constraints_on_bitmap(bs, name, granularity) != 0) {
> +        error_setg(errp, "The constraints are not satisfied");
> +        goto fail;
> +    }
> +
> +    if (s->nb_bitmaps == 0) {
> +        return true;
> +    }
> +
> +    if (s->nb_bitmaps >= QCOW2_MAX_BITMAPS) {
> +        error_setg(errp,
> +                   "Maximum number of persistent bitmaps is already reached");
> +        goto fail;
> +    }
> +
> +    if (s->bitmap_directory_size + calc_dir_entry_size(strlen(name), 0) >
> +        QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
> +    {
> +        error_setg(errp, "No enough space in the bitmap directory");
> +        goto fail;
> +    }
> +
> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list == NULL) {
> +        goto fail;
> +    }
> +
> +    found = find_bitmap_by_name(bm_list, name);
> +    bitmap_list_free(bm_list);
> +    if (found) {
> +        error_setg(errp, "Bitmap with the same name is already stored");
> +        goto fail;
> +    }
> +
> +    return true;
> +
> +fail:
> +    error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
> +                  name, bdrv_get_device_or_node_name(bs));
> +    return false;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d0e41bf..6e1fe53 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3541,6 +3541,7 @@ BlockDriver bdrv_qcow2 = {
>  
>      .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
>      .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
> +    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
>  };
>  
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index d9a7643..749710d 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -616,5 +616,9 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
>  /* qcow2-bitmap.c functions */
>  void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
> +                                      const char *name,
> +                                      uint32_t granularity,
> +                                      Error **errp);
>  
>  #endif
> 
