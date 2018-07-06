Received: from eggs.gnu.org ([2001:4830:134:3::10]:43389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbKaf-0008Ld-Ba
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbKae-0004pI-Dy
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:51:37 -0400
Date: Fri, 6 Jul 2018 14:51:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180706065129.GA9946@lemon.usersys.redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-7-famz@redhat.com>
	<20180705124406.GL3309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705124406.GL3309@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 6/9] block: Use common req handling for
 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 07/05 14:44, Kevin Wolf wrote:
> Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> > Reuse the new bdrv_co_write_req_prepare/finish helpers. The variation
> > here is that discard requests don't affect bs->wr_highest_offset.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/io.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index f06978dda0..912fcb962a 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -1582,7 +1582,18 @@ bdrv_co_write_req_finish(BdrvChild *child, BdrvTrackedRequest *req, int ret)
> >          bdrv_parent_cb_resize(bs);
> >          bdrv_dirty_bitmap_truncate(bs, end_sector << BDRV_SECTOR_BITS);
> >      }
> > -    bdrv_set_dirty(bs, req->offset, req->bytes);
> > +    if (req->bytes) {
> > +        switch (req->type) {
> > +        case BDRV_TRACKED_WRITE:
> > +            stat64_max(&bs->wr_highest_offset, req->offset + req->bytes);
> 
> You forgot to remove this line above, so now this one is redundant and
> we still execute it always.
> 
> Apart from that, why shouldn't discard be included in
> bs->wr_highest_offset? It's an access to an area in the image that must
> be present, so it indicates a larger file size, doesn't it?

I'm not sure. wr_highest_offset is used for management to allocate disk space. A
discard request is on the contrary for releasing disk space. Since guest is
allowed to discard unallocated sectors even though it should be nop in the
backend, such an operation shouldn't cause a user visible change in
@wr_highest_offset in QMP.

Fam

> 
> > +            /* fall through, to set dirty bits */
> > +        case BDRV_TRACKED_DISCARD:
> > +            bdrv_set_dirty(bs, req->offset, req->bytes);
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +    }
> >  }
> 
> Kevin
