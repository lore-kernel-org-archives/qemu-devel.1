Received: from eggs.gnu.org ([2001:4830:134:3::10]:34886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fptc4-0001fN-CE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fptbz-0000AP-5g
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 07:05:16 -0400
Date: Wed, 15 Aug 2018 13:04:34 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180815110434.z7skzr6riz3dmnan@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/10] target/arm: Some pieces of support
 for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

On Tue, Aug 14, 2018 at 01:42:44PM +0100, Peter Maydell wrote:
> Now we have virtualization support in the GICv2 emulation,
> I thought I'd have a look at how much we were still missing
> for being able to enable EL2 support for AArch32.
> This set of patches fixes some minor missing pieces:
>  * various small bugs in cp15 registers or places where
>    we were missing the 32-bit version of a 64-bit register
>  * a bugfix for MSR/MRS (banked), which were not allowing
>    Hyp mode to access ELR_Hyp
>  * implementation of the ERET instruction for A32/T32
>  * support for taking exceptions to Hyp mode (the largest
>    of these missing bits)
> 
> This isn't complete, but I thought I'd push these patches
> out for review. My test setup is that I have another
> couple of patches, one which fixes up hw/arm/boot.c to
> boot AArch32 kernels in Hyp mode if it exists, and one
> which sets ARM_FEATURE_EL2 on our A15 model. With those I
> can get an outer kernel to boot with KVM support and try
> to run an inner guest kernel. The inner kernel boots OK
> but gets random segfaults in its userspace -- I haven't
> tracked down why this is yet...

Cool! :-)

> 
> Some bits that are definitely missing:
>  * ATS1HR, ATS1HW address translation ops
>  * I need to check that the trap semantics for AArch32
>    regs line up with their AArch64 counterparts
> 
> I also noticed that we fail to implement really quite a lot
> of the HCR_EL2 trap semantics for either AArch64 or AArch32,
> to the extent that I'm surprised that nested guests work
> under AArch64 :-)

Yes, we've have an entry for a while in our TODO list to improve
HCR trapping but haven't gotten around to it. IIRC, at the time
when we where bringing the EL2 stuff up, quite little was actually
being used by KVM/Xen.

Cheers,
Edgar



> 
> This patchset is based on top of my target-arm.for-3.1
> branch.
> 
> thanks
> -- PMM
> 
> Peter Maydell (10):
>   target/arm: Correct typo in HAMAIR1 regdef name
>   target/arm: Add missing .cp = 15 to HMAIR1 and HAMAIR1 regdefs
>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HVBAR
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Implement AArch32 Hyp FARs
>   target/arm: Implement ESR_EL2/HSR for AArch32 and no-EL2
>   target/arm: Permit accesses to ELR_Hyp from Hyp mode via MSR/MRS
>     (banked)
>   target/arm: Implement AArch32 ERET instruction
>   target/arm: Implement support for taking exceptions to Hyp mode
> 
>  target/arm/helper.c    | 226 ++++++++++++++++++++++++++++++++++-------
>  target/arm/op_helper.c |  22 ++--
>  target/arm/translate.c |  41 +++++++-
>  3 files changed, 236 insertions(+), 53 deletions(-)
> 
> -- 
> 2.18.0
> 
