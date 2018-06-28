Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYUYc-0007Ci-Bu
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYUYZ-0007M1-7D
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:53:46 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYUYY-0007KU-TN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:53:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id e18-v6so5038691wrs.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 03:53:42 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627043328.11531-8-richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 11:53:40 +0100
Message-ID: <87zhzfuqq3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/35] target/arm: Implement SVE FP
 Multiply-Add Group
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v6: Add some decode commentary.
> ---
>  target/arm/helper-sve.h    |  16 ++++
>  target/arm/sve_helper.c    | 158 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  49 ++++++++++++
>  target/arm/sve.decode      |  18 +++++
>  4 files changed, 241 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 4097b55f0e..eb0645dd43 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -827,6 +827,22 @@ DEF_HELPER_FLAGS_5(sve_ucvt_ds, TCG_CALL_NO_RWG,
>  DEF_HELPER_FLAGS_5(sve_ucvt_dd, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +
> +DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i3=
2)
> +
> +DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +
> +DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i=
32)
> +
>  DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 3401662397..2f416e5e28 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -2938,6 +2938,164 @@ DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_=
float64)
>
>  #undef DO_ZPZ_FP
>
> +/* 4-operand predicated multiply-add.  This requires 7 operands to pass
> + * "properly", so we need to encode some of the registers into DESC.
> + */

How about:

  With potential optimisations using movpfx we could end up with a 4
  operand multiply-add (result =3D A * B + C) which together with prefix,
  floating point status, vector description adds up to 7 operands for the
  "proper" encoding. Instead we encode the source registers numbers in the
  spare space of DESC and index into env in the helper making for a more
  efficient call frame.

> +QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
> +
> +static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
> +                            uint16_t neg1, uint16_t neg3)
> +{
> +    intptr_t i =3D simd_oprsz(desc);
> +    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> +    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> +    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> +    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> +    void *vd =3D &env->vfp.zregs[rd];
> +    void *vn =3D &env->vfp.zregs[rn];
> +    void *vm =3D &env->vfp.zregs[rm];
> +    void *va =3D &env->vfp.zregs[ra];
> +    uint64_t *g =3D vg;
> +
> +    do {
> +        uint64_t pg =3D g[(i - 1) >> 6];
> +        do {
> +            i -=3D 2;
> +            if (likely((pg >> (i & 63)) & 1)) {
> +                float16 e1, e2, e3, r;
> +
> +                e1 =3D *(uint16_t *)(vn + H1_2(i)) ^ neg1;
> +                e2 =3D *(uint16_t *)(vm + H1_2(i));
> +                e3 =3D *(uint16_t *)(va + H1_2(i)) ^ neg3;
> +                r =3D float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                *(uint16_t *)(vd + H1_2(i)) =3D r;
> +            }
> +        } while (i & 63);
> +    } while (i !=3D 0);
> +}
> +
> +void HELPER(sve_fmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_h(env, vg, desc, 0, 0);
> +}
> +
> +void HELPER(sve_fmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0);
> +}
> +
> +void HELPER(sve_fnmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0x8000);
> +}
> +
> +void HELPER(sve_fnmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_h(env, vg, desc, 0, 0x8000);
> +}
> +
> +static void do_fmla_zpzzz_s(CPUARMState *env, void *vg, uint32_t desc,
> +                            uint32_t neg1, uint32_t neg3)
> +{
> +    intptr_t i =3D simd_oprsz(desc);
> +    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> +    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> +    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> +    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> +    void *vd =3D &env->vfp.zregs[rd];
> +    void *vn =3D &env->vfp.zregs[rn];
> +    void *vm =3D &env->vfp.zregs[rm];
> +    void *va =3D &env->vfp.zregs[ra];
> +    uint64_t *g =3D vg;
> +
> +    do {
> +        uint64_t pg =3D g[(i - 1) >> 6];
> +        do {
> +            i -=3D 4;
> +            if (likely((pg >> (i & 63)) & 1)) {
> +                float32 e1, e2, e3, r;
> +
> +                e1 =3D *(uint32_t *)(vn + H1_4(i)) ^ neg1;
> +                e2 =3D *(uint32_t *)(vm + H1_4(i));
> +                e3 =3D *(uint32_t *)(va + H1_4(i)) ^ neg3;
> +                r =3D float32_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                *(uint32_t *)(vd + H1_4(i)) =3D r;
> +            }
> +        } while (i & 63);
> +    } while (i !=3D 0);
> +}
> +
> +void HELPER(sve_fmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_s(env, vg, desc, 0, 0);
> +}
> +
> +void HELPER(sve_fmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0);
> +}
> +
> +void HELPER(sve_fnmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0x80000000);
> +}
> +
> +void HELPER(sve_fnmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_s(env, vg, desc, 0, 0x80000000);
> +}
> +
> +static void do_fmla_zpzzz_d(CPUARMState *env, void *vg, uint32_t desc,
> +                            uint64_t neg1, uint64_t neg3)
> +{
> +    intptr_t i =3D simd_oprsz(desc);
> +    unsigned rd =3D extract32(desc, SIMD_DATA_SHIFT, 5);
> +    unsigned rn =3D extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> +    unsigned rm =3D extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> +    unsigned ra =3D extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> +    void *vd =3D &env->vfp.zregs[rd];
> +    void *vn =3D &env->vfp.zregs[rn];
> +    void *vm =3D &env->vfp.zregs[rm];
> +    void *va =3D &env->vfp.zregs[ra];
> +    uint64_t *g =3D vg;
> +
> +    do {
> +        uint64_t pg =3D g[(i - 1) >> 6];
> +        do {
> +            i -=3D 8;
> +            if (likely((pg >> (i & 63)) & 1)) {
> +                float64 e1, e2, e3, r;
> +
> +                e1 =3D *(uint64_t *)(vn + i) ^ neg1;
> +                e2 =3D *(uint64_t *)(vm + i);
> +                e3 =3D *(uint64_t *)(va + i) ^ neg3;
> +                r =3D float64_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                *(uint64_t *)(vd + i) =3D r;
> +            }
> +        } while (i & 63);
> +    } while (i !=3D 0);
> +}
> +
> +void HELPER(sve_fmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_d(env, vg, desc, 0, 0);
> +}
> +
> +void HELPER(sve_fmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, 0);
> +}
> +
> +void HELPER(sve_fnmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, INT64_MIN);
> +}
> +
> +void HELPER(sve_fnmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +{
> +    do_fmla_zpzzz_d(env, vg, desc, 0, INT64_MIN);
> +}
> +
>  /*
>   * Load contiguous data, protected by a governing predicate.
>   */
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 4df5360da9..acad6374ef 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3472,6 +3472,55 @@ DO_FP3(FMULX, fmulx)
>
>  #undef DO_FP3
>
> +typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
> +
> +static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fm=
la *fn)
> +{
> +    if (fn =3D=3D NULL) {
> +        return false;
> +    }
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    unsigned vsz =3D vec_full_reg_size(s);
> +    unsigned desc;
> +    TCGv_i32 t_desc;
> +    TCGv_ptr pg =3D tcg_temp_new_ptr();
> +
> +    /* We would need 7 operands to pass these arguments "properly".
> +     * So we encode all the register numbers into the descriptor.
> +     */
> +    desc =3D deposit32(a->rd, 5, 5, a->rn);
> +    desc =3D deposit32(desc, 10, 5, a->rm);
> +    desc =3D deposit32(desc, 15, 5, a->ra);
> +    desc =3D simd_desc(vsz, vsz, desc);

If this ends up being repeated in future it might be worth having a
helper, maybe get_packed_desc()?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
