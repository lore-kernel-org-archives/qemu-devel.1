Received: from eggs.gnu.org ([209.51.188.92]:48196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzG1F-0004SA-PK
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzG1C-0000xA-SB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 02:22:13 -0500
References: <20190227211525.2470-1-david@redhat.com>
	<20190227211525.2470-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1f69344e-4b8f-9e39-3d40-6015641410dd@redhat.com>
Date: Thu, 28 Feb 2019 08:22:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190227211525.2470-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC2 1/2] tests/tcg: target/s390x: Test
 VECTOR GATHER ELEMENT
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

On 27.02.19 22:15, David Hildenbrand wrote:
> As want to make use of vectors in constraints of inline asm statements,
> use -march=z13. To make it compile, use a reasonable optimization level
> (-O2).
> 
> Add some infrastructure for checking if SIGILL will be properly triggered.
> Take care of manually unblocking the signal before doing the longjmp,
> otherwise it will remain blocked and eventually lead to the default
> handler getting executed on the next signal.
> 
> Use "signal" for now although checkpatch complains about portability. We
> only care about linux for s390x. If that ever changes, I'll happly
> convert it ;)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tests/tcg/s390x/Makefile.target     |  6 +++
>  tests/tcg/s390x/helper.h            | 22 +++++++++
>  tests/tcg/s390x/signal-helper.inc.c | 46 ++++++++++++++++++
>  tests/tcg/s390x/vge.c               | 75 +++++++++++++++++++++++++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 tests/tcg/s390x/helper.h
>  create mode 100644 tests/tcg/s390x/signal-helper.inc.c
>  create mode 100644 tests/tcg/s390x/vge.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 151dc075aa..474c2428bd 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -6,3 +6,9 @@ TESTS+=ipm
>  TESTS+=exrl-trt
>  TESTS+=exrl-trtr
>  TESTS+=pack
> +
> +VECTOR_TESTS=vge
> +TESTS+=$(VECTOR_TESTS)
> +
> +#enable vectors and optimisation for vector tests
> +$(VECTOR_TESTS): CFLAGS+=-march=z13 -O2
> diff --git a/tests/tcg/s390x/helper.h b/tests/tcg/s390x/helper.h
> new file mode 100644
> index 0000000000..ecbd97519b
> --- /dev/null
> +++ b/tests/tcg/s390x/helper.h
> @@ -0,0 +1,22 @@
> +#ifndef TEST_TCG_S390x_VECTOR_H
> +#define TEST_TCG_S390x_VECTOR_H

s/TEST_TCG_S390x_VECTOR_H/TEST_TCG_S390X_HELPER_H/

> +
> +#include <stdint.h>
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
> diff --git a/tests/tcg/s390x/signal-helper.inc.c b/tests/tcg/s390x/signal-helper.inc.c
> new file mode 100644
> index 0000000000..c214356ca1
> --- /dev/null
> +++ b/tests/tcg/s390x/signal-helper.inc.c
> @@ -0,0 +1,46 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <errno.h>
> +#include "helper.h"
> +
> +jmp_buf jmp_env;
> +
> +static int signal_unblock(int sig)
> +{
> +    sigset_t intmask;
> +
> +    if (sigemptyset(&intmask) ||
> +        sigaddset(&intmask, sig) ||
> +        sigprocmask(SIG_UNBLOCK, &intmask, NULL)) {
> +        return -errno;
> +    }
> +    return 0;
> +}
> +
> +static void handle_sigill(int sig)
> +{
> +    if (sig != SIGILL) {
> +        check("Wrong signal received", false);
> +    }
> +    if (signal_unblock(sig)) {
> +        check("Cannot unblock signal", false);
> +    }
> +    longjmp(jmp_env, 1);
> +}
> +
> +#define CHECK_SIGILL(STATEMENT)                         \
> +do {                                                    \
> +    if (signal(SIGILL, handle_sigill) == SIG_ERR) {     \
> +        check("SIGILL not registered", false);          \
> +    }                                                   \
> +    if (setjmp(jmp_env) == 0) {                         \
> +        STATEMENT;                                      \
> +        check("SIGILL not triggered", false);           \
> +    }                                                   \
> +    if (signal(SIGILL, SIG_DFL) == SIG_ERR) {           \
> +        check("SIGILL not registered", false);          \
> +    }                                                   \
> +} while (0)

So, this now boils down to (thanks Richard)

+jmp_buf jmp_env;
+
+static void handle_sigill(int sig)
+{
+    if (sig != SIGILL) {
+        check("Wrong signal received", false);
+    }
+    siglongjmp(jmp_env, 1);
+}
+
+#define CHECK_SIGILL(STATEMENT)                         \
+do {                                                    \
+    if (signal(SIGILL, handle_sigill) == SIG_ERR) {     \
+        check("SIGILL not registered", false);          \
+    }                                                   \
+    if (sigsetjmp(jmp_env, 1) == 0) {                   \
+        STATEMENT;                                      \
+        check("SIGILL not triggered", false);           \
+    }                                                   \
+    if (signal(SIGILL, SIG_DFL) == SIG_ERR) {           \
+        check("SIGILL not registered", false);          \
+    }                                                   \
+} while (0)


> diff --git a/tests/tcg/s390x/vge.c b/tests/tcg/s390x/vge.c
> new file mode 100644
> index 0000000000..7760be3a1b
> --- /dev/null
> +++ b/tests/tcg/s390x/vge.c
> @@ -0,0 +1,75 @@
> +#include <stdint.h>
> +#include <unistd.h>
> +#include "signal-helper.inc.c"
> +
> +static inline void vgef(S390Vector *v1, S390Vector *v2, const void *a2,
> +                        uint8_t m3)
> +{
> +    asm volatile("vgef %[v1], 0(%[v2], %[a2]), %[m3]\n"
> +                 : [v1] "+v" (v1->v),
> +                   [v2] "+v" (v2->v)
> +                 : [a2] "d" (a2),
> +                   [m3] "i" (m3));
> +}
> +
> +static void test_vgef(void)
> +{
> +    uint32_t data = 0x12345678ul;
> +    S390Vector v1 = {
> +        .q[0] = -1ull,
> +        .q[1] = -1ull,
> +    };
> +    S390Vector v2 = {
> +        .d[0] = -1,
> +        .d[1] = -1,
> +        .d[2] = 56789,
> +        .d[3] = -1,
> +    };
> +
> +    /* load vector element number 2 with the data */
> +    vgef(&v1, &v2, (uint32_t *)((uint8_t *)&data - 56789), 2);
> +    check("vgef: element loaded", v1.d[2] == data);
> +    check("vgef: elements unmodified", v1.d[0] == -1 && v1.d[1] == -1 &&
> +                                       v1.d[3] == -1);
> +
> +    /* invalid element number */
> +    CHECK_SIGILL(vgef(&v1, &v2, 0, 4));
> +}
> +
> +static inline void vgeg(S390Vector *v1, S390Vector *v2, const void *a2,
> +                        uint8_t m3)
> +{
> +    asm volatile("vgeg %[v1], 0(%[v2], %[a2]), %[m3]\n"
> +                 : [v1] "+v" (v1->v),
> +                   [v2] "+v" (v2->v)
> +                 : [a2] "d" (a2),
> +                   [m3] "i" (m3));
> +}
> +
> +static void test_vgeg(void)
> +{
> +    uint64_t data = 0x123456789abcdefull;
> +    S390Vector v1 = {
> +        .q[0] = -1ull,
> +        .q[1] = -1ull,
> +    };
> +    S390Vector v2 = {
> +        .q[0] = -1ull,
> +        .q[1] = 56789,
> +    };
> +
> +    /* load vector element number 1 with the data */
> +    vgeg(&v1, &v2, (uint64_t *)((uint8_t *)&data - 56789), 1);
> +    check("vgef: element loaded", v1.q[1] == data);
> +    check("vgef: elements unmodified", v1.q[0] == -1ull);

s/vgef/vgeg/

> +
> +    /* invalid element number */
> +    CHECK_SIGILL(vgeg(&v1, &v2, 0, 2));
> +}
> +
> +int main(void)
> +{
> +    test_vgef();
> +    test_vgeg();
> +    return 0;
> +}
> 

(reviewing my own code :) )

-- 

Thanks,

David / dhildenb
