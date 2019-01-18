Received: from eggs.gnu.org ([209.51.188.92]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gkbt9-0004LP-8O
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gkbt0-0008Hs-Ff
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:41:14 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 18 Jan 2019 21:40:55 +0000
Message-ID: <20190118214052.GD5213@quinoa.localdomain>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-15-aaron@os.amperecomputing.com>
	<8683c2c4-0111-492c-c6f9-1b2dcc937405@linaro.org>
In-Reply-To: <8683c2c4-0111-492c-c6f9-1b2dcc937405@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1E4B8034F9D854A9B3068C3585D01F8@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 14/14] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On Jan 18 07:26, Richard Henderson wrote:
> On 12/12/18 2:20 AM, Aaron Lindsay wrote:
> > Setup a QEMUTimer to get a callback when we expect counters to next
> > overflow and trigger an interrupt at that time.
> >=20
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > ---
> >  target/arm/cpu.c    |  12 +++++
> >  target/arm/cpu.h    |   8 +++
> >  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 140 insertions(+), 6 deletions(-)
>=20
> Well, this patch is doing several things at once -- adding the timer, add=
ing
> the ns_per_count hook, updating irqs.  Not ideal, but I won't insist it b=
e split.
>=20
> You'll need to re-run against scripts/checkpatch, it would seem.
> The goal-posts with respect to comments have been changed since
> you started this.

Okay, I'll check that again before I send the next version out.

> > @@ -1305,7 +1338,19 @@ void pmccntr_op_start(CPUARMState *env)
> >              eff_cycles /=3D 64;
> >          }
> > =20
> > -        env->cp15.c15_ccnt =3D eff_cycles - env->cp15.c15_ccnt_delta;
> > +        uint64_t new_pmccntr =3D eff_cycles - env->cp15.c15_ccnt_delta=
;
> > +
> > +        unsigned int overflow_bit =3D (env->cp15.c9_pmcr & PMCRLC) ? 6=
3 : 31;
> > +        uint64_t overflow_mask =3D (uint64_t)1 << overflow_bit;
>=20
> Could just as easily be
>=20
>   uint64_t overflow_mask =3D env->cp15.c9_pmcr & PMCRLC ? INT64_MIN : INT=
32_MIN;

Updated.

> > +        if (env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask) {
> > +            env->cp15.c9_pmovsr |=3D (1 << 31);
> > +            if (!(env->cp15.c9_pmcr & PMCRLC)) {
> > +                new_pmccntr &=3D 0xffffffff;
> > +            }
>=20
> Why is this truncation buried within the overflow condition?  Simply beca=
use
> the high bits can't be set without overflow being noticed?  That could us=
e a
> comment, because it looks odd.

Upon re-reading the spec, I don't think this is needed (or even correct
behavior). I must've been thinking that PMCR.LC =3D=3D 0 implied that upper
32 bits could never be updated by the hardware and made PMCCNTR act like
its high bits didn't even exist, like one of the PMXEVCNTRs. I no longer
believe that is true and I'll remove this.

> > @@ -1340,8 +1399,15 @@ static void pmevcntr_op_start(CPUARMState *env, =
uint8_t counter)
> >      }
> > =20
> >      if (pmu_counter_enabled(env, counter)) {
> > -        env->cp15.c14_pmevcntr[counter] =3D
> > -            count - env->cp15.c14_pmevcntr_delta[counter];
> > +        uint64_t new_pmevcntr =3D count - env->cp15.c14_pmevcntr_delta=
[counter];
> > +
> > +        if (!(new_pmevcntr & PMEVCNTR_OVERFLOW_MASK) &&
> > +                (env->cp15.c14_pmevcntr[counter] & PMEVCNTR_OVERFLOW_M=
ASK)) {
> > +            env->cp15.c9_pmovsr |=3D (1 << counter);
> > +            new_pmevcntr &=3D ~PMEVCNTR_OVERFLOW_MASK;
>=20
> That, surely, does not do what you intend.  I can only imagine that you m=
eant
>=20
>     new_pmevcntr =3D (uint32_t)new_pmevcntr;
> or
>     new_pmevcntr &=3D PMEVCNTR_OVERFLOW_MASK - 1;
>=20
> depending on how much you want to depend on the symbol defining the width=
.

In practice, I think only the 32nd bit would ever need to be cleared,
but I agree it is more correct to clear them all.

> Given that it is architecturally defined to 32-bits, I think you could re=
ally
> just drop the define and use
>=20
>     uint32_t new_pmevcntr =3D ...;
>     if (env->cp15.c14_pmevcntr[counter] & ~new_pmevcntr & INT32_MIN)
>
> with equal clarity.

I don't know whether it is important for the resolution of this patch,
but what did you mean by the following?:

> The type of new_pmevcntr means you don't have to clear any
> high bits either.

> > +            /* Detect if this write causes an overflow since we can't =
predict
> > +             * PMSWINC overflows like we can for other events
> > +             */
> > +            uint64_t new_pmswinc =3D env->cp15.c14_pmevcntr[i] + 1;
> > +
> > +            if (!(new_pmswinc & PMEVCNTR_OVERFLOW_MASK) &&
> > +                    (env->cp15.c14_pmevcntr[i] & PMEVCNTR_OVERFLOW_MAS=
K)) {
> > +                env->cp15.c9_pmovsr |=3D (1 << i);
> > +                new_pmswinc &=3D ~PMEVCNTR_OVERFLOW_MASK;
>=20
> Likewise.

Thanks,

Aaron
