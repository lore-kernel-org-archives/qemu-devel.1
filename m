Received: from eggs.gnu.org ([2001:4830:134:3::10]:39679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOcea-0006jA-HK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOceX-0001oU-8g
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:31:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33594)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fOceW-0001g5-QX
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 01:31:05 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAJGDS+HNBG6PSvG7Cc7bN4rMadgm5W+1aQUAeizN9CGjSOCP5w@mail.gmail.com>
	<20180531085057.GG26429@stefanha-x1.localdomain>
	<001801d3f8dd$2629a280$727ce780$@ru>
	<CAJGDS+GEg0kpS_gxCupSz=O6RA8w-uAhO3rypAM524Z_RUHM8Q@mail.gmail.com>
In-Reply-To: <CAJGDS+GEg0kpS_gxCupSz=O6RA8w-uAhO3rypAM524Z_RUHM8Q@mail.gmail.com>
Date: Fri, 1 Jun 2018 08:31:08 +0300
Message-ID: <001e01d3f969$be4f32a0$3aed97e0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Arnabjyoti Kalita' <akalita@cs.stonybrook.edu>
Cc: 'Stefan Hajnoczi' <stefanha@gmail.com>, qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

Hi,

=20

I=E2=80=99m not familiar with KVM, but I know successful attempts of =
replaying the execution by logging IO and MMIO in TCG mode.

The difference in CPU I/O and VM I/O is the following. In icount we =
record anything coming into the VM, but not into the CPU.

It means that the whole packet is recorded. Virtual hardware behaves =
deterministically and therefore CPU will get identical

input in case of replay, because the whole recorded packet is injected =
again by the filter.

=20

Pavel Dovgalyuk

=20

From: Arnabjyoti Kalita [mailto:akalita@cs.stonybrook.edu]=20
Sent: Thursday, May 31, 2018 11:14 PM
To: Pavel Dovgalyuk
Cc: Stefan Hajnoczi; qemu-devel@nongnu.org; Pavel Dovgalyuk
Subject: Re: [Qemu-devel] Recording I/O activity after KVM does a VMEXIT

=20

Dear Pavel,

=20

Thank you for your answer. I am not being able to understand the =
difference between CPU I/Os and VM I/Os. Would any network packet that =
comes into the Guest OS from the outside be a part of VM I/O or CPU I/O =
? I am only interested in "recording" and "replaying" those network =
packets that come from the outside into the networking backend and not =
the other way around. Say for example when I get a VMExit because of the =
arrival of a network packet, I will use the VMExit reason : =
"KVM_EXIT_MMIO"  to trace back to "e1000_mmio_write()" which I expect =
should be enough to record network packets that come from the outside =
and write to the guest address space for "e1000" devices. In such a =
case, I think I will not have to use the "network-filter" backend that =
you use to record VM I/O only. Let me know if you find errors in my =
approach.

=20

I will try to see how I can record disk packets. If disk packets use =
other ways of writing to the guest memory apart from a normal VMExit, I =
will try to find it out. Eventually I hope that it will use one of the =
available disk front-end functions to write to the guest memory from the =
disk, just like e1000 does with an "e1000_mmio_write()" call.=20

=20

Thanks and best regards,

Arnab

=20

=20

=20

=20

=20

   =20

=20

On Thu, May 31, 2018 at 8:44 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:

> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> On Wed, May 30, 2018 at 11:19:13PM -0400, Arnabjyoti Kalita wrote:
> > I am trying to implement a 'minimal' record-replay mechanism for =
KVM, which
> > is similar to the one existing for TCG via -icount. I am trying to =
record
> > I/O events only (specifically disk and network events) when KVM does =
a
> > VMEXIT. This has led me to the function kvm_cpu_exec where I can =
clearly
> > see the different ways of handling all of the possible VMExit cases =
(like
> > PIO, MMIO etc.). To record network packets, I am working with the =
e1000
> > hardware device.
> >
> > Can I make sure that all of the network I/O, atleast for the e1000 =
device
> > happens through the KVM_EXIT_MMIO case and subsequent use of the
> > address_space_rw() function ? Do I also need to look at other =
functions as
> > well ? Also for recording disk activity, can I make sure that =
looking out
> > for the KVM_EXIT_MMIO and/or KVM_EXIT_PIO cases in the vmexit =
mechanism,
> > will be enough ?
> >
> > Let me know if there are other details that I need to take care of. =
I am
> > using QEMU 2.11 on a x86-64 CPU and the guest runs a Linux Kernel =
4.4 with
> > Ubuntu 16.04.

The main icount-based record/replay advantage is that we don't record
any CPU IO. We record only VM IO (e.g., by using the network filter).

Disk devices may transfer data to CPU using DMA, therefore intercepting
only VMExit cases will not be enough.

Pavel Dovgalyuk

=20
