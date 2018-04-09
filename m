Received: from eggs.gnu.org ([2001:4830:134:3::10]:58115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5XPn-0000O4-1j
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5XPj-00017l-SO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:04:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5XPj-00017E-Lz
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8C744040074
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 14:04:51 +0000 (UTC)
Date: Mon, 9 Apr 2018 15:04:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180409140439.GF2449@work-vm>
References: <20180328170207.49512-1-dgilbert@redhat.com>
	<20180403143857.GF11070@localhost.localdomain>
	<20180403205237.GA2501@work-vm>
	<20180404100303.GE4482@localhost.localdomain>
	<20180409102744.GC2449@work-vm>
	<20180409134003.GG5294@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409134003.GG5294@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] migration: Don't activate block devices if
 using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, jdenemar@redhat.com, peterx@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 09.04.2018 um 12:27 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Am 03.04.2018 um 22:52 hat Dr. David Alan Gilbert geschrieben:
> > > > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > > > Am 28.03.2018 um 19:02 hat Dr. David Alan Gilbert (git) geschrieben:
> > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > 
> > > > > > Activating the block devices causes the locks to be taken on
> > > > > > the backing file.  If we're running with -S and the destination libvirt
> > > > > > hasn't started the destination with 'cont', it's expecting the locks are
> > > > > > still untaken.
> > > > > > 
> > > > > > Don't activate the block devices if we're not going to autostart the VM;
> > > > > > 'cont' already will do that anyway.
> > > > > > 
> > > > > > bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
> > > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > 
> > > > > I'm not sure that this is a good idea. Going back to my old writeup of
> > > > > the migration phases...
> > > > > 
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07917.html
> > > > > 
> > > > > ...the phase between migration completion and 'cont' is described like
> > > > > this:
> > > > > 
> > > > >     b) Migration converges:
> > > > >        Both VMs are stopped (assuming -S is given on the destination,
> > > > >        otherwise this phase is skipped), the destination is in control of
> > > > >        the resources
> > > > > 
> > > > > This patch changes the definition of the phase so that neither side is
> > > > > in control of the resources. We lose the phase where the destination is
> > > > > in control, but the VM isn't running yet. This feels like a problem to
> > > > > me.
> > > > 
> > > > But see Jiri's writeup on that bz;  libvirt is hitting the opposite
> > > > problem;   in this corner case they can't have the destination taking
> > > > control yet.
> > > 
> > > I wonder if they can't already grant the destination QEMU the necessary
> > > permission in the pre-switchover phase. Just a thought, I don't know how
> > > this works in detail, so it might not possible after all.
> > 
> > It's a fairly hairy failure case they had; if I remember correctly it's:
> >   a) Start migration
> >   b) Migration gets to completion point
> >   c) Destination is still paused
> >   d) Libvirt is restarted on the source
> >   e) Since libvirt was restarted it fails the migration (and hence knows
> >      the destination won't be started)
> >   f) It now tries to resume the qemu on the source
> > 
> > (f) fails because (b) caused the locks to be taken on the destination;
> > hence this patch stops doing that.  It's a case we don't really think
> > about - i.e. that the migration has actually completed and all the data
> > is on the destination, but libvirt decides for some other reason to
> > abandon migration.
> 
> If you do remember correctly, that scenario doesn't feel tricky at all.
> libvirt needs to quit the destination qemu, which will inactivate the
> images on the destination and release the lock, and then it can continue
> the source.
> 
> In fact, this is so straightforward that I wonder what else libvirt is
> doing. Is the destination qemu only shut down after trying to continue
> the source? That would be libvirt using the wrong order of steps.

I'll leave Jiri to reply to this; I think this is a case of the source
realising libvirt has restarted, then trying to recover all of it's VMs
without being in the position of being able to check on the destination.

> > > > > Consider a case where the management tool keeps a mirror job with
> > > > > sync=none running to expose all I/O requests to some external process.
> > > > > It needs to shut down the old block job on the source in the
> > > > > 'pre-switchover' state, and start a new block job on the destination
> > > > > when the destination controls the images, but the VM doesn't run yet (so
> > > > > that it doesn't miss an I/O request). This patch removes the migration
> > > > > phase that the management tool needs to implement this correctly.
> > > > > 
> > > > > If we need a "neither side has control" phase, we might need to
> > > > > introduce it in addition to the existing phases rather than replacing a
> > > > > phase that is still needed in other cases.
> > > > 
> > > > This is yet another phase to be added.
> > > > IMHO this needs the managment tool to explicitly take control in the
> > > > case you're talking about.
> > > 
> > > What kind of mechanism do you have in mind there?
> > > 
> > > Maybe what could work would be separate QMP commands to inactivate (and
> > > possibly for symmetry activate) all block nodes. Then the management
> > > tool could use the pre-switchover phase to shut down its block jobs
> > > etc., inactivate all block nodes, transfer its own locks and then call
> > > migrate-continue.
> > 
> > Yes it was a 'block-activate' that I'd wondered about.  One complication
> > is that if this now under the control of the management layer then we
> > should stop asserting when the block devices aren't in the expected
> > state and just cleanly fail the command instead.
> 
> Requiring an explicit 'block-activate' on the destination would be an
> incompatible change, so you would have to introduce a new option for
> that. 'block-inactivate' on the source feels a bit simpler.

I'd only want the 'block-activate' in the case of this new block-job
you're suggesting; not in the case of normal migrates - they'd still get
it when they do 'cont' - so the change in behaviour is only with that
block-job case that must start before the end of migrate.

> And yes, you're probably right that we would have to be more careful to
> catch inactive images without crashing. On the other hand, it would
> become a state that is easier to test because it can be directly
> influenced via QMP rather than being only a side effect of migration.

Yes; but crashing is really bad, so we should really really stopping
asserting all over.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
