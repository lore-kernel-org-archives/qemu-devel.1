Received: from eggs.gnu.org ([209.51.188.92]:35392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsyd-0004UE-Ec
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLsyX-0005iT-PH
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:25:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLsyV-0005Vj-IF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:24:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so16827236wrs.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:24:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c11sm29079414wrs.86.2019.05.01.10.24.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 10:24:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2BAC61FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 18:24:50 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-5-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 18:24:50 +0100
Message-ID: <87r29i5bq5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/29] tcg: Specify optional vector
 requirements with a list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Replace the single opcode in .opc with a null-terminated
> array in .opt_opc.  We still require that all opcodes be
> used with the same .vece.
>
> Validate the contents of this list with CONFIG_DEBUG_TCG.
> All tcg_gen_*_vec functions will check any list active
> during .fniv expansion.  Swap the active list in and out
> as we expand other opcodes, or take control away from the
> front-end function.
>
> Convert all existing vector aware front ends.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-gvec.h                   |  24 +--
>  tcg/tcg.h                           |  20 +++
>  target/arm/translate-sve.c          |   9 +-
>  target/arm/translate.c              | 123 +++++++++-----
>  target/ppc/translate/vmx-impl.inc.c |   7 +-
>  tcg/tcg-op-gvec.c                   | 249 ++++++++++++++++------------
>  tcg/tcg-op-vec.c                    | 102 ++++++++++++
>  7 files changed, 372 insertions(+), 162 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index c093243c4c..ac744ff7c9 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -91,8 +91,8 @@ typedef struct {
>      void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
>      /* Expand out-of-line helper w/descriptor.  */
>      gen_helper_gvec_2 *fno;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The data argument to the out-of-line helper.  */
>      int32_t data;
>      /* The vector element size, if applicable.  */
> @@ -112,8 +112,8 @@ typedef struct {
>      gen_helper_gvec_2 *fno;
>      /* Expand out-of-line helper w/descriptor, data as argument.  */
>      gen_helper_gvec_2i *fnoi;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The vector element size, if applicable.  */
>      uint8_t vece;
>      /* Prefer i64 to v64.  */
> @@ -131,8 +131,8 @@ typedef struct {
>      void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
>      /* Expand out-of-line helper w/descriptor.  */
>      gen_helper_gvec_2i *fno;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The data argument to the out-of-line helper.  */
>      uint32_t data;
>      /* The vector element size, if applicable.  */
> @@ -152,8 +152,8 @@ typedef struct {
>      void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
>      /* Expand out-of-line helper w/descriptor.  */
>      gen_helper_gvec_3 *fno;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The data argument to the out-of-line helper.  */
>      int32_t data;
>      /* The vector element size, if applicable.  */
> @@ -175,8 +175,8 @@ typedef struct {
>      void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
>      /* Expand out-of-line helper w/descriptor, data in descriptor.  */
>      gen_helper_gvec_3 *fno;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The vector element size, if applicable.  */
>      uint8_t vece;
>      /* Prefer i64 to v64.  */
> @@ -194,8 +194,8 @@ typedef struct {
>      void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
>      /* Expand out-of-line helper w/descriptor.  */
>      gen_helper_gvec_4 *fno;
> -    /* The opcode, if any, to which this corresponds.  */
> -    TCGOpcode opc;
> +    /* The optional opcodes, if any, utilized by .fniv.  */
> +    const TCGOpcode *opt_opc;
>      /* The data argument to the out-of-line helper.  */
>      int32_t data;
>      /* The vector element size, if applicable.  */
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index cfc57110a1..2c7315da25 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -692,6 +692,7 @@ struct TCGContext {
>  #ifdef CONFIG_DEBUG_TCG
>      int temps_in_use;
>      int goto_tb_issue_mask;
> +    const TCGOpcode *vecop_list;
>  #endif
>
>      /* Code generation.  Note that we specifically do not use tcg_insn_u=
nit
> @@ -1492,4 +1493,23 @@ void helper_atomic_sto_le_mmu(CPUArchState *env, t=
arget_ulong addr, Int128 val,
>  void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int1=
28 val,
>                                TCGMemOpIdx oi, uintptr_t retaddr);
>
> +#ifdef CONFIG_DEBUG_TCG
> +void tcg_assert_listed_vecop(TCGOpcode);
> +#else
> +static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
> +#endif
> +
> +static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
> +{
> +#ifdef CONFIG_DEBUG_TCG
> +    const TCGOpcode *o =3D tcg_ctx->vecop_list;
> +    tcg_ctx->vecop_list =3D n;
> +    return o;
> +#else
> +    return NULL;
> +#endif
> +}
> +
> +bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
> +
>  #endif /* TCG_H */
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 245cd82621..0682c0d32b 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3302,29 +3302,30 @@ static bool trans_SUB_zzi(DisasContext *s, arg_rr=
i_esz *a)
>
>  static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_sub_vec, 0 };
>      static const GVecGen2s op[4] =3D {
>          { .fni8 =3D tcg_gen_vec_sub8_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_sve_subri_b,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8,
>            .scalar_first =3D true },
>          { .fni8 =3D tcg_gen_vec_sub16_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_sve_subri_h,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16,
>            .scalar_first =3D true },
>          { .fni4 =3D tcg_gen_sub_i32,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_sve_subri_s,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32,
>            .scalar_first =3D true },
>          { .fni8 =3D tcg_gen_sub_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_sve_subri_d,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64,
>            .scalar_first =3D true }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 10bc53f91c..35bd426a3d 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5861,27 +5861,31 @@ static void gen_ssra_vec(unsigned vece, TCGv_vec =
d, TCGv_vec a, int64_t sh)
>      tcg_gen_add_vec(vece, d, d, a);
>  }
>
> +static const TCGOpcode vecop_list_ssra[] =3D {
> +    INDEX_op_sari_vec, INDEX_op_add_vec, 0
> +};
> +
>  const GVecGen2i ssra_op[4] =3D {
>      { .fni8 =3D gen_ssra8_i64,
>        .fniv =3D gen_ssra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_sari_vec,
> +      .opt_opc =3D vecop_list_ssra,
>        .vece =3D MO_8 },
>      { .fni8 =3D gen_ssra16_i64,
>        .fniv =3D gen_ssra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_sari_vec,
> +      .opt_opc =3D vecop_list_ssra,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_ssra32_i32,
>        .fniv =3D gen_ssra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_sari_vec,
> +      .opt_opc =3D vecop_list_ssra,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_ssra64_i64,
>        .fniv =3D gen_ssra_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +      .opt_opc =3D vecop_list_ssra,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_sari_vec,
>        .vece =3D MO_64 },
>  };
>
> @@ -5915,27 +5919,31 @@ static void gen_usra_vec(unsigned vece, TCGv_vec =
d, TCGv_vec a, int64_t sh)
>      tcg_gen_add_vec(vece, d, d, a);
>  }
>
> +static const TCGOpcode vecop_list_usra[] =3D {
> +    INDEX_op_shri_vec, INDEX_op_add_vec, 0
> +};
> +
>  const GVecGen2i usra_op[4] =3D {
>      { .fni8 =3D gen_usra8_i64,
>        .fniv =3D gen_usra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_usra,
>        .vece =3D MO_8, },
>      { .fni8 =3D gen_usra16_i64,
>        .fniv =3D gen_usra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_usra,
>        .vece =3D MO_16, },
>      { .fni4 =3D gen_usra32_i32,
>        .fniv =3D gen_usra_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_usra,
>        .vece =3D MO_32, },
>      { .fni8 =3D gen_usra64_i64,
>        .fniv =3D gen_usra_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_usra,
>        .vece =3D MO_64, },
>  };
>
> @@ -5993,27 +6001,29 @@ static void gen_shr_ins_vec(unsigned vece, TCGv_v=
ec d, TCGv_vec a, int64_t sh)
>      }
>  }
>
> +static const TCGOpcode vecop_list_sri[] =3D { INDEX_op_shri_vec, 0 };
> +
>  const GVecGen2i sri_op[4] =3D {
>      { .fni8 =3D gen_shr8_ins_i64,
>        .fniv =3D gen_shr_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_sri,
>        .vece =3D MO_8 },
>      { .fni8 =3D gen_shr16_ins_i64,
>        .fniv =3D gen_shr_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_sri,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_shr32_ins_i32,
>        .fniv =3D gen_shr_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_sri,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_shr64_ins_i64,
>        .fniv =3D gen_shr_ins_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shri_vec,
> +      .opt_opc =3D vecop_list_sri,
>        .vece =3D MO_64 },
>  };
>
> @@ -6069,27 +6079,29 @@ static void gen_shl_ins_vec(unsigned vece, TCGv_v=
ec d, TCGv_vec a, int64_t sh)
>      }
>  }
>
> +static const TCGOpcode vecop_list_sli[] =3D { INDEX_op_shli_vec, 0 };
> +
>  const GVecGen2i sli_op[4] =3D {
>      { .fni8 =3D gen_shl8_ins_i64,
>        .fniv =3D gen_shl_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shli_vec,
> +      .opt_opc =3D vecop_list_sli,
>        .vece =3D MO_8 },
>      { .fni8 =3D gen_shl16_ins_i64,
>        .fniv =3D gen_shl_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shli_vec,
> +      .opt_opc =3D vecop_list_sli,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_shl32_ins_i32,
>        .fniv =3D gen_shl_ins_vec,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shli_vec,
> +      .opt_opc =3D vecop_list_sli,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_shl64_ins_i64,
>        .fniv =3D gen_shl_ins_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>        .load_dest =3D true,
> -      .opc =3D INDEX_op_shli_vec,
> +      .opt_opc =3D vecop_list_sli,
>        .vece =3D MO_64 },
>  };
>
> @@ -6156,51 +6168,60 @@ static void gen_mls_vec(unsigned vece, TCGv_vec d=
, TCGv_vec a, TCGv_vec b)
>  /* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
>   * these tables are shared with AArch64 which does support them.
>   */
> +
> +static const TCGOpcode vecop_list_mla[] =3D {
> +    INDEX_op_mul_vec, INDEX_op_add_vec, 0
> +};
> +
> +static const TCGOpcode vecop_list_mls[] =3D {
> +    INDEX_op_mul_vec, INDEX_op_sub_vec, 0
> +};
> +
>  const GVecGen3 mla_op[4] =3D {
>      { .fni4 =3D gen_mla8_i32,
>        .fniv =3D gen_mla_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mla,
>        .vece =3D MO_8 },
>      { .fni4 =3D gen_mla16_i32,
>        .fniv =3D gen_mla_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mla,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_mla32_i32,
>        .fniv =3D gen_mla_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mla,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_mla64_i64,
>        .fniv =3D gen_mla_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mla,
>        .vece =3D MO_64 },
>  };
>
>  const GVecGen3 mls_op[4] =3D {
>      { .fni4 =3D gen_mls8_i32,
>        .fniv =3D gen_mls_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mls,
>        .vece =3D MO_8 },
>      { .fni4 =3D gen_mls16_i32,
>        .fniv =3D gen_mls_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mls,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_mls32_i32,
>        .fniv =3D gen_mls_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mls,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_mls64_i64,
>        .fniv =3D gen_mls_vec,
> -      .opc =3D INDEX_op_mul_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>        .load_dest =3D true,
> +      .opt_opc =3D vecop_list_mls,
>        .vece =3D MO_64 },
>  };
>
> @@ -6226,19 +6247,25 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec=
 d, TCGv_vec a, TCGv_vec b)
>      tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
>  }
>
> +static const TCGOpcode vecop_list_cmtst[] =3D { INDEX_op_cmp_vec, 0 };
> +
>  const GVecGen3 cmtst_op[4] =3D {
>      { .fni4 =3D gen_helper_neon_tst_u8,
>        .fniv =3D gen_cmtst_vec,
> +      .opt_opc =3D vecop_list_cmtst,
>        .vece =3D MO_8 },
>      { .fni4 =3D gen_helper_neon_tst_u16,
>        .fniv =3D gen_cmtst_vec,
> +      .opt_opc =3D vecop_list_cmtst,
>        .vece =3D MO_16 },
>      { .fni4 =3D gen_cmtst_i32,
>        .fniv =3D gen_cmtst_vec,
> +      .opt_opc =3D vecop_list_cmtst,
>        .vece =3D MO_32 },
>      { .fni8 =3D gen_cmtst_i64,
>        .fniv =3D gen_cmtst_vec,
>        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +      .opt_opc =3D vecop_list_cmtst,
>        .vece =3D MO_64 },
>  };
>
> @@ -6253,26 +6280,30 @@ static void gen_uqadd_vec(unsigned vece, TCGv_vec=
 t, TCGv_vec sat,
>      tcg_temp_free_vec(x);
>  }
>
> +static const TCGOpcode vecop_list_uqadd[] =3D {
> +    INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
> +};
> +
>  const GVecGen4 uqadd_op[4] =3D {
>      { .fniv =3D gen_uqadd_vec,
>        .fno =3D gen_helper_gvec_uqadd_b,
> -      .opc =3D INDEX_op_usadd_vec,
>        .write_aofs =3D true,
> +      .opt_opc =3D vecop_list_uqadd,
>        .vece =3D MO_8 },
>      { .fniv =3D gen_uqadd_vec,
>        .fno =3D gen_helper_gvec_uqadd_h,
> -      .opc =3D INDEX_op_usadd_vec,
>        .write_aofs =3D true,
> +      .opt_opc =3D vecop_list_uqadd,
>        .vece =3D MO_16 },
>      { .fniv =3D gen_uqadd_vec,
>        .fno =3D gen_helper_gvec_uqadd_s,
> -      .opc =3D INDEX_op_usadd_vec,
>        .write_aofs =3D true,
> +      .opt_opc =3D vecop_list_uqadd,
>        .vece =3D MO_32 },
>      { .fniv =3D gen_uqadd_vec,
>        .fno =3D gen_helper_gvec_uqadd_d,
> -      .opc =3D INDEX_op_usadd_vec,
>        .write_aofs =3D true,
> +      .opt_opc =3D vecop_list_uqadd,
>        .vece =3D MO_64 },
>  };
>
> @@ -6287,25 +6318,29 @@ static void gen_sqadd_vec(unsigned vece, TCGv_vec=
 t, TCGv_vec sat,
>      tcg_temp_free_vec(x);
>  }
>
> +static const TCGOpcode vecop_list_sqadd[] =3D {
> +    INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
> +};
> +
>  const GVecGen4 sqadd_op[4] =3D {
>      { .fniv =3D gen_sqadd_vec,
>        .fno =3D gen_helper_gvec_sqadd_b,
> -      .opc =3D INDEX_op_ssadd_vec,
> +      .opt_opc =3D vecop_list_sqadd,
>        .write_aofs =3D true,
>        .vece =3D MO_8 },
>      { .fniv =3D gen_sqadd_vec,
>        .fno =3D gen_helper_gvec_sqadd_h,
> -      .opc =3D INDEX_op_ssadd_vec,
> +      .opt_opc =3D vecop_list_sqadd,
>        .write_aofs =3D true,
>        .vece =3D MO_16 },
>      { .fniv =3D gen_sqadd_vec,
>        .fno =3D gen_helper_gvec_sqadd_s,
> -      .opc =3D INDEX_op_ssadd_vec,
> +      .opt_opc =3D vecop_list_sqadd,
>        .write_aofs =3D true,
>        .vece =3D MO_32 },
>      { .fniv =3D gen_sqadd_vec,
>        .fno =3D gen_helper_gvec_sqadd_d,
> -      .opc =3D INDEX_op_ssadd_vec,
> +      .opt_opc =3D vecop_list_sqadd,
>        .write_aofs =3D true,
>        .vece =3D MO_64 },
>  };
> @@ -6321,25 +6356,29 @@ static void gen_uqsub_vec(unsigned vece, TCGv_vec=
 t, TCGv_vec sat,
>      tcg_temp_free_vec(x);
>  }
>
> +static const TCGOpcode vecop_list_uqsub[] =3D {
> +    INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
> +};
> +
>  const GVecGen4 uqsub_op[4] =3D {
>      { .fniv =3D gen_uqsub_vec,
>        .fno =3D gen_helper_gvec_uqsub_b,
> -      .opc =3D INDEX_op_ussub_vec,
> +      .opt_opc =3D vecop_list_uqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_8 },
>      { .fniv =3D gen_uqsub_vec,
>        .fno =3D gen_helper_gvec_uqsub_h,
> -      .opc =3D INDEX_op_ussub_vec,
> +      .opt_opc =3D vecop_list_uqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_16 },
>      { .fniv =3D gen_uqsub_vec,
>        .fno =3D gen_helper_gvec_uqsub_s,
> -      .opc =3D INDEX_op_ussub_vec,
> +      .opt_opc =3D vecop_list_uqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_32 },
>      { .fniv =3D gen_uqsub_vec,
>        .fno =3D gen_helper_gvec_uqsub_d,
> -      .opc =3D INDEX_op_ussub_vec,
> +      .opt_opc =3D vecop_list_uqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_64 },
>  };
> @@ -6355,25 +6394,29 @@ static void gen_sqsub_vec(unsigned vece, TCGv_vec=
 t, TCGv_vec sat,
>      tcg_temp_free_vec(x);
>  }
>
> +static const TCGOpcode vecop_list_sqsub[] =3D {
> +    INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
> +};
> +
>  const GVecGen4 sqsub_op[4] =3D {
>      { .fniv =3D gen_sqsub_vec,
>        .fno =3D gen_helper_gvec_sqsub_b,
> -      .opc =3D INDEX_op_sssub_vec,
> +      .opt_opc =3D vecop_list_sqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_8 },
>      { .fniv =3D gen_sqsub_vec,
>        .fno =3D gen_helper_gvec_sqsub_h,
> -      .opc =3D INDEX_op_sssub_vec,
> +      .opt_opc =3D vecop_list_sqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_16 },
>      { .fniv =3D gen_sqsub_vec,
>        .fno =3D gen_helper_gvec_sqsub_s,
> -      .opc =3D INDEX_op_sssub_vec,
> +      .opt_opc =3D vecop_list_sqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_32 },
>      { .fniv =3D gen_sqsub_vec,
>        .fno =3D gen_helper_gvec_sqsub_d,
> -      .opc =3D INDEX_op_sssub_vec,
> +      .opt_opc =3D vecop_list_sqsub,
>        .write_aofs =3D true,
>        .vece =3D MO_64 },
>  };
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index bd3ff40e68..6861f4c5b9 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -566,10 +566,15 @@ static void glue(glue(gen_, NAME), _vec)(unsigned v=
ece, TCGv_vec t,     \
>  }                                                                       \
>  static void glue(gen_, NAME)(DisasContext *ctx)                         \
>  {                                                                       \
> +    static const TCGOpcode vecop_list[] =3D {                           =
  \
> +        glue(glue(INDEX_op_, NORM), _vec),                              \
> +        glue(glue(INDEX_op_, SAT), _vec),                               \
> +        INDEX_op_cmp_vec, 0                                             \
> +    };                                                                  \
>      static const GVecGen4 g =3D {                                       =
  \
>          .fniv =3D glue(glue(gen_, NAME), _vec),                         =
  \
>          .fno =3D glue(gen_helper_, NAME),                               =
  \
> -        .opc =3D glue(glue(INDEX_op_, SAT), _vec),                      =
  \
> +        .opt_opc =3D vecop_list,                                        =
  \
>          .write_aofs =3D true,                                           =
  \
>          .vece =3D VECE,                                                 =
  \
>      };                                                                  \
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index f831adb4e7..3fcb2352d9 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -26,6 +26,13 @@
>
>  #define MAX_UNROLL  4
>
> +#ifdef CONFIG_DEBUG_TCG
> +static const TCGOpcode vecop_list_empty[1] =3D { 0 };
> +#else
> +#define vecop_list_empty NULL
> +#endif
> +
> +
>  /* Verify vector size and alignment rules.  OFS should be the OR of all
>     of the operand offsets so that we can check them all at once.  */
>  static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t of=
s)
> @@ -360,31 +367,29 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out=
, TCGv_i64 in)
>   * on elements of size VECE in the selected type.  Do not select V64 if
>   * PREFER_I64 is true.  Return 0 if no vector type is selected.
>   */
> -static TCGType choose_vector_type(TCGOpcode op, unsigned vece, uint32_t =
size,
> -                                  bool prefer_i64)
> +static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
> +                                  uint32_t size, bool prefer_i64)
>  {
>      if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
> -        if (op =3D=3D 0) {
> -            return TCG_TYPE_V256;
> -        }
> -        /* Recall that ARM SVE allows vector sizes that are not a
> +        /*
> +         * Recall that ARM SVE allows vector sizes that are not a
>           * power of 2, but always a multiple of 16.  The intent is
>           * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
>           * It is hard to imagine a case in which v256 is supported
>           * but v128 is not, but check anyway.
>           */
> -        if (tcg_can_emit_vec_op(op, TCG_TYPE_V256, vece)
> +        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
>              && (size % 32 =3D=3D 0
> -                || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
> +                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
>              return TCG_TYPE_V256;
>          }
>      }
>      if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
> -        && (op =3D=3D 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))=
) {
> +        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
>          return TCG_TYPE_V128;
>      }
>      if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
> -        && (op =3D=3D 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V64, vece)))=
 {
> +        && tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)) {
>          return TCG_TYPE_V64;
>      }
>      return 0;
> @@ -418,7 +423,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint=
32_t oprsz,
>      /* Implement inline with a vector type, if possible.
>       * Prefer integer when 64-bit host and no variable dup.
>       */
> -    type =3D choose_vector_type(0, vece, oprsz,
> +    type =3D choose_vector_type(NULL, vece, oprsz,
>                                (TCG_TARGET_REG_BITS =3D=3D 64 && in_32 =
=3D=3D NULL
>                                 && (in_64 =3D=3D NULL || vece =3D=3D MO_6=
4)));
>      if (type !=3D 0) {
> @@ -991,6 +996,8 @@ static void expand_4_vec(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>  void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
>  {
> +    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>      TCGType type;
>      uint32_t some;
>
> @@ -999,7 +1006,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -1032,13 +1039,14 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>          } else {
>              assert(g->fno !=3D NULL);
>              tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno=
);
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> @@ -1049,6 +1057,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>  void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
>                       uint32_t maxsz, int64_t c, const GVecGen2i *g)
>  {
> +    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>      TCGType type;
>      uint32_t some;
>
> @@ -1057,7 +1067,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, =
uint32_t oprsz,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -1099,13 +1109,14 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs=
, uint32_t oprsz,
>                                      maxsz, c, g->fnoi);
>                  tcg_temp_free_i64(tcg_c);
>              }
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> @@ -1123,9 +1134,11 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs,=
 uint32_t oprsz,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      if (type !=3D 0) {
> +        const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>          TCGv_vec t_vec =3D tcg_temp_new_vec(type);
>          uint32_t some;
>
> @@ -1163,6 +1176,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, =
uint32_t oprsz,
>              g_assert_not_reached();
>          }
>          tcg_temp_free_vec(t_vec);
> +        tcg_swap_vecop_list(hold_list);
>      } else if (g->fni8 && check_size_impl(oprsz, 8)) {
>          TCGv_i64 t64 =3D tcg_temp_new_i64();
>
> @@ -1190,6 +1204,8 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, =
uint32_t oprsz,
>  void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
>  {
> +    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>      TCGType type;
>      uint32_t some;
>
> @@ -1198,7 +1214,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, u=
int32_t bofs,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -1236,13 +1252,14 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs,=
 uint32_t bofs,
>              assert(g->fno !=3D NULL);
>              tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
>                                 maxsz, g->data, g->fno);
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> @@ -1254,6 +1271,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>                       uint32_t oprsz, uint32_t maxsz, int64_t c,
>                       const GVecGen3i *g)
>  {
> +    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>      TCGType type;
>      uint32_t some;
>
> @@ -1262,7 +1281,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -1300,13 +1319,14 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs=
, uint32_t bofs,
>          } else {
>              assert(g->fno !=3D NULL);
>              tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno=
);
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> @@ -1317,6 +1337,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>  void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
>  {
> +    const TCGOpcode *this_list =3D g->opt_opc ? : vecop_list_empty;
> +    const TCGOpcode *hold_list =3D tcg_swap_vecop_list(this_list);
>      TCGType type;
>      uint32_t some;
>
> @@ -1325,7 +1347,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, u=
int32_t bofs, uint32_t cofs,
>
>      type =3D 0;
>      if (g->fniv) {
> -        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +        type =3D choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefe=
r_i64);
>      }
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -1366,13 +1388,14 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs,=
 uint32_t bofs, uint32_t cofs,
>              assert(g->fno !=3D NULL);
>              tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
>                                 oprsz, maxsz, g->data, g->fno);
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> @@ -1567,6 +1590,8 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, =
TCGv_i64 b)
>      tcg_temp_free_i64(t2);
>  }
>
> +static const TCGOpcode vecop_list_add[] =3D { INDEX_op_add_vec, 0 };
> +
>  void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> @@ -1574,22 +1599,22 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dof=
s, uint32_t aofs,
>          { .fni8 =3D tcg_gen_vec_add8_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_add8,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_add16_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_add16,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_add_i32,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_add32,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_add_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_add64,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1605,22 +1630,22 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>          { .fni8 =3D tcg_gen_vec_add8_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_adds8,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_add16_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_adds16,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_add_i32,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_adds32,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_add_i64,
>            .fniv =3D tcg_gen_add_vec,
>            .fno =3D gen_helper_gvec_adds64,
> -          .opc =3D INDEX_op_add_vec,
> +          .opt_opc =3D vecop_list_add,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1637,6 +1662,8 @@ void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>      tcg_temp_free_i64(tmp);
>  }
>
> +static const TCGOpcode vecop_list_sub[] =3D { INDEX_op_sub_vec, 0 };
> +
>  void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
>  {
> @@ -1644,22 +1671,22 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>          { .fni8 =3D tcg_gen_vec_sub8_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_subs8,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_sub16_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_subs16,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_sub_i32,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_subs32,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_sub_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_subs64,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1723,22 +1750,22 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dof=
s, uint32_t aofs,
>          { .fni8 =3D tcg_gen_vec_sub8_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_sub8,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_sub16_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_sub16,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_sub_i32,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_sub32,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_sub_i64,
>            .fniv =3D tcg_gen_sub_vec,
>            .fno =3D gen_helper_gvec_sub64,
> -          .opc =3D INDEX_op_sub_vec,
> +          .opt_opc =3D vecop_list_sub,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1747,27 +1774,29 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dof=
s, uint32_t aofs,
>      tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
>  }
>
> +static const TCGOpcode vecop_list_mul[] =3D { INDEX_op_mul_vec, 0 };
> +
>  void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_mul8,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_mul16,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_mul_i32,
>            .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_mul32,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_mul_i64,
>            .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_mul64,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1782,21 +1811,21 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>      static const GVecGen2s g[4] =3D {
>          { .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_muls8,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_muls16,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_mul_i32,
>            .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_muls32,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_mul_i64,
>            .fniv =3D tcg_gen_mul_vec,
>            .fno =3D gen_helper_gvec_muls64,
> -          .opc =3D INDEX_op_mul_vec,
> +          .opt_opc =3D vecop_list_mul,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -1816,22 +1845,23 @@ void tcg_gen_gvec_muli(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>  void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_ssadd_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_ssadd_vec,
>            .fno =3D gen_helper_gvec_ssadd8,
> -          .opc =3D INDEX_op_ssadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_ssadd_vec,
>            .fno =3D gen_helper_gvec_ssadd16,
> -          .opc =3D INDEX_op_ssadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fniv =3D tcg_gen_ssadd_vec,
>            .fno =3D gen_helper_gvec_ssadd32,
> -          .opc =3D INDEX_op_ssadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fniv =3D tcg_gen_ssadd_vec,
>            .fno =3D gen_helper_gvec_ssadd64,
> -          .opc =3D INDEX_op_ssadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 },
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -1841,22 +1871,23 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t d=
ofs, uint32_t aofs,
>  void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_sssub_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_sssub_vec,
>            .fno =3D gen_helper_gvec_sssub8,
> -          .opc =3D INDEX_op_sssub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_sssub_vec,
>            .fno =3D gen_helper_gvec_sssub16,
> -          .opc =3D INDEX_op_sssub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fniv =3D tcg_gen_sssub_vec,
>            .fno =3D gen_helper_gvec_sssub32,
> -          .opc =3D INDEX_op_sssub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fniv =3D tcg_gen_sssub_vec,
>            .fno =3D gen_helper_gvec_sssub64,
> -          .opc =3D INDEX_op_sssub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 },
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -1882,24 +1913,25 @@ static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i6=
4 a, TCGv_i64 b)
>  void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_usadd_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_usadd_vec,
>            .fno =3D gen_helper_gvec_usadd8,
> -          .opc =3D INDEX_op_usadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_usadd_vec,
>            .fno =3D gen_helper_gvec_usadd16,
> -          .opc =3D INDEX_op_usadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_usadd_i32,
>            .fniv =3D tcg_gen_usadd_vec,
>            .fno =3D gen_helper_gvec_usadd32,
> -          .opc =3D INDEX_op_usadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_usadd_i64,
>            .fniv =3D tcg_gen_usadd_vec,
>            .fno =3D gen_helper_gvec_usadd64,
> -          .opc =3D INDEX_op_usadd_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -1925,24 +1957,25 @@ static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i6=
4 a, TCGv_i64 b)
>  void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
>                          uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_ussub_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_ussub_vec,
>            .fno =3D gen_helper_gvec_ussub8,
> -          .opc =3D INDEX_op_ussub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_ussub_vec,
>            .fno =3D gen_helper_gvec_ussub16,
> -          .opc =3D INDEX_op_ussub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_ussub_i32,
>            .fniv =3D tcg_gen_ussub_vec,
>            .fno =3D gen_helper_gvec_ussub32,
> -          .opc =3D INDEX_op_ussub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_ussub_i64,
>            .fniv =3D tcg_gen_ussub_vec,
>            .fno =3D gen_helper_gvec_ussub64,
> -          .opc =3D INDEX_op_ussub_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -1952,24 +1985,25 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t d=
ofs, uint32_t aofs,
>  void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_smin_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_smin_vec,
>            .fno =3D gen_helper_gvec_smin8,
> -          .opc =3D INDEX_op_smin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_smin_vec,
>            .fno =3D gen_helper_gvec_smin16,
> -          .opc =3D INDEX_op_smin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_smin_i32,
>            .fniv =3D tcg_gen_smin_vec,
>            .fno =3D gen_helper_gvec_smin32,
> -          .opc =3D INDEX_op_smin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_smin_i64,
>            .fniv =3D tcg_gen_smin_vec,
>            .fno =3D gen_helper_gvec_smin64,
> -          .opc =3D INDEX_op_smin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -1979,24 +2013,25 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>  void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_umin_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_umin_vec,
>            .fno =3D gen_helper_gvec_umin8,
> -          .opc =3D INDEX_op_umin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_umin_vec,
>            .fno =3D gen_helper_gvec_umin16,
> -          .opc =3D INDEX_op_umin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_umin_i32,
>            .fniv =3D tcg_gen_umin_vec,
>            .fno =3D gen_helper_gvec_umin32,
> -          .opc =3D INDEX_op_umin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_umin_i64,
>            .fniv =3D tcg_gen_umin_vec,
>            .fno =3D gen_helper_gvec_umin64,
> -          .opc =3D INDEX_op_umin_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -2006,24 +2041,25 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>  void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_smax_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_smax_vec,
>            .fno =3D gen_helper_gvec_smax8,
> -          .opc =3D INDEX_op_smax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_smax_vec,
>            .fno =3D gen_helper_gvec_smax16,
> -          .opc =3D INDEX_op_smax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_smax_i32,
>            .fniv =3D tcg_gen_smax_vec,
>            .fno =3D gen_helper_gvec_smax32,
> -          .opc =3D INDEX_op_smax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_smax_i64,
>            .fniv =3D tcg_gen_smax_vec,
>            .fno =3D gen_helper_gvec_smax64,
> -          .opc =3D INDEX_op_smax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -2033,24 +2069,25 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>  void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_umax_vec, 0 };
>      static const GVecGen3 g[4] =3D {
>          { .fniv =3D tcg_gen_umax_vec,
>            .fno =3D gen_helper_gvec_umax8,
> -          .opc =3D INDEX_op_umax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fniv =3D tcg_gen_umax_vec,
>            .fno =3D gen_helper_gvec_umax16,
> -          .opc =3D INDEX_op_umax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_umax_i32,
>            .fniv =3D tcg_gen_umax_vec,
>            .fno =3D gen_helper_gvec_umax32,
> -          .opc =3D INDEX_op_umax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_umax_i64,
>            .fniv =3D tcg_gen_umax_vec,
>            .fno =3D gen_helper_gvec_umax64,
> -          .opc =3D INDEX_op_umax_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_64 }
>      };
>      tcg_debug_assert(vece <=3D MO_64);
> @@ -2104,26 +2141,27 @@ void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
>  void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
>                        uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_neg_vec, 0 };
>      static const GVecGen2 g[4] =3D {
>          { .fni8 =3D tcg_gen_vec_neg8_i64,
>            .fniv =3D tcg_gen_neg_vec,
>            .fno =3D gen_helper_gvec_neg8,
> -          .opc =3D INDEX_op_neg_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_neg16_i64,
>            .fniv =3D tcg_gen_neg_vec,
>            .fno =3D gen_helper_gvec_neg16,
> -          .opc =3D INDEX_op_neg_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_neg_i32,
>            .fniv =3D tcg_gen_neg_vec,
>            .fno =3D gen_helper_gvec_neg32,
> -          .opc =3D INDEX_op_neg_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_neg_i64,
>            .fniv =3D tcg_gen_neg_vec,
>            .fno =3D gen_helper_gvec_neg64,
> -          .opc =3D INDEX_op_neg_vec,
> +          .opt_opc =3D vecop_list,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -2139,7 +2177,6 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>          .fni8 =3D tcg_gen_and_i64,
>          .fniv =3D tcg_gen_and_vec,
>          .fno =3D gen_helper_gvec_and,
> -        .opc =3D INDEX_op_and_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
>
> @@ -2157,7 +2194,6 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, =
uint32_t aofs,
>          .fni8 =3D tcg_gen_or_i64,
>          .fniv =3D tcg_gen_or_vec,
>          .fno =3D gen_helper_gvec_or,
> -        .opc =3D INDEX_op_or_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
>
> @@ -2175,7 +2211,6 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>          .fni8 =3D tcg_gen_xor_i64,
>          .fniv =3D tcg_gen_xor_vec,
>          .fno =3D gen_helper_gvec_xor,
> -        .opc =3D INDEX_op_xor_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
>
> @@ -2193,7 +2228,6 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>          .fni8 =3D tcg_gen_andc_i64,
>          .fniv =3D tcg_gen_andc_vec,
>          .fno =3D gen_helper_gvec_andc,
> -        .opc =3D INDEX_op_andc_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
>
> @@ -2211,7 +2245,6 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>          .fni8 =3D tcg_gen_orc_i64,
>          .fniv =3D tcg_gen_orc_vec,
>          .fno =3D gen_helper_gvec_orc,
> -        .opc =3D INDEX_op_orc_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
>
> @@ -2277,7 +2310,6 @@ static const GVecGen2s gop_ands =3D {
>      .fni8 =3D tcg_gen_and_i64,
>      .fniv =3D tcg_gen_and_vec,
>      .fno =3D gen_helper_gvec_ands,
> -    .opc =3D INDEX_op_and_vec,
>      .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      .vece =3D MO_64
>  };
> @@ -2303,7 +2335,6 @@ static const GVecGen2s gop_xors =3D {
>      .fni8 =3D tcg_gen_xor_i64,
>      .fniv =3D tcg_gen_xor_vec,
>      .fno =3D gen_helper_gvec_xors,
> -    .opc =3D INDEX_op_xor_vec,
>      .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      .vece =3D MO_64
>  };
> @@ -2329,7 +2360,6 @@ static const GVecGen2s gop_ors =3D {
>      .fni8 =3D tcg_gen_or_i64,
>      .fniv =3D tcg_gen_or_vec,
>      .fno =3D gen_helper_gvec_ors,
> -    .opc =3D INDEX_op_or_vec,
>      .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      .vece =3D MO_64
>  };
> @@ -2368,26 +2398,27 @@ void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 =
a, int64_t c)
>  void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_shli_vec, 0 };
>      static const GVecGen2i g[4] =3D {
>          { .fni8 =3D tcg_gen_vec_shl8i_i64,
>            .fniv =3D tcg_gen_shli_vec,
>            .fno =3D gen_helper_gvec_shl8i,
> -          .opc =3D INDEX_op_shli_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_shl16i_i64,
>            .fniv =3D tcg_gen_shli_vec,
>            .fno =3D gen_helper_gvec_shl16i,
> -          .opc =3D INDEX_op_shli_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_shli_i32,
>            .fniv =3D tcg_gen_shli_vec,
>            .fno =3D gen_helper_gvec_shl32i,
> -          .opc =3D INDEX_op_shli_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_shli_i64,
>            .fniv =3D tcg_gen_shli_vec,
>            .fno =3D gen_helper_gvec_shl64i,
> -          .opc =3D INDEX_op_shli_vec,
> +          .opt_opc =3D vecop_list,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -2418,26 +2449,27 @@ void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 =
a, int64_t c)
>  void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_shri_vec, 0 };
>      static const GVecGen2i g[4] =3D {
>          { .fni8 =3D tcg_gen_vec_shr8i_i64,
>            .fniv =3D tcg_gen_shri_vec,
>            .fno =3D gen_helper_gvec_shr8i,
> -          .opc =3D INDEX_op_shri_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_shr16i_i64,
>            .fniv =3D tcg_gen_shri_vec,
>            .fno =3D gen_helper_gvec_shr16i,
> -          .opc =3D INDEX_op_shri_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_shri_i32,
>            .fniv =3D tcg_gen_shri_vec,
>            .fno =3D gen_helper_gvec_shr32i,
> -          .opc =3D INDEX_op_shri_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_shri_i64,
>            .fniv =3D tcg_gen_shri_vec,
>            .fno =3D gen_helper_gvec_shr64i,
> -          .opc =3D INDEX_op_shri_vec,
> +          .opt_opc =3D vecop_list,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -2482,26 +2514,27 @@ void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 =
a, int64_t c)
>  void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode vecop_list[] =3D { INDEX_op_sari_vec, 0 };
>      static const GVecGen2i g[4] =3D {
>          { .fni8 =3D tcg_gen_vec_sar8i_i64,
>            .fniv =3D tcg_gen_sari_vec,
>            .fno =3D gen_helper_gvec_sar8i,
> -          .opc =3D INDEX_op_sari_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_8 },
>          { .fni8 =3D tcg_gen_vec_sar16i_i64,
>            .fniv =3D tcg_gen_sari_vec,
>            .fno =3D gen_helper_gvec_sar16i,
> -          .opc =3D INDEX_op_sari_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_16 },
>          { .fni4 =3D tcg_gen_sari_i32,
>            .fniv =3D tcg_gen_sari_vec,
>            .fno =3D gen_helper_gvec_sar32i,
> -          .opc =3D INDEX_op_sari_vec,
> +          .opt_opc =3D vecop_list,
>            .vece =3D MO_32 },
>          { .fni8 =3D tcg_gen_sari_i64,
>            .fniv =3D tcg_gen_sari_vec,
>            .fno =3D gen_helper_gvec_sar64i,
> -          .opc =3D INDEX_op_sari_vec,
> +          .opt_opc =3D vecop_list,
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> @@ -2574,6 +2607,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, =
uint32_t dofs,
>                        uint32_t aofs, uint32_t bofs,
>                        uint32_t oprsz, uint32_t maxsz)
>  {
> +    static const TCGOpcode cmp_list[] =3D { INDEX_op_cmp_vec, 0 };
>      static gen_helper_gvec_3 * const eq_fn[4] =3D {
>          gen_helper_gvec_eq8, gen_helper_gvec_eq16,
>          gen_helper_gvec_eq32, gen_helper_gvec_eq64
> @@ -2606,6 +2640,8 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, =
uint32_t dofs,
>          [TCG_COND_LTU] =3D ltu_fn,
>          [TCG_COND_LEU] =3D leu_fn,
>      };
> +
> +    const TCGOpcode *hold_list;
>      TCGType type;
>      uint32_t some;
>
> @@ -2618,10 +2654,12 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece=
, uint32_t dofs,
>          return;
>      }
>
> -    /* Implement inline with a vector type, if possible.
> +    /*
> +     * Implement inline with a vector type, if possible.
>       * Prefer integer when 64-bit host and 64-bit comparison.
>       */
> -    type =3D choose_vector_type(INDEX_op_cmp_vec, vece, oprsz,
> +    hold_list =3D tcg_swap_vecop_list(cmp_list);
> +    type =3D choose_vector_type(cmp_list, vece, oprsz,
>                                TCG_TARGET_REG_BITS =3D=3D 64 && vece =3D=
=3D MO_64);
>      switch (type) {
>      case TCG_TYPE_V256:
> @@ -2663,13 +2701,14 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece=
, uint32_t dofs,
>                  assert(fn !=3D NULL);
>              }
>              tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vec=
e]);
> -            return;
> +            oprsz =3D maxsz;
>          }
>          break;
>
>      default:
>          g_assert_not_reached();
>      }
> +    tcg_swap_vecop_list(hold_list);
>
>      if (oprsz < maxsz) {
>          expand_clr(dofs + oprsz, maxsz - oprsz);
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index cfb18682b1..914fe42b1e 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -34,6 +34,90 @@ extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
>  #define TCGV_HIGH TCGV_HIGH_link_error
>  #endif
>
> +/*
> + * Vector optional opcode tracking.
> + * Except for the basic logical operations (and, or, xor), and
> + * data movement (mov, ld, st, dupi), many vector opcodes are
> + * optional and may not be supported on the host.  Thank Intel
> + * for the irregularity in their instruction set.
> + *
> + * The gvec expanders allow custom vector operations to be composed,
> + * generally via the .fniv callback in the GVecGen* structures.  At
> + * the same time, in deciding whether to use this hook we need to
> + * know if the host supports the required operations.  This is
> + * presented as an array of opcodes, terminated by 0.  Each opcode
> + * is assumed to be expanded with the given VECE.
> + *
> + * For debugging, we want to validate this array.  Therefore, when
> + * tcg_ctx->vec_opt_opc is non-NULL, the tcg_gen_*_vec expanders
> + * will validate that their opcode is present in the list.
> + */
> +#ifdef CONFIG_DEBUG_TCG
> +void tcg_assert_listed_vecop(TCGOpcode op)
> +{
> +    const TCGOpcode *p =3D tcg_ctx->vecop_list;
> +    if (p) {
> +        for (; *p; ++p) {
> +            if (*p =3D=3D op) {
> +                return;
> +            }
> +        }
> +        g_assert_not_reached();
> +    }
> +}
> +#endif
> +
> +bool tcg_can_emit_vecop_list(const TCGOpcode *list,
> +                             TCGType type, unsigned vece)
> +{
> +    if (list =3D=3D NULL) {
> +        return true;
> +    }
> +
> +    for (; *list; ++list) {
> +        TCGOpcode opc =3D *list;
> +
> +#ifdef CONFIG_DEBUG_TCG
> +        switch (opc) {
> +        case INDEX_op_and_vec:
> +        case INDEX_op_or_vec:
> +        case INDEX_op_xor_vec:
> +        case INDEX_op_mov_vec:
> +        case INDEX_op_dup_vec:
> +        case INDEX_op_dupi_vec:
> +        case INDEX_op_dup2_vec:
> +        case INDEX_op_ld_vec:
> +        case INDEX_op_st_vec:
> +            /* These opcodes are mandatory and should not be listed.  */
> +            g_assert_not_reached();
> +        default:
> +            break;
> +        }
> +#endif
> +
> +        if (tcg_can_emit_vec_op(opc, type, vece)) {
> +            continue;
> +        }
> +
> +        /*
> +         * The opcode list is created by front ends based on what they
> +         * actually invoke.  We must mirror the logic in the routines
> +         * below for generic expansions using other opcodes.
> +         */
> +        switch (opc) {
> +        case INDEX_op_neg_vec:
> +            if (tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece)) {
> +                continue;
> +            }
> +            break;
> +        default:
> +            break;
> +        }
> +        return false;
> +    }
> +    return true;
> +}
> +
>  void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCG=
Arg a)
>  {
>      TCGOp *op =3D tcg_emit_op(opc);
> @@ -296,11 +380,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_=
vec a, TCGOpcode opc)
>      int can;
>
>      tcg_debug_assert(at->base_type >=3D type);
> +    tcg_assert_listed_vecop(opc);
>      can =3D tcg_can_emit_vec_op(opc, type, vece);
>      if (can > 0) {
>          vec_gen_2(opc, type, vece, ri, ai);
>      } else if (can < 0) {
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
>          tcg_expand_vec_op(opc, type, vece, ri, ai);
> +        tcg_swap_vecop_list(hold_list);
>      } else {
>          return false;
>      }
> @@ -318,11 +405,17 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCG=
v_vec a)
>
>  void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
>  {
> +    const TCGOpcode *hold_list;
> +
> +    tcg_assert_listed_vecop(INDEX_op_neg_vec);
> +    hold_list =3D tcg_swap_vecop_list(NULL);
> +
>      if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)=
) {
>          TCGv_vec t =3D tcg_const_zeros_vec_matching(r);
>          tcg_gen_sub_vec(vece, r, t, a);
>          tcg_temp_free_vec(t);
>      }
> +    tcg_swap_vecop_list(hold_list);
>  }
>
>  static void do_shifti(TCGOpcode opc, unsigned vece,
> @@ -337,6 +430,7 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
>
>      tcg_debug_assert(at->base_type =3D=3D type);
>      tcg_debug_assert(i >=3D 0 && i < (8 << vece));
> +    tcg_assert_listed_vecop(opc);
>
>      if (i =3D=3D 0) {
>          tcg_gen_mov_vec(r, a);
> @@ -350,8 +444,10 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
>          /* We leave the choice of expansion via scalar or vector shift
>             to the target.  Often, but not always, dupi can feed a vector
>             shift easier than a scalar.  */
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
>          tcg_debug_assert(can < 0);
>          tcg_expand_vec_op(opc, type, vece, ri, ai, i);
> +        tcg_swap_vecop_list(hold_list);
>      }
>  }
>
> @@ -384,12 +480,15 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
>
>      tcg_debug_assert(at->base_type >=3D type);
>      tcg_debug_assert(bt->base_type >=3D type);
> +    tcg_assert_listed_vecop(INDEX_op_cmp_vec);
>      can =3D tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
>      if (can > 0) {
>          vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
>      } else {
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
>          tcg_debug_assert(can < 0);
>          tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond=
);
> +        tcg_swap_vecop_list(hold_list);
>      }
>  }
>
> @@ -407,12 +506,15 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_=
vec a,
>
>      tcg_debug_assert(at->base_type >=3D type);
>      tcg_debug_assert(bt->base_type >=3D type);
> +    tcg_assert_listed_vecop(opc);
>      can =3D tcg_can_emit_vec_op(opc, type, vece);
>      if (can > 0) {
>          vec_gen_3(opc, type, vece, ri, ai, bi);
>      } else {
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
>          tcg_debug_assert(can < 0);
>          tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
> +        tcg_swap_vecop_list(hold_list);
>      }
>  }


--
Alex Benn=C3=A9e
