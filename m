Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9H00-0005dA-CW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9Gzz-00013y-BC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:21:48 -0400
References: <20180416114414.18406-1-vsementsov@virtuozzo.com>
	<20180416114414.18406-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d387ba9f-89f8-db99-ddf5-38ab05c515ff@redhat.com>
Date: Thu, 19 Apr 2018 17:21:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180416114414.18406-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] dirty-bitmaps: fix comment about
 dirty_bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 04/16/2018 07:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> Clarify first two cases and fix Modify -> Any access in third case.
> Also, drop 'only' from third case, as it a bit confuses, when thinking
> about case where we modify BdrvDirtyBitmap and access HBitmap.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index c4dd1d4bb8..189666efa5 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -709,10 +709,14 @@ struct BlockDriverState {
>      uint64_t write_threshold_offset;
>      NotifierWithReturn write_threshold_notifier;
>  
> -    /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
> -     * Reading from the list can be done with either the BQL or the
> -     * dirty_bitmap_mutex.  Modifying a bitmap only requires
> -     * dirty_bitmap_mutex.  */
> +    /* Writing to the list (i.e. to any field of BdrvDirtyBitmap or to the
> +     * list-head) requires both the BQL _and_ the dirty_bitmap_mutex.
> +     *
> +     * Reading from the list (from any field of BdrvDirtyBitmap or from the
> +     * list-head) can be done with either the BQL or the dirty_bitmap_mutex.
> +     *
> +     * Any access to underlying HBitmap requires dirty_bitmap_mutex.

"to the underlying HBitmap," probably.

> +     */
>      QemuMutex dirty_bitmap_mutex;
>      QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
>  
> 

Reviewed-by: John Snow <jsnow@redhat.com>
