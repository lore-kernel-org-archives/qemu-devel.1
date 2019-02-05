Received: from eggs.gnu.org ([209.51.188.92]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gr0z0-0006XV-25
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gr0yz-00058H-1K
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:41:50 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Tue, 5 Feb 2019 13:41:22 +0000
Message-ID: <20190205134124.GM5213@quinoa.localdomain>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-11-aaron@os.amperecomputing.com>
	<CABoDooPMwWR3TXxAqzoByeyuaReVmV0NFpWCJr897QL6r7n_nw@mail.gmail.com>
In-Reply-To: <CABoDooPMwWR3TXxAqzoByeyuaReVmV0NFpWCJr897QL6r7n_nw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3EAB37240C4294AA417EA393A085784@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Aaron Lindsay <alindsay@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Feb 04 20:22, Laurent Desnogues wrote:
> Hello,
>=20
> On Tue, Dec 11, 2018 at 4:25 PM Aaron Lindsay
> <aaron@os.amperecomputing.com> wrote:
> >
> > Add arrays to hold the registers, the definitions themselves, access
> > functions, and logic to reset counters when PMCR.P is set. Update
> > filtering code to support counters other than PMCCNTR. Support migratio=
n
> > with raw read/write functions.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/cpu.h    |   3 +
> >  target/arm/helper.c | 296 +++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 282 insertions(+), 17 deletions(-)
> [...]
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index fd2923f033..1b851d1689 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> [...]
> > @@ -5301,6 +5526,43 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >          };
> >          define_one_arm_cp_reg(cpu, &pmcr);
> >          define_one_arm_cp_reg(cpu, &pmcr64);
> > +        for (i =3D 0; i < pmcrn; i++) {
> > +            char *pmevcntr_name =3D g_strdup_printf("PMEVCNTR%d", i);
> > +            char *pmevcntr_el0_name =3D g_strdup_printf("PMEVCNTR%d_EL=
0", i);
> > +            char *pmevtyper_name =3D g_strdup_printf("PMEVTYPER%d", i)=
;
> > +            char *pmevtyper_el0_name =3D g_strdup_printf("PMEVTYPER%d_=
EL0", i);
> > +            ARMCPRegInfo pmev_regs[] =3D {
> > +                { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 15,
> > +                  .crm =3D 8 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D =
i & 7,
> > +                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALI=
AS,
> > +                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_w=
ritefn,
> > +                  .accessfn =3D pmreg_access },
> > +                { .name =3D pmevcntr_el0_name, .state =3D ARM_CP_STATE=
_AA64,
> > +                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 8 | =
(3 & (i >> 3)),
> > +                  .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D p=
mreg_access,
> > +                  .type =3D ARM_CP_IO,
> > +                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_w=
ritefn,
> > +                  .raw_readfn =3D pmevcntr_rawread,
> > +                  .raw_writefn =3D pmevcntr_rawwrite },
> > +                { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 15,
> > +                  .crm =3D 12 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D=
 i & 7,
> > +                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALI=
AS,
> > +                  .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper=
_writefn,
> > +                  .accessfn =3D pmreg_access },
> > +                { .name =3D pmevtyper_el0_name, .state =3D ARM_CP_STAT=
E_AA64,
> > +                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 12 |=
 (3 & (i >> 3)),
>=20
> Looking at ARM documentation, I think the value for crn should be 14
> for PMEVCNTR<n>_EL0 and PMEVTYPER<n>_EL0.

You are correct. I'll post a fix momentarily.

Out of curiosity, how did you discover this? I've been using recent
Linux kernels for testing, and thought it used these registers, but I
guess it must only be using PMSELR/PMXEVCNTR/PMXEVTYPER.

-Aaron
