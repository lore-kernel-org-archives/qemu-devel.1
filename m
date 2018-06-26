Received: from eggs.gnu.org ([2001:4830:134:3::10]:58390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXo2O-0004aK-86
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXo2M-000483-WD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:29:40 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXo2M-00047j-QL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:29:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id 14-v6so15985072oie.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:29:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-30-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 14:29:17 +0100
Message-ID: <CAFEAcA8n=SWOAO7S_-Uf3aLn+0cAd4ocgXufQnAB4PU3WACy0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 29/35] target/arm: Implement SVE fp
 complex multiply add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |   4 +
>  target/arm/sve_helper.c    | 162 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  37 +++++++++
>  target/arm/sve.decode      |   4 +
>  4 files changed, 207 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 0bd9fe2f28..023952a9a4 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -1115,6 +1115,10 @@ DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
>
> +DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index ee7fc23bb9..cd3dfc8b26 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3729,6 +3729,168 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
>      } while (i != 0);
>  }
>
> +/*
> + * FP Complex Multiply
> + */
> +
> +QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 22 > 32);
> +
> +void HELPER(sve_fcmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    intptr_t j, i = simd_oprsz(desc);
> +    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> +    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> +    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> +    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> +    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    bool flip = rot & 1;
> +    float16 neg_imag, neg_real;
> +    void *vd = &env->vfp.zregs[rd];
> +    void *vn = &env->vfp.zregs[rn];
> +    void *vm = &env->vfp.zregs[rm];
> +    void *va = &env->vfp.zregs[ra];
> +    uint64_t *g = vg;
> +
> +    neg_imag = float16_set_sign(0, (rot & 2) != 0);
> +    neg_real = float16_set_sign(0, rot == 1 || rot == 2);
> +
> +    do {
> +        uint64_t pg = g[(i - 1) >> 6];
> +        do {
> +            float16 e1, e2, e3, e4, nr, ni, mr, mi, d;
> +
> +            /* I holds the real index; J holds the imag index.  */
> +            j = i - sizeof(float16);
> +            i -= 2 * sizeof(float16);
> +
> +            nr = *(float16 *)(vn + H1_2(i));
> +            ni = *(float16 *)(vn + H1_2(j));
> +            mr = *(float16 *)(vm + H1_2(i));
> +            mi = *(float16 *)(vm + H1_2(j));
> +
> +            e2 = (flip ? ni : nr);
> +            e1 = (flip ? mi : mr) ^ neg_real;
> +            e4 = e2;
> +            e3 = (flip ? mr : mi) ^ neg_imag;

These don't seem to match up with the pseudocode, which
applies the neg_real or neg_imag negations to element2,
not element1/3. I think the operations are correct but the
variable names are confusingly swapped.

> +
> +            if (likely((pg >> (i & 63)) & 1)) {
> +                d = *(float16 *)(va + H1_2(i));
> +                d = float16_muladd(e2, e1, d, 0, &env->vfp.fp_status_f16);
> +                *(float16 *)(vd + H1_2(i)) = d;
> +            }
> +            if (likely((pg >> (j & 63)) & 1)) {
> +                d = *(float16 *)(va + H1_2(j));
> +                d = float16_muladd(e4, e3, d, 0, &env->vfp.fp_status_f16);
> +                *(float16 *)(vd + H1_2(j)) = d;
> +            }
> +        } while (i & 63);
> +    } while (i != 0);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
