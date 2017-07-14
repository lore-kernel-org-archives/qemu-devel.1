Received: from eggs.gnu.org ([2001:4830:134:3::10]:49917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1R0-0000iG-9l
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1Qv-0004K6-7U
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW1Qv-0004Jy-0c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:19:05 -0400
Date: Fri, 14 Jul 2017 17:18:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714170926-mutt-send-email-mst@kernel.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-23-dgilbert@redhat.com>
	<20170711042232.GA29326@pxdev.xzpeter.org>
	<20170712150004.GJ22628@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712150004.GJ22628@redhat.com>
Subject: Re: [Qemu-devel] [RFC 22/29] vhost+postcopy: Call wakeups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, a.perevalov@samsung.com, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com

On Wed, Jul 12, 2017 at 05:00:04PM +0200, Andrea Arcangeli wrote:
> What we could do is to add a UFFDIO_BIND that takes an "fd" as
> parameter to the ioctl to bind the two uffd together. Then we could
> push logical offsets in addition to the virtual address ranges when
> calling UFFDIO_REGISTER_LOGICAL (the logical offsets would then match
> the guest physical addresses) so that the UFFDIO_COPY_LOGICAL would
> then be able to get a logical range to wakeup that the kernel would
> translate into virtual addresses for all uffds bind together. Pushing
> offsets into UFFDIO_REGISTER was David's idea.

I think it was mine originally just in an off-list discussion.
To me it seems cleaner to do UFFDIO_DUP which gives you
a new fd bound to the current one, though.

> That would eliminate the enter/exit kernel for the explicit
> UFFDIO_WAKE and calling a single UFFDIO_COPY would be enough.
> 
> Alternatively we should make the uffd work based on file offsets
> instead of virtual addresses but that would involve changes to
> filesystems and it only would move the needle on top of tmpfs
> (shared=on/off no difference) and hugetlbfs. It would be enough for
> vhost-bridge.
> 
> Usually the uffd fault lives at the higher level of the virtual memory
> subsystem and never deals with file offsets so if we can get away with
> logical ranges per-uffd for UFFDIO_REGISTER and UFFDIO_COPY, it may be
> simpler and easier to extend automatically to all memory types
> supported by uffd (including anon which has no file offset).
> 
> No major improvement is to be expected by such an enhancement though
> so it's not very high priority to implement. It's not even clear if
> the complexity is worth it. Doing one more syscall per page I think
> might be measurable only on very fast network. The current way of
> operation where uffd are independent of each other and the translation
> table is transferred by userland means is quite optimal already and
> much simpler. Furthermore for hugetlbfs the performance difference
> most certainly wouldn't be measurable, as the enter/exit kernel would
> be diluted by a factor of 512 compared to 4k userfaults.
> 
> Thanks,
> Andrea
