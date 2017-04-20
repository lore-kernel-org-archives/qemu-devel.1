Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1A81-0007V5-RP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1A80-0007Vd-NH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 07:20:01 -0400
Date: Thu, 20 Apr 2017 19:19:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420111950.GL24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<20170420075237.18219-3-famz@redhat.com>
	<20170420105829.GE4747@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420105829.GE4747@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 02/20] block: Drop consistent read perm
 if opened unsafe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 04/20 12:58, Kevin Wolf wrote:
> Am 20.04.2017 um 09:52 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block.c b/block.c
> > index 1fbbb8d..f5182d8 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1722,9 +1722,15 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> >          }
> >  
> >          /* bs->file always needs to be consistent because of the metadata. We
> > -         * can never allow other users to resize or write to it. */
> > -        perm |= BLK_PERM_CONSISTENT_READ;
> > -        shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +         * cannot allow other users to resize or write to it unless the caller
> > +         * explicitly expects unsafe readings. */
> > +        if (!(bdrv_get_flags(bs) & BDRV_O_UNSAFE_READ)) {
> 
> We have already spent considerable time to get rid of flags and instead
> convert them into options passed in the QDict, so that they become
> configurable with things like blockdev-add. Adding new flags potentially
> moves in the opposite direction, so we have to be careful there.
> 
> I would be okay with patch 1, because in this case it's basically just a
> shortcut for callers of blk_new_open(), which is fine. As soon as we
> start querying the flag later and even rely on it being inherited, like
> in this patch, I think it becomes a problem.
> 
> So if we need the flag in all nodes, can we make it an option that is
> parsed in bdrv_open_common() into a bool bs->unsafe_read and inherited
> explicitly in bdrv_inherited_options() and bdrv_backing_options()?

OK, I knew new flags are bad, but this is perhaps what I was missing, as an
alternative.

> 
> > +            perm |= BLK_PERM_CONSISTENT_READ;
> > +            shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +        } else {
> > +            perm &= ~BLK_PERM_CONSISTENT_READ;
> > +            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
> > +        }
> 
> I'm not completely sure why we would be interested in CONSISTENT_READ
> anyway, isn't allowing shared writes what we really need? (Which you
> already do here in addition to dropping CONSISTENT_READ, without it
> being mentioned in the commit message.)

I think taking external programs into account, CONSISTENT_READ and shared write
are related: if another writer can modify file, our view is not consistent.
That's why I handle them together.

> 
> Also, another thought: Being only at the start of the series, I'm not
> sure what this will be used for, but can we make sure that unsafe_read
> is only set if the image is opened read-only? If this is for the
> libguestfs use case, this restriction should be fine.

I guess you are right. I will give a try to your QDict idea, and only apply it
if read-only.

Fam
