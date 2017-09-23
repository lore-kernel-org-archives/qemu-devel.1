Received: from eggs.gnu.org ([2001:4830:134:3::10]:54806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dviEZ-00010t-SH
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 07:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dviEZ-0004Ui-20
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 07:04:31 -0400
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <28b265bf-a416-f78e-49ed-1f0ec5f1f950@virtuozzo.com>
Date: Sat, 23 Sep 2017 14:04:24 +0300
MIME-Version: 1.0
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix use of
 uninitialized pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org

22.09.2017 17:43, Vladimir Sementsov-Ogievskiy wrote:
> Without initialization to zero dirty_bitmap field may be not zero
> for a bitmap which should not be stored and
> qcow2_store_persistent_dirty_bitmaps will erroneously call
> store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.

please fix it to SIGSEGV...

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2-bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index e8d3bdbd6e..14f41d0427 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -602,7 +602,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>               goto fail;
>           }
>   
> -        bm = g_new(Qcow2Bitmap, 1);
> +        bm = g_new0(Qcow2Bitmap, 1);
>           bm->table.offset = e->bitmap_table_offset;
>           bm->table.size = e->bitmap_table_size;
>           bm->flags = e->flags;


-- 
Best regards,
Vladimir
