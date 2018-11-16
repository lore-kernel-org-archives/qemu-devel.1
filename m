Received: from eggs.gnu.org ([2001:4830:134:3::10]:44173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNkQg-0006L4-Mp
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNkQe-0004Nj-Sh
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:09:26 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 16 Nov 2018 20:09:13 +0000
Message-ID: <20181116200904.GE23658@quinoa.localdomain>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-8-aaron@os.amperecomputing.com>
	<CAFEAcA8F5ZhPHU2ZC53xeXOEuR2NqzwHqjG9858VELjorwYj5g@mail.gmail.com>
In-Reply-To: <CAFEAcA8F5ZhPHU2ZC53xeXOEuR2NqzwHqjG9858VELjorwYj5g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <689726F3A8957D40976F9424C435FD0D@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 07/12] target/arm: Add array for
 supported PMU events, generate PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Nov 16 15:06, Peter Maydell wrote:
> On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com>=
 wrote:
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -957,9 +957,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
> >      if (!cpu->has_pmu) {
> >          unset_feature(env, ARM_FEATURE_PMU);
> >          cpu->id_aa64dfr0 &=3D ~0xf00;
> > -    } else if (!kvm_enabled()) {
> > -        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
> > -        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> > +    }
> > +    if (arm_feature(env, ARM_FEATURE_PMU)) {
> > +        uint64_t pmceid =3D get_pmceid(&cpu->env);
> > +        cpu->pmceid0 =3D extract64(pmceid, 0, 32);
> > +        cpu->pmceid1 =3D extract64(pmceid, 32, 32);
> > +
> > +        if (!kvm_enabled()) {
> > +            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0=
);
> > +            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
> > +        }
> > +    } else {
> > +        cpu->pmceid0 =3D 0x00000000;
> > +        cpu->pmceid1 =3D 0x00000000;
> >      }
>=20
> This now sets one of the ID registers for "we have no
> PMU" in the first "if (!cpu->has_pmu)" statement (id_aa64dfr0),
> and some of them (pmceid0, pcmeid1) in this else clause at the
> end. We should put them all in the same place.

I agree that would be cleaner - I'll move the id_aa64dfr0 update to
later else clause.

> > +/*
> > + * get_pmceid
> > + * @env: CPUARMState
> > + *
> > + * Return the PMCEID[01] register values corresponding to the counters=
 which
> > + * are supported given the current configuration (0 is low 32, 1 is hi=
gh 32
> > + * bits)
> > + */
> > +uint64_t get_pmceid(CPUARMState *env);
>=20
> This doesn't look like the right API, because in AArch64
> PMCEID0_EL0 and PMCEID1_EL0 are both 64-bit registers,
> so you can't fit them both into a single uint64_t.

Heh, I think I started working on this long enough ago that I was using
a copy of the ARMv8.0 ARM - before the statistical profiling extensions
were announced. I believe those are the only currently-defined common
events >=3D 0x4000, so they're the only bits defined in the upper 32 bits
of PMCEID[01].

Now that I look at it, pmceid[01] are currently only defined as
uint32_t, and we don't have PMCEID[23] for the high bits for AArch32.
Perhaps that should be a separate patch.

At any rate, I'll plan to update this the following signature for the
next version, where `which` is [01] for which PMCEID is being requested.
For now I'll probably just put a comment about not supporting the 0x40xx
events, since I don't know that coming up with a sparse array is worth
it, but the signature will be appropriate if we add support later:

uint64_t get_pmceid(CPUARMState *env, unsigned which);

-Aaron
