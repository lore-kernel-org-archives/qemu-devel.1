Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdmQO-0006ML-6w
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdmQM-0003br-Tw
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:22:20 -0500
References: <1487091579-67092-1-git-send-email-vsementsov@virtuozzo.com>
	<1487091579-67092-22-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <eee8fdbb-515d-c198-6da0-634c5e6657e6@redhat.com>
Date: Tue, 14 Feb 2017 18:22:10 -0500
MIME-Version: 1.0
In-Reply-To: <1487091579-67092-22-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/25] qcow2-bitmap: refcounts
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
> Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-img
> check implementation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-bitmap.c   | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2-refcount.c |  6 ++++
>  block/qcow2.h          |  3 ++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 419d51e..326a799 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1222,3 +1222,79 @@ common_errp:
>                 name, bdrv_get_device_or_node_name(bs), reason);
>      return false;
>  }
> +
> +int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
> +                                  void **refcount_table,
> +                                  int64_t *refcount_table_size)
> +{
> +    int ret;
> +    BDRVQcow2State *s = bs->opaque;
> +    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm;
> +
> +    if (s->nb_bitmaps == 0) {
> +        return 0;
> +    }
> +
> +    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
> +                                   s->bitmap_directory_offset,
> +                                   s->bitmap_directory_size);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, NULL);
> +    if (bm_list == NULL) {
> +        res->corruptions++;
> +        return -EINVAL;
> +    }
> +
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        uint64_t *bitmap_table = NULL;
> +        int i;
> +
> +        ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                       refcount_table, refcount_table_size,
> +                                       bm->table.offset,
> +                                       bm->table.size * sizeof(uint64_t));
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
> +        if (ret < 0) {
> +            res->corruptions++;
> +            goto out;
> +        }
> +
> +        for (i = 0; i < bm->table.size; ++i) {
> +            uint64_t entry = bitmap_table[i];
> +            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
> +
> +            if (check_table_entry(entry, s->cluster_size) < 0) {
> +                res->corruptions++;
> +                continue;
> +            }
> +
> +            if (offset == 0) {
> +                continue;
> +            }
> +
> +            ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_table_size,
> +                                           offset, s->cluster_size);
> +            if (ret < 0) {
> +                g_free(bitmap_table);
> +                goto out;
> +            }
> +        }
> +
> +        g_free(bitmap_table);
> +    }
> +
> +out:
> +    bitmap_list_free(bm_list);
> +
> +    return ret;
> +}
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 14a736d..cdb74ba 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1846,6 +1846,12 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>          return ret;
>      }
>  
> +    /* bitmaps */
> +    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, nb_clusters);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>      return check_refblocks(bs, res, fix, rebuild, refcount_table, nb_clusters);
>  }
>  
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0a3708d..eaad34a 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -624,5 +624,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
>                                        const char *name,
>                                        uint32_t granularity,
>                                        Error **errp);
> +int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
> +                                  void **refcount_table,
> +                                  int64_t *refcount_table_size);
>  
>  #endif
> 

Looks OK.

Reviewed-by: John Snow <jsnow@redhat.com>
