Received: from eggs.gnu.org ([2001:4830:134:3::10]:36582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eOJkZ-0007i1-Qr
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 03:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eOJkU-0000Sb-UO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 03:47:47 -0500
Date: Mon, 11 Dec 2017 15:47:34 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20171211084733.GC26889@toto>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/12] Refactor get_phys_addr() not to
 return FSR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Dec 05, 2017 at 07:46:20PM +0000, Peter Maydell wrote:
> Currently get_phys_addr() and its various subfunctions return a
> hard-coded fault status register value for translation failures. This
> is awkward because FSR values these days may be either long-descriptor
> format or short-descriptor format.  Worse, the right FSR type to use
> doesn't depend only on the translation table being walked -- some
> cases, like fault info reported to AArch32 EL2 for some kinds of ATS
> operation, must be in long-descriptor format even if the translation
> table being walked was short format. We can't get those cases right
> with our current approach. (We put in a bodge fix so we could at
> least run Xen, in commit 50cd71b0d347c7.)
>     
> This series does a refactoring of get_phys_addr() so that instead
> of returning FSR values it puts information in the existing
> ARMMMUFaultInfo structure that is sufficient to construct an
> FSR value, and the callers then do that using the right condition
> for whatever they're doing. I've included Edgar's patch from back
> in June that fixes the handling of ATS instructions, which is most
> of the point of the refactoring.
> 
> Rather than doing it all in one massive unreviewable patch, the
> series is structured as:
>  * patch 1: add fields to ARMMMUFaultInfo, and the utility functions
>    that return a long or short format FSR given a fault info struct
>  * patch 2: stop passing an fsr argument to arm_ld*_ptw(), since
>    nothing actually looks at the result. (This breaks a cycle
>    arm_ldq_ptw()->S1_ptw_translate()->get_phys_addr_lpae()->arm_ldq_ptw()
>    which would otherwise make a stepwise refactoring awkward.)
>  * patches 3 to 8: for each of the different subfunctions of
>    get_phys_addr(), make them fill in the fault info fields instead
>    of an fsr value. Temporarily we add calls to arm_fi_to_sfsc()
>    and arm_fi_to_lfsc() at the callsites in get_phys_addr(), since
>    the callers of get_phys_addr() still need the fsr values. These
>    will go away again in a later patch.
>  * patches 9 and 10: change the callers of get_phys_addr() to use
>    the info in the fault info struct and ignore the fsr value.
>  * patch 11: remove the now unused fsr argument (and the temporary
>    calls to arm_fi_to_sfsc()/arm_fi_to_lfsc())
>  * patch 12: Edgar's patch for ATS PAR format
> 
> Arguably it would be good to push the "create the FSR value"
> logic further, into the point where the exception is taken.
> (This would let us correct the oddity where for M profile we
> get an A/R profile FSR value in arm_v7m_cpu_do_interrupt()
> which we then have to convert into the appropriate M profile
> fault status bits.) However, migration backcompat makes this
> tricky, because at the moment we migrate env->exception.fsr,
> and so we'd need to have code just to handle inbound migrations
> from old QEMU with an FSR and reconstitute a fault info struct.
> So I've stopped here, at least for now.
> 
> This whole series sits on top of my v8M TT patchset (which also
> had to touch some of the get_phys_addr() code). I've pushed it
> to this git branch if that's more convenient:
> 
>  https://git.linaro.org/people/peter.maydell/qemu-arm.git fsr-in-faultinfo
> 
> I have tested a bit (including a Linux KVM EL2 setup), but more
> testing would definitely be useful. Stefano: in particular it would
> be good to check this hasn't broken Xen again :-)
> 
> Based-on: 1512153879-5291-1-git-send-email-peter.maydell@linaro.org
> ([PATCH 0/7] armv8m: Implement TT, and other bugfixes)


Hi Peter,

Thans for working on this, the series looks good to me!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar


> 
> thanks
> -- PMM
> 
> 
> Edgar E. Iglesias (1):
>   target/arm: Extend PAR format determination
> 
> Peter Maydell (11):
>   target/arm: Provide fault type enum and FSR conversion functions
>   target/arm: Remove fsr argument from arm_ld*_ptw()
>   target/arm: Convert get_phys_addr_v5() to not return FSC values
>   target/arm: Convert get_phys_addr_v6() to not return FSC values
>   target/arm: Convert get_phys_addr_lpae() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav5() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav7() to not return FSC values
>   target/arm: Convert get_phys_addr_pmsav8() to not return FSC values
>   target/arm: Use ARMMMUFaultInfo in deliver_fault()
>   target/arm: Ignore fsr from get_phys_addr() in do_ats_write()
>   target/arm: Remove fsr argument from get_phys_addr() and
>     arm_tlb_fill()
> 
>  target/arm/internals.h | 187 +++++++++++++++++++++++++++++++++++++-
>  target/arm/helper.c    | 238 +++++++++++++++++++++++++++----------------------
>  target/arm/op_helper.c |  82 +++++------------
>  3 files changed, 342 insertions(+), 165 deletions(-)
> 
> -- 
> 2.7.4
> 
