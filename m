Received: from eggs.gnu.org ([209.51.188.92]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr1BW-0006Nx-BD
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr1BU-0007Z9-UY
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:54:46 -0500
MIME-Version: 1.0
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-11-aaron@os.amperecomputing.com>
	<CABoDooPMwWR3TXxAqzoByeyuaReVmV0NFpWCJr897QL6r7n_nw@mail.gmail.com>
	<20190205134124.GM5213@quinoa.localdomain>
In-Reply-To: <20190205134124.GM5213@quinoa.localdomain>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 5 Feb 2019 14:54:27 +0100
Message-ID: <CABoDooNTkg2WUpWneOGMNmT_4hHuZTT5qG=uhp6vxY_w73zd_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v10 10/14] target/arm: Finish
 implementation of PM[X]EVCNTR and PM[X]EVTYPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Aaron Lindsay <alindsay@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Feb 5, 2019 at 2:41 PM Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> On Feb 04 20:22, Laurent Desnogues wrote:
> > Hello,
> >
> > On Tue, Dec 11, 2018 at 4:25 PM Aaron Lindsay
> > <aaron@os.amperecomputing.com> wrote:
> > >
> > > Add arrays to hold the registers, the definitions themselves, access
> > > functions, and logic to reset counters when PMCR.P is set. Update
> > > filtering code to support counters other than PMCCNTR. Support migration
> > > with raw read/write functions.
> > >
> > > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > ---
> > >  target/arm/cpu.h    |   3 +
> > >  target/arm/helper.c | 296 +++++++++++++++++++++++++++++++++++++++++---
> > >  2 files changed, 282 insertions(+), 17 deletions(-)
> > [...]
> > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > index fd2923f033..1b851d1689 100644
> > > --- a/target/arm/helper.c
> > > +++ b/target/arm/helper.c
> > [...]
> > > @@ -5301,6 +5526,43 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> > >          };
> > >          define_one_arm_cp_reg(cpu, &pmcr);
> > >          define_one_arm_cp_reg(cpu, &pmcr64);
> > > +        for (i = 0; i < pmcrn; i++) {
> > > +            char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
> > > +            char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
> > > +            char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
> > > +            char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
> > > +            ARMCPRegInfo pmev_regs[] = {
> > > +                { .name = pmevcntr_name, .cp = 15, .crn = 15,
> > > +                  .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> > > +                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
> > > +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
> > > +                  .accessfn = pmreg_access },
> > > +                { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
> > > +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
> > > +                  .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
> > > +                  .type = ARM_CP_IO,
> > > +                  .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
> > > +                  .raw_readfn = pmevcntr_rawread,
> > > +                  .raw_writefn = pmevcntr_rawwrite },
> > > +                { .name = pmevtyper_name, .cp = 15, .crn = 15,
> > > +                  .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
> > > +                  .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
> > > +                  .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
> > > +                  .accessfn = pmreg_access },
> > > +                { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
> > > +                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),
> >
> > Looking at ARM documentation, I think the value for crn should be 14
> > for PMEVCNTR<n>_EL0 and PMEVTYPER<n>_EL0.
>
> You are correct. I'll post a fix momentarily.
>
> Out of curiosity, how did you discover this? I've been using recent
> Linux kernels for testing, and thought it used these registers, but I
> guess it must only be using PMSELR/PMXEVCNTR/PMXEVTYPER.

There regs are used in a proprietary bare metal bootloader on a
virtual platform my company uses for performance measurements.

Thanks,

Laurent
