Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOMwg-0006YP-4L
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOMwd-0001HG-2a
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:44:46 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34716)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOMwc-0001E7-Q1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:44:42 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
	<20180531085057.GG26429@stefanha-x1.localdomain>
In-Reply-To: <20180531085057.GG26429@stefanha-x1.localdomain>
Date: Thu, 31 May 2018 15:44:43 +0300
Message-ID: <001801d3f8dd$2629a280$727ce780$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefan Hajnoczi' <stefanha@gmail.com>, 'Arnabjyoti Kalita' <akalita@cs.stonybrook.edu>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> On Wed, May 30, 2018 at 11:19:13PM -0400, Arnabjyoti Kalita wrote:
> > I am trying to implement a 'minimal' record-replay mechanism for KVM, which
> > is similar to the one existing for TCG via -icount. I am trying to record
> > I/O events only (specifically disk and network events) when KVM does a
> > VMEXIT. This has led me to the function kvm_cpu_exec where I can clearly
> > see the different ways of handling all of the possible VMExit cases (like
> > PIO, MMIO etc.). To record network packets, I am working with the e1000
> > hardware device.
> >
> > Can I make sure that all of the network I/O, atleast for the e1000 device
> > happens through the KVM_EXIT_MMIO case and subsequent use of the
> > address_space_rw() function ? Do I also need to look at other functions as
> > well ? Also for recording disk activity, can I make sure that looking out
> > for the KVM_EXIT_MMIO and/or KVM_EXIT_PIO cases in the vmexit mechanism,
> > will be enough ?
> >
> > Let me know if there are other details that I need to take care of. I am
> > using QEMU 2.11 on a x86-64 CPU and the guest runs a Linux Kernel 4.4 with
> > Ubuntu 16.04.

The main icount-based record/replay advantage is that we don't record
any CPU IO. We record only VM IO (e.g., by using the network filter).

Disk devices may transfer data to CPU using DMA, therefore intercepting
only VMExit cases will not be enough.

Pavel Dovgalyuk
