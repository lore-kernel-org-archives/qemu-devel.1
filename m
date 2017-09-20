Received: from eggs.gnu.org ([2001:4830:134:3::10]:58001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duUT5-0001mB-AA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duUT4-0003xG-1s
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:10:27 -0400
Date: Wed, 20 Sep 2017 10:10:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920021014.GB18491@lemon>
References: <20170919201910.25656-1-eblake@redhat.com>
	<20170919201910.25656-6-eblake@redhat.com>
	<26069637-9535-cb59-8920-9d9a7eef78b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26069637-9535-cb59-8920-9d9a7eef78b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 09/19 19:00, John Snow wrote:
> 
> 
> On 09/19/2017 04:18 PM, Eric Blake wrote:
> > We've previously fixed several places where we failed to account
> > for possible errors from bdrv_nb_sectors().  Fix another one by
> > making bdrv_dirty_bitmap_truncate() take the new size from the
> > caller instead of querying itself; then adjust the sole caller
> > bdrv_truncate() to pass the size just determined by a successful
> > resize, or to skip the bitmap resize on failure, thus avoiding
> > sizing the bitmaps to -1.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > ---
> > v9: skip only bdrv_dirty_bitmap_truncate on error [Fam]
> > v8: retitle and rework to avoid possibility of secondary failure [John]
> > v7: new patch [Kevin]
> > ---
> >  include/block/dirty-bitmap.h |  2 +-
> >  block.c                      | 15 ++++++++++-----
> >  block/dirty-bitmap.c         |  6 +++---
> >  3 files changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> > index 8fd842eac9..7a27590047 100644
> > --- a/include/block/dirty-bitmap.h
> > +++ b/include/block/dirty-bitmap.h
> > @@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
> >  void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
> >  int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
> >  int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
> > -void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
> > +void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
> >  bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
> >  bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
> >  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> > diff --git a/block.c b/block.c
> > index ee6a48976e..89261a7a53 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -3450,12 +3450,17 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
> >      assert(!(bs->open_flags & BDRV_O_INACTIVE));
> > 
> >      ret = drv->bdrv_truncate(bs, offset, prealloc, errp);
> > -    if (ret == 0) {
> > -        ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> > -        bdrv_dirty_bitmap_truncate(bs);
> > -        bdrv_parent_cb_resize(bs);
> > -        atomic_inc(&bs->write_gen);
> > +    if (ret < 0) {
> > +        return ret;
> >      }
> > +    ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Could not refresh total sector count");
> > +    } else {
> 
> Sorry for dragging my feet on this point; if anyone else wants to R-B
> this I will cede without much of a fuss, but perhaps you can help me
> understand.
> 
> (Copying some questions I asked Eric on IRC, airing to list for wider
> discussion, and also because I had to drive home before the stores
> closed for the evening)
> 
> Do you suspect that almost certainly if bdrv_truncate() fails overall
> that the image format driver will either unmount the image or become
> read-only?
> 
> There are calls from parallels, qcow, qcow2-refcount, qcow2, raw-format,
> vhdx-log, vhdx plus whichever calls from blk_truncate (jobs, all of the
> same formats, blockdev, qemu-img)
> 
> I'm just trying to picture exactly what's going to happen if we manage
> to resize the drive but then don't resize the bitmap -- say we expand
> the drive larger but fail to refresh (and fail to resize the bitmap.)
> 
> if the block format module does not immediately and dutifully stop all
> further writes -- is there anything that stops us from writing to new
> sectors that were beyond EOF previously?
> 
> I suppose if *not* that's a bug for callers of bdrv_truncate to allow
> that kind of monkey business, but if it CAN happen, hbitmap only guards
> against such things with an assert (which, IIRC, is not guaranteed to be
> on for all builds)

It's guaranteed since a few hours ago:

commit 262a69f4282e44426c7a132138581d400053e0a1
Author: Eric Blake <eblake@redhat.com>
Date:   Mon Sep 11 16:13:20 2017 -0500

    osdep.h: Prohibit disabling assert() in supported builds

> 
> 
> So the question is: "bdrv_truncate failure is NOT considered recoverable
> in ANY case, is it?"
> 
> It may possibly be safer to, if the initial truncate request succeeds,
> apply a best-effort to the bitmap before returning the error.

Like fallback "offset" (or it aligned up to bs cluster size) if
refresh_total_sectors() returns error? I think that is okay.

Fam
