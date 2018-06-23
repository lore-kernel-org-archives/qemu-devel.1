Received: from eggs.gnu.org ([2001:4830:134:3::10]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fWoyB-0001et-6F
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fWoy7-0004aW-Sc
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:17:15 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
Date: Sat, 23 Jun 2018 16:17:08 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


> On Jun 23, 2018, at 12:17 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 06/22/2018 07:22 PM, John Arbuckle wrote:
>> When the fdiv instruction divides a finite number by zero,
>> the result actually depends on the FPSCR[ZE] bit. If this
>> bit is set, the return value is zero. If it is not set
>> the result should be either positive or negative infinity.
>> The sign of this result would depend on the sign of the
>> two inputs. What currently happens is only infinity is
>> returned even if the FPSCR[ZE] bit is set. This patch
>> fixes this problem by actually checking the FPSCR[ZE] bit
>> when deciding what the answer should be.
>>=20
>> fdiv is suppose to only set the FPSCR's FPRF bits during a
>> division by zero situation when the FPSCR[ZE] is not set.
>> What currently happens is these bits are always set. This
>> patch fixes this problem by checking the FPSCR[ZE] bit to
>> decide if the FPRF bits should be set.=20
>>=20
>> =
https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-env=
ironments-for-32-e3087633.html
>> This document has the information on the fdiv. Page 133 has the =
information on what action is executed when a division by zero situation =
takes place.=20
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> target/ppc/fpu_helper.c            | 16 ++++++++++++++++
>> target/ppc/translate/fp-impl.inc.c | 28 +++++++++++++++++++++++++++-
>> 2 files changed, 43 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index 7714bfe0f9..de694604fb 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -658,6 +658,20 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t =
arg1, uint64_t arg2)
>>     } else if (unlikely(float64_is_zero(farg1.d) && =
float64_is_zero(farg2.d))) {
>>         /* Division of zero by zero */
>>         farg1.ll =3D float_invalid_op_excp(env, =
POWERPC_EXCP_FP_VXZDZ, 1);
>> +    } else if (arg2 =3D=3D 0) {
>> +        /* Division by zero */
>> +        float_zero_divide_excp(env, GETPC());
>> +        if (fpscr_ze) { /* if zero divide exception is enabled */
>> +            farg1.ll =3D 0;
>> +        } else {
>> +            uint64_t sign =3D (farg1.ll ^ farg2.ll) >> 63;
>> +            if (sign) { /* Negative sign bit */
>> +                farg1.ll =3D 0xfff0000000000000; /* Negative =
Infinity */
>> +            } else { /* Positive sign bit */
>> +                farg1.ll =3D 0x7ff0000000000000; /* Positive =
Infinity */
>> +            }
>> +            helper_compute_fprf_float64(env, farg1.d);
>=20
> I don't believe you.
> (1) This is against IEEE spec,

I'm trying to implement IBM PowerPC specs.=20

> (2) There is nothing about this zero result in the Power manual,

This is for PowerPC. Power and PowerPC are cousins to each other rather =
than having a child-parent relationship. Yes there are a lot of similar =
instructions between them, this does not mean they are compatible with =
each other. =20

> (3) I do not replicate this experimentally.

I used a G3 iMac and a G5 iMac to do my testing.

>=20
> #include <signal.h>
> #include <stdio.h>
> #include <fenv.h>
> #include <stdlib.h>
>=20
> void handle(int sig, siginfo_t *info, void *x)
> {
>    ucontext_t *u =3D x;
>    printf("%f\n", u->uc_mcontext.fp_regs[0]);
>    exit(0);
> }
>=20
> int main()
> {
>  struct sigaction a =3D { .sa_sigaction =3D handle, .sa_flags =3D =
SA_SIGINFO };
>  sigaction(SIGFPE, &a, NULL);
>  feenableexcept(FE_ALL_EXCEPT);

This is C99 code. There are a lot of floating point bugs with this =
implementation. I suggest all future testing be done using PowerPC =
assembly language only.

>=20
>  {
>    register double f0 __asm__("32") =3D 2;
>    register double f1 __asm__("33") =3D 1;
>    register double f2 __asm__("34") =3D 0;
>    __asm__ volatile ("fdiv %0,%1,%2" : "+f"(f0) : "f"(f1), "f"(f2));
>  }
>  return 1;
> }
>=20
> Produces the expected 2.0, i.e. the destination register is =
unmodified.
> Without feenableexcept, of course, the normal infinity is produced.

What compiler did you use to compile this program?

What operating system did you run this program on?

What are the specs of the system you used to test this program on?

I made a complete floating point test program that I could send you if =
you want to see how I test things.

Thank you.=
