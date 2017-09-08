Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqIJT-0000TN-74
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqIJS-0004A6-0K
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:23:11 -0400
Date: Fri, 8 Sep 2017 14:22:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908122254.GG3283@localhost.localdomain>
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830210542.2153-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/18] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
> We are still using an internal hbitmap that tracks a size in sectors,
> with the granularity scaled down accordingly, because it lets us
> use a shortcut for our iterators which are currently sector-based.
> But there's no reason we can't track the dirty bitmap size in bytes,
> since it is (mostly) an internal-only variable (remember, the size
> is how many bytes are covered by the bitmap, not how many bytes the
> bitmap occupies).  Furthermore, we're already reporting bytes for
> bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
> return values is a recipe for confusion.  A later cleanup will
> convert dirty bitmap internals to be entirely byte-based,
> eliminating the intermediate sector rounding added here; and
> technically, since bdrv_getlength() already rounds up to sectors,
> our use of DIV_ROUND_UP is more for theoretical completeness than
> for any actual rounding.
> 
> The only external caller in qcow2-bitmap.c is temporarily more verbose
> (because it is still using sector-based math), but will later be
> switched to track progress by bytes instead of sectors.
> 
> Use is_power_of_2() while at it, instead of open-coding that, and
> add an assertion where bdrv_getlength() should not fail.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

I think I would have preferred to change the unit of
BdrvDirtyBitmap.size in one patch and the unit of the return value of
bdrv_dirty_bitmap_size() in another one to keep review a bit easier.

>  block/dirty-bitmap.c | 26 +++++++++++++++-----------
>  block/qcow2-bitmap.c | 14 ++++++++------
>  2 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 42a55e4a4b..e65ec4f7ec 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -1,7 +1,7 @@
>  /*
>   * Block Dirty Bitmap
>   *
> - * Copyright (c) 2016 Red Hat. Inc
> + * Copyright (c) 2016-2017 Red Hat. Inc
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -42,7 +42,7 @@ struct BdrvDirtyBitmap {
>      HBitmap *meta;              /* Meta dirty bitmap */
>      BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
>      char *name;                 /* Optional non-empty unique ID */
> -    int64_t size;               /* Size of the bitmap (Number of sectors) */
> +    int64_t size;               /* Size of the bitmap, in bytes */
>      bool disabled;              /* Bitmap is disabled. It ignores all writes to
>                                     the device */
>      int active_iterators;       /* How many iterators are active */
> @@ -115,17 +115,14 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
>  {
>      int64_t bitmap_size;
>      BdrvDirtyBitmap *bitmap;
> -    uint32_t sector_granularity;
> 
> -    assert((granularity & (granularity - 1)) == 0);
> +    assert(is_power_of_2(granularity) && granularity >= BDRV_SECTOR_SIZE);
> 
>      if (name && bdrv_find_dirty_bitmap(bs, name)) {
>          error_setg(errp, "Bitmap already exists: %s", name);
>          return NULL;
>      }
> -    sector_granularity = granularity >> BDRV_SECTOR_BITS;
> -    assert(sector_granularity);
> -    bitmap_size = bdrv_nb_sectors(bs);
> +    bitmap_size = bdrv_getlength(bs);
>      if (bitmap_size < 0) {
>          error_setg_errno(errp, -bitmap_size, "could not get length of device");
>          errno = -bitmap_size;
> @@ -133,7 +130,12 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
>      }
>      bitmap = g_new0(BdrvDirtyBitmap, 1);
>      bitmap->mutex = &bs->dirty_bitmap_mutex;
> -    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(sector_granularity));
> +    /*
> +     * TODO - let hbitmap track full granularity. For now, it is tracking
> +     * only sector granularity, as a shortcut for our iterators.
> +     */
> +    bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap_size, BDRV_SECTOR_SIZE),
> +                                   ctz32(granularity) - BDRV_SECTOR_BITS);
>      bitmap->size = bitmap_size;
>      bitmap->name = g_strdup(name);
>      bitmap->disabled = false;
> @@ -305,13 +307,14 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>  void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>  {
>      BdrvDirtyBitmap *bitmap;
> -    uint64_t size = bdrv_nb_sectors(bs);
> +    int64_t size = bdrv_getlength(bs);
> 
> +    assert(size >= 0);

How can you assert that there will never be an error? Even if it's
correct (I don't know whether you can have dirty bitmaps on devices that
don't use the cached value), this needs at least a comment.

The rest looks okay.

Kevin
