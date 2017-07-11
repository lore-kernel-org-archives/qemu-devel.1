Received: from eggs.gnu.org ([2001:4830:134:3::10]:52492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dUs1F-0004nM-8A
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dUs1B-0003xv-8f
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:03:49 -0400
Date: Tue, 11 Jul 2017 12:03:34 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170711100334.GA25504@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Jul 10, 2017 at 04:11:29PM +0100, Peter Maydell wrote:
> On 30 June 2017 at 14:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Extend PAR format determination to handle more cases.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  target/arm/helper.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index fd1027e..6a1fffe 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -2345,12 +2345,40 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
> >      uint32_t fsr;
> >      bool ret;
> >      uint64_t par64;
> > +    bool format64 = false;
> >      MemTxAttrs attrs = {};
> >      ARMMMUFaultInfo fi = {};
> >
> >      ret = get_phys_addr(env, value, access_type, mmu_idx,
> >                          &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
> > -    if (extended_addresses_enabled(env)) {
> > +
> > +    if (is_a64(env)) {
> > +        format64 = true;
> > +    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
> > +        /*
> > +         * ATS1Cxx:
> > +         * * TTBCR.EAE determines whether the result is returned using the
> > +         *   32-bit or the 64-bit PAR format
> > +         * * Instructions executed in Hyp mode always use the 64bit format
> > +         *
> > +         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
> > +         * * The Non-secure TTBCR.EAE bit is set to 1
> > +         * * The implementation includes EL2, and the value of HCR.VM is 1
> > +         *
> > +         * ATS1Hx always uses the 64bit format (not supported yet).
> > +         */
> > +        format64 = regime_using_lpae_format(env, mmu_idx);
> > +
> > +        if (arm_feature(env, ARM_FEATURE_EL2)) {
> > +            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> > +                format64 |= env->cp15.hcr_el2 & HCR_VM;
> > +            } else {
> > +                format64 |= arm_current_el(env) == 2;
> > +            }
> > +        }
> > +    }
> 
> So this kind of worries me, because what it's coded as is "determine
> whether architecturally we should be returning a 64-bit or 32-bit
> PAR format", but what the code below it uses the format64 flag for is
> "manipulate whatever PAR we got handed back by get_phys_addr()".
> So we have two separate bits of code that are both choosing
> 32 vs 64 bit PAR (the code in this patch, and the logic inside
> get_phys_addr()), and they have to come to the same conclusion
> or we'll silently mangle the PAR. It seems like it would be
> better to either have get_phys_addr() explicitly tell us what kind
> of format it is returning to us, or to have the caller tell it
> what kind of PAR it needs.

Yes, I see your point and that's exactly what's happenning before the patch.
Some of these new checks are generic in the sense that they check for LPAE/64bitness
but others are I guess ATS specific for lack of a better term.
It feels a bit weird to put the ATS specific PAR format logic into get_phys_addr.

The basic idea here is that we never downgrade to the 32bit format, we only uprgade.
The following line was meant to get the initial format I think you are requesting:
format64 = regime_using_lpae_format(env, mmu_idx);

After that, we apply possible ATS specfic upgrades to 64bit PAR format if needed.

For clarity, perhaps we could make get_phys_addr return this same initial format, and then
we can follow up with the ATS specific upgrades. E.g:

    ret = get_phys_addr(env, value, access_type, mmu_idx,
                        &phys_addr, &attrs, &prot, &page_size, &fsr, &fi,
                        &format64);

    /* Apply possible ATS/PAR 64bit upgrades if format64 is false.  */
    if (is_a64(env)) {
        format64 = true;
    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
        if (arm_feature(env, ARM_FEATURE_EL2)) {
            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
                format64 |= env->cp15.hcr_el2 & HCR_VM;
            } else {
                format64 |= arm_current_el(env) == 2;
            }
        }
    }


Does something like that sound OK?

Cheers,
Edgar


> >      ret = get_phys_addr(env, value, access_type, mmu_idx,
> >                          &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
> > -    if (extended_addresses_enabled(env)) {
> > +
> > +    if (is_a64(env)) {
> > +        format64 = true;
> > +    } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
> > +        /*
> > +         * ATS1Cxx:
> > +         * * TTBCR.EAE determines whether the result is returned using the
> > +         *   32-bit or the 64-bit PAR format
> > +         * * Instructions executed in Hyp mode always use the 64bit format
> > +         *
> > +         * ATS1S2NSOxx uses the 64bit format if any of the following is true:
> > +         * * The Non-secure TTBCR.EAE bit is set to 1
> > +         * * The implementation includes EL2, and the value of HCR.VM is 1
> > +         *
> > +         * ATS1Hx always uses the 64bit format (not supported yet).
> > +         */
> > +        format64 = regime_using_lpae_format(env, mmu_idx);
> > +
> > +        if (arm_feature(env, ARM_FEATURE_EL2)) {
> > +            if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
> > +                format64 |= env->cp15.hcr_el2 & HCR_VM;
> > +            } else {
> > +                format64 |= arm_current_el(env) == 2;
> > +            }
>

> 
> PS: on the subject of virtualization, I notice there's a comment
> a bit later on in do_ats_write() that says
>     /* Note that S2WLK and FSTAGE are always zero, because we don't
>      * implement virtualization and therefore there can't be a stage 2
>      * fault.
>      */
> so we'll need to address that too at some point...
> 
> thanks
> -- PMM
