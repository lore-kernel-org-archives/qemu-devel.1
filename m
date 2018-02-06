Received: from eggs.gnu.org ([2001:4830:134:3::10]:56952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej17y-0003Vy-TW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej17u-0003PX-Ik
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:09:30 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej17u-0003P3-7j
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:09:26 -0500
Received: by mail-wr0-x243.google.com with SMTP id a43so1456558wrc.4
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:09:26 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-15-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-15-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:09:23 +0000
Message-ID: <87lgg6wf18.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 14/20] target/arm: Use vector
 infrastructure for aa64 dup/movi
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

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 81 +++++++++++++++++++---------------------=
------
>  1 file changed, 33 insertions(+), 48 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 11310f1a7a..48088dbb29 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5890,10 +5890,7 @@ static void handle_simd_dupe(DisasContext *s, int =
is_q, int rd, int rn,
>                               int imm5)
>  {
>      int size =3D ctz32(imm5);
> -    int esize =3D 8 << size;
> -    int elements =3D (is_q ? 128 : 64) / esize;
> -    int index, i;
> -    TCGv_i64 tmp;
> +    int index =3D imm5 >> (size + 1);
>
>      if (size > 3 || (size =3D=3D 3 && !is_q)) {
>          unallocated_encoding(s);
> @@ -5904,20 +5901,9 @@ static void handle_simd_dupe(DisasContext *s, int =
is_q, int rd, int rn,
>          return;
>      }
>
> -    index =3D imm5 >> (size + 1);
> -
> -    tmp =3D tcg_temp_new_i64();
> -    read_vec_element(s, tmp, rn, index, size);
> -
> -    for (i =3D 0; i < elements; i++) {
> -        write_vec_element(s, tmp, rd, i, size);
> -    }
> -
> -    if (!is_q) {
> -        clear_vec_high(s, rd);
> -    }
> -
> -    tcg_temp_free_i64(tmp);
> +    tcg_gen_gvec_dup_mem(size, vec_full_reg_offset(s, rd),
> +                         vec_reg_offset(s, rn, index, size),
> +                         is_q ? 16 : 8, vec_full_reg_size(s));
>  }
>
>  /* DUP (element, scalar)
> @@ -5966,9 +5952,7 @@ static void handle_simd_dupg(DisasContext *s, int i=
s_q, int rd, int rn,
>                               int imm5)
>  {
>      int size =3D ctz32(imm5);
> -    int esize =3D 8 << size;
> -    int elements =3D (is_q ? 128 : 64)/esize;
> -    int i =3D 0;
> +    uint32_t dofs, oprsz, maxsz;
>
>      if (size > 3 || ((size =3D=3D 3) && !is_q)) {
>          unallocated_encoding(s);
> @@ -5979,12 +5963,11 @@ static void handle_simd_dupg(DisasContext *s, int=
 is_q, int rd, int rn,
>          return;
>      }
>
> -    for (i =3D 0; i < elements; i++) {
> -        write_vec_element(s, cpu_reg(s, rn), rd, i, size);
> -    }
> -    if (!is_q) {
> -        clear_vec_high(s, rd);
> -    }
> +    dofs =3D vec_full_reg_offset(s, rd);
> +    oprsz =3D is_q ? 16 : 8;
> +    maxsz =3D vec_full_reg_size(s);
> +
> +    tcg_gen_gvec_dup_i64(size, dofs, oprsz, maxsz, cpu_reg(s, rn));
>  }
>
>  /* INS (Element)
> @@ -6175,7 +6158,6 @@ static void disas_simd_mod_imm(DisasContext *s, uin=
t32_t insn)
>      bool is_neg =3D extract32(insn, 29, 1);
>      bool is_q =3D extract32(insn, 30, 1);
>      uint64_t imm =3D 0;
> -    TCGv_i64 tcg_rd, tcg_imm;
>      int i;
>
>      if (o2 !=3D 0 || ((cmode =3D=3D 0xf) && is_neg && !is_q)) {
> @@ -6257,32 +6239,35 @@ static void disas_simd_mod_imm(DisasContext *s, u=
int32_t insn)
>          imm =3D ~imm;
>      }
>
> -    tcg_imm =3D tcg_const_i64(imm);
> -    tcg_rd =3D new_tmp_a64(s);
> +    if (!((cmode & 0x9) =3D=3D 0x1 || (cmode & 0xd) =3D=3D 0x9)) {
> +        /* MOVI or MVNI, with MVNI negation handled above.  */
> +        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
> +                            vec_full_reg_size(s), imm);
> +    } else {
> +        TCGv_i64 tcg_imm =3D tcg_const_i64(imm);
> +        TCGv_i64 tcg_rd =3D new_tmp_a64(s);
>
> -    for (i =3D 0; i < 2; i++) {
> -        int foffs =3D i ? fp_reg_hi_offset(s, rd) : fp_reg_offset(s, rd,=
 MO_64);
> +        for (i =3D 0; i < 2; i++) {
> +            int foffs =3D vec_reg_offset(s, rd, i, MO_64);
>
> -        if (i =3D=3D 1 && !is_q) {
> -            /* non-quad ops clear high half of vector */
> -            tcg_gen_movi_i64(tcg_rd, 0);
> -        } else if ((cmode & 0x9) =3D=3D 0x1 || (cmode & 0xd) =3D=3D 0x9)=
 {
> -            tcg_gen_ld_i64(tcg_rd, cpu_env, foffs);
> -            if (is_neg) {
> -                /* AND (BIC) */
> -                tcg_gen_and_i64(tcg_rd, tcg_rd, tcg_imm);
> +            if (i =3D=3D 1 && !is_q) {
> +                /* non-quad ops clear high half of vector */
> +                tcg_gen_movi_i64(tcg_rd, 0);
>              } else {
> -                /* ORR */
> -                tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_imm);
> +                tcg_gen_ld_i64(tcg_rd, cpu_env, foffs);
> +                if (is_neg) {
> +                    /* AND (BIC) */
> +                    tcg_gen_and_i64(tcg_rd, tcg_rd, tcg_imm);
> +                } else {
> +                    /* ORR */
> +                    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_imm);
> +                }
>              }
> -        } else {
> -            /* MOVI */
> -            tcg_gen_mov_i64(tcg_rd, tcg_imm);
> +            tcg_gen_st_i64(tcg_rd, cpu_env, foffs);
>          }
> -        tcg_gen_st_i64(tcg_rd, cpu_env, foffs);
> -    }
>
> -    tcg_temp_free_i64(tcg_imm);
> +        tcg_temp_free_i64(tcg_imm);
> +    }
>  }
>
>  /* AdvSIMD scalar copy


--
Alex Benn=C3=A9e
