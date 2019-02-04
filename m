Received: from eggs.gnu.org ([209.51.188.92]:32869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqegX-0006DW-Gu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqegT-0000nc-IF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:53:17 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqegR-0000en-Mo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:53:13 -0500
Received: by mail-ot1-x344.google.com with SMTP id e12so13015293otl.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20190128173940.25813-1-alex.bennee@linaro.org>
	<20190128173940.25813-5-alex.bennee@linaro.org>
In-Reply-To: <20190128173940.25813-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 13:52:54 +0000
Message-ID: <CAFEAcA_NoLsU2kg7TDhSH-Uv7+19B3-vC+=DwS=vLkCHuyNMcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/4] tests/tcg/aarch64: userspace system
 register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 28 Jan 2019 at 17:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This tests a bunch of registers that the kernel allows userspace to
> read including the CPUID registers.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v4
>   - also test for extra bits that shouldn't be exposed
> ---
>  tests/tcg/aarch64/Makefile.target |   2 +-
>  tests/tcg/aarch64/sysregs.c       | 120 ++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/sysregs.c
>
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 08c45b8470..cc1a7eb486 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -7,7 +7,7 @@ VPATH           +=3D $(AARCH64_SRC)
>
>  # we don't build any of the ARM tests
>  AARCH64_TESTS=3D$(filter-out $(ARM_TESTS), $(TESTS))
> -AARCH64_TESTS+=3Dfcvt
> +AARCH64_TESTS+=3Dfcvt sysregs
>  TESTS:=3D$(AARCH64_TESTS)
>
>  fcvt: LDFLAGS+=3D-lm
> diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
> new file mode 100644
> index 0000000000..8e11288ee3
> --- /dev/null
> +++ b/tests/tcg/aarch64/sysregs.c
> @@ -0,0 +1,120 @@
> +/*
> + * Check emulated system register access for linux-user mode.
> + *
> + * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-regis=
ters.txt
> + */

This needs the usual copyright line and license statement.

> +
> +#include <asm/hwcap.h>
> +#include <stdio.h>
> +#include <sys/auxv.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <stdbool.h>
> +
> +int failed_mask_count;
> +
> +#define get_cpu_reg(id) ({                                      \
> +            unsigned long __val =3D 0xdeadbeef;                   \
> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
> +            printf("%-20s: 0x%016lx\n", #id, __val);            \
> +            __val;                                               \
> +        })
> +
> +#define get_cpu_reg_check_mask(id, mask) ({                     \
> +            unsigned long __cval =3D get_cpu_reg(id);             \
> +            unsigned long __extra =3D __cval & ~mask;             \
> +            if (__extra) {                                      \
> +                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extra)=
;   \
> +                failed_mask_count++;                            \
> +            }                                                   \
> +})

A brief comment describing what the arguments to these macros
do would be helpful if we ever have to add more registers in future.

> +
> +bool should_fail;
> +int should_fail_count;
> +int should_not_fail_count;
> +uintptr_t failed_pc[10];
> +
> +void sigill_handler(int signo, siginfo_t *si, void *data)
> +{
> +    ucontext_t *uc =3D (ucontext_t *)data;
> +
> +    if (should_fail) {
> +        should_fail_count++;
> +    } else {
> +        uintptr_t pc =3D (uintptr_t) uc->uc_mcontext.pc;
> +        failed_pc[should_not_fail_count++] =3D  pc;
> +    }
> +    uc->uc_mcontext.pc +=3D 4;
> +}
> +
> +int main(void)
> +{
> +    struct sigaction sa;
> +
> +    /* Hook in a SIGILL handler */
> +    memset(&sa, 0, sizeof(struct sigaction));
> +    sa.sa_flags =3D SA_SIGINFO;
> +    sa.sa_sigaction =3D &sigill_handler;
> +    sigemptyset(&sa.sa_mask);
> +
> +    if (sigaction(SIGILL, &sa, 0) !=3D 0) {
> +        perror("sigaction");
> +        return 1;
> +    }
> +
> +    /* since 4.12 */

This is a rather cryptic comment.

> +    printf("Checking CNT registers\n");
> +
> +    get_cpu_reg(ctr_el0);
> +    get_cpu_reg(cntvct_el0);
> +    get_cpu_reg(cntfrq_el0);
> +
> +    /* when (getauxval(AT_HWCAP) & HWCAP_CPUID), since 4.11*/

Missing space before "*/".

> +    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
> +        printf("CPUID registers unavailable\n");
> +        return 1;
> +    } else {
> +        printf("Checking CPUID registers\n");
> +    }
> +
> +    /*
> +     * Some registers only expose some bits to user-space. Anything
> +     * that is IMDEF is exported as 0 to user-space.

IMPDEF

> +     */
> +    get_cpu_reg_check_mask(id_aa64isar0_el1, 0x000fffffff0ffff0ULL);

I can't make sense of this mask value. Presumably it's supposed to be
1s where the value is visible, but the docs say that the visible
bits for ID_AA64ISAR0_EL1 are [23..4] and [55..28], whereas the
mask value here has 1s in [51..24] and [20..4], unless I've miscounted.

> +    get_cpu_reg_check_mask(id_aa64isar1_el1, 0x00000000ffffffffULL);
> +    get_cpu_reg(id_aa64mmfr0_el1);
> +    get_cpu_reg(id_aa64mmfr1_el1);
> +    get_cpu_reg_check_mask(id_aa64pfr0_el1, 0x000f000f0ff0000ULL);

This seems to have [31..28] set but not [35..32]. The bits that
should be [51..48] are also in the wrong place, and the whole
number has one hex digit too few to be 64 bits.

> +    get_cpu_reg(id_aa64pfr1_el1);
> +    get_cpu_reg(id_aa64dfr0_el1);
> +    get_cpu_reg(id_aa64dfr1_el1);
> +
> +    get_cpu_reg_check_mask(midr_el1, 0x00000000ffffffffULL);
> +    get_cpu_reg(mpidr_el1);
> +    /* REVIDR is all IMPDEF so should be all zeros to user-space */
> +    get_cpu_reg_check_mask(revidr_el1, 0x0);

Missing check of the mask value for ID_AA64MMFR2_EL1 ? Should have
bits [35..32] visible.

Missing checks for:
 ID_AA64ZFR0_EL1
 ID_AA64AFR0_EL1
 ID_AA64AFR1_EL1

Missing checks for all the parts of the ID space that are currently
unallocated (and which should be exposed as RAZ/WI).

Missing checks for registers which are exposed but with all
features hidden, eg ID_PFR0_EL1 and the other aarch32 ID regs.

The kernel returns some value, ie does not fault, all the
architecturally defined registers in Op0=3D3, Op1=3D0, CRn=3D0,
CRm=3D0,4,5,6,7. For CRm =3D 0 only op2 =3D {0,5,6} [MIDR_EL1,
MPIDR_EL1, REVIDR_EL1] are valid, but for CRm =3D {4,5,6,7}
the whole set of op2 =3D {0..7} are defined (and RAZ if not
yet given some meaning).

thanks
-- PMM
