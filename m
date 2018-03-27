Received: from eggs.gnu.org ([2001:4830:134:3::10]:45224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0lbM-0001Iu-PD
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f0lbE-0004HR-Qy
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:13:12 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f0lbE-0004Gk-Bi
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:13:04 -0400
Received: by mail-wm0-x236.google.com with SMTP id x4so8277561wmh.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 03:13:04 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-3-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521663109-32262-3-git-send-email-cota@braap.org>
Date: Tue, 27 Mar 2018 11:13:01 +0100
Message-ID: <87zi2t968i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 02/14] tests: add fp-test,
 a floating point test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> This will allow us to run correctness tests against our
> FP implementation. The test can be run in two modes (called
> "testers"): host and soft. With the former we check the results
> and FP flags on the host machine against the model.
> With the latter we check QEMU's fpu primitives against the
> model. Note that in soft mode we are not instantiating any
> particular CPU (hence the HW_POISON_H hack to avoid macro poisoning);
> for that we need to run the test in host mode under QEMU.
>
> The input files are taken from IBM's FPGen test suite:
> https://www.research.ibm.com/haifa/projects/verification/fpgen/
>
> I see no license file in there so I am just downloading them
> with wget. We might want to keep a copy on a qemu server though,
> in case IBM takes those files down in the future.

Hmm the files themselves have:

  Copyright of IBM Corp. 2005

So I'm not sure we can take them into any of our source trees. However
what are we testing here?

Do we just want to test our implementation is IEEE compliant or should
we generate our own test cases on validated hardware to check that our
emulation of a guest is correct (e.g. correct modulo the valid
variations in the standard)?

> The "IBM" syntax of those files (for now the only syntax supported
> in fp-test) is documented here:
> https://www.research.ibm.com/haifa/projects/verification/fpgen/papers/iee=
e-test-suite-v2.pdf
>
> Note that the syntax document has some inaccuracies; the appended
> parsing code works around some of those.
>
> The exception flag (-e) is important: many of the optimizations
> included in the following commits assume that the inexact flag
> is set, so "-e x" is necessary in order to test those code paths.
>
> The whitelist flag (-w) points to a file with test cases to be ignored.
> I have put some whitelist files online, but we should have them
> on a QEMU-related server.
>
> Thus, a typical of fp-test is as follows:
>
>   $ cd qemu/build/tests/fp-test
>   $ make -j && \
> 	./fp-test -t soft ibm/*.fptest \
> 	-w whitelist.txt \
> 	-e x

So this is a unit test of our code rather than a test program running
under QEMU? I noted running under x86-64-linux-user fails pretty
quick.

If so we really should be building this automatically in make check.

>
> If we want to test after-rounding tininess detection, then we need to
> pass "-a -w whitelist-tininess-after.txt" in addition to the above.
> (NB. we can pass "-w" as many times as we want.)
>
> The patch immediately after this one fixes a mismatch against the model
> in softfloat, but after that is applied the above should finish with a 0
> return code, and print something like:
>   All tests OK.
>   Tests passed: 76572. Not handled: 51237, whitelisted: 2662
>
> The tests pass on "host" mode on x86_64 and aarch64 machines.
> On an IBM Power8 machine some exception flags are different from the
> model files, which is interesting given that the model comes from IBM.
>
> Running on host mode under QEMU reports flag mismatches (e.g. for
> x86_64-linux-user), but that isn't too surprising given how little
> love the i386 frontend gets. Host mode under aarch64-linux-user
> passes OK.
>
> Flush-to-zero and flush-inputs-to-zero modes can be tested with the
> -z and -Z flags. Note however that the IBM input files are only
> IEEE-compliant, so for now I've tested these modes by diff'ing
> the reported errors against the model files. We should look into
> generating files for these non-standard modes to make testing
> these modes less painful.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure                |    2 +
>  tests/fp-test/fp-test.c  | 1159 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/.gitignore         |    1 +
>  tests/fp-test/.gitignore |    3 +
>  tests/fp-test/Makefile   |   34 ++
>  5 files changed, 1199 insertions(+)
>  create mode 100644 tests/fp-test/fp-test.c
>  create mode 100644 tests/fp-test/.gitignore
>  create mode 100644 tests/fp-test/Makefile
>
> diff --git a/configure b/configure
> index 6f3921c..8ea3825 100755
> --- a/configure
> +++ b/configure
> @@ -7046,12 +7046,14 @@ fi
>
>  # build tree in object directory in case the source is not in the curren=
t directory
>  DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests=
/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
> +DIRS=3D"$DIRS tests/fp-test"
>  DIRS=3D"$DIRS docs docs/interop fsdev scsi"
>  DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS=3D"$DIRS roms/seabios roms/vgabios"
>  FILES=3D"Makefile tests/tcg/Makefile qdict-test-data.txt"
>  FILES=3D"$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>  FILES=3D"$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Mak=
efile"
> +FILES=3D"$FILES tests/fp-test/Makefile"
>  FILES=3D"$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
>  FILES=3D"$FILES pc-bios/spapr-rtas/Makefile"
>  FILES=3D"$FILES pc-bios/s390-ccw/Makefile"
> diff --git a/tests/fp-test/fp-test.c b/tests/fp-test/fp-test.c
> new file mode 100644
> index 0000000..27637c4
> --- /dev/null
> +++ b/tests/fp-test/fp-test.c
> @@ -0,0 +1,1159 @@
> +/*
> + * fp-test.c - Floating point test suite.
> + *
> + * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +#ifndef HW_POISON_H
> +#error Must define HW_POISON_H to work around TARGET_* poisoning
> +#endif
> +
> +#include "qemu/osdep.h"
> +#include "fpu/softfloat.h"
> +
> +#include <fenv.h>
> +#include <math.h>
> +
> +enum error {
> +    ERROR_NONE,
> +    ERROR_NOT_HANDLED,
> +    ERROR_WHITELISTED,
> +    ERROR_COMMENT,
> +    ERROR_INPUT,
> +    ERROR_RESULT,
> +    ERROR_EXCEPTIONS,
> +    ERROR_MAX,
> +};
> +
> +enum input_fmt {
> +    INPUT_FMT_IBM,
> +};
> +
> +struct input {
> +    const char * const name;
> +    enum error (*test_line)(const char *line);
> +};
> +
> +enum precision {
> +    PREC_FLOAT,
> +    PREC_DOUBLE,
> +    PREC_QUAD,
> +    PREC_FLOAT_TO_DOUBLE,
> +};

Again we will want to include half-precision.

> +
> +struct op_desc {
> +    const char * const name;
> +    int n_operands;
> +};
> +
> +enum op {
> +    OP_ADD,
> +    OP_SUB,
> +    OP_MUL,
> +    OP_MULADD,
> +    OP_DIV,
> +    OP_SQRT,
> +    OP_MINNUM,
> +    OP_MAXNUM,
> +    OP_MAXNUMMAG,
> +    OP_ABS,
> +    OP_IS_NAN,
> +    OP_IS_INF,
> +    OP_FLOAT_TO_DOUBLE,
> +};
> +
> +static const struct op_desc ops[] =3D {
> +    [OP_ADD] =3D       { "+", 2 },
> +    [OP_SUB] =3D       { "-", 2 },
> +    [OP_MUL] =3D       { "*", 2 },
> +    [OP_MULADD] =3D    { "*+", 3 },
> +    [OP_DIV] =3D       { "/", 2 },
> +    [OP_SQRT] =3D      { "V", 1 },
> +    [OP_MINNUM] =3D    { "<C", 2 },
> +    [OP_MAXNUM] =3D    { ">C", 2 },
> +    [OP_MAXNUMMAG] =3D { ">A", 2 },
> +    [OP_ABS] =3D       { "A", 1 },
> +    [OP_IS_NAN] =3D    { "?N", 1 },
> +    [OP_IS_INF] =3D    { "?i", 1 },
> +    [OP_FLOAT_TO_DOUBLE] =3D { "cff", 1 },
> +};
> +
> +/*
> + * We could enumerate all the types here. But really we only care about
> + * QNaN and SNaN since only those can vary across ISAs.
> + */
> +enum op_type {
> +    OP_TYPE_NUMBER,
> +    OP_TYPE_QNAN,
> +    OP_TYPE_SNAN,
> +};
> +
> +struct operand {
> +    uint64_t val;
> +    enum op_type type;
> +};
> +
> +struct test_op {
> +    struct operand operands[3];
> +    struct operand expected_result;
> +    enum precision prec;
> +    enum op op;
> +    signed char round;
> +    uint8_t trapped_exceptions;
> +    uint8_t exceptions;
> +    bool expected_result_is_valid;
> +};
> +
> +typedef enum error (*tester_func_t)(struct test_op *);
> +
> +struct tester {
> +    tester_func_t func;
> +    const char *name;
> +};
> +
> +struct whitelist {
> +    char **lines;
> +    size_t n;
> +    GHashTable *ht;
> +};
> +
> +static uint64_t test_stats[ERROR_MAX];
> +static struct whitelist whitelist;
> +static uint8_t default_exceptions;
> +static bool die_on_error =3D true;
> +static struct float_status soft_status =3D {
> +    .float_detect_tininess =3D float_tininess_before_rounding,
> +};
> +
> +static inline float u64_to_float(uint64_t v)
> +{
> +    uint32_t v32 =3D v;
> +    uint32_t *v32p =3D &v32;
> +
> +    return *(float *)v32p;
> +}
> +
> +static inline double u64_to_double(uint64_t v)
> +{
> +    uint64_t *vp =3D &v;
> +
> +    return *(double *)vp;
> +}
> +
> +static inline uint64_t float_to_u64(float f)
> +{
> +    float *fp =3D &f;
> +
> +    return *(uint32_t *)fp;
> +}
> +
> +static inline uint64_t double_to_u64(double d)
> +{
> +    double *dp =3D &d;
> +
> +    return *(uint64_t *)dp;
> +}
> +
> +static inline bool is_err(enum error err)
> +{
> +    return err !=3D ERROR_NONE &&
> +        err !=3D ERROR_NOT_HANDLED &&
> +        err !=3D ERROR_WHITELISTED &&
> +        err !=3D ERROR_COMMENT;
> +}
> +
> +static int host_exceptions_translate(int host_flags)
> +{
> +    int flags =3D 0;
> +
> +    if (host_flags & FE_INEXACT) {
> +        flags |=3D float_flag_inexact;
> +    }
> +    if (host_flags & FE_UNDERFLOW) {
> +        flags |=3D float_flag_underflow;
> +    }
> +    if (host_flags & FE_OVERFLOW) {
> +        flags |=3D float_flag_overflow;
> +    }
> +    if (host_flags & FE_DIVBYZERO) {
> +        flags |=3D float_flag_divbyzero;
> +    }
> +    if (host_flags & FE_INVALID) {
> +        flags |=3D float_flag_invalid;
> +    }
> +    return flags;
> +}
> +
> +static inline uint8_t host_get_exceptions(void)
> +{
> +    return host_exceptions_translate(fetestexcept(FE_ALL_EXCEPT));
> +}
> +
> +static void host_set_exceptions(uint8_t flags)
> +{
> +    int host_flags =3D 0;
> +
> +    if (flags & float_flag_inexact) {
> +        host_flags |=3D FE_INEXACT;
> +    }
> +    if (flags & float_flag_underflow) {
> +        host_flags |=3D FE_UNDERFLOW;
> +    }
> +    if (flags & float_flag_overflow) {
> +        host_flags |=3D FE_OVERFLOW;
> +    }
> +    if (flags & float_flag_divbyzero) {
> +        host_flags |=3D FE_DIVBYZERO;
> +    }
> +    if (flags & float_flag_invalid) {
> +        host_flags |=3D FE_INVALID;
> +    }
> +    feraiseexcept(host_flags);
> +}
> +
> +#define STANDARD_EXCEPTIONS \
> +    (float_flag_inexact | float_flag_underflow | \
> +     float_flag_overflow | float_flag_divbyzero | float_flag_invalid)
> +#define FMT_EXCEPTIONS "%s%s%s%s%s%s"
> +#define PR_EXCEPTIONS(x)                                \
> +        ((x) & STANDARD_EXCEPTIONS ? "" : "none"),      \
> +        (((x) & float_flag_inexact)   ? "x" : ""),      \
> +        (((x) & float_flag_underflow) ? "u" : ""),      \
> +        (((x) & float_flag_overflow)  ? "o" : ""),      \
> +        (((x) & float_flag_divbyzero) ? "z" : ""),      \
> +        (((x) & float_flag_invalid)   ? "i" : "")
> +
> +static enum error tester_check(const struct test_op *t, uint64_t res64,
> +                               bool res_is_nan, uint8_t flags)
> +{
> +    enum error err =3D ERROR_NONE;
> +
> +    if (t->expected_result_is_valid) {
> +        if (t->expected_result.type =3D=3D OP_TYPE_QNAN ||
> +            t->expected_result.type =3D=3D OP_TYPE_SNAN) {
> +            if (!res_is_nan) {
> +                err =3D ERROR_RESULT;
> +                goto out;
> +            }
> +        } else if (res64 !=3D t->expected_result.val) {
> +            err =3D ERROR_RESULT;
> +            goto out;
> +        }
> +    }
> +    if (t->exceptions && flags !=3D (t->exceptions | default_exceptions)=
) {
> +        err =3D ERROR_EXCEPTIONS;
> +        goto out;
> +    }
> +
> + out:
> +    if (is_err(err)) {
> +        int i;
> +
> +        fprintf(stderr, "%s ", ops[t->op].name);
> +        for (i =3D 0; i < ops[t->op].n_operands; i++) {
> +            fprintf(stderr, "0x%" PRIx64 "%s", t->operands[i].val,
> +                    i < ops[t->op].n_operands - 1 ? " " : "");
> +        }
> +        fprintf(stderr, ", expected: 0x%" PRIx64 ", returned: 0x%" PRIx6=
4,
> +                t->expected_result.val, res64);
> +        if (err =3D=3D ERROR_EXCEPTIONS) {
> +            fprintf(stderr, ", expected exceptions: " FMT_EXCEPTIONS
> +                    ", returned: " FMT_EXCEPTIONS,
> +                    PR_EXCEPTIONS(t->exceptions), PR_EXCEPTIONS(flags));
> +        }
> +        fprintf(stderr, "\n");
> +    }
> +    return err;
> +}
> +
> +static enum error host_tester(struct test_op *t)
> +{
> +    uint64_t res64;
> +    bool result_is_nan;
> +    uint8_t flags =3D 0;
> +
> +    feclearexcept(FE_ALL_EXCEPT);
> +    if (default_exceptions) {
> +        host_set_exceptions(default_exceptions);
> +    }
> +
> +    if (t->prec =3D=3D PREC_FLOAT) {
> +        float a, b, c;
> +        float *in[] =3D { &a, &b, &c };
> +        float res;
> +        int i;
> +
> +        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
> +        for (i =3D 0; i < ops[t->op].n_operands; i++) {
> +            /* use the host's QNaN/SNaN patterns */
> +            if (t->operands[i].type =3D=3D OP_TYPE_QNAN) {
> +                *in[i] =3D __builtin_nanf("");
> +            } else if (t->operands[i].type =3D=3D OP_TYPE_SNAN) {
> +                *in[i] =3D __builtin_nansf("");
> +            } else {
> +                *in[i] =3D u64_to_float(t->operands[i].val);
> +            }
> +        }
> +
> +        if (t->expected_result.type =3D=3D OP_TYPE_QNAN) {
> +            t->expected_result.val =3D float_to_u64(__builtin_nanf(""));
> +        } else if (t->expected_result.type =3D=3D OP_TYPE_SNAN) {
> +            t->expected_result.val =3D float_to_u64(__builtin_nansf(""));
> +        }
> +
> +        switch (t->op) {
> +        case OP_ADD:
> +            res =3D a + b;
> +            break;
> +        case OP_SUB:
> +            res =3D a - b;
> +            break;
> +        case OP_MUL:
> +            res =3D a * b;
> +            break;
> +        case OP_MULADD:
> +            res =3D fmaf(a, b, c);
> +            break;
> +        case OP_DIV:
> +            res =3D a / b;
> +            break;
> +        case OP_SQRT:
> +            res =3D sqrtf(a);
> +            break;
> +        case OP_ABS:
> +            res =3D fabsf(a);
> +            break;
> +        case OP_IS_NAN:
> +            res =3D !!isnan(a);
> +            break;
> +        case OP_IS_INF:
> +            res =3D !!isinf(a);
> +            break;
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        flags =3D host_get_exceptions();
> +        res64 =3D float_to_u64(res);
> +        result_is_nan =3D isnan(res);
> +    } else if (t->prec =3D=3D PREC_DOUBLE) {
> +        double a, b, c;
> +        double *in[] =3D { &a, &b, &c };
> +        double res;
> +        int i;
> +
> +        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
> +        for (i =3D 0; i < ops[t->op].n_operands; i++) {
> +            /* use the host's QNaN/SNaN patterns */
> +            if (t->operands[i].type =3D=3D OP_TYPE_QNAN) {
> +                *in[i] =3D __builtin_nan("");
> +            } else if (t->operands[i].type =3D=3D OP_TYPE_SNAN) {
> +                *in[i] =3D __builtin_nans("");
> +            } else {
> +                *in[i] =3D u64_to_double(t->operands[i].val);
> +            }
> +        }
> +
> +        if (t->expected_result.type =3D=3D OP_TYPE_QNAN) {
> +            t->expected_result.val =3D double_to_u64(__builtin_nan(""));
> +        } else if (t->expected_result.type =3D=3D OP_TYPE_SNAN) {
> +            t->expected_result.val =3D double_to_u64(__builtin_nans(""));
> +        }
> +
> +        switch (t->op) {
> +        case OP_ADD:
> +            res =3D a + b;
> +            break;
> +        case OP_SUB:
> +            res =3D a - b;
> +            break;
> +        case OP_MUL:
> +            res =3D a * b;
> +            break;
> +        case OP_MULADD:
> +            res =3D fma(a, b, c);
> +            break;
> +        case OP_DIV:
> +            res =3D a / b;
> +            break;
> +        case OP_SQRT:
> +            res =3D sqrt(a);
> +            break;
> +        case OP_ABS:
> +            res =3D fabs(a);
> +            break;
> +        case OP_IS_NAN:
> +            res =3D !!isnan(a);
> +            break;
> +        case OP_IS_INF:
> +            res =3D !!isinf(a);
> +            break;
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        flags =3D host_get_exceptions();
> +        res64 =3D double_to_u64(res);
> +        result_is_nan =3D isnan(res);
> +    } else if (t->prec =3D=3D PREC_FLOAT_TO_DOUBLE) {
> +        float a;
> +        double res;
> +
> +        if (t->operands[0].type =3D=3D OP_TYPE_QNAN) {
> +            a =3D __builtin_nanf("");
> +        } else if (t->operands[0].type =3D=3D OP_TYPE_SNAN) {
> +            a =3D __builtin_nansf("");
> +        } else {
> +            a =3D u64_to_float(t->operands[0].val);
> +        }
> +
> +        if (t->expected_result.type =3D=3D OP_TYPE_QNAN) {
> +            t->expected_result.val =3D double_to_u64(__builtin_nan(""));
> +        } else if (t->expected_result.type =3D=3D OP_TYPE_SNAN) {
> +            t->expected_result.val =3D double_to_u64(__builtin_nans(""));
> +        }
> +
> +        switch (t->op) {
> +        case OP_FLOAT_TO_DOUBLE:
> +            res =3D a;
> +            break;
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        flags =3D host_get_exceptions();
> +        res64 =3D double_to_u64(res);
> +        result_is_nan =3D isnan(res);
> +    } else {
> +        return ERROR_NOT_HANDLED; /* XXX */
> +    }
> +    return tester_check(t, res64, result_is_nan, flags);
> +}
> +
> +static enum error soft_tester(struct test_op *t)
> +{
> +    float_status *s =3D &soft_status;
> +    uint64_t res64;
> +    enum error err =3D ERROR_NONE;
> +    bool result_is_nan;
> +
> +    s->float_rounding_mode =3D t->round;
> +    s->float_exception_flags =3D default_exceptions;
> +
> +    if (t->prec =3D=3D PREC_FLOAT) {
> +        float32 a, b, c;
> +        float32 *in[] =3D { &a, &b, &c };
> +        float32 res;
> +        int i;
> +
> +        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
> +        for (i =3D 0; i < ops[t->op].n_operands; i++) {
> +            *in[i] =3D t->operands[i].val;
> +        }
> +
> +        switch (t->op) {
> +        case OP_ADD:
> +            res =3D float32_add(a, b, s);
> +            break;
> +        case OP_SUB:
> +            res =3D float32_sub(a, b, s);
> +            break;
> +        case OP_MUL:
> +            res =3D float32_mul(a, b, s);
> +            break;
> +        case OP_MULADD:
> +            res =3D float32_muladd(a, b, c, 0, s);
> +            break;
> +        case OP_DIV:
> +            res =3D float32_div(a, b, s);
> +            break;
> +        case OP_SQRT:
> +            res =3D float32_sqrt(a, s);
> +            break;
> +        case OP_MINNUM:
> +            res =3D float32_minnum(a, b, s);
> +            break;
> +        case OP_MAXNUM:
> +            res =3D float32_maxnum(a, b, s);
> +            break;
> +        case OP_MAXNUMMAG:
> +            res =3D float32_maxnummag(a, b, s);
> +            break;
> +        case OP_IS_NAN:
> +        {
> +            float f =3D !!float32_is_any_nan(a);
> +
> +            res =3D float_to_u64(f);
> +            break;
> +        }
> +        case OP_IS_INF:
> +        {
> +            float f =3D !!float32_is_infinity(a);
> +
> +            res =3D float_to_u64(f);
> +            break;
> +        }
> +        case OP_ABS:
> +            /* Fall-through: float32_abs does not handle NaN's */
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        res64 =3D res;
> +        result_is_nan =3D isnan(*(float *)&res);
> +    } else if (t->prec =3D=3D PREC_DOUBLE) {
> +        float64 a, b, c;
> +        float64 *in[] =3D { &a, &b, &c };
> +        int i;
> +
> +        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
> +        for (i =3D 0; i < ops[t->op].n_operands; i++) {
> +            *in[i] =3D t->operands[i].val;
> +        }
> +
> +        switch (t->op) {
> +        case OP_ADD:
> +            res64 =3D float64_add(a, b, s);
> +            break;
> +        case OP_SUB:
> +            res64 =3D float64_sub(a, b, s);
> +            break;
> +        case OP_MUL:
> +            res64 =3D float64_mul(a, b, s);
> +            break;
> +        case OP_MULADD:
> +            res64 =3D float64_muladd(a, b, c, 0, s);
> +            break;
> +        case OP_DIV:
> +            res64 =3D float64_div(a, b, s);
> +            break;
> +        case OP_SQRT:
> +            res64 =3D float64_sqrt(a, s);
> +            break;
> +        case OP_MINNUM:
> +            res64 =3D float64_minnum(a, b, s);
> +            break;
> +        case OP_MAXNUM:
> +            res64 =3D float64_maxnum(a, b, s);
> +            break;
> +        case OP_MAXNUMMAG:
> +            res64 =3D float64_maxnummag(a, b, s);
> +            break;
> +        case OP_IS_NAN:
> +        {
> +            double d =3D !!float64_is_any_nan(a);
> +
> +            res64 =3D double_to_u64(d);
> +            break;
> +        }
> +        case OP_IS_INF:
> +        {
> +            double d =3D !!float64_is_infinity(a);
> +
> +            res64 =3D double_to_u64(d);
> +            break;
> +        }
> +        case OP_ABS:
> +            /* Fall-through: float64_abs does not handle NaN's */
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        result_is_nan =3D isnan(*(double *)&res64);
> +    } else if (t->prec =3D=3D PREC_FLOAT_TO_DOUBLE) {
> +        float32 a =3D t->operands[0].val;
> +
> +        switch (t->op) {
> +        case OP_FLOAT_TO_DOUBLE:
> +            res64 =3D float32_to_float64(a, s);
> +            break;
> +        default:
> +            return ERROR_NOT_HANDLED;
> +        }
> +        result_is_nan =3D isnan(*(double *)&res64);
> +    } else {
> +        return ERROR_NOT_HANDLED; /* XXX */
> +    }
> +    return tester_check(t, res64, result_is_nan, s->float_exception_flag=
s);
> +    return err;
> +}
> +
> +static const struct tester valid_testers[] =3D {
> +    [0] =3D {
> +        .name =3D "soft",
> +        .func =3D soft_tester,
> +    },
> +    [1] =3D {
> +        .name =3D "host",
> +        .func =3D host_tester,
> +    },
> +};
> +static const struct tester *tester =3D &valid_testers[0];
> +
> +static int ibm_get_exceptions(const char *p, uint8_t *excp)
> +{
> +    while (*p) {
> +        switch (*p) {
> +        case 'x':
> +            *excp |=3D float_flag_inexact;
> +            break;
> +        case 'u':
> +            *excp |=3D float_flag_underflow;
> +            break;
> +        case 'o':
> +            *excp |=3D float_flag_overflow;
> +            break;
> +        case 'z':
> +            *excp |=3D float_flag_divbyzero;
> +            break;
> +        case 'i':
> +            *excp |=3D float_flag_invalid;
> +            break;
> +        default:
> +            return 1;
> +        }
> +        p++;
> +    }
> +    return 0;
> +}
> +
> +static uint64_t fp_choose(enum precision prec, uint64_t f, uint64_t d)
> +{
> +    switch (prec) {
> +    case PREC_FLOAT:
> +        return f;
> +    case PREC_DOUBLE:
> +        return d;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static int
> +ibm_fp_hex(const char *p, enum precision prec, struct operand *ret)
> +{
> +    int len;
> +
> +    ret->type =3D OP_TYPE_NUMBER;
> +
> +    /* QNaN */
> +    if (unlikely(!strcmp("Q", p))) {
> +        ret->val =3D fp_choose(prec, 0xffc00000, 0xfff8000000000000);
> +        ret->type =3D OP_TYPE_QNAN;
> +        return 0;
> +    }
> +    /* SNaN */
> +    if (unlikely(!strcmp("S", p))) {
> +        ret->val =3D fp_choose(prec, 0xffb00000, 0xfff7000000000000);
> +        ret->type =3D OP_TYPE_SNAN;
> +        return 0;
> +    }
> +    if (unlikely(!strcmp("+Zero", p))) {
> +        ret->val =3D fp_choose(prec, 0x00000000, 0x0000000000000000);
> +        return 0;
> +    }
> +    if (unlikely(!strcmp("-Zero", p))) {
> +        ret->val =3D fp_choose(prec, 0x80000000, 0x8000000000000000);
> +        return 0;
> +    }
> +    if (unlikely(!strcmp("+inf", p) || !strcmp("+Inf", p))) {
> +        ret->val =3D fp_choose(prec, 0x7f800000, 0x7ff0000000000000);
> +        return 0;
> +    }
> +    if (unlikely(!strcmp("-inf", p) || !strcmp("-Inf", p))) {
> +        ret->val =3D fp_choose(prec, 0xff800000, 0xfff0000000000000);
> +        return 0;
> +    }
> +
> +    len =3D strlen(p);
> +
> +    if (strchr(p, 'P')) {

Given we have already strlen'ed should we use memchr(p, 'P', len) or
even strchrnul(p,'P') with a check we haven't run over the end? OR maybe
use glib's string stuff instead.

> +        bool negative =3D p[0] =3D=3D '-';
> +        char *pos;
> +        bool denormal;
> +
> +        if (len <=3D 4) {
> +            return 1;
> +        }
> +        denormal =3D p[1] =3D=3D '0';
> +        if (prec =3D=3D PREC_FLOAT) {
> +            uint32_t exponent;
> +            uint32_t significand;
> +            uint32_t h;
> +
> +            significand =3D strtoul(&p[3], &pos, 16);
> +            if (*pos !=3D 'P') {
> +                return 1;
> +            }
> +            pos++;
> +            exponent =3D strtol(pos, &pos, 10) + 127;
> +            if (pos !=3D p + len) {
> +                return 1;
> +            }
> +            /*
> +             * When there's a leading zero, we have a denormal number. W=
e'd
> +             * expect the input (unbiased) exponent to be -127, but for =
some
> +             * reason -126 is used. Correct that here.
> +             */
> +            if (denormal) {
> +                if (exponent !=3D 1) {
> +                    return 1;
> +                }
> +                exponent =3D 0;
> +            }
> +            h =3D negative ? (1 << 31) : 0;
> +            h |=3D exponent << 23;
> +            h |=3D significand;
> +            ret->val =3D h;
> +            return 0;
> +        } else if (prec =3D=3D PREC_DOUBLE) {
> +            uint64_t exponent;
> +            uint64_t significand;
> +            uint64_t h;
> +
> +            significand =3D strtoul(&p[3], &pos, 16);
> +            if (*pos !=3D 'P') {
> +                return 1;
> +            }
> +            pos++;
> +            exponent =3D strtol(pos, &pos, 10) + 1023;
> +            if (pos !=3D p + len) {
> +                return 1;
> +            }
> +            if (denormal) {
> +                return 1; /* XXX */
> +            }
> +            h =3D negative ? (1ULL << 63) : 0;
> +            h |=3D exponent << 52;
> +            h |=3D significand;
> +            ret->val =3D h;
> +            return 0;
> +        } else { /* XXX */
> +            return 1;
> +        }
> +    } else if (strchr(p, 'e')) {
> +        char *pos;
> +
> +        if (prec =3D=3D PREC_FLOAT) {
> +            float f =3D strtof(p, &pos);
> +
> +            if (*pos) {
> +                return 1;
> +            }
> +            ret->val =3D float_to_u64(f);
> +            return 0;
> +        }
> +        if (prec =3D=3D PREC_DOUBLE) {
> +            double d =3D strtod(p, &pos);
> +
> +            if (*pos) {
> +                return 1;
> +            }
> +            ret->val =3D double_to_u64(d);
> +            return 0;
> +        }
> +        return 0;
> +    } else if (!strcmp(p, "0x0")) {
> +        if (prec =3D=3D PREC_FLOAT) {
> +            ret->val =3D float_to_u64(0.0);
> +        } else if (prec =3D=3D PREC_DOUBLE) {
> +            ret->val =3D double_to_u64(0.0);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +        return 0;
> +    } else if (!strcmp(p, "0x1")) {
> +        if (prec =3D=3D PREC_FLOAT) {
> +            ret->val =3D float_to_u64(1.0);
> +        } else if (prec =3D=3D PREC_DOUBLE) {
> +            ret->val =3D double_to_u64(1.0);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +        return 0;
> +    }
> +    return 1;
> +}
> +
> +static int find_op(const char *name, enum op *op)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(ops); i++) {
> +        if (strcmp(ops[i].name, name) =3D=3D 0) {
> +            *op =3D i;
> +            return 0;
> +        }
> +    }
> +    return 1;
> +}
> +
> +/* Syntax of IBM FP test cases:
> + * https://www.research.ibm.com/haifa/projects/verification/fpgen/syntax=
.txt
> + */
> +static enum error ibm_test_line(const char *line)
> +{
> +    struct test_op t;
> +    /* at most nine fields; this should be more than enough for each fie=
ld */
> +    char s[9][64];
> +    char *p;
> +    int n, field;
> +    int i;
> +
> +    /* data lines start with either b32 or d(64|128) */
> +    if (unlikely(line[0] !=3D 'b' && line[0] !=3D 'd')) {
> +        return ERROR_COMMENT;
> +    }
> +    n =3D sscanf(line, "%63s %63s %63s %63s %63s %63s %63s %63s %63s",
> +               s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8]);
> +    if (unlikely(n < 5 || n > 9)) {
> +        return ERROR_INPUT;
> +    }

Personally I find g_strsplit(line, " ", 9) and g_strfreev() handy for
this sort of parsing.

> +
> +    field =3D 0;
> +    p =3D s[field];
> +    if (unlikely(strlen(p) < 4)) {
> +        return ERROR_INPUT;
> +    }
> +    if (strcmp("b32b64cff", p) =3D=3D 0) {
> +        t.prec =3D PREC_FLOAT_TO_DOUBLE;
> +        if (find_op(&p[6], &t.op)) {
> +            return ERROR_NOT_HANDLED;
> +        }
> +    } else {
> +        if (strncmp("b32", p, 3) =3D=3D 0) {
> +            t.prec =3D PREC_FLOAT;
> +        } else if (strncmp("d64", p, 3) =3D=3D 0) {
> +            t.prec =3D PREC_DOUBLE;
> +        } else if (strncmp("d128", p, 4) =3D=3D 0) {
> +            return ERROR_NOT_HANDLED; /* XXX */
> +        } else {
> +            return ERROR_INPUT;
> +        }
> +        if (find_op(&p[3], &t.op)) {
> +            return ERROR_NOT_HANDLED;
> +        }
> +    }
> +
> +    field =3D 1;
> +    p =3D s[field];
> +    if (!strncmp("=3D0", p, 2)) {
> +        t.round =3D float_round_nearest_even;
> +    } else {
> +        return ERROR_NOT_HANDLED; /* XXX */
> +    }
> +
> +    /* The trapped exceptions field is optional */
> +    t.trapped_exceptions =3D 0;
> +    field =3D 2;
> +    p =3D s[field];
> +    if (ibm_get_exceptions(p, &t.trapped_exceptions)) {
> +        if (unlikely(n =3D=3D 9)) {
> +            return ERROR_INPUT;
> +        }
> +    } else {
> +        field++;
> +    }
> +
> +    for (i =3D 0; i < ops[t.op].n_operands; i++) {
> +        enum precision prec =3D t.prec =3D=3D PREC_FLOAT_TO_DOUBLE ?
> +            PREC_FLOAT : t.prec;
> +
> +        p =3D s[field++];
> +        if (ibm_fp_hex(p, prec, &t.operands[i])) {
> +            return ERROR_INPUT;
> +        }
> +    }
> +
> +    p =3D s[field++];
> +    if (strcmp("->", p)) {
> +        return ERROR_INPUT;
> +    }
> +
> +    p =3D s[field++];
> +    if (unlikely(strcmp("#", p) =3D=3D 0)) {
> +        t.expected_result_is_valid =3D false;
> +    } else {
> +        enum precision prec =3D t.prec =3D=3D PREC_FLOAT_TO_DOUBLE ?
> +            PREC_DOUBLE : t.prec;
> +
> +        if (ibm_fp_hex(p, prec, &t.expected_result)) {
> +            return ERROR_INPUT;
> +        }
> +        t.expected_result_is_valid =3D true;
> +    }
> +
> +    /*
> +     * A 0 here means "do not check the exceptions", i.e. it does NOT me=
an
> +     * "there should be no exceptions raised".
> +     */
> +    t.exceptions =3D 0;
> +    /* the expected exceptions field is optional */
> +    if (field =3D=3D n - 1) {
> +        p =3D s[field++];
> +        if (ibm_get_exceptions(p, &t.exceptions)) {
> +            return ERROR_INPUT;
> +        }
> +    }
> +
> +    /*
> +     * We ignore "trapped exceptions" because we're not testing the trap=
ping
> +     * mechanism of the host CPU.
> +     * We test though that the exception bits are correctly set.
> +     */
> +    if (t.trapped_exceptions) {
> +        return ERROR_NOT_HANDLED;
> +    }
> +    return tester->func(&t);
> +}
> +
> +static const struct input valid_input_types[] =3D {
> +    [INPUT_FMT_IBM] =3D {
> +        .name =3D "ibm",
> +        .test_line =3D ibm_test_line,
> +    },
> +};
> +
> +static const struct input *input_type =3D &valid_input_types[INPUT_FMT_I=
BM];
> +
> +static bool line_is_whitelisted(const char *line)
> +{
> +    if (whitelist.ht =3D=3D NULL) {
> +        return false;
> +    }
> +    return !!g_hash_table_lookup(whitelist.ht, line);
> +}
> +
> +static void test_file(const char *filename)
> +{
> +    static char line[256];
> +    unsigned int i;
> +    FILE *fp;
> +
> +    fp =3D fopen(filename, "r");
> +    if (fp =3D=3D NULL) {
> +        fprintf(stderr, "cannot open file '%s': %s\n",
> +                filename, strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
> +    i =3D 0;
> +    while (fgets(line, sizeof(line), fp)) {
> +        enum error err;
> +
> +        i++;
> +        if (unlikely(line_is_whitelisted(line))) {
> +            test_stats[ERROR_WHITELISTED]++;
> +            continue;
> +        }
> +        err =3D input_type->test_line(line);
> +        if (unlikely(is_err(err))) {
> +            switch (err) {
> +            case ERROR_INPUT:
> +                fprintf(stderr, "error: malformed input @ %s:%d:\n",
> +                        filename, i);
> +                break;
> +            case ERROR_RESULT:
> +                fprintf(stderr, "error: result mismatch for input @ %s:%=
d:\n",
> +                        filename, i);
> +                break;
> +            case ERROR_EXCEPTIONS:
> +                fprintf(stderr, "error: flags mismatch for input @ %s:%d=
:\n",
> +                        filename, i);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            fprintf(stderr, "%s", line);
> +            if (die_on_error) {
> +                exit(EXIT_FAILURE);
> +            }
> +        }
> +        test_stats[err]++;
> +    }
> +    if (fclose(fp)) {
> +        fprintf(stderr, "warning: cannot close file '%s': %s\n",
> +                filename, strerror(errno));
> +    }
> +}
> +
> +static void set_input_fmt(const char *optarg)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(valid_input_types); i++) {
> +        const struct input *type =3D &valid_input_types[i];
> +
> +        if (strcmp(optarg, type->name) =3D=3D 0) {
> +            input_type =3D type;
> +            return;
> +        }
> +    }
> +    fprintf(stderr, "Unknown input format '%s'", optarg);
> +    exit(EXIT_FAILURE);
> +}
> +
> +static void set_tester(const char *optarg)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(valid_testers); i++) {
> +        const struct tester *t =3D &valid_testers[i];
> +
> +        if (strcmp(optarg, t->name) =3D=3D 0) {
> +            tester =3D t;
> +            return;
> +        }
> +    }
> +    fprintf(stderr, "Unknown tester '%s'", optarg);
> +    exit(EXIT_FAILURE);
> +}
> +
> +static void whitelist_add_line(const char *orig_line)
> +{
> +    char *line;
> +    bool inserted;
> +
> +    if (whitelist.ht =3D=3D NULL) {
> +        whitelist.ht =3D g_hash_table_new(g_str_hash, g_str_equal);
> +    }
> +    line =3D g_hash_table_lookup(whitelist.ht, orig_line);
> +    if (unlikely(line !=3D NULL)) {
> +        return;
> +    }
> +    whitelist.n++;
> +    whitelist.lines =3D g_realloc_n(whitelist.lines, whitelist.n, sizeof=
(line));
> +    line =3D strdup(orig_line);
> +    whitelist.lines[whitelist.n - 1] =3D line;
> +    /* if we pass key =3D=3D val GLib will not reserve space for the val=
ue */
> +    inserted =3D g_hash_table_insert(whitelist.ht, line, line);
> +    g_assert(inserted);
> +}
> +
> +static void set_whitelist(const char *filename)
> +{
> +    FILE *fp;
> +    static char line[256];
> +
> +    fp =3D fopen(filename, "r");
> +    if (fp =3D=3D NULL) {
> +        fprintf(stderr, "warning: cannot open white list file '%s': %s\n=
",
> +                filename, strerror(errno));
> +        return;
> +    }
> +    while (fgets(line, sizeof(line), fp)) {
> +        if (isspace(line[0]) || line[0] =3D=3D '#') {
> +            continue;
> +        }
> +        whitelist_add_line(line);
> +    }
> +    if (fclose(fp)) {
> +        fprintf(stderr, "warning: cannot close file '%s': %s\n",
> +                filename, strerror(errno));
> +    }
> +}
> +
> +static void set_default_exceptions(const char *str)
> +{
> +    if (ibm_get_exceptions(str, &default_exceptions)) {
> +        fprintf(stderr, "Invalid exception '%s'\n", str);
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +static void usage_complete(int argc, char *argv[])
> +{
> +    fprintf(stderr, "Usage: %s [options] file1 [file2 ...]\n", argv[0]);
> +    fprintf(stderr, "options:\n");
> +    fprintf(stderr, "  -a =3D Perform tininess detection after rounding "
> +            "(soft tester only). Default: before\n");
> +    fprintf(stderr, "  -n =3D do not die on error. Default: dies on erro=
r\n");
> +    fprintf(stderr, "  -e =3D default exception flags (xiozu). Default: =
none\n");
> +    fprintf(stderr, "  -f =3D format of the input file(s). Default: %s\n=
",
> +            valid_input_types[0].name);
> +    fprintf(stderr, "  -t =3D tester. Default: %s\n", valid_testers[0].n=
ame);
> +    fprintf(stderr, "  -w =3D path to file with test cases to be whiteli=
sted\n");
> +    fprintf(stderr, "  -z =3D flush inputs to zero (soft tester only). "
> +            "Default: disabled\n");
> +    fprintf(stderr, "  -Z =3D flush output to zero (soft tester only). "
> +            "Default: disabled\n");
> +}
> +
> +static void parse_opts(int argc, char *argv[])
> +{
> +    int c;
> +
> +    for (;;) {
> +        c =3D getopt(argc, argv, "ae:f:hnt:w:zZ");
> +        if (c < 0) {
> +            return;
> +        }
> +        switch (c) {
> +        case 'a':
> +            soft_status.float_detect_tininess =3D float_tininess_after_r=
ounding;
> +            break;
> +        case 'e':
> +            set_default_exceptions(optarg);
> +            break;
> +        case 'f':
> +            set_input_fmt(optarg);
> +            break;
> +        case 'h':
> +            usage_complete(argc, argv);
> +            exit(EXIT_SUCCESS);
> +        case 'n':
> +            die_on_error =3D false;
> +            break;
> +        case 't':
> +            set_tester(optarg);
> +            break;
> +        case 'w':
> +            set_whitelist(optarg);
> +            break;
> +        case 'z':
> +            soft_status.flush_inputs_to_zero =3D 1;
> +            break;
> +        case 'Z':
> +            soft_status.flush_to_zero =3D 1;
> +            break;
> +        }
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static uint64_t count_errors(void)
> +{
> +    uint64_t ret =3D 0;
> +    int i;
> +
> +    for (i =3D ERROR_INPUT; i < ERROR_MAX; i++) {
> +        ret +=3D test_stats[i];
> +    }
> +    return ret;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    uint64_t n_errors;
> +    int i;
> +
> +    if (argc =3D=3D 1) {
> +        usage_complete(argc, argv);
> +        exit(EXIT_FAILURE);
> +    }
> +    parse_opts(argc, argv);
> +    for (i =3D optind; i < argc; i++) {
> +        test_file(argv[i]);
> +    }
> +
> +    n_errors =3D count_errors();
> +    if (n_errors) {
> +        printf("Tests failed: %"PRIu64". Parsing: %"PRIu64
> +               ", result:%"PRIu64", flags:%"PRIu64"\n",
> +               n_errors, test_stats[ERROR_INPUT], test_stats[ERROR_RESUL=
T],
> +               test_stats[ERROR_EXCEPTIONS]);
> +    } else {
> +        printf("All tests OK.\n");
> +    }
> +    printf("Tests passed: %" PRIu64 ". Not handled: %" PRIu64
> +           ", whitelisted: %"PRIu64 "\n",
> +           test_stats[ERROR_NONE], test_stats[ERROR_NOT_HANDLED],
> +           test_stats[ERROR_WHITELISTED]);
> +    return !!n_errors;
> +}
> diff --git a/tests/.gitignore b/tests/.gitignore
> index df69175..f9b0f08 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -97,5 +97,6 @@ test-netfilter
>  test-filter-mirror
>  test-filter-redirector
>  *-test
> +!fp-test
>  qapi-schema/*.test.*
>  vm/*.img
> diff --git a/tests/fp-test/.gitignore b/tests/fp-test/.gitignore
> new file mode 100644
> index 0000000..e1e175c
> --- /dev/null
> +++ b/tests/fp-test/.gitignore
> @@ -0,0 +1,3 @@
> +ibm
> +whitelist.txt
> +fp-test
> diff --git a/tests/fp-test/Makefile b/tests/fp-test/Makefile
> new file mode 100644
> index 0000000..703434f
> --- /dev/null
> +++ b/tests/fp-test/Makefile
> @@ -0,0 +1,34 @@
> +BUILD_DIR=3D$(CURDIR)/../..
> +
> +include ../../config-host.mak
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/fp-test $(SRC_PATH)/fpu)
> +
> +QEMU_INCLUDES +=3D -I../..
> +QEMU_INCLUDES +=3D -I$(SRC_PATH)/fpu
> +# work around TARGET_* poisoning
> +QEMU_CFLAGS +=3D -DHW_POISON_H
> +
> +IBMFP :=3D ibm-fptests.zip
> +
> +OBJS :=3D fp-test$(EXESUF)
> +
> +WHITELIST_FILES :=3D whitelist.txt whitelist-tininess-after.txt
> +
> +all: $(OBJS) ibm $(WHITELIST_FILES)
> +
> +ibm:
> +	wget -nv -O $(IBMFP) http://www.haifa.il.ibm.com/projects/verification/=
fpgen/download/test_suite.zip
> +	mkdir -p $@
> +	unzip $(IBMFP) -d $@
> +	rm -rf $(IBMFP)
> +
> +# XXX: upload this to a qemu server, or just commit it.
> +$(WHITELIST_FILES):
> +	wget -nv -O $@ http://www.cs.columbia.edu/~cota/qemu/fpbench-$@
> +
> +fp-test$(EXESUF): fp-test.o softfloat.o
> +
> +clean:
> +	rm -f *.o *.d $(OBJS)


--
Alex Benn=C3=A9e
