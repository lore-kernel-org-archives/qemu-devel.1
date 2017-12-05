Received: from eggs.gnu.org ([2001:4830:134:3::10]:36379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMCK-000777-9X
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMCJ-00036H-5g
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:00:20 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-2-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a2f85b2d-783e-db97-2aa2-907ce170ff17@redhat.com>
Date: Tue, 5 Dec 2017 18:00:10 -0500
MIME-Version: 1.0
In-Reply-To: <20171128071409.21887-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] qcow2-bitmap: add
 qcow2_reopen_bitmaps_rw_hint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org



On 11/28/2017 02:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add version of qcow2_reopen_bitmaps_rw, which do the same work but
> also return a hint about was header updated or not. This will be
> used in the following fix for bitmaps reloading after migration.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h        |  2 ++
>  block/qcow2-bitmap.c | 15 ++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6f0ff15dd0..40fa5b7cfe 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -667,6 +667,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
>                                    void **refcount_table,
>                                    int64_t *refcount_table_size);
>  bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
> +                                 Error **errp);
>  int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
>  int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index f45e46cfbd..6c80dcda69 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1002,7 +1002,8 @@ fail:
>      return false;
>  }
>  
> -int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
> +int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
> +                                 Error **errp)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      Qcow2BitmapList *bm_list;
> @@ -1010,6 +1011,10 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
>      GSList *ro_dirty_bitmaps = NULL;
>      int ret = 0;
>  
> +    if (header_updated != NULL) {
> +        *header_updated = false;
> +    }
> +
>      if (s->nb_bitmaps == 0) {
>          /* No bitmaps - nothing to do */
>          return 0;
> @@ -1053,6 +1058,9 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
>              error_setg_errno(errp, -ret, "Can't update bitmap directory");
>              goto out;
>          }
> +        if (header_updated != NULL) {
> +            *header_updated = true;
> +        }
>          g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
>      }
>  
> @@ -1063,6 +1071,11 @@ out:
>      return ret;
>  }
>  
> +int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
> +{
> +    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
> +}
> +
>  /* store_bitmap_data()
>   * Store bitmap to image, filling bitmap table accordingly.
>   */
> 

Reviewed-by: John Snow <jsnow@redhat.com>
