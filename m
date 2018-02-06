Received: from eggs.gnu.org ([2001:4830:134:3::10]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej123-0006WB-Q2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej11x-0007bY-Uo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:03:23 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej11x-0007a0-KP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:03:17 -0500
Received: by mail-wm0-x243.google.com with SMTP id j21-v6so17368993wmh.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:03:17 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-9-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:03:15 +0000
Message-ID: <87r2pywfbg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 08/20] tcg: Add generic helpers for
 saturating arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> No vector ops as yet.  SSE only has direct support for 8- and 16-bit
> saturation; handling 32- and 64-bit saturation is much more expensive.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/tcg-runtime.h      |  20 ++++
>  tcg/tcg-op-gvec.h            |  10 ++
>  accel/tcg/tcg-runtime-gvec.c | 268 +++++++++++++++++++++++++++++++++++++=
++++++
>  tcg/tcg-op-gvec.c            |  92 +++++++++++++++
>  4 files changed, 390 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 54f7e78b09..f224a975e8 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -157,6 +157,26 @@ DEF_HELPER_FLAGS_4(gvec_mul16, TCG_CALL_NO_RWG, void=
, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_mul32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_mul64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_4(gvec_ssadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_ssadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_ssadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_ssadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +
> +DEF_HELPER_FLAGS_4(gvec_sssub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_sssub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_sssub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_sssub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +
> +DEF_HELPER_FLAGS_4(gvec_usadd8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_usadd16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_usadd32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_usadd64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +
> +DEF_HELPER_FLAGS_4(gvec_ussub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_ussub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_ussub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +DEF_HELPER_FLAGS_4(gvec_ussub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +
>  DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index abe909df39..03ced440c2 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -179,6 +179,16 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, =
uint32_t aofs,
>  void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
>
> +/* Saturated arithmetic.  */
> +void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +
>  void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
>  void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index 59d7a0a2fe..e6f99babcd 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -547,3 +547,271 @@ DO_CMP2(64)
>  #undef DO_CMP0
>  #undef DO_CMP1
>  #undef DO_CMP2
> +
> +void HELPER(gvec_ssadd8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int8_t)) {
> +        int r =3D *(int8_t *)(a + i) + *(int8_t *)(b + i);
> +        if (r > INT8_MAX) {
> +            r =3D INT8_MAX;
> +        } else if (r < INT8_MIN) {
> +            r =3D INT8_MIN;
> +        }
> +        *(int8_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ssadd16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int16_t)) {
> +        int r =3D *(int16_t *)(a + i) + *(int16_t *)(b + i);
> +        if (r > INT16_MAX) {
> +            r =3D INT16_MAX;
> +        } else if (r < INT16_MIN) {
> +            r =3D INT16_MIN;
> +        }
> +        *(int16_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ssadd32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
> +        int32_t ai =3D *(int32_t *)(a + i);
> +        int32_t bi =3D *(int32_t *)(b + i);
> +        int32_t di =3D ai + bi;
> +        if (((di ^ ai) &~ (ai ^ bi)) < 0) {
> +            /* Signed overflow.  */
> +            di =3D (di < 0 ? INT32_MAX : INT32_MIN);
> +        }
> +        *(int32_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ssadd64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
> +        int64_t ai =3D *(int64_t *)(a + i);
> +        int64_t bi =3D *(int64_t *)(b + i);
> +        int64_t di =3D ai + bi;
> +        if (((di ^ ai) &~ (ai ^ bi)) < 0) {
> +            /* Signed overflow.  */
> +            di =3D (di < 0 ? INT64_MAX : INT64_MIN);
> +        }
> +        *(int64_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sssub8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint8_t)) {
> +        int r =3D *(int8_t *)(a + i) - *(int8_t *)(b + i);
> +        if (r > INT8_MAX) {
> +            r =3D INT8_MAX;
> +        } else if (r < INT8_MIN) {
> +            r =3D INT8_MIN;
> +        }
> +        *(uint8_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sssub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int16_t)) {
> +        int r =3D *(int16_t *)(a + i) - *(int16_t *)(b + i);
> +        if (r > INT16_MAX) {
> +            r =3D INT16_MAX;
> +        } else if (r < INT16_MIN) {
> +            r =3D INT16_MIN;
> +        }
> +        *(int16_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sssub32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
> +        int32_t ai =3D *(int32_t *)(a + i);
> +        int32_t bi =3D *(int32_t *)(b + i);
> +        int32_t di =3D ai - bi;
> +        if (((di ^ ai) & (ai ^ bi)) < 0) {
> +            /* Signed overflow.  */
> +            di =3D (di < 0 ? INT32_MAX : INT32_MIN);
> +        }
> +        *(int32_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sssub64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
> +        int64_t ai =3D *(int64_t *)(a + i);
> +        int64_t bi =3D *(int64_t *)(b + i);
> +        int64_t di =3D ai - bi;
> +        if (((di ^ ai) & (ai ^ bi)) < 0) {
> +            /* Signed overflow.  */
> +            di =3D (di < 0 ? INT64_MAX : INT64_MIN);
> +        }
> +        *(int64_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_usadd8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint8_t)) {
> +        unsigned r =3D *(uint8_t *)(a + i) + *(uint8_t *)(b + i);
> +        if (r > UINT8_MAX) {
> +            r =3D UINT8_MAX;
> +        }
> +        *(uint8_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_usadd16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint16_t)) {
> +        unsigned r =3D *(uint16_t *)(a + i) + *(uint16_t *)(b + i);
> +        if (r > UINT16_MAX) {
> +            r =3D UINT16_MAX;
> +        }
> +        *(uint16_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_usadd32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint32_t)) {
> +        uint32_t ai =3D *(uint32_t *)(a + i);
> +        uint32_t bi =3D *(uint32_t *)(b + i);
> +        uint32_t di =3D ai + bi;
> +        if (di < ai) {
> +            di =3D UINT32_MAX;
> +        }
> +        *(uint32_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_usadd64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint64_t)) {
> +        uint64_t ai =3D *(uint64_t *)(a + i);
> +        uint64_t bi =3D *(uint64_t *)(b + i);
> +        uint64_t di =3D ai + bi;
> +        if (di < ai) {
> +            di =3D UINT64_MAX;
> +        }
> +        *(uint64_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ussub8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint8_t)) {
> +        int r =3D *(uint8_t *)(a + i) - *(uint8_t *)(b + i);
> +        if (r < 0) {
> +            r =3D 0;
> +        }
> +        *(uint8_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ussub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint16_t)) {
> +        int r =3D *(uint16_t *)(a + i) - *(uint16_t *)(b + i);
> +        if (r < 0) {
> +            r =3D 0;
> +        }
> +        *(uint16_t *)(d + i) =3D r;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ussub32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint32_t)) {
> +        uint32_t ai =3D *(uint32_t *)(a + i);
> +        uint32_t bi =3D *(uint32_t *)(b + i);
> +        uint32_t di =3D ai - bi;
> +        if (ai < bi) {
> +            di =3D 0;
> +        }
> +        *(uint32_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_ussub64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(uint64_t)) {
> +        uint64_t ai =3D *(uint64_t *)(a + i);
> +        uint64_t bi =3D *(uint64_t *)(b + i);
> +        uint64_t di =3D ai - bi;
> +        if (ai < bi) {
> +            di =3D 0;
> +        }
> +        *(uint64_t *)(d + i) =3D di;
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 027f3e9740..f621422646 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1308,6 +1308,98 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>      tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
>  }
>
> +void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fno =3D gen_helper_gvec_ssadd8, .vece =3D MO_8 },
> +        { .fno =3D gen_helper_gvec_ssadd16, .vece =3D MO_16 },
> +        { .fno =3D gen_helper_gvec_ssadd32, .vece =3D MO_32 },
> +        { .fno =3D gen_helper_gvec_ssadd64, .vece =3D MO_64 }
> +    };
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fno =3D gen_helper_gvec_sssub8, .vece =3D MO_8 },
> +        { .fno =3D gen_helper_gvec_sssub16, .vece =3D MO_16 },
> +        { .fno =3D gen_helper_gvec_sssub32, .vece =3D MO_32 },
> +        { .fno =3D gen_helper_gvec_sssub64, .vece =3D MO_64 }
> +    };
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +static void tcg_gen_vec_usadd32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    TCGv_i32 max =3D tcg_const_i32(-1);
> +    tcg_gen_add_i32(d, a, b);
> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);
> +    tcg_temp_free_i32(max);
> +}
> +
> +static void tcg_gen_vec_usadd32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 max =3D tcg_const_i64(-1);
> +    tcg_gen_add_i64(d, a, b);
> +    tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);
> +    tcg_temp_free_i64(max);
> +}
> +
> +void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fno =3D gen_helper_gvec_usadd8, .vece =3D MO_8 },
> +        { .fno =3D gen_helper_gvec_usadd16, .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_vec_usadd32_i32,
> +          .fno =3D gen_helper_gvec_usadd32,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_vec_usadd32_i64,
> +          .fno =3D gen_helper_gvec_usadd64,
> +          .vece =3D MO_64 }
> +    };
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +static void tcg_gen_vec_ussub32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    TCGv_i32 min =3D tcg_const_i32(0);
> +    tcg_gen_sub_i32(d, a, b);
> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
> +    tcg_temp_free_i32(min);
> +}
> +
> +static void tcg_gen_vec_ussub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 min =3D tcg_const_i64(0);
> +    tcg_gen_sub_i64(d, a, b);
> +    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
> +    tcg_temp_free_i64(min);
> +}
> +
> +void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fno =3D gen_helper_gvec_ussub8, .vece =3D MO_8 },
> +        { .fno =3D gen_helper_gvec_ussub16, .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_vec_ussub32_i32,
> +          .fno =3D gen_helper_gvec_ussub32,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_vec_ussub32_i64,
> +          .fno =3D gen_helper_gvec_ussub64,
> +          .vece =3D MO_64 }
> +    };
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
>  /* Perform a vector negation using normal negation and a mask.
>     Compare gen_subv_mask above.  */
>  static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)


--
Alex Benn=C3=A9e
