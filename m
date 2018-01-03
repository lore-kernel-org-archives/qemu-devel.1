Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eWrBb-0005sy-LG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eWrBW-00066I-Qe
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eWrBW-00065T-GV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:06:54 -0500
Date: Wed, 3 Jan 2018 22:06:51 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180103220651.GE2787@redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<20180103113544.GI2450@redhat.com>
	<CAHNT7Nvo-O2s6xX7kdh-EDd+TSpKHqHAzpGUS7vcUWJBV2Op3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nvo-O2s6xX7kdh-EDd+TSpKHqHAzpGUS7vcUWJBV2Op3w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Jan 04, 2018 at 10:50:06AM +1300, Michael Clark wrote:
> On Thu, Jan 4, 2018 at 12:35 AM, Richard W.M. Jones <rjones@redhat.com>
> wrote:
> 
> > Just a few small points:
> >
> > (1) I've built Fedora RPMs from this patch set [approximately - I'm
> > using a very slightly different / slightly older version, but it's not
> > substantively different]:
> >
> >   http://copr-fe.cloud.fedoraproject.org/coprs/rjones/riscv/
> >
> > It works well for me building plenty of Fedora packages over the past
> > few weeks, except for a possible Linux kernel bug which interacts with
> > the patch set not handling EBREAK correctly, which I had to patch
> > around (in the kernel):
> >
> >   https://groups.google.com/a/groups.riscv.org/forum/#!msg/
> > sw-dev/v05FjcGC1EI/atXXUAcsCgAJ
> 
> 
> Do you have any evidence that the RISC-V QEMU port is not handling ebreak
> correctly? I've reviewed the code and looked at your kernel oops and QEMU
> appears to be correctly trapping with a breapoint exception. At this point
> I think the issue is a riscv linux-kernel bug until we have any evidence to
> the contrary. I suspect from your ooops message that you are encountering
> an ebreak in kernel code given mepc contained a kernel address.

Yes, this is all correct and it definitely indicates a kernel bug.

However what I'm missing is what is supposed to happen when the kernel
executes EBREAK?  Currently the Linux kernel panic/BUG functions do
this, so shouldn't the hypervisor do something other than print a
debug message, eg.  abort(), fire the watchdog, or provide a way to
breakpoint in an attached gdb (if using qemu -s)?

  https://github.com/riscv/riscv-linux/blob/464e1d5f23cca236b930ef068c328a64cab78fb1/arch/riscv/include/asm/bug.h#L51

> GCC 7.x now inserts ebreaks in certain conditions i.e. if there is a
> null dereference that should not be reached.

That too.

> There is an erroneous fprintf that should perhaps be removed, as the debug
> mode support is not required to handle breakpoint exceptions.
> 
> -
> https://github.com/riscv/riscv-qemu/blob/qemu-upstream-v1/target/riscv/helper.c#L394-L396
> 
> Debug mode in the fprintf is referring to JTAG debug as specified in the
> Draft RISC-V External Debug Support specification. We don't intend to
> implement JTAG debug emulation in RISC-V QEMU any time soon, so ebreak
> should just trap and the printf can be removed. We could potentially add
> trace support for exceptions. The RISC-V support doesn't yet implement any
> tracing hooks. I've been trying to adjust stray printf's to use
> error_report but this is one I missed. I would like to add trace support
> for interrupts and exceptions which would be more generally useful.

>From my point of view it'd be helpful if the debug message was
retained and printed the PC, at least in the interim.  This makes it
easy to find out where the kernel is BUG-ing.  In fact I've patched
Fedora's riscv-qemu to do that.

> (2) I'm worried that this patch starts off using virtio-mmio instead
> > of virtio-pci.  virtio-pci is better in every respect than
> > virtio-mmio, and while it may be a good interim solution I think we
> > need to have a plan to get rid of it eventually, and should make it
> > clear that virtio-mmio is not a permanent ABI so we don't get into the
> > same situation that we did with -M virt on ARM.
> >
> 
> I've noted in [PATCH v1 00/00] that we have a goal to add GPEX to the
> SiFive RISC-V virt board. The idea with the initial version of the virt
> board is to provide enough infrastructure so that distro builders can use
> RISC-V QEMU. Prior to the work to implement PLIC, device-tree and VirtIO,
> there was no network and block device support so it was not possible to use
> QEMU for distro bring up. Now RISC-V QEMU is usable. Data point: the arm
> 'virt' board still supports VirtIO MMIO. I don't think this should be a
> blocking issue.

I don't think it should be blocking either, but I also think (from
experience with ARM mach_virt) that we should make it clear that we're
going to have a flag day down the road where we just remove
virtio-mmio and everyone will be required to recompile their kernel,
rather than keep supporting virtio-mmio long term.  However that's
just my opinion, would like to hear what others say.

> I've looked at device support in other ports and it seems
> unreasonable to set such a high bar for inclusion of a port. We would, as
> mentioned in [PATCH v1 00/00], like to shift our development focus to
> upstream QEMU versus maintaining an out-of-tree port so I don't think some
> as yet unsupported feature should be a barrier to inclusion. We also don't
> /yet/ support live migration. We currently only support 8 CPUs due to a
> hardcoded limit in BBL. There is also RISC-V FPGA Soft Core IP that uses
> the XILINX PCIe controller, and given that we have a goal to maintain
> compatibility with Soft Core IP, there may be RISC-V machines that use the
> XILINX PCIe controller.

BTW does SMP work with this patch set?  I tried an earlier patch that
you added and then removed
(https://github.com/riscv/riscv-qemu/commit/65a2c40fe07eaa04c8f5a030623c7d181093065c)
but the kernel hung in the middle of the boot.  I might have been
missing kernel changes that are needed however (beyond CONFIG_SMP=y).

> You can be certain that we are aware of the benefits of VirtIO PCI.
> 
> If PCI is a blocking issue we can remove the 'virt' machine from the
> patchset. It's not necessary for the RISC-V port to be usable. i.e. we can
> maintain it in the riscv.org tree.
> 
> (3) poweroff doesn't work if you use -M virt (and hence don't use
> > HTIF).  I wrote a dummy poweroff device to get around this, but I
> > think it could raise a bigger point: Why bother to support HTIF
> > machine types at all?  The reason given in the patch set is because
> > spike (the cycle-accurate RISC-V emulator) only supports HTIF but
> > is that a good reason?
> >
> 
> Spike (aka 'riscv-isa-sim') is not a cycle-accurate simulator. It's the
> RISC-V "golden reference" ISA simulator. i.e. is the canonical behavioural
> simulator for the RISC-V ISA.
> 
> We are going to support HTIF on the Spike machines and this patch set is
> consistent with that policy. Currently HTIF is the only IO mechanism
> supported by Spike. It is our goal to maintain Spike compatible machines.
> This is important for binary compatibility and verification reasons that we
> can emulate 'riscv-isa-sim'. HTIF is not appropriate for the other machines
> for reasons already discussed on the RISC-V Software Development mailing
> list however HTIF will be maintained and supported while it remains the
> only supported IO mechanism on Spike. If it was removed, we would need to
> remove the Spike machines which would be quite unfortunate.
> 
> The plan for power off and reset is to implement SiFive's AON/PRCI block
> (Always On / Power, Reset, Interrupt). We may indeed rename 'virt' to
> 'sifive_virt' to avoid any comparisons with the arm 'virt' machine. The
> SiFive 'virt' machine is derived from SiFive's Freedom U500 machine and
> implements the SiFive CLINT (Core Local Interruptor) and PLIC (Platform
> Level Interrupt Controller). It's device-tree is unique to the device-tree
> used by SiFive's hardware.
> 
> If HTIF is a blocking issue we can remove the 'spike' machines from the
> patchset. It's not necessary for the RISC-V port to be usable. i.e. we can
> maintain it in the riscv.org tree.
> 
> The sooner we can get through patch review for the bulk of the port, the
> sooner we can shift our attention to future development. i.e. AON/PRCI for
> power off and reset and GPEX for virtio-pci.
> 
> There is already ~14,000 LOC for review so I don't think deferring
> inclusion based on as yet undeveloped features is a very good rationale.
> RISC-V has not been around for 30+ years so comparison to arm features at
> this point is a little bit unfair. EM_MOXIE 223 and EM_RISCV 243 are
> perhaps more fair comparisons, although moxie is already in QEMU.

Sure, agreed.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
