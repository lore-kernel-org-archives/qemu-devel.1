Received: from eggs.gnu.org ([2001:4830:134:3::10]:56231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI88-0006UT-Jt
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI87-0008UT-Se
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:58:32 -0400
Date: Wed, 25 Apr 2018 12:58:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180425105824.GC4652@localhost.localdomain>
References: <20180424192506.149089-1-eblake@redhat.com>
	<20180424192506.149089-5-eblake@redhat.com>
	<CA+aFP1B=Hh81BktL-8V1LD5A9wZQEdJw4yMgV_WEDQ85C-a5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1B=Hh81BktL-8V1LD5A9wZQEdJw4yMgV_WEDQ85C-a5WQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/6] rbd: Switch to
 byte-based callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 24.04.2018 um 21:53 hat Jason Dillaman geschrieben:
> On Tue, Apr 24, 2018 at 3:25 PM, Eric Blake <eblake@redhat.com> wrote:
> > We are gradually moving away from sector-based interfaces, towards
> > byte-based.  Make the change for the last few sector-based callbacks
> > in the rbd driver.
> >
> > Note that the driver was already using byte-based calls for
> > performing actual I/O, so this just gets rid of a round trip
> > of scaling; however, as I don't know if RBD is tolerant of
> > non-sector AIO operations, I went with the conservate approach
> > of adding .bdrv_refresh_limits to override the block layer
> > defaults back to the pre-patch value of 512.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> >
> > ---
> > v2: override new block layer default alignment [Kevin]
> > ---
> >  block/rbd.c | 44 ++++++++++++++++++++++++--------------------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index c9359d0ad84..638ecf8d986 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -231,6 +231,13 @@ done:
> >  }
> >
> >
> > +static void qemu_rbd_refresh_limits(BlockDriverState *bs, Error **errp)
> > +{
> > +    /* XXX Does RBD support AIO on less than 512-byte alignment? */
> 
> Yes, librbd internally supports 1-byte alignment for IO, but the
> optimal alignment/length would be object size * stripe count.

Would you like to post a follow-up patch to this series that removes the
.bdrv_refresh_limits implementation again with a commit message
explaining that RBD does support byte alignment?

Kevin
