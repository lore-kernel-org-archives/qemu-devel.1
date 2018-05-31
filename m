Received: from eggs.gnu.org ([2001:4830:134:3::10]:40793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fOTxb-00029g-RR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fOTxa-0005uR-EC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:11 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:45826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <akalita@cs.stonybrook.edu>)
	id 1fOTxZ-0005tL-U5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:14:10 -0400
Received: by mail-lf0-x242.google.com with SMTP id n3-v6so11549371lfe.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:14:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001801d3f8dd$2629a280$727ce780$@ru>
References: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
	<20180531085057.GG26429@stefanha-x1.localdomain>
	<001801d3f8dd$2629a280$727ce780$@ru>
From: Arnabjyoti Kalita <akalita@cs.stonybrook.edu>
Date: Thu, 31 May 2018 16:14:07 -0400
Message-ID: <CAJGDS+GEg0kpS_gxCupSz=O6RA8w-uAhO3rypAM524Z_RUHM8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Dear Pavel,

Thank you for your answer. I am not being able to understand the difference
between CPU I/Os and VM I/Os. Would any network packet that comes into the
Guest OS from the outside be a part of VM I/O or CPU I/O ? I am only
interested in "recording" and "replaying" those network packets that come
from the outside into the networking backend and not the other way around.
Say for example when I get a VMExit because of the arrival of a network
packet, I will use the VMExit reason : "KVM_EXIT_MMIO"  to trace back to
"e1000_mmio_write()" which I expect should be enough to record network
packets that come from the outside and write to the guest address space for
"e1000" devices. In such a case, I think I will not have to use the
"network-filter" backend that you use to record VM I/O only. Let me know if
you find errors in my approach.

I will try to see how I can record disk packets. If disk packets use other
ways of writing to the guest memory apart from a normal VMExit, I will try
to find it out. Eventually I hope that it will use one of the available
disk front-end functions to write to the guest memory from the disk, just
like e1000 does with an "e1000_mmio_write()" call.

Thanks and best regards,
Arnab







On Thu, May 31, 2018 at 8:44 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > On Wed, May 30, 2018 at 11:19:13PM -0400, Arnabjyoti Kalita wrote:
> > > I am trying to implement a 'minimal' record-replay mechanism for KVM,
> which
> > > is similar to the one existing for TCG via -icount. I am trying to
> record
> > > I/O events only (specifically disk and network events) when KVM does a
> > > VMEXIT. This has led me to the function kvm_cpu_exec where I can
> clearly
> > > see the different ways of handling all of the possible VMExit cases
> (like
> > > PIO, MMIO etc.). To record network packets, I am working with the e1000
> > > hardware device.
> > >
> > > Can I make sure that all of the network I/O, atleast for the e1000
> device
> > > happens through the KVM_EXIT_MMIO case and subsequent use of the
> > > address_space_rw() function ? Do I also need to look at other
> functions as
> > > well ? Also for recording disk activity, can I make sure that looking
> out
> > > for the KVM_EXIT_MMIO and/or KVM_EXIT_PIO cases in the vmexit
> mechanism,
> > > will be enough ?
> > >
> > > Let me know if there are other details that I need to take care of. I
> am
> > > using QEMU 2.11 on a x86-64 CPU and the guest runs a Linux Kernel 4.4
> with
> > > Ubuntu 16.04.
>
> The main icount-based record/replay advantage is that we don't record
> any CPU IO. We record only VM IO (e.g., by using the network filter).
>
> Disk devices may transfer data to CPU using DMA, therefore intercepting
> only VMExit cases will not be enough.
>
> Pavel Dovgalyuk
>
>
