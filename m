Received: from eggs.gnu.org ([2001:4830:134:3::10]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM3Lu-00070U-W6
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM3Lq-0001zH-50
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM3Lp-0001yv-S9
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 21:52:54 -0500
Date: Tue, 5 Dec 2017 10:52:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171205025247.GA2925@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-32-peterx@redhat.com>
	<20171201165327.GB2318@work-vm> <20171204044813.GD7916@xz-mi>
	<20171204171028.GG2420@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204171028.GG2420@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 31/32] migration,
 qmp: new command "migrate-pause"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Dec 04, 2017 at 05:10:29PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Fri, Dec 01, 2017 at 04:53:28PM +0000, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > It is used to manually trigger the postcopy pause state.  It works just
> > > > like when we found the migration stream failed during postcopy, but
> > > > provide an explicit way for user in case of misterious socket hangs.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Can we change the name to something like 'migrate-disconnect' - pause
> > > is a bit easy to confuse with other things and this is really more
> > > an explicit network disconnect (Is it worth just making it a flag to
> > > migrate-cancel?)
> > 
> > Then I would prefer to reuse the migrate_cancel command.  
> > 
> > Actually this reminded me about what would happen now if someone on
> > src VM sends a "migrate_cancel" during postcopy active.  It should
> > crash the VM, right?
> > 
> > Considering above, I'm thinking whether we should just make it a
> > default behavior that when do migrate_cancel during postcopy-active we
> > just do a pause instead of real cancel. After all it cannot re-start
> > the VM any more on source, so IMHO a real cancel does not mean much
> > here.  More importantly, what if someone wants to manually trigger
> > this pause but accidentally forgot to type that new flag (say,
> > -D[isconnect])?  It'll crash the VM directly.
> > 
> > What do you think?
> 
> Yes, that's OK, just be careful about race conditions between the
> states,  for example what happens if you do a cancel and you enter
> migrate_fd_cancel in postcopy-active, but before you can actually
> cancel you end up completing,

If I am going to modify that, migrate_fd_cancel won't be called if we
are in postcopy-active state, instead we'll just do the disconnect
only.

For finally solving all the races between QMP commands and migration
thread, I do think (again) that we need locks or some other sync
method.  I really hope we can have this fixed in QEMU 2.12.  Basically
we will need to go over every migration command to see whether it'll
need to take the migration lock (to be added) or not.  With that,
it'll save a lot of our future time IMHO thinking about races.

> or the opposite where you do a
> migrate-start-postcopy almost immediately before migrade-cancel;
> do you get to cancel in teh active or postcopy-active state?

This is a good example that at least migrate-start-postcopy is
synchronized somehow nicely with the migration thread using a single
variable (actually it can be non-atomic operation I think, anyway, no
race is here as long as we are delivering the message via a single
variable, and qmp command is the only writter).  For this command I
think it's pretty safe.  After all, user should not run that command
too fast if he/she wants a paused postcopy, at least he/she should do
query-migration before that to make sure the state is postcopy-active.
So IMHO this is totally fine.

Thanks,

-- 
Peter Xu
