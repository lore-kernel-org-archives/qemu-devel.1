Received: from eggs.gnu.org ([2001:4830:134:3::10]:35132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2aAd-0000wp-1i
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2aAZ-0008CL-Ut
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1e2aAZ-0008By-MH
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:52:47 -0400
Date: Thu, 12 Oct 2017 11:52:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171012095240.GB5624@localhost.localdomain>
References: <20171011191317.24157-1-dgilbert@redhat.com>
	<20171012082145.GA16125@redhat.com>
	<20171012091831.GA5624@localhost.localdomain>
	<20171012092726.GD16125@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012092726.GD16125@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] migration: pause-before-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

Am 12.10.2017 um 11:27 hat Daniel P. Berrange geschrieben:
> On Thu, Oct 12, 2017 at 11:18:31AM +0200, Kevin Wolf wrote:
> > Am 12.10.2017 um 10:21 hat Daniel P. Berrange geschrieben:
> > > On Wed, Oct 11, 2017 at 08:13:10PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > 
> > > > Hi,
> > > >   This set attempts to make a race condition between migration and
> > > > drive-mirror (and other block users) soluble by allowing the migration
> > > > to be paused after the source qemu releases the block devices but
> > > > before the serialisation of the device state.
> > > > 
> > > > The symptom of this failure, as reported by Wangjie, is a:
> > > >    _co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed
> > > > 
> > > > and the source qemu dieing; so the problem is pretty nasty.
> > > > This has only been seen on 2.9 onwards, but the theory is that
> > > > prior to 2.9 it might have been happening anyway and we were
> > > > perhaps getting unreported corruptions (lost writes); so this
> > > > really needs fixing.
> > > > 
> > > > This flow came from discussions between Kevin and me, and we can't
> > > > see a way of fixing it without exposing a new state to the management
> > > > layer.
> > > > 
> > > > The flow is now:
> > > > 
> > > > (qemu) migrate_set_capability pause-before-device on
> > > > (qemu) migrate -d ...
> > > > (qemu) info migrate
> > > > ...
> > > > Migration status: pause-before-device
> > > > ...
> > > > << issue commands to clean up any block jobs>>
> > > > 
> > > > (qemu) migrate_continue pause-before-device
> > > > (qemu) info migrate
> > > > ...
> > > > Migration status: completed
> > > 
> > > I'm curious why QEMU doesn't have enough info to clean up the block
> > > jobs automatically ? What is the key thing that libvirt knows about
> > > the block jobs, that QEMU is lacking ? If QEMU had the right info it
> > > could do it automatically & avoid this extra lock-step synchronization
> > > with libvirt.
> > 
> > The key point is that the block job needs to be completed while the
> > source VM is stopped, but the source qemu is still in control of the
> > image files (e.g. still holds the file locks), so that it can do the
> > remaining writes.
> > 
> > Without the additional migration phase, the only state where both sides
> > are stopped is when the destination is in control of the image files
> > (migration has completed, but -S prevents it from automatically
> > resuming), so the source can't write to the image any more.
> 
> Hmm, I always thought that the target QEMU did not start using the
> image files until you ran 'cont' on the target. eg once source QEMU
> has migrate=completed, both QEMUs are in paused state and source QEMU
> still owns the images, until we run 'cont'.
> 
> What you're saying seems to imply this is not the case, but if so what
> is triggering the target QEMU to acquire the locks on images ? Is it
> done implicitly when it finishes reading device state off the wire ?
> 
> If so, could we instead add a migrate feature flag to tell the target
> QEMU not to automatically acquire image locks, until it receives an
> explicit 'cont'. That would then not require this extra lock-step
> migration state.

The handover consists of two parts: The destination acquires the locks,
but first the source needs to release them. Without a new command, the
source can't know when it is supposed to do that. The destination
receives the 'cont' command, but source doesn't know about this. So you
have to have something that tells the source "management has made sure
to complete what needed to be completed, you can now give up control of
the images".

I also think that conceptually it is the cleanest to have a source
controlled pre-handover phase with paused VM, which is only symmetrical
to the existing post-handover phase that we have on the destination.
This gives us a clean model for the handover of any resources that
require some tearing down on the source before they can be used on the
destination, so it appears to be the most future-proof option.

Kevin
