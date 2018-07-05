Received: from eggs.gnu.org ([2001:4830:134:3::10]:34034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb7A2-0005ZP-41
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb79x-0002zZ-VD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:31:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180703151732.29843-8-richard.henderson@linaro.org>
Date: Thu, 5 Jul 2018 12:31:06 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9095EFA-A3D5-4EEE-A5DA-E4284FD8881E@gmail.com>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<20180703151732.29843-8-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 7/7] target/ppc: Use non-arithmetic
 conversions for fp load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org


> On Jul 3, 2018, at 11:17 AM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> Memory operations have no side effects on fp state.
> The use of a "real" conversions between float64 and float32
> would raise exceptions for SNaN and out-of-range inputs.

Would you have any documentation that tells us about converting
between 64 bit and 32 bit floating points?


>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> target/ppc/helper.h                |  4 +-
> target/ppc/fpu_helper.c            | 63 ++++++++++++++++++++++++------
> target/ppc/translate/fp-impl.inc.c | 26 +++++-------
> 3 files changed, 62 insertions(+), 31 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index cc3d031407..33e6e1df60 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -61,8 +61,8 @@ DEF_HELPER_2(compute_fprf_float64, void, env, i64)
> DEF_HELPER_3(store_fpscr, void, env, i64, i32)
> DEF_HELPER_2(fpscr_clrbit, void, env, i32)
> DEF_HELPER_2(fpscr_setbit, void, env, i32)
> -DEF_HELPER_2(float64_to_float32, i32, env, i64)
> -DEF_HELPER_2(float32_to_float64, i64, env, i32)
> +DEF_HELPER_FLAGS_1(todouble, TCG_CALL_NO_RWG_SE, i64, i32)
> +DEF_HELPER_FLAGS_1(tosingle, TCG_CALL_NO_RWG_SE, i32, i64)
>=20
> DEF_HELPER_4(fcmpo, void, env, i64, i64, i32)
> DEF_HELPER_4(fcmpu, void, env, i64, i64, i32)
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 1e195487d3..d4e9e3bccb 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -47,24 +47,61 @@ static inline bool =
fp_exceptions_enabled(CPUPPCState *env)
>=20
> =
/*************************************************************************=
****/
> /* Floating point operations helpers */
> -uint64_t helper_float32_to_float64(CPUPPCState *env, uint32_t arg)
> -{
> -    CPU_FloatU f;
> -    CPU_DoubleU d;
>=20
> -    f.l =3D arg;
> -    d.d =3D float32_to_float64(f.f, &env->fp_status);
> -    return d.ll;
> +/*
> + * This is the non-arithmatic conversion that happens e.g. on loads.
> + * In the Power ISA pseudocode, this is called DOUBLE.
> + */
> +uint64_t helper_todouble(uint32_t arg)
> +{
> +    uint32_t abs_arg =3D arg & 0x7fffffff;
> +    uint64_t ret;
> +
> +    if (likely(abs_arg >=3D 0x00800000)) {
> +        /* Normalized operand, or Inf, or NaN.  */
> +        ret  =3D (uint64_t)extract32(arg, 30, 2) << 62;
> +        ret |=3D ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
> +        ret |=3D (uint64_t)extract32(arg, 0, 29) << 29;
> +    } else {
> +        /* Zero or Denormalized operand.  */
> +        ret =3D (uint64_t)extract32(arg, 31, 1) << 63;
> +        if (unlikely(abs_arg !=3D 0)) {
> +            /* Denormalized operand.  */
> +            int shift =3D clz32(abs_arg) - 9;
> +            int exp =3D -126 - shift + 1023;
> +            ret |=3D (uint64_t)exp << 52;
> +            ret |=3D abs_arg << (shift + 29);
> +        }
> +    }
> +    return ret;
> }
>=20
> -uint32_t helper_float64_to_float32(CPUPPCState *env, uint64_t arg)
> +/*
> + * This is the non-arithmatic conversion that happens e.g. on stores.
> + * In the Power ISA pseudocode, this is called SINGLE.
> + */
> +uint32_t helper_tosingle(uint64_t arg)
> {
> -    CPU_FloatU f;
> -    CPU_DoubleU d;
> +    int exp =3D extract64(arg, 52, 11);
> +    uint32_t ret;
>=20
> -    d.ll =3D arg;
> -    f.f =3D float64_to_float32(d.d, &env->fp_status);
> -    return f.l;
> +    if (likely(exp > 896)) {
> +        /* No denormalization required (includes Inf, NaN).  */
> +        ret  =3D extract64(arg, 62, 2) << 30;
> +        ret |=3D extract64(arg, 29, 29);
> +    } else {
> +        /* Zero or Denormal result.  If the exponent is in bounds for
> +         * a single-precision denormal result, extract the proper =
bits.
> +         * If the input is not zero, and the exponent is out of =
bounds,
> +         * then the result is undefined; this underflows to zero.
> +         */
> +        ret =3D extract64(arg, 63, 1) << 63;
> +        if (unlikely(exp >=3D 874)) {
> +            /* Denormal result.  */
> +            ret |=3D ((1ULL << 52) | extract64(arg, 0, 52)) >> (896 + =
30 - exp);
> +        }
> +    }
> +    return ret;
> }
>=20
> static inline int ppc_float32_get_unbiased_exp(float32 f)
> diff --git a/target/ppc/translate/fp-impl.inc.c =
b/target/ppc/translate/fp-impl.inc.c
> index 2fbd4d4f38..a6f522b85c 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -660,15 +660,12 @@ GEN_LDUF(name, ldop, op | 0x21, type);           =
                             \
> GEN_LDUXF(name, ldop, op | 0x01, type);                                =
       \
> GEN_LDXF(name, ldop, 0x17, op | 0x00, type)
>=20
> -static inline void gen_qemu_ld32fs(DisasContext *ctx, TCGv_i64 arg1, =
TCGv arg2)
> +static void gen_qemu_ld32fs(DisasContext *ctx, TCGv_i64 dest, TCGv =
addr)
> {
> -    TCGv t0 =3D tcg_temp_new();
> -    TCGv_i32 t1 =3D tcg_temp_new_i32();
> -    gen_qemu_ld32u(ctx, t0, arg2);
> -    tcg_gen_trunc_tl_i32(t1, t0);
> -    tcg_temp_free(t0);
> -    gen_helper_float32_to_float64(arg1, cpu_env, t1);
> -    tcg_temp_free_i32(t1);
> +    TCGv_i32 tmp =3D tcg_temp_new_i32();
> +    tcg_gen_qemu_ld_i32(tmp, addr, ctx->mem_idx, DEF_MEMOP(MO_UL));
> +    gen_helper_todouble(dest, tmp);
> +    tcg_temp_free_i32(tmp);
> }
>=20
>  /* lfd lfdu lfdux lfdx */
> @@ -836,15 +833,12 @@ GEN_STUF(name, stop, op | 0x21, type);           =
                             \
> GEN_STUXF(name, stop, op | 0x01, type);                                =
       \
> GEN_STXF(name, stop, 0x17, op | 0x00, type)
>=20
> -static inline void gen_qemu_st32fs(DisasContext *ctx, TCGv_i64 arg1, =
TCGv arg2)
> +static void gen_qemu_st32fs(DisasContext *ctx, TCGv_i64 src, TCGv =
addr)
> {
> -    TCGv_i32 t0 =3D tcg_temp_new_i32();
> -    TCGv t1 =3D tcg_temp_new();
> -    gen_helper_float64_to_float32(t0, cpu_env, arg1);
> -    tcg_gen_extu_i32_tl(t1, t0);
> -    tcg_temp_free_i32(t0);
> -    gen_qemu_st32(ctx, t1, arg2);
> -    tcg_temp_free(t1);
> +    TCGv_i32 tmp =3D tcg_temp_new_i32();
> +    gen_helper_tosingle(tmp, src);
> +    tcg_gen_qemu_st_i32(tmp, addr, ctx->mem_idx, DEF_MEMOP(MO_UL));
> +    tcg_temp_free_i32(tmp);
> }
>=20
> /* stfd stfdu stfdux stfdx */
> --=20
> 2.17.1
>=20
