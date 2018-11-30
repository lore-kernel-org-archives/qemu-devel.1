Received: from eggs.gnu.org ([2001:4830:134:3::10]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gSovX-00088R-RB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gSovU-0002PY-2z
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:58:13 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 30 Nov 2018 19:57:55 +0000
Message-ID: <20181130195742.GC24714@quinoa.localdomain>
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-14-aaron@os.amperecomputing.com>
	<d6fde9c7-b72e-ae9d-817b-71c3d6369dbc@linaro.org>
	<20181130175629.GB24714@quinoa.localdomain>
	<fb2e45b2-463d-aefe-e3d7-f3027f662c12@linaro.org>
In-Reply-To: <fb2e45b2-463d-aefe-e3d7-f3027f662c12@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EB9EB3CA4B2EE40BAEEB6D2661B5D14@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 13/13] target/arm: Send interrupts on
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, SM-Aaron Lindsay <alindsay@os.amperecomputing.com>

On Nov 30 10:19, Richard Henderson wrote:
> On 11/30/18 9:56 AM, Aaron Lindsay wrote:
> > On Nov 30 09:13, Richard Henderson wrote:
> >> On 11/20/18 1:26 PM, Aaron Lindsay wrote:
> >>> Setup a QEMUTimer to get a callback when we expect counters to next
> >>> overflow and trigger an interrupt at that time.
> >>>
> >>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> >>> Signed-off-by: Aaron Lindsay <alindsay@os.amperecomputing.com>
> >>> ---
> >>>  target/arm/cpu.c    |  12 +++++
> >>>  target/arm/cpu.h    |   7 +++
> >>>  target/arm/helper.c | 126 +++++++++++++++++++++++++++++++++++++++++-=
--
> >>>  3 files changed, 139 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> >>> index 208a08e867..7311a48e3c 100644
> >>> --- a/target/arm/cpu.c
> >>> +++ b/target/arm/cpu.c
> >>> @@ -827,6 +827,13 @@ static void arm_cpu_finalizefn(Object *obj)
> >>>          QLIST_REMOVE(hook, node);
> >>>          g_free(hook);
> >>>      }
> >>> +#ifndef CONFIG_USER_ONLY
> >>> +    if (arm_feature(&cpu->env, ARM_FEATURE_PMU) && cpu->pmu_timer) {
> >>
> >> No need for two tests here.  Just check cpu->pmu_timer.
> >> (If it's set for any reason it should be freed, surely.)
> >>
> >>> @@ -1305,7 +1338,18 @@ void pmccntr_op_start(CPUARMState *env)
> >>>              eff_cycles /=3D 64;
> >>>          }
> >>> =20
> >>> -        env->cp15.c15_ccnt =3D eff_cycles - env->cp15.c15_ccnt_delta=
;
> >>> +        uint64_t new_pmccntr =3D eff_cycles - env->cp15.c15_ccnt_del=
ta;
> >>> +
> >>> +        unsigned int overflow_bit =3D (env->cp15.c9_pmcr & PMCRLC) ?=
 63 : 31;
> >>> +        uint64_t overflow_mask =3D (uint64_t)1 << overflow_bit;
> >>> +        if (!(new_pmccntr & overflow_mask) &&
> >>> +                (env->cp15.c15_ccnt & overflow_mask)) {
> >>
> >> Fyi, this expression is
> >>
> >>     env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask
> >>
> >>> +            env->cp15.c9_pmovsr |=3D (1 << 31);
> >>> +            new_pmccntr &=3D ~overflow_mask;
> >>
> >> Why this line?  You just checked that overflow_mask was unset in new_p=
mccntr above.
> >=20
> > This ensures that when overflow_bit =3D=3D 31 (because PMCR.LC is not s=
et)
> > the high 32 bits remain 0 even after an overflow has occurred. As you
> > point out, it's silly when overflow_bit =3D=3D 64, but I didn't think i=
t was
> > worth the extra conditional to avoid it.
>=20
> Eh?  But we've set overflow_mask based on PMCR.LC, so what you say here d=
oesn't
> make sense.

Sorry, I had an off-by-one-bit think-o I couldn't get past until I
started typing a concrete example to explain myself. I'll change this
line to be:

if (!(env->cp15.c9_pmcr & PMCRLC))
	new_pmccntr &=3D 0xffffffff;

-Aaron
