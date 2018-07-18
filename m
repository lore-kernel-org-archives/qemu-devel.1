Received: from eggs.gnu.org ([2001:4830:134:3::10]:49248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1ffbMY-000719-TO
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 21:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1ffbMV-0005h1-Nh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 21:34:42 -0400
MIME-Version: 1.0
References: <CAB30WPccergMTSWWrwj-WhTCcaMvvW7vnAMO3qvy9b9B53N=zA@mail.gmail.com>
	<CAFEAcA8v762p3JSQ=9Vu68-evYS5MMH467pAo8=XZWsw+x6s7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8v762p3JSQ=9Vu68-evYS5MMH467pAo8=XZWsw+x6s7Q@mail.gmail.com>
From: Kevin Loughlin <kevlough@umich.edu>
Date: Tue, 17 Jul 2018 21:34:18 -0400
Message-ID: <CAB30WPfKKesSfvyEx9ZpSUQShnXJnH1YCXgZgp0OoY888r0K4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Native Memory Virtualization in qemu-system-aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-discuss@nongnu.org, "Mickens, James" <mickens@g.harvard.edu>

I am indeed attempting to implement a non-standard extension to the ARMv8
architecture for experimental purposes. My high-level goal for the
extension is to completely isolate *N* execution environments (for example,
I even prohibit inter-environment communication) using purely HW-based
isolation mechanisms (i.e. no monitor software to help enforce/configure
isolation).

As part of my design, I want to take a single set of physical memory
hardware (e.g., RAM chips, MMUs, etc.) and

   1. partition the resources *N* ways, creating *N* views of the available
   physical resources, and then
   2. be able to dynamically switch the current view that is "active,"
   i.e., visible to the CPU and other devices

Under my setup, the CPU's MMU translates from VAs to IPAs, and an external
memory controller then intercepts all memory transactions and translates
these IPAs to true PAs. This allows the memory controller to enforce
physical isolation of environments, and does not expose true PAs to the
CPU/system software.

The CPU object would initialize and store an AddressSpace object for each
environment in its field "cpu_ases." Additionally, each environment's
memory map would follow identical offsets. That is, if RAM/flash/etc starts
at offset X in one environment, it will start at offset X in the other as
well. Therefore, my controller only ever needs to perform IPA-to-PA
translations via a simple, hard-wired base+bounds policy that is based on
the active environment.

My question is how best to emulate the memory controller given this desired
setup. I have three primary ideas, and I would love to get feedback on
their feasibility.

   1. Implement the controller as an IOMMU region. I would be responsible
   for writing the controller's operations to shift and forward the target
   address to the appropriate subregion. Would it be possible to trigger
   the IOMMU region on every access to system_memory? For example, even during
   QEMU's loading process? Or would I only be able to trigger the IOMMU
   operations on access to the subregions that represent my environments? My
   understanding of the IOMMU regions is shaky. Nonetheless, this sounds
   like the most promising approach, assuming I can provide the shifting and
   forwarding operations and hide the PAs from the CPU's TLB as desired.

   2. Go into the target/arm code, find every instance of accesses to
   address spaces, and shift the target physical address accordingly. This
   seems ugly and unlikely to work.

   3. Use overlapping subregions with differing priorities, as in done in
   QEMU's TrustZone implementation. However, these priorities would have to
   change on an environment context switch, and I don't know if that would
   lead to chaos.


Thanks,

Kevin

P.S. Note that my virtualization actually occurs *beneath* the TrustZone
layer. While creating "nested" TrustZones within each of my partitions is
theoretically possible, it's not an explicit goal of my design. Naturally,
I do use some isolation techniques similar to those deployed in TrustZone,
but ultimately my extension is designed for different purposes than
TrustZone.

On Fri, Jul 13, 2018 at 11:22 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 12 July 2018 at 17:48, Kevin Loughlin <kevlough@umich.edu> wrote:
> > I know TrustZone has support for memory virtualization in AArch64, but
> I'm
> > looking to create a different model. Namely, I'd like to fully virtualize
> > the memory map for the "virt" board.
> >
> > As a basic example of what I want, assuming an execution environment that
> > runs in a 1GB physical address space (0x0 - 0x3FFFFFFF), I'd like to be
> > able to switch to a second execution environment with a distinct SW stack
> > that runs in the second GB of a board memory (0x40000000 - 0x7FFFFFFF).
> The
> > key points for my desired memory virtualization are the following...
> >
> >    1. Both of these environments should have distinct virtual address
> spaces
> >    2. The OS in each environment should believe it is running on physical
> >    addresses 0x0 - 0x3FFFFFFF in both cases.
> >    3. Neither environment should have access to the physical memory state
> >    of the other
> >
> > I initialize distinct AddressSpace and MemoryRegion structures for each
> of
> > these GB blocks. Because all I want is a simple shift of physical address
> > for one environment, I hesitate to mirror the (relatively) complex
> address
> > translation process for TrustZone. Does anyone know if it would be better
> > to either (a) provide custom read/write functions for the shifted
> > MemoryRegion object, or (b) modify the target/arm code, such as adding a
> > shift to get_phys_addr() in target/arm/helper.c?
>
> I'm a bit confused about what you're trying to do. Without TrustZone,
> by definition there is only one physical address space (ie all of
> memory/devices/etc are addressed by a single 64-bit physaddr).
> There's no way to cause the CPU to not have access to it.
> With TrustZone, you can think of the system as having two physical
> address spaces (so to access something you need to specify both
> a 64-bit physaddr and the TZ secure/nonsecure bit), and the CPU
> and the system design cooperate to enforce that code running in the
> nonsecure world can't get at things in the system it should not have
> access to.
>
> The whole point of TZ is to allow you to do this sort of partitioning.
> Without it there's no way for the system (RAM or whatever) to know which
> environment is running on the CPU.
>
> You could in theory design and implement a non-standard extension to
> the architecture to do equivalent things to what TZ is doing I suppose,
> but that would be a lot of work and a lot of fragile modifications
> to QEMU.
>
> thanks
> -- PMM
>
