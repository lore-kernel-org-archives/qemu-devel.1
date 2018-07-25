Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fiQ21-000185-Jd
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1fiQ1y-00064a-Ja
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1fiQ1y-0005n1-As
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 16:05:06 -0400
Date: Wed, 25 Jul 2018 16:04:56 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20180725200456.GM18452@redhat.com>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629115359.GH2568@work-vm> <20180725101836.GI2479@xz-mi>
	<20180725191736.GE2365@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725191736.GE2365@work-vm>
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com

On Wed, Jul 25, 2018 at 08:17:37PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Fri, Jun 29, 2018 at 12:53:59PM +0100, Dr. David Alan Gilbert wrote:
> > > * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
> > > > The patch set adds the ability to make external snapshots while VM is running.
> > > 
> > > cc'ing in Andrea since this uses sigsegv's to avoid userfault-wp that
> > > isn't there yet.
> > > 
> > > Hi Denis,
> > >   How robust are you finding this SEGV based trick; for example what
> > > about things like the kernel walking vhost queues or similar kernel
> > > nasties?
> > 
> > (I'm commenting on this old series to keep the discussion together)
> > 
> > If we want to make this series really work for people, we should
> > possibly need to know whether it could work with vhost (otherwise we
> > might need to go back to userfaultfd write-protection).
> > 
> > I digged a bit on the vhost-net IO, it should be using two ways to
> > write to guest memory:
> > 
> > - copy_to_user(): this should possibly still be able to be captured by
> >   mprotect() (after some confirmation from Paolo, but still we'd
> >   better try it out)
> 
> What confuses me here is who is going to get the signal from this and
> how we recover from the signal - or does it come back as an error
> on the vhost fd somehow?

The problem is having to start to handle manually all sigsegv in
vhost-net by trapping copy_to_user returning less than the full buffer
size or put_user returning -EFAULT.

Those errors would need to be forwarded by vhost-net to qemu userland
to call mprotect after copying the data.

That's not conceptually different from having uffd-wp sending the
message except that will then require zero changes to vhost-net and
every other piece of kernel code that may have to write to the write
protected memory.

It may look like the uffd-wp model is wish-feature similar to an
optimization, but without the uffd-wp model when the WP fault is
triggered by kernel code, the sigsegv model falls apart and requires
all kind of ad-hoc changes just for this single feature. Plus uffd-wp
has other benefits: it makes it all reliable in terms of not
increasing the number of vmas in use during the snapshot. Finally it
makes it faster too with no mmap_sem for reading and no sigsegv
signals.

The non cooperative features got merged first because there was much
activity on the kernel side on that front, but this is just an ideal
time to nail down the remaining issues in uffd-wp I think. That I
believe is time better spent than trying to emulate it with sigsegv
and changing all drivers to send new events down to qemu specific to
the sigsegv handling. We considered this before doing uffd for
postcopy too but overall it's unreliable and more work (no single
change was then needed to KVM code with uffd to handle postcopy and
here it should be the same).

Thanks,
Andrea
