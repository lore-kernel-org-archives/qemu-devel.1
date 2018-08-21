Received: from eggs.gnu.org ([2001:4830:134:3::10]:36882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1CF-0003J1-KD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs1AD-0003qU-Rg
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:33:21 -0400
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<20180821025104.19604-5-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d36e3509-df38-d2a9-b78e-622d26c0aa63@redhat.com>
Date: Tue, 21 Aug 2018 09:33:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180821025104.19604-5-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/s390x: fix IPM polluting
 irrelevant bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 21.08.2018 04:51, Pavel Zbitskiy wrote:
> Suppose psw.mask=0x0000000080000000, cc=2, r1=0 and we do "ipm 1".
> This command must touch only bits 32-39, so the expected output
> is r1=0x20000000. However, currently qemu yields r1=0x20008000,
> because irrelevant parts of PSW leak into r1 during program mask
> transfer.
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  target/s390x/translate.c        | 17 +++++++----------
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/ipm.c           | 22 ++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 10 deletions(-)
>  create mode 100644 tests/tcg/s390x/ipm.c
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 929fc2db28..f58b36b789 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2445,20 +2445,17 @@ static DisasJumpType op_insi(DisasContext *s, DisasOps *o)
>  
>  static DisasJumpType op_ipm(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i64 t1;
> +    TCGv_i64 t1, t2;
>  
>      gen_op_calc_cc(s);
> -    tcg_gen_andi_i64(o->out, o->out, ~0xff000000ull);
> -
>      t1 = tcg_temp_new_i64();
> -    tcg_gen_shli_i64(t1, psw_mask, 20);
> -    tcg_gen_shri_i64(t1, t1, 36);
> -    tcg_gen_or_i64(o->out, o->out, t1);
> -
> -    tcg_gen_extu_i32_i64(t1, cc_op);
> -    tcg_gen_shli_i64(t1, t1, 28);
> -    tcg_gen_or_i64(o->out, o->out, t1);
> +    tcg_gen_extract_i64(t1, psw_mask, 40, 4);
> +    t2 = tcg_temp_new_i64();
> +    tcg_gen_extu_i32_i64(t2, cc_op);
> +    tcg_gen_deposit_i64(t1, t1, t2, 4, 60);
> +    tcg_gen_deposit_i64(o->out, o->out, t1, 24, 8);
>      tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
>      return DISAS_NEXT;
>  }
>  
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index f62f950d8e..c800a582e5 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -2,3 +2,4 @@ VPATH+=$(SRC_PATH)/tests/tcg/s390x
>  CFLAGS+=-march=zEC12 -m64
>  TESTS+=hello-s390x
>  TESTS+=csst
> +TESTS+=ipm
> diff --git a/tests/tcg/s390x/ipm.c b/tests/tcg/s390x/ipm.c
> new file mode 100644
> index 0000000000..742f3a18c5
> --- /dev/null
> +++ b/tests/tcg/s390x/ipm.c
> @@ -0,0 +1,22 @@
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +    uint32_t op1 = 0x55555555;
> +    uint32_t op2 = 0x44444444;
> +    uint64_t cc = 0xffffffffffffffffull;
> +
> +    asm volatile(
> +        "    clc 0(4,%[op1]),0(%[op2])\n"
> +        "    ipm %[cc]\n"
> +        : [cc] "+r" (cc)
> +        : [op1] "r" (&op1),
> +          [op2] "r" (&op2)
> +        : "cc");
> +    if (cc != 0xffffffff20ffffffull) {
> +        write(1, "bad cc\n", 7);
> +        return 1;
> +    }
> +    return 0;
> +}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
