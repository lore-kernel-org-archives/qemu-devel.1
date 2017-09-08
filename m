Received: from eggs.gnu.org ([2001:4830:134:3::10]:33843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqFgY-0004Qt-QV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dqFgT-0007nX-6E
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:50 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dqFgS-0007n4-R5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:45 -0400
Received: by mail-wr0-x232.google.com with SMTP id v109so3621809wrc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 02:34:44 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170817230114.3655-8-richard.henderson@linaro.org>
Date: Fri, 08 Sep 2017 10:34:42 +0100
Message-ID: <874lsdile5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/8] tcg: Expand target vector ops with
 host vector ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I can see where this is going but I'll defer the review until v2 with
the extra verbosity in the original expander patch.

> ---
>  tcg/tcg-op-gvec.h |   4 +
>  tcg/tcg.h         |   6 +-
>  tcg/tcg-op-gvec.c | 230 +++++++++++++++++++++++++++++++++++++++++++-----------
>  tcg/tcg.c         |   8 +-
>  4 files changed, 197 insertions(+), 51 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index 10db3599a5..99f36d208e 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -40,6 +40,10 @@ typedef struct {
>      /* Similarly, but load up a constant and re-use across lanes.  */
>      void (*fni8x)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
>      uint64_t extra_value;
> +    /* Operations with host vector ops.  */
> +    TCGOpcode op_v256;
> +    TCGOpcode op_v128;
> +    TCGOpcode op_v64;
>      /* Larger sizes: expand out-of-line helper w/size descriptor.  */
>      void (*fno)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
>  } GVecGen3;
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b443143b21..7f10501d31 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -825,9 +825,11 @@ int tcg_global_mem_new_internal(TCGType, TCGv_ptr, intptr_t, const char *);
>  TCGv_i32 tcg_global_reg_new_i32(TCGReg reg, const char *name);
>  TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
>
> -TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
> -TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
> +int tcg_temp_new_internal(TCGType type, bool temp_local);
> +TCGv_i32 tcg_temp_new_internal_i32(bool temp_local);
> +TCGv_i64 tcg_temp_new_internal_i64(bool temp_local);
>
> +void tcg_temp_free_internal(int arg);
>  void tcg_temp_free_i32(TCGv_i32 arg);
>  void tcg_temp_free_i64(TCGv_i64 arg);
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 6de49dc07f..3aca565dc0 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -30,54 +30,73 @@
>  #define REP8(x)    ((x) * 0x0101010101010101ull)
>  #define REP16(x)   ((x) * 0x0001000100010001ull)
>
> -#define MAX_INLINE 16
> +#define MAX_UNROLL  4
>
> -static inline void check_size_s(uint32_t opsz, uint32_t clsz)
> +static inline void check_size_align(uint32_t opsz, uint32_t clsz, uint32_t ofs)
>  {
> -    tcg_debug_assert(opsz % 8 == 0);
> -    tcg_debug_assert(clsz % 8 == 0);
> +    uint32_t align = clsz > 16 || opsz >= 16 ? 15 : 7;
> +    tcg_debug_assert(opsz > 0);
>      tcg_debug_assert(opsz <= clsz);
> +    tcg_debug_assert((opsz & align) == 0);
> +    tcg_debug_assert((clsz & align) == 0);
> +    tcg_debug_assert((ofs & align) == 0);
>  }
>
> -static inline void check_align_s_3(uint32_t dofs, uint32_t aofs, uint32_t bofs)
> +static inline void check_overlap_3(uint32_t d, uint32_t a,
> +                                   uint32_t b, uint32_t s)
>  {
> -    tcg_debug_assert(dofs % 8 == 0);
> -    tcg_debug_assert(aofs % 8 == 0);
> -    tcg_debug_assert(bofs % 8 == 0);
> +    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
> +    tcg_debug_assert(d == b || d + s <= b || b + s <= d);
> +    tcg_debug_assert(a == b || a + s <= b || b + s <= a);
>  }
>
> -static inline void check_size_l(uint32_t opsz, uint32_t clsz)
> +static inline bool check_size_impl(uint32_t opsz, uint32_t lnsz)
>  {
> -    tcg_debug_assert(opsz % 16 == 0);
> -    tcg_debug_assert(clsz % 16 == 0);
> -    tcg_debug_assert(opsz <= clsz);
> +    uint32_t lnct = opsz / lnsz;
> +    return lnct >= 1 && lnct <= MAX_UNROLL;
>  }
>
> -static inline void check_align_l_3(uint32_t dofs, uint32_t aofs, uint32_t bofs)
> +static void expand_clr_v(uint32_t dofs, uint32_t clsz, uint32_t lnsz,
> +                         TCGType type, TCGOpcode opc_mv, TCGOpcode opc_st)
>  {
> -    tcg_debug_assert(dofs % 16 == 0);
> -    tcg_debug_assert(aofs % 16 == 0);
> -    tcg_debug_assert(bofs % 16 == 0);
> -}
> +    TCGArg t0 = tcg_temp_new_internal(type, 0);
> +    TCGArg env = GET_TCGV_PTR(tcg_ctx.tcg_env);
> +    uint32_t i;
>
> -static inline void check_overlap_3(uint32_t d, uint32_t a,
> -                                   uint32_t b, uint32_t s)
> -{
> -    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
> -    tcg_debug_assert(d == b || d + s <= b || b + s <= d);
> -    tcg_debug_assert(a == b || a + s <= b || b + s <= a);
> +    tcg_gen_op2(&tcg_ctx, opc_mv, t0, 0);
> +    for (i = 0; i < clsz; i += lnsz) {
> +        tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
> +    }
> +    tcg_temp_free_internal(t0);
>  }
>
> -static void expand_clr(uint32_t dofs, uint32_t opsz, uint32_t clsz)
> +static void expand_clr(uint32_t dofs, uint32_t clsz)
>  {
> -    if (clsz > opsz) {
> -        TCGv_i64 zero = tcg_const_i64(0);
> -        uint32_t i;
> +    if (clsz >= 32 && TCG_TARGET_HAS_v256) {
> +        uint32_t done = QEMU_ALIGN_DOWN(clsz, 32);
> +        expand_clr_v(dofs, done, 32, TCG_TYPE_V256,
> +                     INDEX_op_movi_v256, INDEX_op_st_v256);
> +        dofs += done;
> +        clsz -= done;
> +    }
>
> -        for (i = opsz; i < clsz; i += 8) {
> -            tcg_gen_st_i64(zero, tcg_ctx.tcg_env, dofs + i);
> -        }
> -        tcg_temp_free_i64(zero);
> +    if (clsz >= 16 && TCG_TARGET_HAS_v128) {
> +        uint16_t done = QEMU_ALIGN_DOWN(clsz, 16);
> +        expand_clr_v(dofs, done, 16, TCG_TYPE_V128,
> +                     INDEX_op_movi_v128, INDEX_op_st_v128);
> +        dofs += done;
> +        clsz -= done;
> +    }
> +
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        expand_clr_v(dofs, clsz, 8, TCG_TYPE_I64,
> +                     INDEX_op_movi_i64, INDEX_op_st_i64);
> +    } else if (TCG_TARGET_HAS_v64) {
> +        expand_clr_v(dofs, clsz, 8, TCG_TYPE_V64,
> +                     INDEX_op_movi_v64, INDEX_op_st_v64);
> +    } else {
> +        expand_clr_v(dofs, clsz, 4, TCG_TYPE_I32,
> +                     INDEX_op_movi_i32, INDEX_op_st_i32);
>      }
>  }
>
> @@ -164,6 +183,7 @@ static void expand_3x8(uint32_t dofs, uint32_t aofs,
>      tcg_temp_free_i64(t0);
>  }
>
> +/* FIXME: add CSE for constants and we can eliminate this.  */
>  static void expand_3x8p1(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                           uint32_t opsz, uint64_t data,
>                           void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
> @@ -192,28 +212,111 @@ static void expand_3x8p1(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      tcg_temp_free_i64(t2);
>  }
>
> +static void expand_3_v(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t lnsz, TCGType type,
> +                       TCGOpcode opc_op, TCGOpcode opc_ld, TCGOpcode opc_st)
> +{
> +    TCGArg t0 = tcg_temp_new_internal(type, 0);
> +    TCGArg env = GET_TCGV_PTR(tcg_ctx.tcg_env);
> +    uint32_t i;
> +
> +    if (aofs == bofs) {
> +        for (i = 0; i < opsz; i += lnsz) {
> +            tcg_gen_op3(&tcg_ctx, opc_ld, t0, env, aofs + i);
> +            tcg_gen_op3(&tcg_ctx, opc_op, t0, t0, t0);
> +            tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
> +        }
> +    } else {
> +        TCGArg t1 = tcg_temp_new_internal(type, 0);
> +        for (i = 0; i < opsz; i += lnsz) {
> +            tcg_gen_op3(&tcg_ctx, opc_ld, t0, env, aofs + i);
> +            tcg_gen_op3(&tcg_ctx, opc_ld, t1, env, bofs + i);
> +            tcg_gen_op3(&tcg_ctx, opc_op, t0, t0, t1);
> +            tcg_gen_op3(&tcg_ctx, opc_st, t0, env, dofs + i);
> +        }
> +        tcg_temp_free_internal(t1);
> +    }
> +    tcg_temp_free_internal(t0);
> +}
> +
>  void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                      uint32_t opsz, uint32_t clsz, const GVecGen3 *g)
>  {
> +    check_size_align(opsz, clsz, dofs | aofs | bofs);
>      check_overlap_3(dofs, aofs, bofs, clsz);
> -    if (opsz <= MAX_INLINE) {
> -        check_size_s(opsz, clsz);
> -        check_align_s_3(dofs, aofs, bofs);
> -        if (g->fni8) {
> -            expand_3x8(dofs, aofs, bofs, opsz, g->fni8);
> -        } else if (g->fni4) {
> -            expand_3x4(dofs, aofs, bofs, opsz, g->fni4);
> +
> +    if (opsz > MAX_UNROLL * 32 || clsz > MAX_UNROLL * 32) {
> +        goto do_ool;
> +    }
> +
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. opsz == 80 would be expanded with 2x32 + 1x16.  */
> +    /* ??? For clsz > opsz, the host may be able to use an op-sized
> +       operation, zeroing the balance of the register.  We can then
> +       use a cl-sized store to implement the clearing without an extra
> +       store operation.  This is true for aarch64 and x86_64 hosts.  */
> +
> +    if (check_size_impl(opsz, 32) && tcg_op_supported(g->op_v256)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(opsz, 32);
> +        expand_3_v(dofs, aofs, bofs, done, 32, TCG_TYPE_V256,
> +                   g->op_v256, INDEX_op_ld_v256, INDEX_op_st_v256);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        opsz -= done;
> +        clsz -= done;
> +    }
> +
> +    if (check_size_impl(opsz, 16) && tcg_op_supported(g->op_v128)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(opsz, 16);
> +        expand_3_v(dofs, aofs, bofs, done, 16, TCG_TYPE_V128,
> +                   g->op_v128, INDEX_op_ld_v128, INDEX_op_st_v128);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        opsz -= done;
> +        clsz -= done;
> +    }
> +
> +    if (check_size_impl(opsz, 8)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(opsz, 8);
> +        if (tcg_op_supported(g->op_v64)) {
> +            expand_3_v(dofs, aofs, bofs, done, 8, TCG_TYPE_V64,
> +                       g->op_v64, INDEX_op_ld_v64, INDEX_op_st_v64);
> +        } else if (g->fni8) {
> +            expand_3x8(dofs, aofs, bofs, done, g->fni8);
>          } else if (g->fni8x) {
> -            expand_3x8p1(dofs, aofs, bofs, opsz, g->extra_value, g->fni8x);
> +            expand_3x8p1(dofs, aofs, bofs, done, g->extra_value, g->fni8x);
>          } else {
> -            g_assert_not_reached();
> +            done = 0;
>          }
> -        expand_clr(dofs, opsz, clsz);
> -    } else {
> -        check_size_l(opsz, clsz);
> -        check_align_l_3(dofs, aofs, bofs);
> -        expand_3_o(dofs, aofs, bofs, opsz, clsz, g->fno);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        opsz -= done;
> +        clsz -= done;
>      }
> +
> +    if (check_size_impl(opsz, 4)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(opsz, 4);
> +        expand_3x4(dofs, aofs, bofs, done, g->fni4);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        opsz -= done;
> +        clsz -= done;
> +    }
> +
> +    if (opsz == 0) {
> +        if (clsz != 0) {
> +            expand_clr(dofs, clsz);
> +        }
> +        return;
> +    }
> +
> + do_ool:
> +    expand_3_o(dofs, aofs, bofs, opsz, clsz, g->fno);
>  }
>
>  static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
> @@ -240,6 +343,9 @@ void tcg_gen_gvec_add8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      static const GVecGen3 g = {
>          .extra_value = REP8(0x80),
>          .fni8x = gen_addv_mask,
> +        .op_v256 = INDEX_op_add8_v256,
> +        .op_v128 = INDEX_op_add8_v128,
> +        .op_v64 = INDEX_op_add8_v64,
>          .fno = gen_helper_gvec_add8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -251,6 +357,9 @@ void tcg_gen_gvec_add16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      static const GVecGen3 g = {
>          .extra_value = REP16(0x8000),
>          .fni8x = gen_addv_mask,
> +        .op_v256 = INDEX_op_add16_v256,
> +        .op_v128 = INDEX_op_add16_v128,
> +        .op_v64 = INDEX_op_add16_v64,
>          .fno = gen_helper_gvec_add16,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -261,6 +370,9 @@ void tcg_gen_gvec_add32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni4 = tcg_gen_add_i32,
> +        .op_v256 = INDEX_op_add32_v256,
> +        .op_v128 = INDEX_op_add32_v128,
> +        .op_v64 = INDEX_op_add32_v64,
>          .fno = gen_helper_gvec_add32,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -271,6 +383,8 @@ void tcg_gen_gvec_add64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_add_i64,
> +        .op_v256 = INDEX_op_add64_v256,
> +        .op_v128 = INDEX_op_add64_v128,
>          .fno = gen_helper_gvec_add64,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -328,6 +442,9 @@ void tcg_gen_gvec_sub8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      static const GVecGen3 g = {
>          .extra_value = REP8(0x80),
>          .fni8x = gen_subv_mask,
> +        .op_v256 = INDEX_op_sub8_v256,
> +        .op_v128 = INDEX_op_sub8_v128,
> +        .op_v64 = INDEX_op_sub8_v64,
>          .fno = gen_helper_gvec_sub8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -339,6 +456,9 @@ void tcg_gen_gvec_sub16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      static const GVecGen3 g = {
>          .extra_value = REP16(0x8000),
>          .fni8x = gen_subv_mask,
> +        .op_v256 = INDEX_op_sub16_v256,
> +        .op_v128 = INDEX_op_sub16_v128,
> +        .op_v64 = INDEX_op_sub16_v64,
>          .fno = gen_helper_gvec_sub16,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -349,6 +469,9 @@ void tcg_gen_gvec_sub32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni4 = tcg_gen_sub_i32,
> +        .op_v256 = INDEX_op_sub32_v256,
> +        .op_v128 = INDEX_op_sub32_v128,
> +        .op_v64 = INDEX_op_sub32_v64,
>          .fno = gen_helper_gvec_sub32,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -359,6 +482,8 @@ void tcg_gen_gvec_sub64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_sub_i64,
> +        .op_v256 = INDEX_op_sub64_v256,
> +        .op_v128 = INDEX_op_sub64_v128,
>          .fno = gen_helper_gvec_sub64,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -397,6 +522,9 @@ void tcg_gen_gvec_and8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_and_i64,
> +        .op_v256 = INDEX_op_and_v256,
> +        .op_v128 = INDEX_op_and_v128,
> +        .op_v64 = INDEX_op_and_v64,
>          .fno = gen_helper_gvec_and8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -407,6 +535,9 @@ void tcg_gen_gvec_or8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_or_i64,
> +        .op_v256 = INDEX_op_or_v256,
> +        .op_v128 = INDEX_op_or_v128,
> +        .op_v64 = INDEX_op_or_v64,
>          .fno = gen_helper_gvec_or8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -417,6 +548,9 @@ void tcg_gen_gvec_xor8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_xor_i64,
> +        .op_v256 = INDEX_op_xor_v256,
> +        .op_v128 = INDEX_op_xor_v128,
> +        .op_v64 = INDEX_op_xor_v64,
>          .fno = gen_helper_gvec_xor8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -427,6 +561,9 @@ void tcg_gen_gvec_andc8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_andc_i64,
> +        .op_v256 = INDEX_op_andc_v256,
> +        .op_v128 = INDEX_op_andc_v128,
> +        .op_v64 = INDEX_op_andc_v64,
>          .fno = gen_helper_gvec_andc8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> @@ -437,6 +574,9 @@ void tcg_gen_gvec_orc8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>  {
>      static const GVecGen3 g = {
>          .fni8 = tcg_gen_orc_i64,
> +        .op_v256 = INDEX_op_orc_v256,
> +        .op_v128 = INDEX_op_orc_v128,
> +        .op_v64 = INDEX_op_orc_v64,
>          .fno = gen_helper_gvec_orc8,
>      };
>      tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 879b29e81f..86eb4214b0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -604,7 +604,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>      return temp_idx(s, ts);
>  }
>
> -static int tcg_temp_new_internal(TCGType type, int temp_local)
> +int tcg_temp_new_internal(TCGType type, bool temp_local)
>  {
>      TCGContext *s = &tcg_ctx;
>      TCGTemp *ts;
> @@ -650,7 +650,7 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
>      return idx;
>  }
>
> -TCGv_i32 tcg_temp_new_internal_i32(int temp_local)
> +TCGv_i32 tcg_temp_new_internal_i32(bool temp_local)
>  {
>      int idx;
>
> @@ -658,7 +658,7 @@ TCGv_i32 tcg_temp_new_internal_i32(int temp_local)
>      return MAKE_TCGV_I32(idx);
>  }
>
> -TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
> +TCGv_i64 tcg_temp_new_internal_i64(bool temp_local)
>  {
>      int idx;
>
> @@ -666,7 +666,7 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
>      return MAKE_TCGV_I64(idx);
>  }
>
> -static void tcg_temp_free_internal(int idx)
> +void tcg_temp_free_internal(int idx)
>  {
>      TCGContext *s = &tcg_ctx;
>      TCGTemp *ts;


--
Alex Bennée
