Received: from eggs.gnu.org ([2001:4830:134:3::10]:44623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gTv5c-00048O-Ml
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gTv5b-0005s3-Aq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:45:12 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Mon, 3 Dec 2018 20:44:58 +0000
Message-ID: <20181203204452.GB5549@quinoa.localdomain>
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
	<CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
In-Reply-To: <CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9ED7D8D07CE33419A5868FD84E56832@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Nov 30 16:10, Peter Maydell wrote:
> On Tue, 20 Nov 2018 at 21:26, Aaron Lindsay
> <aaron@os.amperecomputing.com> wrote:
> >
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > ---
> >  target/arm/cpu.h    |  4 ++--
> >  target/arm/helper.c | 12 ++++++++++--
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 627e5c1995..50de58e4a2 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -837,8 +837,8 @@ struct ARMCPU {
> >      uint32_t id_pfr0;
> >      uint32_t id_pfr1;
> >      uint32_t id_dfr0;
> > -    uint32_t pmceid0;
> > -    uint32_t pmceid1;
> > +    uint64_t pmceid0;
> > +    uint64_t pmceid1;
> >      uint32_t id_afr0;
> >      uint32_t id_mmfr0;
> >      uint32_t id_mmfr1;
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 71be6fb578..75f054fe79 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5432,7 +5432,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >              { .name =3D "PMCEID0", .state =3D ARM_CP_STATE_AA32,
> >                .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 6,
> >                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > -              .resetvalue =3D cpu->pmceid0 },
> > +              .resetvalue =3D extract64(cpu->pmceid0, 0, 32) },
> > +            { .name =3D "PMCEID2", .state =3D ARM_CP_STATE_AA32,
> > +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 4,
> > +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > +              .resetvalue =3D extract64(cpu->pmceid0, 32, 32) },
> >              { .name =3D "PMCEID0_EL0", .state =3D ARM_CP_STATE_AA64,
> >                .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2=
 =3D 6,
> >                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > @@ -5440,7 +5444,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >              { .name =3D "PMCEID1", .state =3D ARM_CP_STATE_AA32,
> >                .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =
=3D 7,
> >                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > -              .resetvalue =3D cpu->pmceid1 },
> > +              .resetvalue =3D extract64(cpu->pmceid1, 0, 32) },
> > +            { .name =3D "PMCEID3", .state =3D ARM_CP_STATE_AA32,
> > +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 5,
> > +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > +              .resetvalue =3D extract64(cpu->pmceid1, 32, 32) },
> >              { .name =3D "PMCEID1_EL0", .state =3D ARM_CP_STATE_AA64,
> >                .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2=
 =3D 7,
> >                .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D=
 ARM_CP_CONST,
> > --
>=20
> PMCEID2 and PMCEID3 are only defined from ARMv8.1; before that they
> are UNDEFINED. So these registers need to be only defined if a
> suitable feature bit or ID register field check passes.

It looks like we don't currently support any ARMv8.1+ CPUs and don't
have an entry in the `arm_features` enum for it. I'll plan to add
ARM_FEATURE_V81 and make defining these registers depend on it, assuming
any future CPUs supporting it will use that, unless you feel I should do
something different.

-Aaron
