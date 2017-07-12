Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1dVJ7r-0006U6-QH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1dVJ7n-0000rZ-UN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1dVJ7n-0000qK-LG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:00:23 -0400
Date: Wed, 12 Jul 2017 17:00:04 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170712150004.GJ22628@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-23-dgilbert@redhat.com>
	<20170711042232.GA29326@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711042232.GA29326@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 22/29] vhost+postcopy: Call wakeups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com

On Tue, Jul 11, 2017 at 12:22:32PM +0800, Peter Xu wrote:
> On Wed, Jun 28, 2017 at 08:00:40PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Cause the vhost-user client to be woken up whenever:
> >   a) We place a page in postcopy mode
> 
> Just to make sure I understand it correctly - UFFDIO_COPY will only
> wake up the waiters on the same userfaultfd context, so we don't need
> to wake up QEMU userfaultfd (vcpu threads), but we need to explicitly
> wake up other ufds/threads, like vhost-user backends. Am I right?

Yes.

Every "uffd" represents one and only one "mm" (i.e. a process). So
there is no way a single UFFDIO_COPY can wake the faults happening on
a process different from the "mm" the uffd is associated with.

vhost-bridge being a different process requires a UFFDIO_WAKE on its
own uffd it passed to qemu in addition of the UFFDIO_COPY that like
you said implicitly wakes the userfaults happening on the qemu process
(vcpus iothread, dataplane etc..).

On a side note there's a way not to wake userfaults implicitly in
UFFDIO_COPY in case you want to wake userfaults in batches but nobody
uses that for now (uffdio_copy.mode |= UFFDIO_COPY_MODE_DONTWAKE).

It'd be theoretically nice to optimize away the additional enter/exit
kernel introduced by the UFFDIO_WAKE and the translation table as
well.

What we could do is to add a UFFDIO_BIND that takes an "fd" as
parameter to the ioctl to bind the two uffd together. Then we could
push logical offsets in addition to the virtual address ranges when
calling UFFDIO_REGISTER_LOGICAL (the logical offsets would then match
the guest physical addresses) so that the UFFDIO_COPY_LOGICAL would
then be able to get a logical range to wakeup that the kernel would
translate into virtual addresses for all uffds bind together. Pushing
offsets into UFFDIO_REGISTER was David's idea.

That would eliminate the enter/exit kernel for the explicit
UFFDIO_WAKE and calling a single UFFDIO_COPY would be enough.

Alternatively we should make the uffd work based on file offsets
instead of virtual addresses but that would involve changes to
filesystems and it only would move the needle on top of tmpfs
(shared=on/off no difference) and hugetlbfs. It would be enough for
vhost-bridge.

Usually the uffd fault lives at the higher level of the virtual memory
subsystem and never deals with file offsets so if we can get away with
logical ranges per-uffd for UFFDIO_REGISTER and UFFDIO_COPY, it may be
simpler and easier to extend automatically to all memory types
supported by uffd (including anon which has no file offset).

No major improvement is to be expected by such an enhancement though
so it's not very high priority to implement. It's not even clear if
the complexity is worth it. Doing one more syscall per page I think
might be measurable only on very fast network. The current way of
operation where uffd are independent of each other and the translation
table is transferred by userland means is quite optimal already and
much simpler. Furthermore for hugetlbfs the performance difference
most certainly wouldn't be measurable, as the enter/exit kernel would
be diluted by a factor of 512 compared to 4k userfaults.

Thanks,
Andrea
