Received: from eggs.gnu.org ([2001:4830:134:3::10]:41113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dskeA-0000Bf-Cs
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dske7-0001CA-7x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:02:42 -0400
Date: Fri, 15 Sep 2017 15:02:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915070232.GF17199@lemon>
References: <20170915054404.19914-1-famz@redhat.com>
	<20170915054404.19914-2-famz@redhat.com>
	<20170915064132.GP3617@pxdev.xzpeter.org>
	<20170915064907.GD17199@lemon>
	<20170915065627.GQ3617@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915065627.GQ3617@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Allow ram_save_cleanup to
 be called with empty state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org

On Fri, 09/15 14:56, Peter Xu wrote:
> On Fri, Sep 15, 2017 at 02:49:07PM +0800, Fam Zheng wrote:
> > On Fri, 09/15 14:41, Peter Xu wrote:
> > > On Fri, Sep 15, 2017 at 01:44:02PM +0800, Fam Zheng wrote:
> > > > So that we can do cleanup unconditionally at the end of main().
> > > > 
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > > ---
> > > >  migration/ram.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index e18b3e2d4f..37e6a71241 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1365,6 +1365,9 @@ static void ram_save_cleanup(void *opaque)
> > > >      RAMState **rsp = opaque;
> > > >      RAMBlock *block;
> > > >  
> > > > +    if (!rsp || !*rsp) {
> > > > +        return;
> > > > +    }
> > > >      /* caller have hold iothread lock or is in a bh, so there is
> > > >       * no writing race against this migration_bitmap
> > > >       */
> > > > -- 
> > > > 2.13.5
> > > > 
> > > 
> > > Instead of take special care on RAM, how about check in
> > > migrate_fd_cancel(), and return directly if migration_is_idle()?
> > 
> > This is not from migrate_fd_cancel(), but from qemu_savevm_state_cleanup(), so
> > that doesn't work.
> 
> Yeh I see the point.  But my logic still stands - we don't need to
> cleanup anything if the migration is not really there.
> 
> I'm thinking whether we can put qemu_savevm_state_cleanup() into
> migrate_fd_cancel() in some way, though I am still not 100% sure on
> the colo part.  Anyway, I feel like a bit confusing we have two
> cleanup functions.

I agree, but I don't know what is the best way to clean this up: savevm and
migration seem a little independent from each other.

Fam
