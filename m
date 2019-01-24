Received: from eggs.gnu.org ([209.51.188.92]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmlOb-0006iA-NY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmlOa-0002q2-4J
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:14:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmlOZ-0002fg-4f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:14:40 -0500
Date: Thu, 24 Jan 2019 20:04:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124200428.GG2101@work-vm>
References: <e5021228-184b-cc1b-7aba-3bba795127a6@msgid.tls.msk.ru>
	<20190114105132.GA2524@work-vm>
	<20190114115205.GD6837@linux.fritz.box>
	<20190118155703.GF2146@work-vm>
	<20190121155553.GD5638@linux.fritz.box>
	<20190121160524.GC2083@work-vm>
	<20190121164550.GE5638@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121164550.GE5638@linux.fritz.box>
Subject: Re: [Qemu-devel] 3.1: second invocation of migrate crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, quintela@redhat.com, qemu-devel <qemu-devel@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 21.01.2019 um 17:05 hat Dr. David Alan Gilbert geschrieben:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Am 18.01.2019 um 16:57 hat Dr. David Alan Gilbert geschrieben:
> > > > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > > > Am 14.01.2019 um 11:51 hat Dr. David Alan Gilbert geschrieben:
> > > > > > * Michael Tokarev (mjt@tls.msk.ru) wrote:
> > > > > > > $ qemu-system-x86_64 -monitor stdio -hda foo.img
> > > > > > > QEMU 3.1.0 monitor - type 'help' for more information
> > > > > > > (qemu) stop
> > > > > > > (qemu) migrate "exec:cat >/dev/null"
> > > > > > > (qemu) migrate "exec:cat >/dev/null"
> > > > > > > qemu-system-x86_64: /build/qemu/qemu-3.1/block.c:4647: bdrv_inactivate_recurse: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> > > > > > > Aborted
> > > > > > 
> > > > > > And on head as well;  it only happens if the 1st migrate is succesful;
> > > > > > if it got cancelled the 2nd one works, so it's not too bad.
> > > > > > 
> > > > > > I suspect the problem here is all around locking/ownership - the block
> > > > > > devices get shutdown at the end of migration since the assumption is
> > > > > > that the other end has them open now and we had better release them.
> > > > > 
> > > > > Yes, only "cont" gets control back to the source VM.
> > > > > 
> > > > > I think we really should limit the possible monitor commands in the
> > > > > postmigrate status, and possibly provide a way to get back to the
> > > > > regular paused state (which means getting back control of the resources)
> > > > > without resuming the VM first.
> > > > 
> > > > This error is a little interesting if you'd done something like:
> > > > 
> > > > 
> > > >      src:
> > > >          stop
> > > >          migrate
> > > > 
> > > >      dst:
> > > >          <kill qemu for some reason>
> > > >          start a new qemu
> > > > 
> > > >      src:
> > > >          migrate
> > > > 
> > > > Now that used to work (safely) - note we've not started
> > > > a VM succesfully anywhere else.
> > > > 
> > > > Now the source refuses to let that happen - with a rather
> > > > nasty abort.
> > > 
> > > Essentially it's another effect of the problem that migration has always
> > > lacked a proper model of ownership transfer. And it's still treating
> > > this as a block layer problem rather than making it a core concept of
> > > migration as it should.
> > > 
> > > We can stack another one-off fix on top, and get back control of the
> > > block devices automatically on a second 'migrate'. But it feels like a
> > > hack and not like VMs had a properly designed and respected state
> > > machine.
> > 
> > Hmm; I don't like to get back to this argument because I think
> > we've got a perfectly servicable model that's implemented at higher
> > levels outside qemu, and the real problem is the block layer added
> > new assumptions about the semantics without checking they were really
> > true.
> > qemu only has the view from a single host; it takes the higher level
> > view from something like libvirt to have the view across multiple hosts
> > to understand who has the ownership when.
> 
> Obviously the upper layer is not handling this without the help of QEMU
> or we wouldn't have had bugs that images were accessed by two QEMU
> processes at the same time. We didn't change the assumptions, but we
> only started to actually check the preconditions that have always been
> necessary to perform live migration correctly.

In this case there is a behaviour that was perfectly legal before that
fails now; further the case is safe - the source hasn't accessed the
disks after the first migration and isn't trying to access it again
either.

> But if you like to think the upper layer should handle all of this,

I don't really want the upper layer to handle all of this; but I don't
think we can handle it all either - we've not got the higher level
view of screwups that happen outside qemu.

>then
> it's on libvirt to handle the ownership transfer manually. If we really
> want, we can add explicit QMP commands to activate and inactivate block
> nodes. This can be done and requiring that the management layer does
> all of this would be a consistent interface, too.
> 
> I just don't like this design much for two reasons: The first is that
> you can't migrate a VM that has disks with a simple 'migrate' command
> any more. The second is that if you implement it consistently, this has
> an impact on compatibility. I think it's a design that could be
> considered if we were adding live migration as a new feature, but it's
> probably hard to switch to it now.
> 
> In any case, I do think we should finally make a decision how ownership
> of resources should work in the context of migration, and then implement
> that.

I think we're mostly OK, but what I'd like would be:
  a) I'd like things to fail gently rather than abort; so I'd either
     like the current functions to fail cleanly so I can fail the
     migration or add a check at the start of migration to tell the user
    they did something wrong.

  b) I'd like commands that can tell me the current state and a command
     to move it to the other state explicitly; so we've got a way
     to recover in weirder cases.

  c) I'd like to document what the states should be before/after/in
     various  middle states of migration.

I think the normal case is fine, and hence as you say, I wouldn't
want to break a normal 'migrate' - I just want cleaner failures
and ways to do the more unusual things.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
