Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssBE-00041w-Qs
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssBE-0002nq-0m
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:09:52 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssBD-0002ng-RU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:09:51 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so10183540oib.10
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:09:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-19-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:09:30 +0100
Message-ID: <CAFEAcA8DXUrkaPWxm3aym7vcrTyTxN2=q_n4h7FG3WWF0+EMsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Rewrite vector gather
 stores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This fixes the endianness problem for softmmu, and does
> move the main loop out of a macro and into an inlined function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  52 ++++++++++----
>  target/arm/sve_helper.c    | 139 ++++++++++++++++++++++++-------------
>  target/arm/translate-sve.c |  74 +++++++++++++-------
>  3 files changed, 177 insertions(+), 88 deletions(-)
>

> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 76d3f021e4..0a4756bff9 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -5235,61 +5235,100 @@ DO_LDFF1_ZPZ_D(sve_ldffsds_zd, uint64_t, int32_t,  cpu_ldl_data_ra)
>
>  /* Stores with a vector index.  */
>
> -#define DO_ST1_ZPZ_S(NAME, TYPEI, FN)                                   \
> -void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
> -                  target_ulong base, uint32_t desc)                     \
> -{                                                                       \
> -    intptr_t i, oprsz = simd_oprsz(desc);                               \
> -    unsigned scale = simd_data(desc);                                   \
> -    uintptr_t ra = GETPC();                                             \
> -    for (i = 0; i < oprsz; ) {                                          \
> -        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
> -        do {                                                            \
> -            if (likely(pg & 1)) {                                       \
> -                target_ulong off = *(TYPEI *)(vm + H1_4(i));            \
> -                uint32_t d = *(uint32_t *)(vd + H1_4(i));               \
> -                FN(env, base + (off << scale), d, ra);                  \
> -            }                                                           \
> -            i += sizeof(uint32_t), pg >>= sizeof(uint32_t);             \
> -        } while (i & 15);                                               \
> -    }                                                                   \
> +static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
> +                       target_ulong base, uint32_t desc, uintptr_t ra,
> +                       zreg_off_fn *off_fn, sve_ld1_tlb_fn *tlb_fn)
> +{
> +    const int mmu_idx = cpu_mmu_index(env, false);
> +    intptr_t i, oprsz = simd_oprsz(desc);
> +    unsigned scale = simd_data(desc);
> +
> +    set_helper_retaddr(ra);
> +    for (i = 0; i < oprsz; ) {
> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
> +        do {
> +            if (pg & 1) {

Is dropping the "likely()" off this conditional intentional ?


> +                target_ulong off = off_fn(vm, i);
> +                tlb_fn(env, vd, i, base + (off << scale), mmu_idx, ra);
> +            }
> +            i += 4, pg >>= 4;
> +        } while (i & 15);
> +    }
> +    set_helper_retaddr(0);
>  }
>
Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
