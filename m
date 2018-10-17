Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCsNn-0003dv-9l
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aaron@os.amperecomputing.com>) id 1gCsNh-0004V7-3P
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:25:29 -0400
From: Aaron Lindsay <Aaron@os.amperecomputing.com>
Date: Wed, 17 Oct 2018 20:25:12 +0000
Message-ID: <20181017202505.GC25905@quinoa.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-13-aclindsa@gmail.com>
	<0fdcad4a-c8b5-3309-d2ce-f9be901ec52a@linaro.org>
	<20181017192013.GA25905@quinoa.localdomain>
	<31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
In-Reply-To: <31f327f4-42ee-55fc-596d-97d935803867@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF1C43578DC6DA43A834DF202634E04F@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 12/14] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <aclindsa@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 12:34, Richard Henderson wrote:
> On 10/17/18 12:20 PM, Aaron Lindsay wrote:
> > On Oct 16 17:09, Richard Henderson wrote:
> >> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> >>> This both advertises that we support four counters and enables them
> >>> because the pmu_num_counters() reads this value from PMCR.
> >>>
> >>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> >>> ---
> >>>  target/arm/helper.c | 8 ++++----
> >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> It looks like this should have been folded into patch 10,
> >> or patch 10 split to include the code changes that go with
> >> these comment changes.
> >=20
> > By setting PMCR.N to 4, this commit is what causes all the previous
> > implementation of non-PMCCNTR counters to become usable by the guest -
> > both because the OS can now detect their presence in PMCR, and because
> > the system registers used to setup/access the counters are gated on
> > pmu_num_counters(), which uses PMCR.N to determine if a counter is
> > implemented.
>=20
> But e.g.
>=20
> > @@ -5412,8 +5412,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >      }
> >      if (arm_feature(env, ARM_FEATURE_V7)) {
> >          /* v7 performance monitor control register: same implementor
> > -         * field as main ID register, and we implement only the cycle
> > -         * count register.
> > +         * field as main ID register, and we implement four counters i=
n
> > +         * addition to the cycle count register.
> >           */
> >          unsigned int i, pmcrn =3D 4;
> >          ARMCPRegInfo pmcr =3D {
>=20
> clearly belongs with the previous patch, since pmcrn is already 4.

I suppose pmcrn (the local variable) should've been set to 0 before this
patch and updated here to be 4. However, even though it was already set
to 4 my amendment to the comment was still not true until this patch,
because it wasn't written into PMCR.N (the CP register).

> > @@ -1706,7 +1706,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
> >        .access =3D PL1_W, .type =3D ARM_CP_NOP },
> >      /* Performance monitors are implementation defined in v7,
> >       * but with an ARM recommended set of registers, which we
> > -     * follow (although we don't actually implement any counters)
> > +     * follow.
> >       *
> >       * Performance registers fall into three categories:
> >       *  (a) always UNDEF in PL0, RW in PL1 (PMINTENSET, PMINTENCLR)
>=20
> And this is out of date as well, and probably belonged elsewhere.
> Which leaves only

Why is this out of date? Because PMCR.N still contained zero, no
counters were implemented from the guest's standpoint until this patch.

> > @@ -5430,7 +5430,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >              .access =3D PL0_RW, .accessfn =3D pmreg_access,
> >              .type =3D ARM_CP_IO,
> >              .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcr),
> > -            .resetvalue =3D cpu->midr & 0xff000000,
> > +            .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN=
_SHIFT),
> >              .writefn =3D pmcr_write, .raw_writefn =3D raw_write,
> >          };
>=20
> which suggests that this one line belonged to the patch that set pmcrn in=
 the
> first place.

I get the feeling we may be talking past each other/misunderstanding
somehow, but I'm not sure why/how. Maybe I'm thinking about whether or
not counters are implemented from the guest's standpoint and you're
thinking about it from the standpoint of whether the code to implement
them exists in QEMU?

Anyway, by splitting these patches apart, my intention was to separate
the plumbing work from turning on the water. If you believe it is better
to do both in the same patch, I'll make that change for v7.

-Aaron
