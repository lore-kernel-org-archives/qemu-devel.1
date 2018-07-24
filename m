Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1fi4mA-0008Ha-9w
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevlough@umich.edu>) id 1fi4m7-0002W4-02
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:23:22 -0400
MIME-Version: 1.0
References: <CAB30WPccergMTSWWrwj-WhTCcaMvvW7vnAMO3qvy9b9B53N=zA@mail.gmail.com>
	<CAFEAcA8v762p3JSQ=9Vu68-evYS5MMH467pAo8=XZWsw+x6s7Q@mail.gmail.com>
	<CAB30WPfKKesSfvyEx9ZpSUQShnXJnH1YCXgZgp0OoY888r0K4w@mail.gmail.com>
	<CAFEAcA-_ZiPNz7tyQy2otZ6z9rT8wszhRxBZrmNXTr9AFaBzqg@mail.gmail.com>
In-Reply-To: <CAFEAcA-_ZiPNz7tyQy2otZ6z9rT8wszhRxBZrmNXTr9AFaBzqg@mail.gmail.com>
From: Kevin Loughlin <kevlough@umich.edu>
Date: Tue, 24 Jul 2018 17:23:01 -0400
Message-ID: <CAB30WPeBwR2EK_pNssyH0od0UQb9sj-jgx4rs5pR7UQ=pGM6VA@mail.gmail.com>
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

Thanks! That was super helpful.

To confirm, support for IOMMU regions in the CPU's memory access path did
NOT exist prior to recent releases, correct? My QEMU version is 2.11, and I
believe you're up to 3.0 now. If that's the case, I may stick with the
"changing priorities" approach, since I know you've also updated the virt
board and refactored the system bus code since I branched. Additionally,
you correctly pointed out that I simply want to map a huge chunk of memory
in and out at once. However, the IOMMU solution does have the benefit of a
more realistic approach than changing the priorities.

On Wed, Jul 18, 2018 at 1:58 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 18 July 2018 at 02:34, Kevin Loughlin <kevlough@umich.edu> wrote:
> > Under my setup, the CPU's MMU translates from VAs to IPAs, and an
> external
> > memory controller then intercepts all memory transactions and translates
> > these IPAs to true PAs. This allows the memory controller to enforce
> > physical isolation of environments, and does not expose true PAs to the
> > CPU/system software.
>
> Ah, right, "external custom memory controller" makes sense.
>
> > My question is how best to emulate the memory controller given this
> desired
> > setup. I have three primary ideas, and I would love to get feedback on
> their
> > feasibility.
> >
> > Implement the controller as an IOMMU region. I would be responsible for
> > writing the controller's operations to shift and forward the target
> address
> > to the appropriate subregion. Would it be possible to trigger the IOMMU
> > region on every access to system_memory? For example, even during QEMU's
> > loading process? Or would I only be able to trigger the IOMMU operations
> on
> > access to the subregions that represent my environments? My
> understanding of
> > the IOMMU regions is shaky. Nonetheless, this sounds like the most
> promising
> > approach, assuming I can provide the shifting and forwarding operations
> and
> > hide the PAs from the CPU's TLB as desired.
>
> I would probably go with implementing it as an IOMMU region. We recently
> added code to QEMU that allows you to put IOMMUs in the CPU's
> memory-access path, so this works now. The example we have of
> that at the moment is hw/misc/tz-mpc.c (which is a simple device
> which configurably controls access to the thing "downstream" of it
> based on a lookup table and whether the access is S or NS).
>
> As you've guessed, the way the IOMMU stuff works is that it gates
> access to the things sat behind it: the device has a MemoryRegion
> "upstream" which it exposes to the code which creates it, and a
> MemoryRegion property "downstream". The creating code (ie the board)
> passes in whatever the "downstream" is (likely a container MemoryRegion
> with RAM and so on), and maps the "upstream" end into the address
> space that the CPU sees. (You would probably have one downstream
> for each separate subregion). You could either have the IOMMU
> only "in front" of one part of the overall address space, or
> in front of the whole of the address space, as you liked.
> (Assuming you have some kind of "control register" memory mapped
> interface for programming it, it can't be behind itself; that
> would be "an interesting topological exercise", to quote nethack.)
>
> What the CPU sees is whatever is in the MemoryRegion passed to it
> via
>         object_property_set_link(cpuobj, ..., "memory",
>                                  &error_abort);
>
> The virt board happens to currently use get_system_memory()
> for that, but you can use a custom container MemoryRegion if you
> like.
>
> > Go into the target/arm code, find every instance of accesses to address
> > spaces, and shift the target physical address accordingly. This seems
> ugly
> > and unlikely to work.
>
> That's very fragile, and I don't recommend it.
>
> > Use overlapping subregions with differing priorities, as in done in
> QEMU's
> > TrustZone implementation. However, these priorities would have to change
> on
> > an environment context switch, and I don't know if that would lead to
> chaos.
>
> You can model things this way too, yes (both by changing priorities, and by
> simply enabling/disabling/mapping/unmapping memory regions). The main
> advantage that using IOMMU regions gets you are:
>  * you can do things at a finer granularity, say changing
>    permissions at a page-by-page level, without creating a
>    ton of MemoryRegion objects. Swapping MRs in and out would
>    work if you only wanted to do it for big chunks of space at once
>  * you can make the choice of what to do based on the memory
>    transaction attributes (eg secure/nonsecure, user/privileged)
>    rather than having to provide a single mapping only
> If you really do only want to map 4G of RAM in and out at once,
> this might be simpler.
>
> Note that for both the IOMMU approach and the MemoryRegion map/unmap
> approach, changing the mapping will blow away the emulated CPU's
> cached TLB entirely. So if you do it very often you'll see a
> performance hit. (In the IOMMU case it might in theory be possible
> to get some of that performance back by being cleverer in the core
> memory subsystem code so as to only drop the bits of the TLB that
> are affected; but if you're remapping all-of-RAM then that probably
> covers all the interesting cached TLB entries anyhow.)
>
> thanks
> -- PMM
>
