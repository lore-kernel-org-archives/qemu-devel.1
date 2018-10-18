Received: from eggs.gnu.org ([2001:4830:134:3::10]:44679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD8Hx-0008U4-43
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gD8Hv-0000xW-6U
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:24:33 -0400
Date: Thu, 18 Oct 2018 15:23:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181018132356.GD4946@localhost.localdomain>
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-4-kwolf@redhat.com>
	<d7cef744-9dee-1445-b219-b01404051543@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cef744-9dee-1445-b219-b01404051543@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/9] block: Require auto-read-only for
 existing fallbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 17.10.2018 um 20:53 hat Eric Blake geschrieben:
> On 10/17/18 11:41 AM, Kevin Wolf wrote:
> > Some block drivers have traditionally changed their node to read-only
> > mode without asking the user. This behaviour has been marked deprecated
> > since 2.11, expecting users to provide an explicit read-only=on option.
> > 
> > Now that we have auto-read-only=on, enable these drivers to make use of
> > the option.
> > 
> > This is the only use of bdrv_set_read_only(), so we can make it a bit
> > more specific and turn it into a bdrv_apply_auto_read_only() that is
> > more convenient for drivers to use.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > +++ b/block/rbd.c
> > @@ -780,16 +780,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >       /* If we are using an rbd snapshot, we must be r/o, otherwise
> >        * leave as-is */
> >       if (s->snap != NULL) {
> > -        if (!bdrv_is_read_only(bs)) {
> > -            error_report("Opening rbd snapshots without an explicit "
> > -                         "read-only=on option is deprecated. Future versions "
> > -                         "will refuse to open the image instead of "
> > -                         "automatically marking the image read-only.");
> > -            r = bdrv_set_read_only(bs, true, &local_err);
> > -            if (r < 0) {
> > -                error_propagate(errp, local_err);
> > -                goto failed_open;
> > -            }
> > +        r = bdrv_apply_auto_read_only(bs, "rbd snapshots are read-only", errp);
> > +        if (r < 0) {
> > +            rbd_close(s->image);
> > +            goto failed_open;
> 
> That rbd_close() is an independent bugfix.  Should probably be split to a
> separate commit, or at a minimum called out in the commit message as
> intentional.

Okay, I'll split it.

> Actually, is it really needed to prevent a leak, or does the existing
> rados_shutdown() in failed_open already implicitly cover the actions of
> rbd_close()?

I don't know if rados_shutdown() would implicitly do that as well, but
the normal .bdrv_close implementation calls both, too, so I suppose the
safe option is to let the error path do the same.

Kevin
