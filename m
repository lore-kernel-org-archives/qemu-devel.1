Received: from eggs.gnu.org ([2001:4830:134:3::10]:52026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2ZmD-0001I2-UJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2ZmA-00054V-QV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2ZmA-00053x-HL
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:27:34 -0400
Date: Thu, 12 Oct 2017 10:27:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171012092726.GD16125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011191317.24157-1-dgilbert@redhat.com>
	<20171012082145.GA16125@redhat.com>
	<20171012091831.GA5624@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012091831.GA5624@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/7] migration: pause-before-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Thu, Oct 12, 2017 at 11:18:31AM +0200, Kevin Wolf wrote:
> Am 12.10.2017 um 10:21 hat Daniel P. Berrange geschrieben:
> > On Wed, Oct 11, 2017 at 08:13:10PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Hi,
> > >   This set attempts to make a race condition between migration and
> > > drive-mirror (and other block users) soluble by allowing the migration
> > > to be paused after the source qemu releases the block devices but
> > > before the serialisation of the device state.
> > > 
> > > The symptom of this failure, as reported by Wangjie, is a:
> > >    _co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed
> > > 
> > > and the source qemu dieing; so the problem is pretty nasty.
> > > This has only been seen on 2.9 onwards, but the theory is that
> > > prior to 2.9 it might have been happening anyway and we were
> > > perhaps getting unreported corruptions (lost writes); so this
> > > really needs fixing.
> > > 
> > > This flow came from discussions between Kevin and me, and we can't
> > > see a way of fixing it without exposing a new state to the management
> > > layer.
> > > 
> > > The flow is now:
> > > 
> > > (qemu) migrate_set_capability pause-before-device on
> > > (qemu) migrate -d ...
> > > (qemu) info migrate
> > > ...
> > > Migration status: pause-before-device
> > > ...
> > > << issue commands to clean up any block jobs>>
> > > 
> > > (qemu) migrate_continue pause-before-device
> > > (qemu) info migrate
> > > ...
> > > Migration status: completed
> > 
> > I'm curious why QEMU doesn't have enough info to clean up the block
> > jobs automatically ? What is the key thing that libvirt knows about
> > the block jobs, that QEMU is lacking ? If QEMU had the right info it
> > could do it automatically & avoid this extra lock-step synchronization
> > with libvirt.
> 
> The key point is that the block job needs to be completed while the
> source VM is stopped, but the source qemu is still in control of the
> image files (e.g. still holds the file locks), so that it can do the
> remaining writes.
> 
> Without the additional migration phase, the only state where both sides
> are stopped is when the destination is in control of the image files
> (migration has completed, but -S prevents it from automatically
> resuming), so the source can't write to the image any more.

Hmm, I always thought that the target QEMU did not start using the
image files until you ran 'cont' on the target. eg once source QEMU
has migrate=completed, both QEMUs are in paused state and source QEMU
still owns the images, until we run 'cont'.

What you're saying seems to imply this is not the case, but if so what
is triggering the target QEMU to acquire the locks on images ? Is it
done implicitly when it finishes reading device state off the wire ?

If so, could we instead add a migrate feature flag to tell the target
QEMU not to automatically acquire image locks, until it receives an
explicit 'cont'. That would then not require this extra lock-step
migration state.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
