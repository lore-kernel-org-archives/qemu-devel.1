Received: from eggs.gnu.org ([2001:4830:134:3::10]:52291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpzlG-00029w-6p
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpzl9-0005yU-8n
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:34:38 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dpzl8-0005xo-Su
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:34:31 -0400
Received: by mail-wr0-x230.google.com with SMTP id a43so486477wrc.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 09:34:30 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170817230114.3655-2-richard.henderson@linaro.org>
Date: Thu, 07 Sep 2017 17:34:27 +0100
Message-ID: <878thqmprg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] tcg: Add generic vector infrastructure
 and ops for add/sub/logic
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
> ---
>  Makefile.target        |   5 +-
>  tcg/tcg-op-gvec.h      |  88 ++++++++++
>  tcg/tcg-runtime.h      |  16 ++
>  tcg/tcg-op-gvec.c      | 443 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-runtime-gvec.c | 199 ++++++++++++++++++++++
>  5 files changed, 749 insertions(+), 2 deletions(-)
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 tcg/tcg-op-gvec.c
>  create mode 100644 tcg/tcg-runtime-gvec.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 7f42c45db8..9ae3e904f7 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -93,8 +93,9 @@ all: $(PROGS) stap
>  # cpu emulator library
>  obj-y += exec.o
>  obj-y += accel/
> -obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
> -obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
> +obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-common.o tcg/optimize.o
> +obj-$(CONFIG_TCG) += tcg/tcg-op.o tcg/tcg-op-gvec.o
> +obj-$(CONFIG_TCG) += tcg/tcg-runtime.o tcg/tcg-runtime-gvec.o
>  obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
>  obj-y += fpu/softfloat.o
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> new file mode 100644
> index 0000000000..10db3599a5
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.h
> @@ -0,0 +1,88 @@
> +/*
> + *  Generic vector operation expansion
> + *
> + *  Copyright (c) 2017 Linaro
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * "Generic" vectors.  All operands are given as offsets from ENV,
> + * and therefore cannot also be allocated via tcg_global_mem_new_*.
> + * OPSZ is the byte size of the vector upon which the operation is performed.
> + * CLSZ is the byte size of the full vector; bytes beyond OPSZ are cleared.
> + *
> + * All sizes must be 8 or any multiple of 16.
> + * When OPSZ is 8, the alignment may be 8, otherwise must be 16.
> + * Operands may completely, but not partially, overlap.

Isn't this going to be a problem for narrow/widden Rn->Rn operations?
Should we say so explicitly here?

> + */
> +
> +/* Fundamental operation expanders.  These are exposed to the front ends
> +   so that target-specific SIMD operations can be handled similarly to
> +   the standard SIMD operations.  */
> +
> +typedef struct {
> +    /* "Small" sizes: expand inline as a 64-bit or 32-bit lane.
> +       Generally only one of these will be non-NULL.  */

Generally or always? We after all go through in a certain order and
expand the first one defined.

> +    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
> +    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
> +    /* Similarly, but load up a constant and re-use across lanes.  */
> +    void (*fni8x)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
> +    uint64_t extra_value;

Probably personal preference but I'd leave extra_value and additional
non-function pointers to the end of the structure for cleaner
readability.

> +    /* Larger sizes: expand out-of-line helper w/size descriptor.  */
> +    void (*fno)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +} GVecGen3;
> +
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t opsz, uint32_t clsz, const GVecGen3 *);
> +

Why GVecGen3 and tcg_gen_gvec_3? It seems a little arbitrary.

> +#define DEF_GVEC_2(X) \
> +    void tcg_gen_gvec_##X(uint32_t dofs, uint32_t aofs, uint32_t bofs, \
> +                          uint32_t opsz, uint32_t clsz)
> +
> +DEF_GVEC_2(add8);
> +DEF_GVEC_2(add16);
> +DEF_GVEC_2(add32);
> +DEF_GVEC_2(add64);
> +
> +DEF_GVEC_2(sub8);
> +DEF_GVEC_2(sub16);
> +DEF_GVEC_2(sub32);
> +DEF_GVEC_2(sub64);
> +
> +DEF_GVEC_2(and8);
> +DEF_GVEC_2(or8);
> +DEF_GVEC_2(xor8);
> +DEF_GVEC_2(andc8);
> +DEF_GVEC_2(orc8);
> +
> +#undef DEF_GVEC_2
> +
> +/*
> + * 64-bit vector operations.  Use these when the register has been
> + * allocated with tcg_global_mem_new_i64.  OPSZ = CLSZ = 8.
> + */
> +
> +#define DEF_VEC8_2(X) \
> +    void tcg_gen_vec8_##X(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +
> +DEF_VEC8_2(add8);
> +DEF_VEC8_2(add16);
> +DEF_VEC8_2(add32);
> +
> +DEF_VEC8_2(sub8);
> +DEF_VEC8_2(sub16);
> +DEF_VEC8_2(sub32);
> +
> +#undef DEF_VEC8_2

Again GVEC_2 and VEC8_2 don't tell me much.

> diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
> index c41d38a557..f8d07090f8 100644
> --- a/tcg/tcg-runtime.h
> +++ b/tcg/tcg-runtime.h
> @@ -134,3 +134,19 @@ GEN_ATOMIC_HELPERS(xor_fetch)
>  GEN_ATOMIC_HELPERS(xchg)
>
>  #undef GEN_ATOMIC_HELPERS
> +
> +DEF_HELPER_FLAGS_4(gvec_add8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_add16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_add32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_add64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(gvec_sub8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sub16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sub32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sub64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(gvec_and8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_or8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_xor8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_andc8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_orc8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> new file mode 100644
> index 0000000000..6de49dc07f
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.c
> @@ -0,0 +1,443 @@
> +/*
> + *  Generic vector operation expansion
> + *
> + *  Copyright (c) 2017 Linaro
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "tcg.h"
> +#include "tcg-op.h"
> +#include "tcg-op-gvec.h"
> +#include "trace-tcg.h"
> +#include "trace/mem.h"
> +
> +#define REP8(x)    ((x) * 0x0101010101010101ull)
> +#define REP16(x)   ((x) * 0x0001000100010001ull)
> +
> +#define MAX_INLINE 16
> +
> +static inline void check_size_s(uint32_t opsz, uint32_t clsz)
> +{
> +    tcg_debug_assert(opsz % 8 == 0);
> +    tcg_debug_assert(clsz % 8 == 0);
> +    tcg_debug_assert(opsz <= clsz);
> +}
> +
> +static inline void check_align_s_3(uint32_t dofs, uint32_t aofs, uint32_t bofs)
> +{
> +    tcg_debug_assert(dofs % 8 == 0);
> +    tcg_debug_assert(aofs % 8 == 0);
> +    tcg_debug_assert(bofs % 8 == 0);
> +}
> +
> +static inline void check_size_l(uint32_t opsz, uint32_t clsz)
> +{
> +    tcg_debug_assert(opsz % 16 == 0);
> +    tcg_debug_assert(clsz % 16 == 0);
> +    tcg_debug_assert(opsz <= clsz);
> +}
> +
> +static inline void check_align_l_3(uint32_t dofs, uint32_t aofs, uint32_t bofs)
> +{
> +    tcg_debug_assert(dofs % 16 == 0);
> +    tcg_debug_assert(aofs % 16 == 0);
> +    tcg_debug_assert(bofs % 16 == 0);
> +}
> +
> +static inline void check_overlap_3(uint32_t d, uint32_t a,
> +                                   uint32_t b, uint32_t s)
> +{
> +    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
> +    tcg_debug_assert(d == b || d + s <= b || b + s <= d);
> +    tcg_debug_assert(a == b || a + s <= b || b + s <= a);
> +}
> +
> +static void expand_clr(uint32_t dofs, uint32_t opsz, uint32_t clsz)
> +{
> +    if (clsz > opsz) {
> +        TCGv_i64 zero = tcg_const_i64(0);
> +        uint32_t i;
> +
> +        for (i = opsz; i < clsz; i += 8) {
> +            tcg_gen_st_i64(zero, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        tcg_temp_free_i64(zero);
> +    }
> +}
> +
> +static TCGv_i32 make_desc(uint32_t opsz, uint32_t clsz)

A comment about the encoding of opdata into the constant probably
wouldn't go amiss. Should we have some inline helpers to extract the
data for the actual implementations?

> +{
> +    tcg_debug_assert(opsz >= 16 && opsz <= 255 * 16 && opsz % 16 == 0);
> +    tcg_debug_assert(clsz >= 16 && clsz <= 255 * 16 && clsz % 16 == 0);
> +    opsz /= 16;
> +    clsz /= 16;
> +    opsz -= 1;
> +    clsz -= 1;
> +    return tcg_const_i32(deposit32(opsz, 8, 8, clsz));
> +}
> +
> +static void expand_3_o(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz,
> +                       void (*fno)(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> TCGv_i32))

Hmm copy of the function pointer definition, maybe they should be
typedefs and declared with comments in tcg-op-gvec.h?

> +{
> +    TCGv_ptr d = tcg_temp_new_ptr();
> +    TCGv_ptr a = tcg_temp_new_ptr();
> +    TCGv_ptr b = tcg_temp_new_ptr();
> +    TCGv_i32 desc = make_desc(opsz, clsz);
> +
> +    tcg_gen_addi_ptr(d, tcg_ctx.tcg_env, dofs);
> +    tcg_gen_addi_ptr(a, tcg_ctx.tcg_env, aofs);
> +    tcg_gen_addi_ptr(b, tcg_ctx.tcg_env, bofs);
> +    fno(d, a, b, desc);
> +
> +    tcg_temp_free_ptr(d);
> +    tcg_temp_free_ptr(a);
> +    tcg_temp_free_ptr(b);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +static void expand_3x4(uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t opsz,
> +                       void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))

Ditto typedef?

> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    if (aofs == bofs) {
> +        for (i = 0; i < opsz; i += 4) {
> +            tcg_gen_ld_i32(t0, tcg_ctx.tcg_env, aofs + i);
> +            fni(t0, t0, t0);
> +            tcg_gen_st_i32(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +    } else {
> +        TCGv_i32 t1 = tcg_temp_new_i32();
> +        for (i = 0; i < opsz; i += 4) {
> +            tcg_gen_ld_i32(t0, tcg_ctx.tcg_env, aofs + i);
> +            tcg_gen_ld_i32(t1, tcg_ctx.tcg_env, bofs + i);
> +            fni(t0, t0, t1);
> +            tcg_gen_st_i32(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        tcg_temp_free_i32(t1);
> +    }
> +    tcg_temp_free_i32(t0);
> +}
> +
> +static void expand_3x8(uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t opsz,
> +                       void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    if (aofs == bofs) {
> +        for (i = 0; i < opsz; i += 8) {
> +            tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +            fni(t0, t0, t0);
> +            tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +    } else {
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        for (i = 0; i < opsz; i += 8) {
> +            tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +            tcg_gen_ld_i64(t1, tcg_ctx.tcg_env, bofs + i);
> +            fni(t0, t0, t1);
> +            tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        tcg_temp_free_i64(t1);
> +    }
> +    tcg_temp_free_i64(t0);
> +}
> +
> +static void expand_3x8p1(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                         uint32_t opsz, uint64_t data,
> +                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64,
> TCGv_i64))

Again typedef

I don't quite follow the suffix's of the expanders. I guess _o is for
offset but p1? Either we need a mini comment for each expander or a more
obvious suffix scheme...

> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_const_i64(data);
> +    uint32_t i;
> +
> +    if (aofs == bofs) {
> +        for (i = 0; i < opsz; i += 8) {
> +            tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +            fni(t0, t0, t0, t2);
> +            tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +    } else {
> +        TCGv_i64 t1 = tcg_temp_new_i64();
> +        for (i = 0; i < opsz; i += 8) {
> +            tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +            tcg_gen_ld_i64(t1, tcg_ctx.tcg_env, bofs + i);
> +            fni(t0, t0, t1, t2);
> +            tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        tcg_temp_free_i64(t1);
> +    }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t opsz, uint32_t clsz, const GVecGen3 *g)
> +{
> +    check_overlap_3(dofs, aofs, bofs, clsz);
> +    if (opsz <= MAX_INLINE) {
> +        check_size_s(opsz, clsz);
> +        check_align_s_3(dofs, aofs, bofs);
> +        if (g->fni8) {
> +            expand_3x8(dofs, aofs, bofs, opsz, g->fni8);
> +        } else if (g->fni4) {
> +            expand_3x4(dofs, aofs, bofs, opsz, g->fni4);
> +        } else if (g->fni8x) {
> +            expand_3x8p1(dofs, aofs, bofs, opsz, g->extra_value, g->fni8x);
> +        } else {
> +            g_assert_not_reached();
> +        }
> +        expand_clr(dofs, opsz, clsz);
> +    } else {
> +        check_size_l(opsz, clsz);
> +        check_align_l_3(dofs, aofs, bofs);
> +        expand_3_o(dofs, aofs, bofs, opsz, clsz, g->fno);
> +    }
> +}
> +
> +static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    TCGv_i64 t3 = tcg_temp_new_i64();
> +
> +    tcg_gen_andc_i64(t1, a, m);
> +    tcg_gen_andc_i64(t2, b, m);
> +    tcg_gen_xor_i64(t3, a, b);
> +    tcg_gen_add_i64(d, t1, t2);
> +    tcg_gen_and_i64(t3, t3, m);
> +    tcg_gen_xor_i64(d, d, t3);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t3);
> +}
> +
> +void tcg_gen_gvec_add8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .extra_value = REP8(0x80),
> +        .fni8x = gen_addv_mask,
> +        .fno = gen_helper_gvec_add8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add16(uint32_t dofs, uint32_t aofs, uint32_t bofs,

> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .extra_value = REP16(0x8000),
> +        .fni8x = gen_addv_mask,
> +        .fno = gen_helper_gvec_add16,

OK now I'm confused - we have two functions here but tcg_gen_gvec_3
expand one of them depending on the leg taken by opsz. One is a mask
function and the other using adds?

> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni4 = tcg_gen_add_i32,
> +        .fno = gen_helper_gvec_add32,

Ahh ok I see here, use native add_i32 for small values, pass to the
generic helper for larger vectors. Still confused about the previous
expander though...

> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_add_i64,
> +        .fno = gen_helper_gvec_add64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_vec8_add8(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP8(0x80));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec8_add16(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec8_add32(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +    tcg_gen_andi_i64(t1, a, ~0xffffffffull);
> +    tcg_gen_add_i64(t2, a, b);
> +    tcg_gen_add_i64(t1, t1, b);
> +    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    TCGv_i64 t3 = tcg_temp_new_i64();
> +
> +    tcg_gen_or_i64(t1, a, m);
> +    tcg_gen_andc_i64(t2, b, m);
> +    tcg_gen_eqv_i64(t3, a, b);
> +    tcg_gen_sub_i64(d, t1, t2);
> +    tcg_gen_and_i64(t3, t3, m);
> +    tcg_gen_xor_i64(d, d, t3);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t3);
> +}
> +
> +void tcg_gen_gvec_sub8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .extra_value = REP8(0x80),
> +        .fni8x = gen_subv_mask,
> +        .fno = gen_helper_gvec_sub8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_sub16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .extra_value = REP16(0x8000),
> +        .fni8x = gen_subv_mask,
> +        .fno = gen_helper_gvec_sub16,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_sub32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni4 = tcg_gen_sub_i32,
> +        .fno = gen_helper_gvec_sub32,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_sub64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_sub_i64,
> +        .fno = gen_helper_gvec_sub64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_vec8_sub8(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP8(0x80));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec8_sub16(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec8_sub32(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +    tcg_gen_andi_i64(t1, b, ~0xffffffffull);
> +    tcg_gen_sub_i64(t2, a, b);
> +    tcg_gen_sub_i64(t1, a, t1);
> +    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +void tcg_gen_gvec_and8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_and_i64,
> +        .fno = gen_helper_gvec_and8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_or8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_or_i64,
> +        .fno = gen_helper_gvec_or8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_xor8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_xor_i64,
> +        .fno = gen_helper_gvec_xor8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_andc8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_andc_i64,
> +        .fno = gen_helper_gvec_andc8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_orc8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_orc_i64,
> +        .fno = gen_helper_gvec_orc8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> diff --git a/tcg/tcg-runtime-gvec.c b/tcg/tcg-runtime-gvec.c
> new file mode 100644
> index 0000000000..9a37ce07a2
> --- /dev/null
> +++ b/tcg/tcg-runtime-gvec.c
> @@ -0,0 +1,199 @@
> +/*
> + *  Generic vectorized operation runtime
> + *
> + *  Copyright (c) 2017 Linaro
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +
> +/* Virtually all hosts support 16-byte vectors.  Those that don't
> +   can emulate them via GCC's generic vector extension.
> +
> +   In tcg-op-gvec.c, we asserted that both the size and alignment
> +   of the data are multiples of 16.  */
> +
> +typedef uint8_t vec8 __attribute__((vector_size(16)));
> +typedef uint16_t vec16 __attribute__((vector_size(16)));
> +typedef uint32_t vec32 __attribute__((vector_size(16)));
> +typedef uint64_t vec64 __attribute__((vector_size(16)));
> +
> +static inline intptr_t extract_opsz(uint32_t desc)
> +{
> +    return ((desc & 0xff) + 1) * 16;
> +}
> +
> +static inline intptr_t extract_clsz(uint32_t desc)
> +{
> +    return (((desc >> 8) & 0xff) + 1) * 16;
> +}

Ahh the data helpers. Any reason we don't use extract32() here where as
we used deposit32 the other end? It should generate the most efficient
code right?

> +
> +static inline void clear_high(void *d, intptr_t opsz, uint32_t desc)
> +{
> +    intptr_t clsz = extract_clsz(desc);
> +    intptr_t i;
> +
> +    if (unlikely(clsz > opsz)) {
> +        for (i = opsz; i < clsz; i += sizeof(vec64)) {
> +            *(vec64 *)(d + i) = (vec64){ 0 };
> +        }
> +    }
> +}
> +
> +void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec8)) {
> +        *(vec8 *)(d + i) = *(vec8 *)(a + i) + *(vec8 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec16)) {
> +        *(vec16 *)(d + i) = *(vec16 *)(a + i) + *(vec16 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec32)) {
> +        *(vec32 *)(d + i) = *(vec32 *)(a + i) + *(vec32 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) + *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec8)) {
> +        *(vec8 *)(d + i) = *(vec8 *)(a + i) - *(vec8 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec16)) {
> +        *(vec16 *)(d + i) = *(vec16 *)(a + i) - *(vec16 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec32)) {
> +        *(vec32 *)(d + i) = *(vec32 *)(a + i) - *(vec32 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) - *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_and8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) & *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_or8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) | *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_xor8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_andc8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}
> +
> +void HELPER(gvec_orc8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t opsz = extract_opsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < opsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, opsz, desc);
> +}

OK I can follow the helpers easily enough. I think the generators just
need to be a little clearer for non-authors to follow ;-)

--
Alex Bennée
