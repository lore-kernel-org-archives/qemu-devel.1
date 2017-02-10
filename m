Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKAC-0001eN-0H
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 17:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKAB-0005de-7V
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 17:59:36 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-11-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b32e331c-5b74-dab1-6d2a-19f3cf841ebb@redhat.com>
Date: Fri, 10 Feb 2017 17:59:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/24] block/dirty-bitmap: add autoload
 field to BdrvDirtyBitmap
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



On 02/03/2017 04:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Mirror AUTO flag from Qcow2 bitmap in BdrvDirtyBitmap. This will be
> needed in future, to save this flag back to Qcow2 for persistent
> bitmaps.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/dirty-bitmap.c         | 16 ++++++++++++++++
>  block/qcow2-bitmap.c         |  2 ++
>  include/block/dirty-bitmap.h |  2 ++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 90af37287f..2d27494dc7 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -44,6 +44,8 @@ struct BdrvDirtyBitmap {
>      int64_t size;               /* Size of the bitmap (Number of sectors) */
>      bool disabled;              /* Bitmap is read-only */
>      int active_iterators;       /* How many iterators are active */
> +    bool autoload;              /* For persistent bitmaps: bitmap must be
> +                                   autoloaded on image opening */
>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>  };
>  
> @@ -70,6 +72,8 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      g_free(bitmap->name);
>      bitmap->name = NULL;
> +
> +    bitmap->autoload = false;
>  }
>  

No real need for the extra line.

>  BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
> @@ -238,6 +242,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>      bitmap->name = NULL;
>      successor->name = name;
>      bitmap->successor = NULL;
> +    successor->autoload = bitmap->autoload;
> +    bitmap->autoload = false;
>      bdrv_release_dirty_bitmap(bs, bitmap);
>  
>      return successor;
> @@ -540,3 +546,13 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
>  {
>      return hbitmap_count(bitmap->meta);
>  }
> +
> +void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
> +{
> +    bitmap->autoload = autoload;
> +}
> +
> +bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->autoload;
> +}
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index eeeec1aa7f..bcbb0491ee 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -706,6 +706,8 @@ void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>              if (bitmap == NULL) {
>                  goto fail;
>              }
> +
> +            bdrv_dirty_bitmap_set_autoload(bitmap, true);
>              bm->flags |= BME_FLAG_IN_USE;
>              created_dirty_bitmaps =
>                      g_slist_append(created_dirty_bitmaps, bitmap);
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 1e17729ac2..45a389a20a 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -75,4 +75,6 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>                                          bool finish);
>  void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
>  
> +void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
> +bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
>  #endif
> 

Reviewed-by: John Snow <jsnow@redhat.com>
