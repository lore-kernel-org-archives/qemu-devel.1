Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fadNN-0000Lo-R0
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fadNM-0005Kb-Sk
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:43:01 -0400
Date: Wed, 4 Jul 2018 16:42:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180704084242.GA8621@lemon.usersys.redhat.com>
References: <20180704061320.2041-1-famz@redhat.com>
	<20180704061320.2041-2-famz@redhat.com>
	<20180704074453.GA4334@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704074453.GA4334@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: Fix dst total_sectors after
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 07/04 09:44, Kevin Wolf wrote:
> Am 04.07.2018 um 08:13 hat Fam Zheng geschrieben:
> > This was noticed by the new image fleecing tests case 222. The issue is
> > apparent and we should just do the same right things as in
> > bdrv_aligned_pwritev.
> > 
> > Reported-by: John Snow <jsnow@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2945,6 +2945,10 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
> >                                                    dst, dst_offset,
> >                                                    bytes, flags);
> >      }
> > +    if (ret == 0) {
> > +        int64_t end_sector = DIV_ROUND_UP(dst_offset + bytes, BDRV_SECTOR_SIZE);
> > +        dst->bs->total_sectors = MAX(dst->bs->total_sectors, end_sector);
> > +    }
> 
> I think it's time to extract this stuff to a common function. I was
> already aware that a write request that extends the image isn't behaving
> exactly the same as bdrv_co_truncate(), and this one is bound to diverge
> from the other two instances as well.
> 
> This is what bdrv_aligned_pwritev() does after the write:
> 
>     atomic_inc(&bs->write_gen);
>     bdrv_set_dirty(bs, offset, bytes);
> 
>     stat64_max(&bs->wr_highest_offset, offset + bytes);
> 
>     if (ret >= 0) {
>         bs->total_sectors = MAX(bs->total_sectors, end_sector);
>         ret = 0;
>     }
> 
> Before the write, it also calls bs->before_write_notifiers.
> 
> This is what bdrv_co_truncate() does after truncating the image:
> 
>     ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>     if (ret < 0) {
>         error_setg_errno(errp, -ret, "Could not refresh total sector count");
>     } else {
>         offset = bs->total_sectors * BDRV_SECTOR_SIZE;
>     }
>     bdrv_dirty_bitmap_truncate(bs, offset);
>     bdrv_parent_cb_resize(bs);
>     atomic_inc(&bs->write_gen);
> 
> This means that we probably have at least the following bugs in
> bdrv_co_copy_range_internal():
> 
> 1. bs->write_gen is not increased, a following flush is ignored
> 2. Dirty bitmaps are not dirtied
> 3. Dirty bitmaps are not resized when extending the image
> 4. bs->wr_highest_offset is not adjusted correctly
> 5. bs->total_sectors is not resized (the bug this patch fixes)
> 6. The parent node isn't notified about an image size change
> 
> Of these, 3. and 6. also seem to be bugs in bdrv_aligned_pwritev().
> 

Indeed, great insight. I'll work on v2.

Fam
