Received: from eggs.gnu.org ([2001:4830:134:3::10]:38747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eb4Is-0003qy-S6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eb4Io-0007B9-Uc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:55:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eb4Io-00079s-Ky
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:55:50 -0500
Date: Mon, 15 Jan 2018 12:55:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180115125543.GB2584@work-vm>
References: <9406328b-b058-2c34-dc32-45b440ea7b80@aptalaska.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9406328b-b058-2c34-dc32-45b440ea7b80@aptalaska.net>
Subject: Re: [Qemu-devel] question: I found a qemu crash about migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Schumacher <matt.s@aptalaska.net>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com

* Matthew Schumacher (matt.s@aptalaska.net) wrote:
> Am 28.09.2017 um 19:01 hat Dr. David Alan Gilbert geschrieben:
> > Hi,
> >   This is a 'fun' bug;  I had a good chat to kwolf about it earlier.
> > A proper fix really needs to be done together with libvirt so that we
> > can sequence:
> >    a) The stopping of the CPU on the source
> >    b) The termination of the mirroring block job
> >    c) The inactivation of the block devices on the source
> >        (bdrv_inactivate_all)
> >    d) The activation of the block devices on the destination
> >        (bdrv_invalidate_cache_all)
> >    e) The start of the CPU on the destinationOn 01/12/2018 03:21 PM,
> qemu-devel-confirm+7e23769bf079599cf1f3db6b00d347e8675d87f
> 3@nongnu.org wrote:
> >
> >
> > It looks like you're hitting a race between b/c;  we've had races
> > between c/d in the past and moved the bdrv_inactivate_all.
> >
> > During the discussion we ended up with two proposed solutions;
> > both of them require one extra command and one extra migration
> > capability.
> >
> > The block way
> > -------------
> >    1) Add a new migration capability pause-at-complete
> >    2) Add a new migration state almost-complete
> >    3) After saving devices, if pause-at-complete is set,
> >       transition to almost-complete
> >    4) Add a new command (migration-continue) that
> >       causes the migration to inactivate the devices (c)
> >       and send the final EOF to the destination.
> >
> > You set pause-at-complete, wait until migrate hits almost-complete;
> > cleanup the mirror job, and then do migration-continue.  When it
> > completes do 'cont' on the destination.
> >
> > The migration way
> > -----------------
> >    1) Stop doing (d) when the destination is started with -S
> >       since it happens anyway when 'cont' is issued
> >    2) Add a new migration capability ext-manage-storage
> >    3) When 'ext-manage-storage' is set, we don't bother doing (c)
> >    4) Add a new command 'block-inactivate' on the source
> >
> > You set ext-manage-storage, do the migrate and when it's finished
> > clean up the block job, block-inactivate on the source, and
> > then cont on the destination.
> >
> >
> > My worry about the 'block way' is that the point at which we
> > do the pause seems pretty interesting;  it probably is best
> > done after the final device save but before the inactivate,
> > but could be done before it.  But it probably becomes API
> > and something might become dependent on where we did it.
> >
> > I think Kevin's worry about the 'migration way' is that
> > it's a bit of a block-specific fudge; which is probably right.
> >
> >
> > I've not really thought what happens when you have a mix of shared and
> > non-shared storage.
> >
> > Could we do any hack that isn't libvirt-visible for existing versions?
> > I guess maybe hack drive-mirror so it interlocks with the migration
> > code somehow to hold off on that inactivate?
> >
> > This code is visible probalby from 2.9.ish with the new locking code;
> > but really that b/c race has been there for ever - there's maybe
> > always the chance that the last few blocks of mirroring might have
> > happened too late ?
> >
> > Thoughts?
> > What are the libvirt view on the preferred solution.
> >
> > Dave
> 
> Devs,
> 
> Did this issue ever get addressed?  I'm looking at the history for
> mirror.c at https://github.com/qemu/qemu/commits/master/block/mirror.c
> and I don't see anything that leads me to believe this was fixed.
> 
> I'm still unable to live migrate storage without risking corruption on
> even a moderately loaded vm.

Yes, there's now a 'pause-before-switchover' which gives libvirt
a chance to quiesce the block devices.
That went in my 93fbd0314^..0331c8cabf6168 back in October.
I believe libvirt uses that; see libvirt commit 6addde2.

Dave

> Thanks,
> schu
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
