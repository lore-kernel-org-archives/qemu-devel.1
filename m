Received: from eggs.gnu.org ([2001:4830:134:3::10]:47175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1ciMmk-0001fw-6J
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1ciMmh-0000L0-3Y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:00:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1ciMmg-0000Kv-U4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:00:19 -0500
Date: Mon, 27 Feb 2017 16:00:15 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170227150015.GB5816@redhat.com>
References: <20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
	<20170213181601.GG3086@work-vm>
	<20170214162155.GB6645@aperevalov-ubuntu>
	<20170214193425.GF11561@work-vm>
	<20170221073115.GA5046@aperevalov-ubuntu>
	<20170221100313.GB2377@work-vm>
	<20170227110520.GA27506@aperevalov-R560>
	<20170227112657.GE2350@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227112657.GE2350@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, quintela@redhat.com

Hello,

On Mon, Feb 27, 2017 at 11:26:58AM +0000, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > Also if I'm not wrong, commands and pages are transferred over the same
> > socket. Why not to use OOB TCP in this case for commands?
> 
> My understanding was that OOB was limited to quite small transfers
> I think the right way is to use a separate FD for the requests, so I'll
> do it after Juan's multifd series.

OOB would do the trick and we considered it some time ago, but we need
this to work over any network pipe including TLS (out of control of
qemu but setup by libvirt), and OOB being a protocol level TCP
specific feature in the kernel, I don't think there's any way to
access it through TLS APIs abstractions. Plus like David said there
are issues with the size of the transfer.

Currently reducing tcp_wmem sysctl to 3MiB sounds best (to give a
little room for the headers of the packets required to transfer
2M). For 4k pages it can be reduced perhaps to 6k/10k.

> Although even then I'm not sure how it will behave; the other thing
> might be to throttle the background page transfer so the FIFO isn't
> as full.

Yes, we didn't go in this direction because it would be only a short
term solution.

The kernel has optimal throttling in the TCP stack already, trying to
throttle against it in qemu so that the tcp_wmem queue doesn't
fill, doesn't look attractive.

With the multisocket implementation, with tc qdisc you can further
make sure that you've got the userfault socket with top priority and
delivered immediately, but normally it will not be necessary and
fq_codel (should be the userland post-boot default by now, kernel has
still an obsolete default) should do a fine job by default. Having a
proper tc qdisc default will matter once we switch to the multisocket
implementation so you'll have to pay attention to that, but that's
something to pay attention to regardless, if you have significant
network load from multiple sockets in the equation, nothing out of the
ordinary.

Thanks,
Andrea
