Received: from eggs.gnu.org ([209.51.188.92]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzoDq-0007Lw-Io
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzoDp-00036t-5K
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:53:30 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-8-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48cfe9d8-e5ef-77a6-e93d-7edd2fe1155a@redhat.com>
Date: Fri, 1 Mar 2019 13:53:06 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block/dirty-bitmaps: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 3/1/19 1:15 PM, John Snow wrote:
> Set the inconsistent bit on load instead of rejecting such bitmaps.
> There is no way to un-set it; the only option is to delete it.
> 
> Obvervations:
> - bitmap loading does not need to update the header for in_use bitmaps.
> - inconsistent bitmaps don't need to have their data loaded; they're
>   glorified corruption sentinels.
> - bitmap saving does not need to save inconsistent bitmaps back to disk.
> - bitmap reopening DOES need to drop the readonly flag from inconsistent
>   bitmaps to allow reopening of qcow2 files with non-qemu-owned bitmaps
>   being eventually flushed back to disk.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2-bitmap.c | 103 ++++++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 50 deletions(-)
> 

> @@ -962,35 +963,39 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>      }
>  
>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {

> +        BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
> +        if (bitmap == NULL) {
> +            goto fail;
>          }

> +        if (bm->flags & BME_FLAG_IN_USE) {
> +            bdrv_dirty_bitmap_set_inconsistent(bitmap);

If you take my suggestion of an assertion in 1/7, then this line...

>          } else {
> -            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
> -                            (gpointer)true);
> +            /* NB: updated flags only get written if can_write(bs) is true. */
> +            bm->flags |= BME_FLAG_IN_USE;
> +            needs_update = true;
>          }
> +        if (!(bm->flags & BME_FLAG_AUTO)) {
> +            bdrv_disable_dirty_bitmap(bitmap);
> +        }
> +        bdrv_dirty_bitmap_set_persistance(bitmap, true);

...and this line need to swap order.

Also, can we have a preliminary patch to s/persistance/persistence/ and
fix our typo?

> @@ -1112,23 +1117,21 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
>      }
>  
>      QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> -        if (!(bm->flags & BME_FLAG_IN_USE)) {
> -            BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
> -            if (bitmap == NULL) {
> -                continue;
> -            }
> -
> -            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
> -                error_setg(errp, "Bitmap %s is not readonly but not marked"
> -                                 "'IN_USE' in the image. Something went wrong,"
> -                                 "all the bitmaps may be corrupted", bm->name);

Nice - you're fixingthemissing spaces.

> -                ret = -EINVAL;
> -                goto out;
> -            }
> +        BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
> +        if (bitmap == NULL) {
> +            continue;
> +        }
>  
> -            bm->flags |= BME_FLAG_IN_USE;
> -            ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
> +        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
> +            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, but was "
> +                       "not marked as readonly. This is a bug, something went "
> +                       "wrong. All of the bitmaps may be corrupted", bm->name);

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
