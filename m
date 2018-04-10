Received: from eggs.gnu.org ([2001:4830:134:3::10]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5pMf-0005pR-AX
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5pMc-0000dO-2g
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:14:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1f5pMb-0000cI-Pq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:14:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3757406802D
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 09:14:48 +0000 (UTC)
Date: Tue, 10 Apr 2018 11:14:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180410091437.GC7026@localhost.localdomain>
References: <20180328170207.49512-1-dgilbert@redhat.com>
	<20180403143857.GF11070@localhost.localdomain>
	<20180403205237.GA2501@work-vm>
	<20180404100303.GE4482@localhost.localdomain>
	<20180409102744.GC2449@work-vm>
	<20180409134003.GG5294@localhost.localdomain>
	<20180410073635.GA91107@orkuz.home>
	<20180410081848.GA7026@localhost.localdomain>
	<20180410084524.GB2559@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410084524.GB2559@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peterx@redhat.com

Am 10.04.2018 um 10:45 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 10.04.2018 um 09:36 hat Jiri Denemark geschrieben:
> > > On Mon, Apr 09, 2018 at 15:40:03 +0200, Kevin Wolf wrote:
> > > > Am 09.04.2018 um 12:27 hat Dr. David Alan Gilbert geschrieben:
> > > > > It's a fairly hairy failure case they had; if I remember correctly it's:
> > > > >   a) Start migration
> > > > >   b) Migration gets to completion point
> > > > >   c) Destination is still paused
> > > > >   d) Libvirt is restarted on the source
> > > > >   e) Since libvirt was restarted it fails the migration (and hence knows
> > > > >      the destination won't be started)
> > > > >   f) It now tries to resume the qemu on the source
> > > > > 
> > > > > (f) fails because (b) caused the locks to be taken on the destination;
> > > > > hence this patch stops doing that.  It's a case we don't really think
> > > > > about - i.e. that the migration has actually completed and all the data
> > > > > is on the destination, but libvirt decides for some other reason to
> > > > > abandon migration.
> > > > 
> > > > If you do remember correctly, that scenario doesn't feel tricky at all.
> > > > libvirt needs to quit the destination qemu, which will inactivate the
> > > > images on the destination and release the lock, and then it can continue
> > > > the source.
> > > > 
> > > > In fact, this is so straightforward that I wonder what else libvirt is
> > > > doing. Is the destination qemu only shut down after trying to continue
> > > > the source? That would be libvirt using the wrong order of steps.
> > > 
> > > There's no connection between the two libvirt daemons in the case we're
> > > talking about so they can't really synchronize the actions. The
> > > destination daemon will kill the new QEMU process and the source will
> > > resume the old one, but the order is completely random.
> > 
> > Hm, okay...
> > 
> > > > > Yes it was a 'block-activate' that I'd wondered about.  One complication
> > > > > is that if this now under the control of the management layer then we
> > > > > should stop asserting when the block devices aren't in the expected
> > > > > state and just cleanly fail the command instead.
> > > > 
> > > > Requiring an explicit 'block-activate' on the destination would be an
> > > > incompatible change, so you would have to introduce a new option for
> > > > that. 'block-inactivate' on the source feels a bit simpler.
> > > 
> > > As I said in another email, the explicit block-activate command could
> > > depend on a migration capability similarly to how pre-switchover state
> > > works.
> > 
> > Yeah, that's exactly the thing that we wouldn't need if we could use
> > 'block-inactivate' on the source instead. It feels a bit wrong to
> > design a more involved QEMU interface around the libvirt internals,
> 
> It's not necessarily 'libvirt internals' - it's a case of them having to
> cope with recovering from failures that happen around migration; it's
> not an easy problem, and if they've got a way to stop both sides running
> at the same time that's pretty important.

The 'libvirt internals' isn't that it needs an additional state where
neither source nor destination QEMU own the images, but that it has to
be between migration completion and image activation on the destination
rather than between image inactivation on the source and migration
completion. The latter would be much easier for qemu, but apparently it
doesn't work for libvirt because of how it works internally.

But as I said, I'd just implement both for symmetry and then management
tools can pick whatever makes their life easier.

> > but
> > as long as we implement both sides for symmetry and libvirt just happens
> > to pick the destination side for now, I think it's okay.
> > 
> > By the way, are block devices the only thing that need to be explicitly
> > activated? For example, what about qemu_announce_self() for network
> > cards, do we need to delay that, too?
> > 
> > In any case, I think this patch needs to be reverted for 2.12 because
> > it's wrong, and then we can create the proper solution in the 2.13
> > timefrage.
> 
> what case does this break?
> I'm a bit wary of reverting this, which fixes a known problem, on the
> basis that it causes a theoretical problem.

It breaks the API. And the final design we're having in mind now is
compatible with the old API, not with the new one exposed by this patch,
so that switch would break the API again to get back to the old state.

Do you know all the scripts that people are using around QEMU? I don't,
but I know that plenty of them exist, so I don't think we can declare
this API breakage purely theoretical.

Yes, the patch fixes a known problem, but also a problem that is a rare
corner case error that you can only hit with really bad timing. Do we
really want to risk unconditionally breaking success cases for fixing a
mostly theoretical corner case error path (with the failure mode that
the guest is paused when it shouldn't be)?

Kevin
