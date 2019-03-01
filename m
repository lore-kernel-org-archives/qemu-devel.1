Received: from eggs.gnu.org ([209.51.188.92]:51362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gznyU-0002z4-Op
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gznyP-0008FL-Pz
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:37:37 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66ebf636-43e1-f16a-bd05-e9a8a766d4bd@redhat.com>
Date: Fri, 1 Mar 2019 13:36:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
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
> Instead of checking against busy, inconsistent, or read only directly,
> use a check function with permissions bits that let us streamline the
> checks without reproducing them in many places.
> 
> Included in this patch are permissions changes that simply add the
> inconsistent check to existing permissions call spots, without
> addressing existing bugs.
> 
> In general, this means that busy+readonly checks become BDRV_BITMAP_DEFAULT,
> which checks against all three conditions. busy-only checks become
> BDRV_BITMAP_ALLOW_RO.
> 
> Notably, remove allows inconsistent bitmaps, so it doesn't follow the pattern.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/block/dirty-bitmap.h   | 13 ++++++++-
>  block/dirty-bitmap.c           | 38 +++++++++++++++++++-------
>  blockdev.c                     | 49 +++++++---------------------------
>  migration/block-dirty-bitmap.c | 12 +++------
>  nbd/server.c                   |  3 +--
>  5 files changed, 54 insertions(+), 61 deletions(-)
> 

Diffstat proves its a win, even with the extra documentation for the new
function. Nice.

> +int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
> +                            Error **errp)
> +{
> +    if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitmap_busy(bitmap)) {
> +        error_setg(errp, "Bitmap '%s' is currently in use by another"
> +                   " operation and cannot be used", bitmap->name);

Split before space,

> +        return -1;
> +    }
> +
> +    if ((flags & BDRV_BITMAP_RO) && bdrv_dirty_bitmap_readonly(bitmap)) {
> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
> +                   bitmap->name);
> +        return -1;
> +    }
> +
> +    if ((flags & BDRV_BITMAP_INCONSISTENT) &&
> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
> +        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used",
> +                   bitmap->name);
> +        error_append_hint(errp, "Try block-dirty-bitmap-remove to delete "
> +                          "this bitmap from disk");

split after space.  Looks inconsistent within a single function (pardon
the pun :)

That's minor,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
