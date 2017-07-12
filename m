Received: from eggs.gnu.org ([2001:4830:134:3::10]:45949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVOkm-0001gm-VL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVOkm-0004jl-2i
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:01:01 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-18-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bc598e9b-1606-ead3-30a4-d654b39994ed@redhat.com>
Date: Wed, 12 Jul 2017 17:00:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-18-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 17/17] dirty-bitmap: Convert internal
 hbitmap size/granularity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> Now that all callers are using byte-based interfaces, there's no
> reason for our internal hbitmap to remain with sector-based
> granularity.  It also simplifies our internal scaling, since we
> already know that hbitmap widens requests out to granularity
> boundaries.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v4: rebase to earlier changes, include serialization, R-b dropped
> v3: no change
> v2: no change
> ---
>  block/dirty-bitmap.c | 60 +++++++++++++++-------------------------------------
>  1 file changed, 17 insertions(+), 43 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 5bfc7bc..0b349f0 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -38,7 +38,7 @@
>   */
>  struct BdrvDirtyBitmap {
>      QemuMutex *mutex;
> -    HBitmap *bitmap;            /* Dirty sector bitmap implementation */
> +    HBitmap *bitmap;            /* Dirty bitmap implementation */
>      HBitmap *meta;              /* Meta dirty bitmap */
>      BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
>      char *name;                 /* Optional non-empty unique ID */
> @@ -130,12 +130,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
>      }
>      bitmap = g_new0(BdrvDirtyBitmap, 1);
>      bitmap->mutex = &bs->dirty_bitmap_mutex;
> -    /*
> -     * TODO - let hbitmap track full granularity. For now, it is tracking
> -     * only sector granularity, as a shortcut for our iterators.
> -     */
> -    bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap_size, BDRV_SECTOR_SIZE),
> -                                   ctz32(granularity) - BDRV_SECTOR_BITS);
> +    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
>      bitmap->size = bitmap_size;
>      bitmap->name = g_strdup(name);
>      bitmap->disabled = false;
> @@ -310,7 +305,6 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>      int64_t size = bdrv_getlength(bs);
> 
>      assert(size >= 0);
> -    size = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);

whoops uh, were we setting bitmap->size to the *sector* size prior to
this, even though we had already changed bitmap->size to be the byte size?

--js
