Received: from eggs.gnu.org ([2001:4830:134:3::10]:51919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fp8Ox-0008WA-D8
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fp8Os-0006TI-FJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 04:40:35 -0400
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
	<20180810030139.25916-6-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fa0f3b2c-e02e-e808-36ed-3257bffd6253@redhat.com>
Date: Mon, 13 Aug 2018 10:40:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180810030139.25916-6-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 5/7] target/s390x: add EX
 support for TRT and TRTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, richard.henderson@linaro.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 10.08.2018 05:01, Pavel Zbitskiy wrote:
> Improves "b213c9f5: target/s390x: Implement TRTR" by introducing the
> intermediate functions, which are compatible with dx_helper type.
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/mem_helper.c       | 16 +++++++++++
>  tests/tcg/s390x/Makefile.target |  2 ++
>  tests/tcg/s390x/exrl-trt.c      | 48 +++++++++++++++++++++++++++++++++
>  tests/tcg/s390x/exrl-trtr.c     | 48 +++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
>  create mode 100644 tests/tcg/s390x/exrl-trt.c
>  create mode 100644 tests/tcg/s390x/exrl-trtr.c
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index c94dbf3fcb..704d0193b5 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1299,12 +1299,26 @@ static inline uint32_t do_helper_trt(CPUS390XState *env, int len,
>      return 0;
>  }
>  
> +static uint32_t do_helper_trt_fwd(CPUS390XState *env, uint32_t len,
> +                                  uint64_t array, uint64_t trans,
> +                                  uintptr_t ra)
> +{
> +    return do_helper_trt(env, len, array, trans, 1, ra);
> +}
> +
>  uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
>                       uint64_t trans)
>  {
>      return do_helper_trt(env, len, array, trans, 1, GETPC());
>  }
>  
> +static uint32_t do_helper_trt_bkwd(CPUS390XState *env, uint32_t len,
> +                                   uint64_t array, uint64_t trans,
> +                                   uintptr_t ra)
> +{
> +    return do_helper_trt(env, len, array, trans, -1, ra);
> +}
> +
>  uint32_t HELPER(trtr)(CPUS390XState *env, uint32_t len, uint64_t array,
>                        uint64_t trans)
>  {
> @@ -2193,12 +2207,14 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
>          typedef uint32_t (*dx_helper)(CPUS390XState *, uint32_t, uint64_t,
>                                        uint64_t, uintptr_t);
>          static const dx_helper dx[16] = {
> +            [0x0] = do_helper_trt_bkwd,
>              [0x2] = do_helper_mvc,
>              [0x4] = do_helper_nc,
>              [0x5] = do_helper_clc,
>              [0x6] = do_helper_oc,
>              [0x7] = do_helper_xc,
>              [0xc] = do_helper_tr,
> +            [0xd] = do_helper_trt_fwd,
>          };
>          dx_helper helper = dx[opc & 0xf];
>  
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index c800a582e5..7de4376f52 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -3,3 +3,5 @@ CFLAGS+=-march=zEC12 -m64
>  TESTS+=hello-s390x
>  TESTS+=csst
>  TESTS+=ipm
> +TESTS+=exrl-trt
> +TESTS+=exrl-trtr
> diff --git a/tests/tcg/s390x/exrl-trt.c b/tests/tcg/s390x/exrl-trt.c
> new file mode 100644
> index 0000000000..3c5323aecb
> --- /dev/null
> +++ b/tests/tcg/s390x/exrl-trt.c
> @@ -0,0 +1,48 @@
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +    char op1[] = "hello";
> +    char op2[256];
> +    uint64_t r1 = 0xffffffffffffffffull;
> +    uint64_t r2 = 0xffffffffffffffffull;
> +    uint64_t cc;
> +    int i;
> +
> +    for (i = 0; i < 256; i++) {
> +        if (i == 0) {
> +            op2[i] = 0xaa;
> +        } else {
> +            op2[i] = 0;
> +        }
> +    }
> +    asm volatile(
> +        "    j 2f\n"
> +        "1:  trt 0(1,%[op1]),0(%[op2])\n"
> +        "2:  exrl %[op1_len],1b\n"
> +        "    lgr %[r1],%%r1\n"
> +        "    lgr %[r2],%%r2\n"
> +        "    ipm %[cc]\n"
> +        : [r1] "+r" (r1),
> +          [r2] "+r" (r2),
> +          [cc] "=r" (cc)
> +        : [op1] "r" (&op1),
> +          [op1_len] "r" (5),
> +          [op2] "r" (&op2)
> +        : "r1", "r2", "cc");
> +    cc = (cc >> 28) & 3;
> +    if (cc != 2) {
> +        write(1, "bad cc\n", 7);
> +        return 1;
> +    }
> +    if ((char *)r1 != &op1[5]) {
> +        write(1, "bad r1\n", 7);
> +        return 1;
> +    }
> +    if (r2 != 0xffffffffffffffaaull) {
> +        write(1, "bad r2\n", 7);
> +        return 1;
> +    }
> +    return 0;
> +}
> diff --git a/tests/tcg/s390x/exrl-trtr.c b/tests/tcg/s390x/exrl-trtr.c
> new file mode 100644
> index 0000000000..c33153ad7e
> --- /dev/null
> +++ b/tests/tcg/s390x/exrl-trtr.c
> @@ -0,0 +1,48 @@
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +    char op1[] = {0, 1, 2, 3};
> +    char op2[256];
> +    uint64_t r1 = 0xffffffffffffffffull;
> +    uint64_t r2 = 0xffffffffffffffffull;
> +    uint64_t cc;
> +    int i;
> +
> +    for (i = 0; i < 256; i++) {
> +        if (i == 1) {
> +            op2[i] = 0xbb;
> +        } else {
> +            op2[i] = 0;
> +        }
> +    }
> +    asm volatile(
> +        "    j 2f\n"
> +        "1:  trtr 3(1,%[op1]),0(%[op2])\n"
> +        "2:  exrl %[op1_len],1b\n"
> +        "    lgr %[r1],%%r1\n"
> +        "    lgr %[r2],%%r2\n"
> +        "    ipm %[cc]\n"
> +        : [r1] "+r" (r1),
> +          [r2] "+r" (r2),
> +          [cc] "=r" (cc)
> +        : [op1] "r" (&op1),
> +          [op1_len] "r" (3),
> +          [op2] "r" (&op2)
> +        : "r1", "r2", "cc");
> +    cc = (cc >> 28) & 3;
> +    if (cc != 1) {
> +        write(1, "bad cc\n", 7);
> +        return 1;
> +    }
> +    if ((char *)r1 != &op1[1]) {
> +        write(1, "bad r1\n", 7);
> +        return 1;
> +    }
> +    if (r2 != 0xffffffffffffffbbull) {
> +        write(1, "bad r2\n", 7);
> +        return 1;
> +    }
> +    return 0;
> +}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
