Received: from eggs.gnu.org ([2001:4830:134:3::10]:34175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4UK9-0003FY-Vl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4UK4-0002Xe-1q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:02:34 -0400
Date: Tue, 17 Oct 2017 12:02:06 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20171017160206.GA22177@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-8-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_1J2xZpnv9dNBeSH5ZvMvBujp3XHPK1SfypjFMU1OBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_1J2xZpnv9dNBeSH5ZvMvBujp3XHPK1SfypjFMU1OBSg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 15:19, Peter Maydell wrote:
> On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > Also modify it to be stored as a uint64_t
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.h    |  2 +-
> >  target/arm/helper.c | 27 ++++++++++++++++++++++++---
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 811b1fe..365a809 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -325,7 +325,7 @@ typedef struct CPUARMState {
> >          uint32_t c9_data;
> >          uint64_t c9_pmcr; /* performance monitor control register */
> >          uint64_t c9_pmcnten; /* perf monitor counter enables */
> > -        uint32_t c9_pmovsr; /* perf monitor overflow status */
> > +        uint64_t c9_pmovsr; /* perf monitor overflow status */
> 
> This is a bug fix, so it should go in its own patch. Specifically,
> we already have an AArch64 sysreg PMOVSCLR_EL0 which has
>       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> so we should have made the CPUARMState field 64 bits when we
> added it. (I think without this bugfix reads of the AArch64
> reg will return data from the adjoining field in the struct.)

Okay, I'll split it off in v3.

> 
> >          uint32_t c9_pmuserenr; /* perf monitor user enable */
> >          uint64_t c9_pmselr; /* perf monitor counter selection register */
> >          uint64_t c9_pminten; /* perf monitor interrupt enables */
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 74e90c5..3932ac0 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -1150,9 +1150,17 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >  static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                           uint64_t value)
> >  {
> > +    value &= PMU_COUNTER_MASK(env);
> >      env->cp15.c9_pmovsr &= ~value;
> >  }
> >
> > +static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                         uint64_t value)
> > +{
> > +    value &= PMU_COUNTER_MASK(env);
> > +    env->cp15.c9_pmovsr |= value;
> > +}
> > +
> >  static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                               uint64_t value)
> >  {
> > @@ -1317,10 +1325,10 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
> >        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
> >        .writefn = pmcntenclr_write },
> >      { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
> > -      .access = PL0_RW, .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> > -      .accessfn = pmreg_access,
> > +      .access = PL0_RW, .accessfn = pmreg_access,
> > +      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> 
> Is this just reshuffling the order of .field initializers?

Also updated offsetof -> offsetoflow32. IIRC, I shuffled the order to
match that of the surrounding registers and to appease my sense of
order. Would you prefer that I don't shuffle them, or split that off as
a separate patch?

> >        .writefn = pmovsr_write,
> > -      .raw_writefn = raw_write },
> > +      .raw_writefn = raw_write, .resetvalue = 0 },
> 
> .resetvalue 0 is the default, but it doesn't hurt to specify it
> explicitly I guess.
> 
> >      { .name = "PMOVSCLR_EL0", .state = ARM_CP_STATE_AA64,
> >        .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 3,
> >        .access = PL0_RW, .accessfn = pmreg_access,
> > @@ -1328,6 +1336,19 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
> >        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> >        .writefn = pmovsr_write,
> >        .raw_writefn = raw_write },
> > +    { .name = "PMOVSSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 3,
> > +      .access = PL0_RW, .accessfn = pmreg_access,
> > +      .type = ARM_CP_ALIAS,
> > +      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> > +      .writefn = pmovsset_write,
> > +      .raw_writefn = raw_write },
> > +    { .name = "PMOVSSET_EL0", .state = ARM_CP_STATE_AA64,
> > +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 14, .opc2 = 3,
> > +      .access = PL0_RW, .accessfn = pmreg_access,
> > +      .type = ARM_CP_ALIAS,
> > +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
> > +      .writefn = pmovsset_write,
> > +      .raw_writefn = raw_write },
> 
> You can implement these using a single STATE_BOTH regdef, I think.
> Also, there's a standard order for the fields which goes
> .cp .opc0 .opc1 .crn .crm .opc2
> (you can often omit the .cp as the default is 15).
> 
> We need to be a bit careful here, because the AArch32 PMMOVSET
> register isn't implemented in ARMv7 until v7VE. So we need to
> put the regdef somewhere else...

Hmmm, what does it need to be protected by? I assume ARM_FEATURE_V8 ||
(ARM_FEATURE_V7 && something), but I'm not familiar enough with v7 that
it's immediately obvious from looking around what 'something' is.

-Aaron

> 
> 
> thanks
> -- PMM

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
