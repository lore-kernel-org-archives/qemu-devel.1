Received: from eggs.gnu.org ([2001:4830:134:3::10]:41424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9Izz-0002o9-Kh
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 18:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9Izy-0005cQ-Ho
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 18:57:39 -0400
Date: Mon, 30 Oct 2017 15:57:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA8pvLNGReghJp0QATbBtC-KCgPqQheKnY=KzDPcjdym3g@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710301444460.7297@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710251623560.574@sstabellini-ThinkPad-X260>
	<CAFEAcA8pvLNGReghJp0QATbBtC-KCgPqQheKnY=KzDPcjdym3g@mail.gmail.com>
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

On Mon, 30 Oct 2017, Peter Maydell wrote:
> On 26 October 2017 at 00:28, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > extended_addresses_enabled calls arm_el_is_aa64, hardcoding exception
> > level 1. Instead, add an additional "el" argument to
> > extended_addresses_enabled.
> >
> > The caller will pass the right value. In most cases, it will be
> > arm_current_el(env). However, arm_debug_excp_handler will
> > use arm_debug_target_el(env), as the target el for a debug trap can be
> > different from the current el.
> >
> > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> I have some longer comments below about what a mess this whole
> area is. Fixing some of that requires some heavy refactoring,
> which I don't want to do just now since we're about to go into
> softfreeze for the next release.
> 
> What's the specific situation/bug that you're trying to fix with
> this patch? You don't say in the commit message.
> We should be able to put in a point fix to deal with whatever it is,
> but it's hard to suggest what that would be without the detail
> of what exactly we're getting wrong. (It's the PAR format stuff,
> right? But which ATS instruction are you using, from which
> exception level, with which register width, for which stage
> 1 page table format and stage 1 guest register width?)

Thank you for understanding, I am not really up for heavy refactoring
in QEMU right now :-)

Yes, I am trying to fix the AT instruction, which is used by Xen for
address translations. Xen always runs at EL2. do_ats_write takes the
wrong path because extended_addresses_enabled assumes EL1.

To go more into details, virt_to_maddr translates a Xen virtual address
into a physical address. Xen implements virt_to_maddr as:

  static inline paddr_t __virt_to_maddr(vaddr_t va)
  {
      uint64_t par = va_to_par(va);
      return (par & PADDR_MASK & PAGE_MASK) | (va & ~PAGE_MASK);
  }

Where va_to_par is:

  #define ATS1HR          p15,4,c7,c8,0   /* Address Translation Stage 1 Hyp. Read */
  static inline uint64_t __va_to_par(vaddr_t va)
  {
      uint64_t par, tmp;
      tmp = READ_CP64(PAR);
      WRITE_CP32(va, ATS1HR);
      isb(); /* Ensure result is available. */
      par = READ_CP64(PAR);
      WRITE_CP64(tmp, PAR);
      return par;
  }

This is what breaks Xen 64-bit booting on qemu-system-aarch64.

For completeness, I'll also point out other uses of ATS instructions in
Xen.

Xen uses the following to translate a guest virtual address into a
physical address (Xen has no saying in the guest pagetable format or
register width):

  #define ATS12NSOPR      p15,0,c7,c8,4   /* Address Translation Stage 1+2 Non-Secure Kernel Read */
  #define ATS12NSOPW      p15,0,c7,c8,5   /* Address Translation Stage 1+2 Non-Secure Kernel Write */
  static inline uint64_t gva_to_ma_par(vaddr_t va, unsigned int flags)
  {
      uint64_t par, tmp;
      tmp = READ_CP64(PAR);
      if ( (flags & GV2M_WRITE) == GV2M_WRITE )
          WRITE_CP32(va, ATS12NSOPW);
      else
          WRITE_CP32(va, ATS12NSOPR);
      isb(); /* Ensure result is available. */
      par = READ_CP64(PAR);
      WRITE_CP64(tmp, PAR);
      return par;
  }

Finally, Xen uses the following to translate guest virtual addresses
into pseudo-physical addresses:

  #define ATS1CPR         p15,0,c7,c8,0   /* Address Translation Stage 1. Non-Secure Kernel Read */
  #define ATS1CPW         p15,0,c7,c8,1   /* Address Translation Stage 1. Non-Secure Kernel Write */
  
  static inline uint64_t gva_to_ipa_par(vaddr_t va, unsigned int flags)
  {
      uint64_t par, tmp;
      tmp = READ_CP64(PAR);
      if ( (flags & GV2M_WRITE) == GV2M_WRITE )
          WRITE_CP32(va, ATS1CPW);
      else
          WRITE_CP32(va, ATS1CPR);
      isb(); /* Ensure result is available. */
      par = READ_CP64(PAR);
      WRITE_CP64(tmp, PAR);
      return par;
  }
