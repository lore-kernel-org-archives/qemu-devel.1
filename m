Received: from eggs.gnu.org ([2001:4830:134:3::10]:34394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYXOH-0000hf-O0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYXOE-0000Gd-LX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:55:17 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYXOE-0000FH-AG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:55:14 -0400
Received: by mail-wm0-x242.google.com with SMTP id p11-v6so9122385wmc.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:55:14 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-32-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-32-richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 14:55:11 +0100
Message-ID: <87tvpnuibk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 31/35] target/arm: Implement SVE fp
 complex multiply add (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Enhance the existing helpers to support SVE, which takes the
> index from each 128-bit segment.  The change has no effect
> for AdvSIMD, since there is only one such segment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-sve.c | 23 ++++++++++++++++++
>  target/arm/vec_helper.c    | 50 +++++++++++++++++++++++---------------
>  target/arm/sve.decode      |  6 +++++
>  3 files changed, 59 insertions(+), 20 deletions(-)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 7ce3222158..4f2152fb70 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4005,6 +4005,29 @@ static bool trans_FCMLA_zpzzz(DisasContext *s,
>      return true;
>  }
>
> +static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a, uint32_=
t insn)
> +{
> +    static gen_helper_gvec_3_ptr * const fns[2] =3D {
> +        gen_helper_gvec_fcmlah_idx,
> +        gen_helper_gvec_fcmlas_idx,
> +    };
> +
> +    tcg_debug_assert(a->esz =3D=3D 1 || a->esz =3D=3D 2);
> +    tcg_debug_assert(a->rd =3D=3D a->ra);
> +    if (sve_access_check(s)) {
> +        unsigned vsz =3D vec_full_reg_size(s);
> +        TCGv_ptr status =3D get_fpstatus_ptr(a->esz =3D=3D MO_16);
> +        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           status, vsz, vsz,
> +                           a->index * 4 + a->rot,
> +                           fns[a->esz - 1]);
> +        tcg_temp_free_ptr(status);
> +    }
> +    return true;
> +}
> +
>  /*
>   *** SVE Floating Point Unary Operations Prediated Group
>   */
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index 8f2dc4b989..db5aeb9f24 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -319,22 +319,27 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, vo=
id *vm,
>      uint32_t neg_imag =3D extract32(desc, SIMD_DATA_SHIFT + 1, 1);
>      intptr_t index =3D extract32(desc, SIMD_DATA_SHIFT + 2, 2);
>      uint32_t neg_real =3D flip ^ neg_imag;
> -    uintptr_t i;
> -    float16 e1 =3D m[H2(2 * index + flip)];
> -    float16 e3 =3D m[H2(2 * index + 1 - flip)];
> +    intptr_t elements =3D opr_sz / sizeof(float16);
> +    intptr_t eltspersegment =3D 16 / sizeof(float16);
> +    intptr_t i, j;
>
>      /* Shift boolean to the sign bit so we can xor to negate.  */
>      neg_real <<=3D 15;
>      neg_imag <<=3D 15;
> -    e1 ^=3D neg_real;
> -    e3 ^=3D neg_imag;
>
> -    for (i =3D 0; i < opr_sz / 2; i +=3D 2) {
> -        float16 e2 =3D n[H2(i + flip)];
> -        float16 e4 =3D e2;
> +    for (i =3D 0; i < elements; i +=3D eltspersegment) {
> +        float16 mr =3D m[H2(i + 2 * index + 0)];
> +        float16 mi =3D m[H2(i + 2 * index + 1)];
> +        float16 e1 =3D neg_real ^ (flip ? mi : mr);
> +        float16 e3 =3D neg_imag ^ (flip ? mr : mi);
>
> -        d[H2(i)] =3D float16_muladd(e2, e1, d[H2(i)], 0, fpst);
> -        d[H2(i + 1)] =3D float16_muladd(e4, e3, d[H2(i + 1)], 0, fpst);
> +        for (j =3D i; j < i + eltspersegment; j +=3D 2) {
> +            float16 e2 =3D n[H2(j + flip)];
> +            float16 e4 =3D e2;
> +
> +            d[H2(j)] =3D float16_muladd(e2, e1, d[H2(j)], 0, fpst);
> +            d[H2(j + 1)] =3D float16_muladd(e4, e3, d[H2(j + 1)], 0, fps=
t);
> +        }
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> @@ -380,22 +385,27 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, vo=
id *vm,
>      uint32_t neg_imag =3D extract32(desc, SIMD_DATA_SHIFT + 1, 1);
>      intptr_t index =3D extract32(desc, SIMD_DATA_SHIFT + 2, 2);
>      uint32_t neg_real =3D flip ^ neg_imag;
> -    uintptr_t i;
> -    float32 e1 =3D m[H4(2 * index + flip)];
> -    float32 e3 =3D m[H4(2 * index + 1 - flip)];
> +    intptr_t elements =3D opr_sz / sizeof(float32);
> +    intptr_t eltspersegment =3D 16 / sizeof(float32);
> +    intptr_t i, j;
>
>      /* Shift boolean to the sign bit so we can xor to negate.  */
>      neg_real <<=3D 31;
>      neg_imag <<=3D 31;
> -    e1 ^=3D neg_real;
> -    e3 ^=3D neg_imag;
>
> -    for (i =3D 0; i < opr_sz / 4; i +=3D 2) {
> -        float32 e2 =3D n[H4(i + flip)];
> -        float32 e4 =3D e2;
> +    for (i =3D 0; i < elements; i +=3D eltspersegment) {
> +        float32 mr =3D m[H4(i + 2 * index + 0)];
> +        float32 mi =3D m[H4(i + 2 * index + 1)];
> +        float32 e1 =3D neg_real ^ (flip ? mi : mr);
> +        float32 e3 =3D neg_imag ^ (flip ? mr : mi);
>
> -        d[H4(i)] =3D float32_muladd(e2, e1, d[H4(i)], 0, fpst);
> -        d[H4(i + 1)] =3D float32_muladd(e4, e3, d[H4(i + 1)], 0, fpst);
> +        for (j =3D i; j < i + eltspersegment; j +=3D 2) {
> +            float32 e2 =3D n[H4(j + flip)];
> +            float32 e4 =3D e2;
> +
> +            d[H4(j)] =3D float32_muladd(e2, e1, d[H4(j)], 0, fpst);
> +            d[H4(j + 1)] =3D float32_muladd(e4, e3, d[H4(j + 1)], 0, fps=
t);
> +        }
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index e342cfdf14..62365ed90f 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -733,6 +733,12 @@ FCADD           01100100 esz:2 00000 rot:1 100 pg:3 =
rm:5 rd:5 \
>  FCMLA_zpzzz     01100100 esz:2 0 rm:5 0 rot:2 pg:3 rn:5 rd:5 \
>                  ra=3D%reg_movprfx
>
> +# SVE floating-point complex multiply-add (indexed)
> +FCMLA_zzxz      01100100 10 1 index:2 rm:3 0001 rot:2 rn:5 rd:5 \
> +                ra=3D%reg_movprfx esz=3D1
> +FCMLA_zzxz      01100100 11 1 index:1 rm:4 0001 rot:2 rn:5 rd:5 \
> +                ra=3D%reg_movprfx esz=3D2
> +
>  ### SVE FP Multiply-Add Indexed Group
>
>  # SVE floating-point multiply-add (indexed)


--
Alex Benn=C3=A9e
