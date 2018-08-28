Received: from eggs.gnu.org ([2001:4830:134:3::10]:50091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fukhk-0006Xz-52
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fukcj-0005Lf-Dp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:30:02 -0400
Date: Tue, 28 Aug 2018 16:29:58 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20180828202957.GC3671@okra.localdomain>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-7-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-0_PQdFXo_vY-cxkeC_HwxsKhCe7VNy7+4iCX-NqtOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-0_PQdFXo_vY-cxkeC_HwxsKhCe7VNy7+4iCX-NqtOqw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/13] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <alindsay@amperecomputing.com>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Jun 28 17:23, Peter Maydell wrote:
> On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > Add an array for PMOVSSET so we only define it for v7ve+ platforms
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 7d63bb2..5d83446 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -1293,9 +1293,17 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >  static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                           uint64_t value)
> >  {
> > +    value &= pmu_counter_mask(env);
> >      env->cp15.c9_pmovsr &= ~value;
> >  }
> 
> This change doesn't look like it should be in this patch ?

This has been appropriately split off into a separate patch for v6. I
must've seen "pmovsr" and staged it here by accident.

> >
> > +static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                         uint64_t value)
> > +{
> > +    value &= pmu_counter_mask(env);
> > +    env->cp15.c9_pmovsr |= value;
> > +}
> > +
> >  static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >                               uint64_t value)
> >  {
> > @@ -1645,6 +1653,23 @@ static const ARMCPRegInfo v7mp_cp_reginfo[] = {
> >      REGINFO_SENTINEL
> >  };
> >
> > +static const ARMCPRegInfo pmovsset_cp_reginfo[] = {
> > +    /* PMOVSSET is not implemented in v7 before v7ve */
> > +    { .name = "PMOVSSET", .cp = 15, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 3,
> > +      .access = PL0_RW, .accessfn = pmreg_access,
> > +      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
> > +      .writefn = pmovsset_write,
> > +      .raw_writefn = raw_write },
> 
> This should be marked ARM_CP_ALIAS, beacuse its underlying
> state in c9_pmovsr is just an alias into PMOVSR, and that
> register is handling reset and migration.

Thanks for catching this, too!

-Aaron
