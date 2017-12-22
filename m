Received: from eggs.gnu.org ([2001:4830:134:3::10]:49278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSIyI-0008Je-TF
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSIyG-0007qi-9x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:46:26 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-5-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <337c3f5a-2322-cb84-990b-dbe32dbefeb3@virtuozzo.com>
Date: Fri, 22 Dec 2017 11:46:15 +0300
MIME-Version: 1.0
In-Reply-To: <20171220154945.88410-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 04/13] dirty-bitmap: add locked state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

20.12.2017 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Add special state, when qmp operations on the bitmap are disabled.
> It is needed during bitmap migration. "Frozen" state is not
> appropriate here, because it looks like bitmap is unchanged.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

[...]

> +void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
> +{
> +    qemu_mutex_lock(bitmap->mutex);
> +    bitmap->qmp_locked = qmp_locked;
> +    qemu_mutex_unlock(bitmap->mutex);
> +}
> +
> +bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->qmp_locked;
> +}
> +
>   /* Called with BQL taken.  */
>   bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
>   {
> @@ -197,6 +211,8 @@ DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
>   {
>       if (bdrv_dirty_bitmap_frozen(bitmap)) {
>           return DIRTY_BITMAP_STATUS_FROZEN;
> +    } else if (!bdrv_dirty_bitmap_qmp_locked(bitmap)) {

should be without "!", it breaks 124 iotest.

> +        return DIRTY_BITMAP_STATUS_LOCKED;
>       } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
>           return DIRTY_BITMAP_STATUS_DISABLED;
>       } else {
> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24a0b..82b2956c5c 100644
> --- a/blockdev.c



-- 
Best regards,
Vladimir
