Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnKD-0001Ox-0T
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdnKB-0007Z1-OB
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:20:00 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-24-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <80e4aa29-8033-8fdc-579e-da5ee9f7f7b8@redhat.com>
Date: Tue, 14 Feb 2017 19:19:52 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-24-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/25] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
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
> Realize .bdrv_remove_persistent_dirty_bitmap interface.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-bitmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  3 +++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 326a799..7ad1f7c 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1055,6 +1055,47 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
>      return NULL;
>  }
>  
> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                          const char *name,
> +                                          Error **errp)
> +{
> +    int ret;
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2Bitmap *bm;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (s->nb_bitmaps == 0) {
> +        /* Absence of the bitmap is not an error: see explanation above
> +         * bdrv_remove_persistent_dirty_bitmap() definition. */
> +        return;
> +    }
> +
> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list == NULL) {
> +        return;
> +    }
> +
> +    bm = find_bitmap_by_name(bm_list, name);
> +    if (bm == NULL) {
> +        goto fail;
> +    }
> +
> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
> +
> +    ret = update_ext_header_and_dir(bs, bm_list);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
> +        goto fail;
> +    }
> +
> +    free_bitmap_clusters(bs, &bm->table);
> +
> +fail:
> +    bitmap_free(bm);
> +    bitmap_list_free(bm_list);
> +}
> +
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>  {
>      BdrvDirtyBitmap *bitmap;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6e1fe53..653ba78 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3542,6 +3542,7 @@ BlockDriver bdrv_qcow2 = {
>      .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
>      .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
>      .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
> +    .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
>  };
>  
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index eaad34a..a009827 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -627,5 +627,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>  int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                    void **refcount_table,
>                                    int64_t *refcount_table_size);
> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                          const char *name,
> +                                          Error **errp);
>  
>  #endif
> 

Reviewed-by: John Snow <jsnow@redhat.com>
