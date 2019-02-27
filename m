Received: from eggs.gnu.org ([209.51.188.92]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxOi-0000dP-DP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyxFi-0002Xz-3v
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:19:55 -0500
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <353dcc05-2990-cd9d-9b6b-606f35426b23@redhat.com>
Date: Wed, 27 Feb 2019 12:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190227111411.22890-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 27.02.19 12:14, David Hildenbrand wrote:
> We want to make use of vectors, so use -march=z13. To make it compile,
> use a reasonable optimization level (-O2), which seems to work just fine
> with all tests.

Just double-checked, at least exrl-trt will need a fixup to work with -O2.

> 
> Add some infrastructure for checking if SIGILL will be properly
> triggered.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/tcg/s390x/Makefile.target     |  3 ++-
>  tests/tcg/s390x/helper.h            | 28 +++++++++++++++++++++
>  tests/tcg/s390x/signal_helper.inc.c | 39 +++++++++++++++++++++++++++++
>  tests/tcg/s390x/vlgv.c              | 37 +++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/s390x/helper.h
>  create mode 100644 tests/tcg/s390x/signal_helper.inc.c
>  create mode 100644 tests/tcg/s390x/vlgv.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 151dc075aa..d1ae755ab9 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -1,8 +1,9 @@
>  VPATH+=$(SRC_PATH)/tests/tcg/s390x
> -CFLAGS+=-march=zEC12 -m64
> +CFLAGS+=-march=z13 -m64 -O2
>  TESTS+=hello-s390x
>  TESTS+=csst
>  TESTS+=ipm
>  TESTS+=exrl-trt
>  TESTS+=exrl-trtr
>  TESTS+=pack
> +TESTS+=vlgv
> diff --git a/tests/tcg/s390x/helper.h b/tests/tcg/s390x/helper.h
> new file mode 100644
> index 0000000000..845b8bb504
> --- /dev/null
> +++ b/tests/tcg/s390x/helper.h
> @@ -0,0 +1,28 @@
> +#ifndef TEST_TCG_S390x_VECTOR_H
> +#define TEST_TCG_S390x_VECTOR_H
> +
> +#include <stdint.h>
> +
> +#define ES_8    0
> +#define ES_16   1
> +#define ES_32   2
> +#define ES_64   3
> +#define ES_128  4
> +
> +typedef union S390Vector {
> +    __uint128_t v;
> +    uint64_t q[2];
> +    uint32_t d[4];
> +    uint16_t w[8];
> +    uint8_t h[16];
> +} S390Vector;
> +
> +static inline void check(const char *s, bool cond)
> +{
> +    if (!cond) {
> +        fprintf(stderr, "Check failed: %s\n", s);
> +        exit(-1);
> +    }
> +}
> +
> +#endif /* TEST_TCG_S390x_VECTOR_H */
> diff --git a/tests/tcg/s390x/signal_helper.inc.c b/tests/tcg/s390x/signal_helper.inc.c
> new file mode 100644
> index 0000000000..5bd69ca76a
> --- /dev/null
> +++ b/tests/tcg/s390x/signal_helper.inc.c
> @@ -0,0 +1,39 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include "helper.h"
> +
> +jmp_buf jmp_env;
> +
> +static void sig_sigill(int sig)
> +{
> +    if (sig != SIGILL) {
> +        check("Wrong signal received", false);
> +    }
> +    longjmp(jmp_env, 1);
> +}
> +
> +#define CHECK_SIGILL(STATEMENT)                             \
> +do {                                                        \
> +    struct sigaction act;                                   \
> +                                                            \
> +    act.sa_handler = sig_sigill;                            \
> +    act.sa_flags = 0;                                       \
> +    if (sigaction(SIGILL, &act, NULL)) {                    \
> +        check("SIGILL handler not registered", false);      \
> +    }                                                       \
> +                                                            \
> +    if (setjmp(jmp_env) == 0) {                             \
> +        STATEMENT;                                          \
> +        check("SIGILL not triggered", false);               \
> +    }                                                       \
> +                                                            \
> +    act.sa_handler = SIG_DFL;                               \
> +    sigemptyset(&act.sa_mask);                              \
> +    act.sa_flags = 0;                                       \
> +    if (sigaction(SIGILL, &act, NULL)) {                    \
> +        check("SIGILL handler not unregistered", false);    \
> +    }                                                       \
> +} while (0)
> diff --git a/tests/tcg/s390x/vlgv.c b/tests/tcg/s390x/vlgv.c
> new file mode 100644
> index 0000000000..3c37ee2035
> --- /dev/null
> +++ b/tests/tcg/s390x/vlgv.c
> @@ -0,0 +1,37 @@
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "signal_helper.inc.c"
> +
> +static inline void vlgv(uint64_t *r1, S390Vector *v3, const void *a2,
> +                        uint8_t m4)
> +{
> +    asm volatile("vlgv %[r1], %[v3], 0(%[a2]), %[m4]\n"
> +                 : [r1] "+d" (*r1),
> +                   [v3] "+v" (v3->v)
> +                 : [a2] "d" (a2),
> +                   [m4] "i" (m4));
> +}
> +
> +int main(void)
> +{
> +    S390Vector v3 = {
> +        .q[0] = 0x0011223344556677ull,
> +        .q[1] = 0x8899aabbccddeeffull,
> +    };
> +    uint64_t r1 = 0;
> +
> +    /* Directly set all ignored bits to  */
> +    vlgv(&r1, &v3, (void *)(7 | ~0xf), ES_8);
> +    check("8 bit", r1 == 0x77);
> +    vlgv(&r1, &v3, (void *)(4 | ~0x7), ES_16);
> +    check("16 bit", r1 == 0x8899);
> +    vlgv(&r1, &v3, (void *)(3 | ~0x3), ES_32);
> +    check("32 bit", r1 == 0xccddeeff);
> +    vlgv(&r1, &v3, (void *)(1 | ~0x1), ES_64);
> +    check("64 bit", r1 == 0x8899aabbccddeeffull);
> +    check("v3 not modified", v3.q[0] == 0x0011223344556677ull &&
> +                             v3.q[1] == 0x8899aabbccddeeffull);
> +
> +    CHECK_SIGILL(vlgv(&r1, &v3, NULL, ES_128));
> +    return 0;
> +}
> 


-- 

Thanks,

David / dhildenb
