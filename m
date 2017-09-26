Received: from eggs.gnu.org ([2001:4830:134:3::10]:44538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwyOI-0002V0-AT
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwyOD-0001cg-LP
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:31:46 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:49059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dwyOD-0001bk-6i
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:31:41 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m127so12347780wmm.3
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 15:31:41 -0700 (PDT)
References: <20170916023417.14599-1-richard.henderson@linaro.org>
	<20170916023417.14599-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170916023417.14599-3-richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 23:31:37 +0100
Message-ID: <87r2utccs6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/6] tcg: Add vector expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Other than live comments:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  Makefile.target              |   2 +-
>  accel/tcg/tcg-runtime.h      |  24 ++
>  tcg/tcg-gvec-desc.h          |  49 +++
>  tcg/tcg-op-gvec.h            | 143 ++++++++
>  accel/tcg/tcg-runtime-gvec.c | 255 +++++++++++++
>  tcg/tcg-op-gvec.c            | 853 +++++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/Makefile.objs      |   2 +-
>  7 files changed, 1326 insertions(+), 2 deletions(-)
>  create mode 100644 tcg/tcg-gvec-desc.h
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 accel/tcg/tcg-runtime-gvec.c
>  create mode 100644 tcg/tcg-op-gvec.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 6361f957fb..f9967feef5 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -94,7 +94,7 @@ all: $(PROGS) stap
>  obj-y += exec.o
>  obj-y += accel/
>  obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
> -obj-$(CONFIG_TCG) += tcg/tcg-common.o
> +obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-op-gvec.o
>  obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
>  obj-y += fpu/softfloat.o
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index c41d38a557..61c0ce39d3 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -134,3 +134,27 @@ GEN_ATOMIC_HELPERS(xor_fetch)
>  GEN_ATOMIC_HELPERS(xchg)
>
>  #undef GEN_ATOMIC_HELPERS
> +
> +DEF_HELPER_FLAGS_3(gvec_mov, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
> +DEF_HELPER_FLAGS_3(gvec_neg8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_neg16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_neg32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(gvec_neg64, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_3(gvec_not, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_and, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_or, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_xor, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_andc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_orc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> diff --git a/tcg/tcg-gvec-desc.h b/tcg/tcg-gvec-desc.h
> new file mode 100644
> index 0000000000..8ba9a8168d
> --- /dev/null
> +++ b/tcg/tcg-gvec-desc.h
> @@ -0,0 +1,49 @@
> +/*
> + *  Generic vector operation descriptor
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
> +/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
> +#define SIMD_OPRSZ_SHIFT   0
> +#define SIMD_OPRSZ_BITS    5
> +
> +#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
> +#define SIMD_MAXSZ_BITS    5
> +
> +#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
> +#define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
> +
> +/* Create a descriptor from components.  */
> +uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
> +
> +/* Extract the operation size from a descriptor.  */
> +static inline intptr_t simd_oprsz(uint32_t desc)
> +{
> +    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
> +}
> +
> +/* Extract the max vector size from a descriptor.  */
> +static inline intptr_t simd_maxsz(uint32_t desc)
> +{
> +    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
> +}
> +
> +/* Extract the operation-specific data from a descriptor.  */
> +static inline int32_t simd_data(uint32_t desc)
> +{
> +    return sextract32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS);
> +}
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> new file mode 100644
> index 0000000000..28bd77f1dc
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.h
> @@ -0,0 +1,143 @@
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
> + * OPRSZ is the byte size of the vector upon which the operation is performed.
> + * MAXSZ is the byte size of the full vector; bytes beyond OPSZ are cleared.
> + *
> + * All sizes must be 8 or any multiple of 16.
> + * When OPRSZ is 8, the alignment may be 8, otherwise must be 16.
> + * Operands may completely, but not partially, overlap.
> + */
> +
> +/* Expand a call to a gvec-style helper, with pointers to two vector
> +   operands, and a descriptor (see tcg-gvec-desc.h).  */
> +typedef void (gen_helper_gvec_2)(TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_2 *fn);
> +
> +/* Similarly, passing an extra pointer (e.g. env or float_status).  */
> +typedef void (gen_helper_gvec_2_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_2_ptr *fn);
> +
> +/* Similarly, with three vector operands.  */
> +typedef void (gen_helper_gvec_3)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_3 *fn);
> +
> +typedef void (gen_helper_gvec_3_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                     TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_3_ptr *fn);
> +
> +/* Expand a gvec operation.  Either inline or out-of-line depending on
> +   the actual vector size and the operations supported by the host.  */
> +typedef struct {
> +    /* Expand inline as a 64-bit or 32-bit integer.
> +       Only one of these will be non-NULL.  */
> +    void (*fni8)(TCGv_i64, TCGv_i64);
> +    void (*fni4)(TCGv_i32, TCGv_i32);
> +    /* Expand inline with a host vector type.  */
> +    void (*fniv)(TCGv_vec, TCGv_vec);
> +    /* Expand out-of-line helper w/descriptor.  */
> +    gen_helper_gvec_2 *fno;
> +    /* Prefer i64 to v64.  */
> +    bool prefer_i64;
> +} GVecGen2;
> +
> +typedef struct {
> +    /* Expand inline as a 64-bit or 32-bit integer.
> +       Only one of these will be non-NULL.  */
> +    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64);
> +    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32);
> +    /* Expand inline with a host vector type.  */
> +    void (*fniv)(TCGv_vec, TCGv_vec, TCGv_vec);
> +    /* Expand out-of-line helper w/descriptor.  */
> +    gen_helper_gvec_3 *fno;
> +    /* Prefer i64 to v64.  */
> +    bool prefer_i64;
> +    /* Load dest as a 3rd source operand.  */
> +    bool load_dest;
> +} GVecGen3;
> +
> +void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
> +                    uint32_t opsz, uint32_t clsz, const GVecGen2 *);
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t opsz, uint32_t clsz, const GVecGen3 *);
> +
> +/* Expand a specific vector operation.  */
> +
> +#define DEF(X) \
> +    void tcg_gen_gvec_##X(uint32_t dofs, uint32_t aofs, \
> +                          uint32_t opsz, uint32_t clsz)
> +
> +DEF(mov);
> +DEF(not);
> +DEF(neg8);
> +DEF(neg16);
> +DEF(neg32);
> +DEF(neg64);
> +
> +#undef DEF
> +#define DEF(X) \
> +    void tcg_gen_gvec_##X(uint32_t dofs, uint32_t aofs, uint32_t bofs, \
> +                          uint32_t opsz, uint32_t clsz)
> +
> +DEF(add8);
> +DEF(add16);
> +DEF(add32);
> +DEF(add64);
> +
> +DEF(sub8);
> +DEF(sub16);
> +DEF(sub32);
> +DEF(sub64);
> +
> +DEF(and);
> +DEF(or);
> +DEF(xor);
> +DEF(andc);
> +DEF(orc);
> +
> +#undef DEF
> +
> +/*
> + * 64-bit vector operations.  Use these when the register has been allocated
> + * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
> + * OPRSZ = MAXSZ = 8.
> + */
> +
> +void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 a);
> +void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 a);
> +void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 a);
> +
> +void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +
> +void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> new file mode 100644
> index 0000000000..c75e76367c
> --- /dev/null
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -0,0 +1,255 @@
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
> +#include "tcg-gvec-desc.h"
> +
> +
> +/* Virtually all hosts support 16-byte vectors.  Those that don't can emulate
> +   them via GCC's generic vector extension.  This turns out to be simpler and
> +   more reliable than getting the compiler to autovectorize.
> +
> +   In tcg-op-gvec.c, we asserted that both the size and alignment
> +   of the data are multiples of 16.  */
> +
> +typedef uint8_t vec8 __attribute__((vector_size(16)));
> +typedef uint16_t vec16 __attribute__((vector_size(16)));
> +typedef uint32_t vec32 __attribute__((vector_size(16)));
> +typedef uint64_t vec64 __attribute__((vector_size(16)));
> +
> +static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
> +{
> +    intptr_t maxsz = simd_maxsz(desc);
> +    intptr_t i;
> +
> +    if (unlikely(maxsz > oprsz)) {
> +        for (i = oprsz; i < maxsz; i += sizeof(vec64)) {
> +            *(vec64 *)(d + i) = (vec64){ 0 };
> +        }
> +    }
> +}
> +
> +void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec8)) {
> +        *(vec8 *)(d + i) = *(vec8 *)(a + i) + *(vec8 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec16)) {
> +        *(vec16 *)(d + i) = *(vec16 *)(a + i) + *(vec16 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec32)) {
> +        *(vec32 *)(d + i) = *(vec32 *)(a + i) + *(vec32 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) + *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec8)) {
> +        *(vec8 *)(d + i) = *(vec8 *)(a + i) - *(vec8 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec16)) {
> +        *(vec16 *)(d + i) = *(vec16 *)(a + i) - *(vec16 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec32)) {
> +        *(vec32 *)(d + i) = *(vec32 *)(a + i) - *(vec32 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) - *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec8)) {
> +        *(vec8 *)(d + i) = -*(vec8 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec16)) {
> +        *(vec16 *)(d + i) = -*(vec16 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg32)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec32)) {
> +        *(vec32 *)(d + i) = -*(vec32 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg64)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = -*(vec64 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_mov)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +
> +    memcpy(d, a, oprsz);
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_not)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = ~*(vec64 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_and)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) & *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_or)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) | *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_xor)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_andc)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(vec64 *)(d + i) = *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> new file mode 100644
> index 0000000000..7464321eba
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.c
> @@ -0,0 +1,853 @@
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
> +#include "tcg.h"
> +#include "tcg-op.h"
> +#include "tcg-op-gvec.h"
> +#include "tcg-gvec-desc.h"
> +
> +#define REP8(x)    ((x) * 0x0101010101010101ull)
> +#define REP16(x)   ((x) * 0x0001000100010001ull)
> +
> +#define MAX_UNROLL  4
> +
> +/* Verify vector size and alignment rules.  OFS should be the OR of all
> +   of the operand offsets so that we can check them all at once.  */
> +static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
> +{
> +    uint32_t align = maxsz > 16 || oprsz >= 16 ? 15 : 7;
> +    tcg_debug_assert(oprsz > 0);
> +    tcg_debug_assert(oprsz <= maxsz);
> +    tcg_debug_assert((oprsz & align) == 0);
> +    tcg_debug_assert((maxsz & align) == 0);
> +    tcg_debug_assert((ofs & align) == 0);
> +}
> +
> +/* Verify vector overlap rules for two operands.  */
> +static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
> +{
> +    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
> +}
> +
> +/* Verify vector overlap rules for three operands.  */
> +static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s)
> +{
> +    check_overlap_2(d, a, s);
> +    check_overlap_2(d, b, s);
> +    check_overlap_2(a, b, s);
> +}
> +
> +/* Create a descriptor from components.  */
> +uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
> +{
> +    uint32_t desc = 0;
> +
> +    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
> +    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
> +    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
> +
> +    oprsz = (oprsz / 8) - 1;
> +    maxsz = (maxsz / 8) - 1;
> +    desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
> +    desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
> +    desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
> +
> +    return desc;
> +}
> +
> +/* Generate a call to a gvec-style helper with two vector operands.  */
> +void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_2 *fn)
> +{
> +    TCGv_ptr a0, a1;
> +    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 = tcg_temp_new_ptr();
> +    a1 = tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
> +    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
> +
> +    fn(a0, a1, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with three vector operands.  */
> +void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_3 *fn)
> +{
> +    TCGv_ptr a0, a1, a2;
> +    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 = tcg_temp_new_ptr();
> +    a1 = tcg_temp_new_ptr();
> +    a2 = tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
> +    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
> +    tcg_gen_addi_ptr(a2, tcg_ctx.tcg_env, bofs);
> +
> +    fn(a0, a1, a2, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with three vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_2_ptr *fn)
> +{
> +    TCGv_ptr a0, a1;
> +    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 = tcg_temp_new_ptr();
> +    a1 = tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
> +    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
> +
> +    fn(a0, a1, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with three vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_3_ptr *fn)
> +{
> +    TCGv_ptr a0, a1, a2;
> +    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 = tcg_temp_new_ptr();
> +    a1 = tcg_temp_new_ptr();
> +    a2 = tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
> +    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
> +    tcg_gen_addi_ptr(a2, tcg_ctx.tcg_env, bofs);
> +
> +    fn(a0, a1, a2, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Return true if we want to implement something of OPRSZ bytes
> +   in units of LNSZ.  This limits the expansion of inline code.  */
> +static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
> +{
> +    uint32_t lnct = oprsz / lnsz;
> +    return lnct >= 1 && lnct <= MAX_UNROLL;
> +}
> +
> +/* Clear MAXSZ bytes at DOFS.  */
> +static void expand_clr(uint32_t dofs, uint32_t maxsz)
> +{
> +    if (maxsz >= 16 && TCG_TARGET_HAS_v128) {
> +        TCGv_vec zero;
> +
> +        if (maxsz >= 32 && TCG_TARGET_HAS_v256) {
> +            zero = tcg_temp_new_vec(TCG_TYPE_V256);
> +            tcg_gen_movi_vec(zero, 0);
> +
> +            for (; maxsz >= 32; dofs += 32, maxsz -= 32) {
> +                tcg_gen_stl_vec(zero, tcg_ctx.tcg_env, dofs, TCG_TYPE_V256);
> +            }
> +        } else {
> +            zero = tcg_temp_new_vec(TCG_TYPE_V128);
> +            tcg_gen_movi_vec(zero, 0);
> +        }
> +        for (; maxsz >= 16; dofs += 16, maxsz -= 16) {
> +            tcg_gen_stl_vec(zero, tcg_ctx.tcg_env, dofs, TCG_TYPE_V128);
> +        }
> +
> +        tcg_temp_free_vec(zero);
> +    } if (TCG_TARGET_REG_BITS == 64) {
> +        TCGv_i64 zero = tcg_const_i64(0);
> +
> +        for (; maxsz >= 8; dofs += 8, maxsz -= 8) {
> +            tcg_gen_st_i64(zero, tcg_ctx.tcg_env, dofs);
> +        }
> +
> +        tcg_temp_free_i64(zero);
> +    } else if (TCG_TARGET_HAS_v64) {
> +        TCGv_vec zero = tcg_temp_new_vec(TCG_TYPE_V64);
> +
> +        tcg_gen_movi_vec(zero, 0);
> +        for (; maxsz >= 8; dofs += 8, maxsz -= 8) {
> +            tcg_gen_st_vec(zero, tcg_ctx.tcg_env, dofs);
> +        }
> +
> +        tcg_temp_free_vec(zero);
> +    } else {
> +        TCGv_i32 zero = tcg_const_i32(0);
> +
> +        for (; maxsz >= 4; dofs += 4, maxsz -= 4) {
> +            tcg_gen_st_i32(zero, tcg_ctx.tcg_env, dofs);
> +        }
> +
> +        tcg_temp_free_i32(zero);
> +    }
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
> +static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t opsz,
> +                         void (*fni)(TCGv_i32, TCGv_i32))
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += 4) {
> +        tcg_gen_ld_i32(t0, tcg_ctx.tcg_env, aofs + i);
> +        fni(t0, t0);
> +        tcg_gen_st_i32(t0, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
> +static void expand_3_i32(uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t opsz, bool load_dest,
> +                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
> +{
> +    TCGv_i32 t0 = tcg_temp_new_i32();
> +    TCGv_i32 t1 = tcg_temp_new_i32();
> +    TCGv_i32 t2 = tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += 4) {
> +        tcg_gen_ld_i32(t0, tcg_ctx.tcg_env, aofs + i);
> +        tcg_gen_ld_i32(t1, tcg_ctx.tcg_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i32(t2, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        fni(t2, t0, t1);
> +        tcg_gen_st_i32(t2, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
> +static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t opsz,
> +                         void (*fni)(TCGv_i64, TCGv_i64))
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += 8) {
> +        tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +        fni(t0, t0);
> +        tcg_gen_st_i64(t0, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
> +static void expand_3_i64(uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t opsz, bool load_dest,
> +                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += 8) {
> +        tcg_gen_ld_i64(t0, tcg_ctx.tcg_env, aofs + i);
> +        tcg_gen_ld_i64(t1, tcg_ctx.tcg_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i64(t2, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        fni(t2, t0, t1);
> +        tcg_gen_st_i64(t2, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
> +static void expand_2_vec(uint32_t dofs, uint32_t aofs,
> +                         uint32_t opsz, uint32_t tysz, TCGType type,
> +                         void (*fni)(TCGv_vec, TCGv_vec))
> +{
> +    TCGv_vec t0 = tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += tysz) {
> +        tcg_gen_ld_vec(t0, tcg_ctx.tcg_env, aofs + i);
> +        fni(t0, t0);
> +        tcg_gen_st_vec(t0, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
> +static void expand_3_vec(uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t opsz,
> +                         uint32_t tysz, TCGType type, bool load_dest,
> +                         void (*fni)(TCGv_vec, TCGv_vec, TCGv_vec))
> +{
> +    TCGv_vec t0 = tcg_temp_new_vec(type);
> +    TCGv_vec t1 = tcg_temp_new_vec(type);
> +    TCGv_vec t2 = tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i = 0; i < opsz; i += tysz) {
> +        tcg_gen_ld_vec(t0, tcg_ctx.tcg_env, aofs + i);
> +        tcg_gen_ld_vec(t1, tcg_ctx.tcg_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_vec(t2, tcg_ctx.tcg_env, dofs + i);
> +        }
> +        fni(t2, t0, t1);
> +        tcg_gen_st_vec(t2, tcg_ctx.tcg_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t2);
> +    tcg_temp_free_vec(t1);
> +    tcg_temp_free_vec(t0);
> +}
> +
> +/* Expand a vector two-operand operation.  */
> +void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
> +{
> +    check_size_align(oprsz, maxsz, dofs | aofs);
> +    check_overlap_2(dofs, aofs, maxsz);
> +
> +    /* Quick check for sizes we won't support inline.  */
> +    if (oprsz > MAX_UNROLL * 32 || maxsz > MAX_UNROLL * 32) {
> +        goto do_ool;
> +    }
> +
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
> +    /* ??? For maxsz > oprsz, the host may be able to use an op-sized
> +       operation, zeroing the balance of the register.  We can then
> +       use a cl-sized store to implement the clearing without an extra
> +       store operation.  This is true for aarch64 and x86_64 hosts.  */
> +
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_2_vec(dofs, aofs, done, 32, TCG_TYPE_V256, g->fniv);
> +        dofs += done;
> +        aofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
> +        expand_2_vec(dofs, aofs, done, 16, TCG_TYPE_V128, g->fniv);
> +        dofs += done;
> +        aofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (check_size_impl(oprsz, 8)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
> +        if (TCG_TARGET_HAS_v64 && !g->prefer_i64) {
> +            expand_2_vec(dofs, aofs, done, 8, TCG_TYPE_V64, g->fniv);
> +        } else if (g->fni8) {
> +            expand_2_i64(dofs, aofs, done, g->fni8);
> +        } else {
> +            done = 0;
> +        }
> +        dofs += done;
> +        aofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (check_size_impl(oprsz, 4)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
> +        expand_2_i32(dofs, aofs, done, g->fni4);
> +        dofs += done;
> +        aofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (oprsz == 0) {
> +        if (maxsz != 0) {
> +            expand_clr(dofs, maxsz);
> +        }
> +        return;
> +    }
> +
> + do_ool:
> +    tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, 0, g->fno);
> +}
> +
> +/* Expand a vector three-operand operation.  */
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
> +{
> +    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
> +    check_overlap_3(dofs, aofs, bofs, maxsz);
> +
> +    /* Quick check for sizes we won't support inline.  */
> +    if (oprsz > MAX_UNROLL * 32 || maxsz > MAX_UNROLL * 32) {
> +        goto do_ool;
> +    }
> +
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
> +    /* ??? For maxsz > oprsz, the host may be able to use an op-sized
> +       operation, zeroing the balance of the register.  We can then
> +       use a cl-sized store to implement the clearing without an extra
> +       store operation.  This is true for aarch64 and x86_64 hosts.  */
> +
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_3_vec(dofs, aofs, bofs, done, 32, TCG_TYPE_V256,
> +                     g->load_dest, g->fniv);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 16);
> +        expand_3_vec(dofs, aofs, bofs, done, 16, TCG_TYPE_V128,
> +                     g->load_dest, g->fniv);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (check_size_impl(oprsz, 8)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 8);
> +        if (TCG_TARGET_HAS_v64 && !g->prefer_i64) {
> +            expand_3_vec(dofs, aofs, bofs, done, 8, TCG_TYPE_V64,
> +                         g->load_dest, g->fniv);
> +        } else if (g->fni8) {
> +            expand_3_i64(dofs, aofs, bofs, done, g->load_dest, g->fni8);
> +        } else {
> +            done = 0;
> +        }
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (check_size_impl(oprsz, 4)) {
> +        uint32_t done = QEMU_ALIGN_DOWN(oprsz, 4);
> +        expand_3_i32(dofs, aofs, bofs, done, g->load_dest, g->fni4);
> +        dofs += done;
> +        aofs += done;
> +        bofs += done;
> +        oprsz -= done;
> +        maxsz -= done;
> +    }
> +
> +    if (oprsz == 0) {
> +        if (maxsz != 0) {
> +            expand_clr(dofs, maxsz);
> +        }
> +        return;
> +    }
> +
> + do_ool:
> +    tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, g->fno);
> +}
> +
> +/*
> + * Expand specific vector operations.
> + */
> +
> +void tcg_gen_gvec_mov(uint32_t dofs, uint32_t aofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni8 = tcg_gen_mov_i64,
> +        .fniv = tcg_gen_mov_vec,
> +        .fno = gen_helper_gvec_mov,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_not(uint32_t dofs, uint32_t aofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni8 = tcg_gen_not_i64,
> +        .fniv = tcg_gen_not_vec,
> +        .fno = gen_helper_gvec_not,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
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
> +void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP8(0x80));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
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
> +void tcg_gen_gvec_add8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_vec_add8_i64,
> +        .fniv = tcg_gen_add8_vec,
> +        .fno = gen_helper_gvec_add8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_vec_add16_i64,
> +        .fniv = tcg_gen_add16_vec,
> +        .fno = gen_helper_gvec_add16,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni4 = tcg_gen_add_i32,
> +        .fniv = tcg_gen_add32_vec,
> +        .fno = gen_helper_gvec_add32,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_add64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_add_i64,
> +        .fniv = tcg_gen_add64_vec,
> +        .fno = gen_helper_gvec_add64,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
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
> +void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP8(0x80));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
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
> +void tcg_gen_gvec_sub8(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_vec_sub8_i64,
> +        .fniv = tcg_gen_sub8_vec,
> +        .fno = gen_helper_gvec_sub8,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_sub16(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_vec_sub16_i64,
> +        .fniv = tcg_gen_sub16_vec,
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
> +        .fniv = tcg_gen_sub32_vec,
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
> +        .fniv = tcg_gen_sub64_vec,
> +        .fno = gen_helper_gvec_sub64,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    TCGv_i64 t3 = tcg_temp_new_i64();
> +
> +    tcg_gen_andc_i64(t3, m, b);
> +    tcg_gen_andc_i64(t2, b, m);
> +    tcg_gen_sub_i64(d, m, t2);
> +    tcg_gen_xor_i64(d, d, t3);
> +
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t3);
> +}
> +
> +void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP8(0x80));
> +    gen_negv_mask(d, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    TCGv_i64 m = tcg_const_i64(REP16(0x8000));
> +    gen_negv_mask(d, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +    tcg_gen_andi_i64(t1, b, ~0xffffffffull);
> +    tcg_gen_neg_i64(t2, b);
> +    tcg_gen_neg_i64(t1, t1);
> +    tcg_gen_deposit_i64(d, t1, t2, 0, 32);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +void tcg_gen_gvec_neg8(uint32_t dofs, uint32_t aofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni8 = tcg_gen_vec_neg8_i64,
> +        .fniv = tcg_gen_neg8_vec,
> +        .fno = gen_helper_gvec_neg8,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_neg16(uint32_t dofs, uint32_t aofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni8 = tcg_gen_vec_neg16_i64,
> +        .fniv = tcg_gen_neg16_vec,
> +        .fno = gen_helper_gvec_neg16,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_neg32(uint32_t dofs, uint32_t aofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni4 = tcg_gen_neg_i32,
> +        .fniv = tcg_gen_neg32_vec,
> +        .fno = gen_helper_gvec_neg32,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_neg64(uint32_t dofs, uint32_t aofs,
> +                        uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen2 g = {
> +        .fni8 = tcg_gen_neg_i64,
> +        .fniv = tcg_gen_neg64_vec,
> +        .fno = gen_helper_gvec_neg64,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_and(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_and_i64,
> +        .fniv = tcg_gen_and_vec,
> +        .fno = gen_helper_gvec_and,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_or(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                     uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_or_i64,
> +        .fniv = tcg_gen_or_vec,
> +        .fno = gen_helper_gvec_or,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_xor(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_xor_i64,
> +        .fniv = tcg_gen_xor_vec,
> +        .fno = gen_helper_gvec_xor,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_andc(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                       uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_andc_i64,
> +        .fniv = tcg_gen_andc_vec,
> +        .fno = gen_helper_gvec_andc,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> +
> +void tcg_gen_gvec_orc(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                      uint32_t opsz, uint32_t clsz)
> +{
> +    static const GVecGen3 g = {
> +        .fni8 = tcg_gen_orc_i64,
> +        .fniv = tcg_gen_orc_vec,
> +        .fno = gen_helper_gvec_orc,
> +        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, clsz, &g);
> +}
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index 228cd84fa4..d381a02f34 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_SOFTMMU) += tcg-all.o
>  obj-$(CONFIG_SOFTMMU) += cputlb.o
> -obj-y += tcg-runtime.o
> +obj-y += tcg-runtime.o tcg-runtime-gvec.o
>  obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
>  obj-y += translator.o


--
Alex Bennée
