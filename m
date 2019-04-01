Received: from eggs.gnu.org ([209.51.188.92]:49820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1hAxrp-0001fc-HN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1hAxrn-0003iB-IM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:24:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1hAxrm-0003gx-Mg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:24:51 -0400
Message-ID: <c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Mon, 01 Apr 2019 16:24:29 +0200
In-Reply-To: <AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
References: <20190324221319-mutt-send-email-mst@kernel.org>
	<AM6PR05MB66166ED74E2718150F0CBF62BD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190326085309-mutt-send-email-mst@kernel.org>
	<AM6PR05MB661611FE4DD494AF9EFB6B8ABD5F0@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190327064143.GP9149@xz-x1>
	<060498b58287775ce6bd7dd704f13b6d6e185f91.camel@oracle.com>
	<20190327084255.GR9149@xz-x1>
	<AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401102515.GD8853@xz-x1>
	<AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elijah Shakkour <elijahsh@mellanox.com>, Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 2019-04-01 at 14:01 +0000, Elijah Shakkour wrote:
> 
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Monday, April 1, 2019 1:25 PM
> > To: Elijah Shakkour <elijahsh@mellanox.com>
> > Cc: Knut Omang <knut.omang@oracle.com>; Michael S. Tsirkin
> > <mst@redhat.com>; Alex Williamson <alex.williamson@redhat.com>;
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefan Hajnoczi
> > <stefanha@gmail.com>; qemu-devel@nongnu.org
> > Subject: Re: QEMU and vIOMMU support for emulated VF passthrough to
> > nested (L2) VM
> > 
> > On Mon, Apr 01, 2019 at 09:12:38AM +0000, Elijah Shakkour wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Sent: Monday, April 1, 2019 5:47 AM
> > > > To: Elijah Shakkour <elijahsh@mellanox.com>
> > > > Cc: Knut Omang <knut.omang@oracle.com>; Michael S. Tsirkin
> > > > <mst@redhat.com>; Alex Williamson <alex.williamson@redhat.com>;
> > > > Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Stefan Hajnoczi
> > > > <stefanha@gmail.com>; qemu-devel@nongnu.org
> > > > Subject: Re: QEMU and vIOMMU support for emulated VF passthrough
> > to
> > > > nested (L2) VM
> > > >
> > > > On Sun, Mar 31, 2019 at 11:15:00AM +0000, Elijah Shakkour wrote:
> > > >
> > > > [...]
> > > >
> > > > > I didn't have DMA nor MMIO read/write working with my old command
> > > > line.
> > > > > But, when I removed all CPU flags and only provided "-cpu host", I
> > > > > see that
> > > > MMIO works.
> > > > > Still, DMA read/write from emulated device doesn't work for VF.
> > > > > For
> > > > example:
> > > > > Driver provides me a buffer pointer through MMIO write, this
> > > > > address
> > > > (pointer) is GPA of L2, and when I try to call pci_dma_read() with
> > > > this address I get:
> > > > > "
> > > > > Unassigned mem read 0000000000000000 "
> > > >
> > > > I don't know where this error log was dumped but if it's during DMA
> > > > then I agree it can probably be related to vIOMMU.
> > > >
> > >
> > > This log is dumped from:
> > > memory.c: unassigned_mem_read()
> > >
> > > > > As I said, my problem now is in translation of L2 GPA provided by
> > > > > driver,
> > > > when I call DMA read/write for this address from VF.
> > > > > Any insights?
> > > >
> > > > I just noticed that you were using QEMU 2.12 [1].  If that's the
> > > > case, please rebase to the latest QEMU, at least >=3.0 because
> > > > there's major refactor of the shadow logic during 3.0 devel cycle AFAICT.
> > > >
> > >
> > > Rebased to QEMU 3.1
> > > Now I see the address I'm trying to read from in log but still same error:
> > > "
> > > Unassigned mem read 00000000f0481000
> > > "
> > > What do you suggest?
> > 
> > Would you please answer the questions that Knut asked?  Is it working for L1
> > guest?  How about PF?
> 
> Both VF and PF are working for L1 guest.
> I don't know how to passthrough PF to nested VM in hyper-v.

On Linux passing through VFs and PFs are the same. 
Maybe you can try passthrough with all Linux first? (first PF then VF) ?

> I don't invoke VF manually in hyper-v and pass it through to nested VM. I use hyper-v
> manager to configure and provide a VF for nested VM (I can see the VF only in the nested
> VM).
> 
> Did someone try to run emulated device in linux RH as nested L2 where L1 is windows
> hyper-v? Does DMA read/write work for this emulated device in this case?

I have never tried that, I have only used Linux as L2, Windows might be pickier about what
it expects, so starting with Linux to rule that out is probably a good idea.

> > 
> > You can also try to enable VT-d device log by appending:
> > 
> >   -trace enable="vtd_*"
> > 
> > In case it dumps anything useful for you.
> 
> Is there a way to open those traces to be dumped to stdout/stderr on the fly, instead of
> dtrace?

It's up to you what tracer(s) to configure when you build QEMU - check out 
docs/devel/tracing.txt . There's a few trace events defined in the SR/IOV patch set, you
might want to enable them as well.

Knut

> > --
> > Peter Xu
