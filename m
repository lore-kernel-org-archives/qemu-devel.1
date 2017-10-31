Received: from eggs.gnu.org ([2001:4830:134:3::10]:39533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9a0S-0005NV-KZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9a0R-00053A-Kv
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:07:16 -0400
Date: Tue, 31 Oct 2017 10:07:03 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA9GEpxHtPpe3OSZ5eycLB50i5Q_us8dzOjiUj1HxoFnKA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710311001380.13766@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710251623560.574@sstabellini-ThinkPad-X260>
	<CAFEAcA8pvLNGReghJp0QATbBtC-KCgPqQheKnY=KzDPcjdym3g@mail.gmail.com>
	<alpine.DEB.2.10.1710301444460.7297@sstabellini-ThinkPad-X260>
	<CAFEAcA9GEpxHtPpe3OSZ5eycLB50i5Q_us8dzOjiUj1HxoFnKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Julien Grall <julien.grall@linaro.org>

On Tue, 31 Oct 2017, Peter Maydell wrote:
> On 30 October 2017 at 22:57, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > On Mon, 30 Oct 2017, Peter Maydell wrote:
> >> What's the specific situation/bug that you're trying to fix with
> >> this patch? You don't say in the commit message.
> >> We should be able to put in a point fix to deal with whatever it is,
> >> but it's hard to suggest what that would be without the detail
> >> of what exactly we're getting wrong. (It's the PAR format stuff,
> >> right? But which ATS instruction are you using, from which
> >> exception level, with which register width, for which stage
> >> 1 page table format and stage 1 guest register width?)
> >
> > Thank you for understanding, I am not really up for heavy refactoring
> > in QEMU right now :-)
> >
> > Yes, I am trying to fix the AT instruction, which is used by Xen for
> > address translations. Xen always runs at EL2. do_ats_write takes the
> > wrong path because extended_addresses_enabled assumes EL1.
> >
> > To go more into details, virt_to_maddr translates a Xen virtual address
> > into a physical address. Xen implements virt_to_maddr as:
> >
> >   static inline paddr_t __virt_to_maddr(vaddr_t va)
> >   {
> >       uint64_t par = va_to_par(va);
> >       return (par & PADDR_MASK & PAGE_MASK) | (va & ~PAGE_MASK);
> >   }
> >
> > Where va_to_par is:
> >
> >   #define ATS1HR          p15,4,c7,c8,0   /* Address Translation Stage 1 Hyp. Read */
> >   static inline uint64_t __va_to_par(vaddr_t va)
> >   {
> >       uint64_t par, tmp;
> >       tmp = READ_CP64(PAR);
> >       WRITE_CP32(va, ATS1HR);
> >       isb(); /* Ensure result is available. */
> >       par = READ_CP64(PAR);
> >       WRITE_CP64(tmp, PAR);
> >       return par;
> >   }
> >
> > This is what breaks Xen 64-bit booting on qemu-system-aarch64.
> 
> I'm confused. You say this is 64-bit booting, but the code you quote
> here looks like it's doing 32-bit cp15 accesses, not 64-bit mrs/msr
> sysreg accesses.
> 
> We definitely don't support 32-bit Hyp mode right now.
> 
> Could you please answer all of:
> >> which ATS instruction are you using, from which
> >> exception level, with which register width, for which stage
> >> 1 page table format and stage 1 guest register width?)

Sorry Peter, I copy/pasted the values from arm32/page.h instead of
arm64/page.h in Xen :-/

Xen is running at EL2, 64-bit (aarch64). The ATS instruction is "at
s1e2r", used to translate Xen virtual addresses into physical addresses.
This is what breaks.
