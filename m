Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BlT-0006zJ-PS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BlS-0000D0-UQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:05:31 -0400
Date: Thu, 4 May 2017 16:05:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504080521.GC4725@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-17-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/17] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> @@ -400,7 +431,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>      return list;
>  }
>  
> -int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> +/* Called within bdrv_dirty_bitmap_lock..unlock */
> +int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>                     int64_t sector)

Parameter indentation is off now.

>  {
>      if (bitmap) {
> @@ -410,6 +442,18 @@ int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>      }
>  }
>  
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 03db2cf..c264ead 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -598,8 +598,8 @@ struct BlockDriverState {
>  
>      /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
>       * Reading from the list can be done with either the BQL or the
> -     * dirty_bitmap_mutex.  Modifying a bitmap requires the AioContext
> -     * lock.  */
> +     * dirty_bitmap_mutex.  Modifying a bitmap only requires
> +     * dirty_bitmap_mutex.  */

I'm confused by this comment. What's added in this patch is bitmap->mutex, not
dirty_bitmap_mutex. Is it a mistake?

>      QemuMutex dirty_bitmap_mutex;
>      QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
>  

Fam
