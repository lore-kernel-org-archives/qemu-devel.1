Received: from eggs.gnu.org ([2001:4830:134:3::10]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZin-0007D9-Hw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edZik-0007QS-El
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:53:01 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edZik-0007Q4-57
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 05:52:58 -0500
Received: by mail-wr0-x244.google.com with SMTP id x1so8112268wrb.5
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 02:52:57 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-5-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 10:52:55 +0000
Message-ID: <87372ykvw8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/16] target/arm: Use pointers in neon
 tbl helper
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

> Rather than passing a regno to the helper, pass pointers to the
> vector register directly.  This eliminates the need to pass in
> the environment pointer and reduces the number of places that
> directly access env->vfp.regs[].
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h    |  2 +-
>  target/arm/op_helper.c | 17 +++++++----------
>  target/arm/translate.c |  8 ++++----
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index dbdc38fcb7..5dec2e6262 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -188,7 +188,7 @@ DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, =
f32, ptr)
>  DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
>  DEF_HELPER_2(recpe_u32, i32, i32, ptr)
>  DEF_HELPER_FLAGS_2(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32, ptr)
> -DEF_HELPER_5(neon_tbl, i32, env, i32, i32, i32, i32)
> +DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i32, i32, i32, ptr, i32)
>
>  DEF_HELPER_3(shl_cc, i32, env, i32, i32)
>  DEF_HELPER_3(shr_cc, i32, env, i32, i32)
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 712c5c55b6..a937e76710 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -54,20 +54,17 @@ static int exception_target_el(CPUARMState *env)
>      return target_el;
>  }
>
> -uint32_t HELPER(neon_tbl)(CPUARMState *env, uint32_t ireg, uint32_t def,
> -                          uint32_t rn, uint32_t maxindex)
> +uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
> +                          uint32_t maxindex)
>  {
> -    uint32_t val;
> -    uint32_t tmp;
> -    int index;
> -    int shift;
> -    uint64_t *table;
> -    table =3D (uint64_t *)&env->vfp.regs[rn];
> +    uint32_t val, shift;

Any particular reason to promote shift to a uint32_t here?

> +    uint64_t *table =3D vn;
> +
>      val =3D 0;
>      for (shift =3D 0; shift < 32; shift +=3D 8) {
> -        index =3D (ireg >> shift) & 0xff;
> +        uint32_t index =3D (ireg >> shift) & 0xff;
>          if (index < maxindex) {
> -            tmp =3D (table[index >> 3] >> ((index & 7) << 3)) & 0xff;
> +            uint32_t tmp =3D (table[index >> 3] >> ((index & 7) << 3)) &=
 0xff;
>              val |=3D tmp << shift;
>          } else {
>              val |=3D def & (0xff << shift);
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 6f02c56abb..852d2a75b1 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7544,9 +7544,9 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                      tcg_gen_movi_i32(tmp, 0);
>                  }
>                  tmp2 =3D neon_load_reg(rm, 0);
> -                tmp4 =3D tcg_const_i32(rn);
> +                ptr1 =3D vfp_reg_ptr(true, rn);
>                  tmp5 =3D tcg_const_i32(n);
> -                gen_helper_neon_tbl(tmp2, cpu_env, tmp2, tmp, tmp4, tmp5=
);
> +                gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp5);
>                  tcg_temp_free_i32(tmp);
>                  if (insn & (1 << 6)) {
>                      tmp =3D neon_load_reg(rd, 1);
> @@ -7555,9 +7555,9 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                      tcg_gen_movi_i32(tmp, 0);
>                  }
>                  tmp3 =3D neon_load_reg(rm, 1);
> -                gen_helper_neon_tbl(tmp3, cpu_env, tmp3, tmp, tmp4, tmp5=
);
> +                gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp5);
>                  tcg_temp_free_i32(tmp5);
> -                tcg_temp_free_i32(tmp4);
> +                tcg_temp_free_ptr(ptr1);
>                  neon_store_reg(rd, 0, tmp2);
>                  neon_store_reg(rd, 1, tmp3);
>                  tcg_temp_free_i32(tmp);

I was wondering why tmp4 wasn't dropped from the declarations until I
was reminded how massively overloaded this function is.

Anyway baring the minor nit:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>



--
Alex Benn=C3=A9e
