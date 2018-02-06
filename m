Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej0yQ-0003od-Qr
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej0yJ-0004TI-7r
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:59:38 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej0yI-0004Si-KE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:59:31 -0500
Received: by mail-wm0-x241.google.com with SMTP id f71so2924709wmf.0
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 02:59:30 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-5-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 10:59:25 +0000
Message-ID: <87wozqwfhu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 04/20] tcg: Add generic vector expanders
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile.target              |    2 +-
>  accel/tcg/tcg-runtime.h      |   29 +
>  tcg/tcg-gvec-desc.h          |   49 ++
>  tcg/tcg-op-gvec.h            |  198 +++++++
>  tcg/tcg-op.h                 |    1 +
>  tcg/tcg-opc.h                |    6 +
>  tcg/tcg.h                    |   27 +
>  accel/tcg/tcg-runtime-gvec.c |  325 +++++++++++
>  tcg/tcg-op-gvec.c            | 1308 ++++++++++++++++++++++++++++++++++++=
++++++
>  tcg/tcg-op-vec.c             |   33 +-
>  tcg/tcg.c                    |   13 +-
>  accel/tcg/Makefile.objs      |    2 +-
>  configure                    |   48 ++
>  13 files changed, 2023 insertions(+), 18 deletions(-)
>  create mode 100644 tcg/tcg-gvec-desc.h
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 accel/tcg/tcg-runtime-gvec.c
>  create mode 100644 tcg/tcg-op-gvec.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 7f30a1e725..6549481096 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -93,7 +93,7 @@ all: $(PROGS) stap
>  # cpu emulator library
>  obj-y +=3D exec.o
>  obj-y +=3D accel/
> -obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o
> +obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D disas/tci.o
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 1df17d0ba9..76ee41ce58 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -134,3 +134,32 @@ GEN_ATOMIC_HELPERS(xor_fetch)
>  GEN_ATOMIC_HELPERS(xchg)
>
>  #undef GEN_ATOMIC_HELPERS
> +
> +DEF_HELPER_FLAGS_3(gvec_mov, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_3(gvec_dup8, TCG_CALL_NO_RWG, void, ptr, i32, i32)
> +DEF_HELPER_FLAGS_3(gvec_dup16, TCG_CALL_NO_RWG, void, ptr, i32, i32)
> +DEF_HELPER_FLAGS_3(gvec_dup32, TCG_CALL_NO_RWG, void, ptr, i32, i32)
> +DEF_HELPER_FLAGS_3(gvec_dup64, TCG_CALL_NO_RWG, void, ptr, i32, i64)
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
> index 0000000000..3b4c2d9c69
> --- /dev/null
> +++ b/tcg/tcg-gvec-desc.h
> @@ -0,0 +1,49 @@
> +/*
> + * Generic vector operation descriptor
> + *
> + * Copyright (c) 2018 Linaro
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vect=
ors. */
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
> index 0000000000..5a7d640a9d
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.h
> @@ -0,0 +1,198 @@
> +/*
> + * Generic vector operation expansion
> + *
> + * Copyright (c) 2018 Linaro
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +/*
> + * "Generic" vectors.  All operands are given as offsets from ENV,
> + * and therefore cannot also be allocated via tcg_global_mem_new_*.
> + * OPRSZ is the byte size of the vector upon which the operation is perf=
ormed.
> + * MAXSZ is the byte size of the full vector; bytes beyond OPSZ are clea=
red.
> + *
> + * All sizes must be 8 or any multiple of 16.
> + * When OPRSZ is 8, the alignment may be 8, otherwise must be 16.
> + * Operands may completely, but not partially, overlap.
> + */
> +
> +/* Expand a call to a gvec-style helper, with pointers to two vector
> +   operands, and a descriptor (see tcg-gvec-desc.h).  */
> +typedef void gen_helper_gvec_2(TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_2 *fn);
> +
> +/* Similarly, passing an extra pointer (e.g. env or float_status).  */
> +typedef void gen_helper_gvec_2_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i3=
2);
> +void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_2_ptr *fn);
> +
> +/* Similarly, with three vector operands.  */
> +typedef void gen_helper_gvec_3(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t oprsz, uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_3 *fn);
> +
> +/* Similarly, with four vector operands.  */
> +typedef void gen_helper_gvec_4(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                               TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_4 *fn);
> +
> +/* Similarly, with five vector operands.  */
> +typedef void gen_helper_gvec_5(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                               TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
> +                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 =
*fn);
> +
> +typedef void gen_helper_gvec_3_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                   TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_3_ptr *fn);
> +
> +typedef void gen_helper_gvec_4_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
> +void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
> +                        uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_4_ptr *fn);
> +
> +/* Expand a gvec operation.  Either inline or out-of-line depending on
> +   the actual vector size and the operations supported by the host.  */
> +typedef struct {
> +    /* Expand inline as a 64-bit or 32-bit integer.
> +       Only one of these will be non-NULL.  */
> +    void (*fni8)(TCGv_i64, TCGv_i64);
> +    void (*fni4)(TCGv_i32, TCGv_i32);
> +    /* Expand inline with a host vector type.  */
> +    void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
> +    /* Expand out-of-line helper w/descriptor.  */
> +    gen_helper_gvec_2 *fno;
> +    /* The opcode, if any, to which this corresponds.  */
> +    TCGOpcode opc;
> +    /* The data argument to the out-of-line helper.  */
> +    int32_t data;
> +    /* The vector element size, if applicable.  */
> +    uint8_t vece;
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
> +    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
> +    /* Expand out-of-line helper w/descriptor.  */
> +    gen_helper_gvec_3 *fno;
> +    /* The opcode, if any, to which this corresponds.  */
> +    TCGOpcode opc;
> +    /* The data argument to the out-of-line helper.  */
> +    int32_t data;
> +    /* The vector element size, if applicable.  */
> +    uint8_t vece;
> +    /* Prefer i64 to v64.  */
> +    bool prefer_i64;
> +    /* Load dest as a 3rd source operand.  */
> +    bool load_dest;
> +} GVecGen3;
> +
> +typedef struct {
> +    /* Expand inline as a 64-bit or 32-bit integer.
> +       Only one of these will be non-NULL.  */
> +    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
> +    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
> +    /* Expand inline with a host vector type.  */
> +    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
> +    /* Expand out-of-line helper w/descriptor.  */
> +    gen_helper_gvec_4 *fno;
> +    /* The opcode, if any, to which this corresponds.  */
> +    TCGOpcode opc;
> +    /* The data argument to the out-of-line helper.  */
> +    int32_t data;
> +    /* The vector element size, if applicable.  */
> +    uint8_t vece;
> +    /* Prefer i64 to v64.  */
> +    bool prefer_i64;
> +} GVecGen4;
> +
> +void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
> +void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
> +
> +/* Expand a specific vector operation.  */
> +
> +void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz);
> +
> +void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +
> +void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +
> +void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                          uint32_t s, uint32_t m);
> +void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
> +                          uint32_t m, TCGv_i32);
> +void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
> +                          uint32_t m, TCGv_i64);
> +
> +void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t s, uint32_t m, uint8_t x=
);
> +void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t s, uint32_t m, uint16_t=
 x);
> +void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t s, uint32_t m, uint32_t=
 x);
> +void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t s, uint32_t m, uint64_t=
 x);
> +
> +/*
> + * 64-bit vector operations.  Use these when the register has been alloc=
ated
> + * with tcg_global_mem_new_i64, and so we cannot also address it via poi=
nter.
> + * OPRSZ =3D MAXSZ =3D 8.
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
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index a684ab5890..f8ba63340e 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -914,6 +914,7 @@ void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
> +void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
>  void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
>  void tcg_gen_and_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index b851ad4bca..801b0b1e16 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -228,6 +228,12 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS=
_andc_vec))
>  DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
>  DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
>
> +DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
> +
> +#if TCG_TARGET_MAYBE_vec
> +#include "tcg-target.opc.h"
> +#endif
> +
>  #undef TLADDR_ARGS
>  #undef DATA64_ARGS
>  #undef IMPL
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index dce483b0ee..ec8f1bc72e 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1207,6 +1207,33 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint=
8_t *tb_ptr);
>
>  void tcg_register_jit(void *buf, size_t buf_size);
>
> +#if TCG_TARGET_MAYBE_vec
> +/* Return zero if the tuple (opc, type, vece) is unsupportable;
> +   return > 0 if it is directly supportable;
> +   return < 0 if we must call tcg_expand_vec_op.  */
> +int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
> +#else
> +static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned v=
e)
> +{
> +    return 0;
> +}
> +#endif
> +
> +/* Expand the tuple (opc, type, vece) on the given arguments.  */
> +void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
> +
> +/* Replicate a constant C accoring to the log2 of the element size.  */
> +uint64_t dup_const(unsigned vece, uint64_t c);
> +
> +#define dup_const(VECE, C)                                         \
> +    (__builtin_constant_p(VECE)                                    \
> +     ? (  (VECE) =3D=3D MO_8  ? 0x0101010101010101ull * (uint8_t)(C)   \
> +        : (VECE) =3D=3D MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \
> +        : (VECE) =3D=3D MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
> +        : dup_const(VECE, C))                                      \
> +     : dup_const(VECE, C))
> +
> +
>  /*
>   * Memory helpers that will be used by TCG generated code.
>   */
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> new file mode 100644
> index 0000000000..e093922225
> --- /dev/null
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -0,0 +1,325 @@
> +/*
> + * Generic vectorized operation runtime
> + *
> + * Copyright (c) 2018 Linaro
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +#include "tcg-gvec-desc.h"
> +
> +
> +/* Virtually all hosts support 16-byte vectors.  Those that don't can em=
ulate
> + * them via GCC's generic vector extension.  This turns out to be simple=
r and
> + * more reliable than getting the compiler to autovectorize.
> + *
> + * In tcg-op-gvec.c, we asserted that both the size and alignment of the=
 data
> + * are multiples of 16.
> + *
> + * When the compiler does not support all of the operations we require, =
the
> + * loops are written so that we can always fall back on the base types.
> + */
> +#ifdef CONFIG_VECTOR16
> +typedef uint8_t vec8 __attribute__((vector_size(16)));
> +typedef uint16_t vec16 __attribute__((vector_size(16)));
> +typedef uint32_t vec32 __attribute__((vector_size(16)));
> +typedef uint64_t vec64 __attribute__((vector_size(16)));
> +
> +typedef int8_t svec8 __attribute__((vector_size(16)));
> +typedef int16_t svec16 __attribute__((vector_size(16)));
> +typedef int32_t svec32 __attribute__((vector_size(16)));
> +typedef int64_t svec64 __attribute__((vector_size(16)));
> +
> +#define DUP16(X)  { X, X, X, X, X, X, X, X, X, X, X, X, X, X, X, X }
> +#define DUP8(X)   { X, X, X, X, X, X, X, X }
> +#define DUP4(X)   { X, X, X, X }
> +#define DUP2(X)   { X, X }
> +#else
> +typedef uint8_t vec8;
> +typedef uint16_t vec16;
> +typedef uint32_t vec32;
> +typedef uint64_t vec64;
> +
> +typedef int8_t svec8;
> +typedef int16_t svec16;
> +typedef int32_t svec32;
> +typedef int64_t svec64;
> +
> +#define DUP16(X)  X
> +#define DUP8(X)   X
> +#define DUP4(X)   X
> +#define DUP2(X)   X
> +#endif /* CONFIG_VECTOR16 */
> +
> +static inline void clear_high(void *d, intptr_t oprsz, uint32_t desc)
> +{
> +    intptr_t maxsz =3D simd_maxsz(desc);
> +    intptr_t i;
> +
> +    if (unlikely(maxsz > oprsz)) {
> +        for (i =3D oprsz; i < maxsz; i +=3D sizeof(uint64_t)) {
> +            *(uint64_t *)(d + i) =3D 0;
> +        }
> +    }
> +}
> +
> +void HELPER(gvec_add8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> +        *(vec8 *)(d + i) =3D *(vec8 *)(a + i) + *(vec8 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec16)) {
> +        *(vec16 *)(d + i) =3D *(vec16 *)(a + i) + *(vec16 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> +        *(vec32 *)(d + i) =3D *(vec32 *)(a + i) + *(vec32 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_add64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) + *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub8)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> +        *(vec8 *)(d + i) =3D *(vec8 *)(a + i) - *(vec8 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec16)) {
> +        *(vec16 *)(d + i) =3D *(vec16 *)(a + i) - *(vec16 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub32)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> +        *(vec32 *)(d + i) =3D *(vec32 *)(a + i) - *(vec32 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sub64)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) - *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg8)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> +        *(vec8 *)(d + i) =3D -*(vec8 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec16)) {
> +        *(vec16 *)(d + i) =3D -*(vec16 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg32)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> +        *(vec32 *)(d + i) =3D -*(vec32 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_neg64)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D -*(vec64 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_mov)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +
> +    memcpy(d, a, oprsz);
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_dup64)(void *d, uint32_t desc, uint64_t c)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    if (c =3D=3D 0) {
> +        oprsz =3D 0;
> +    } else {
> +        for (i =3D 0; i < oprsz; i +=3D sizeof(uint64_t)) {
> +            *(uint64_t *)(d + i) =3D c;
> +        }
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_dup32)(void *d, uint32_t desc, uint32_t c)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    if (c =3D=3D 0) {
> +        oprsz =3D 0;
> +    } else {
> +        for (i =3D 0; i < oprsz; i +=3D sizeof(uint32_t)) {
> +            *(uint32_t *)(d + i) =3D c;
> +        }
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_dup16)(void *d, uint32_t desc, uint32_t c)
> +{
> +    HELPER(gvec_dup32)(d, desc, 0x00010001 * (c & 0xffff));
> +}
> +
> +void HELPER(gvec_dup8)(void *d, uint32_t desc, uint32_t c)
> +{
> +    HELPER(gvec_dup32)(d, desc, 0x01010101 * (c & 0xff));
> +}
> +
> +void HELPER(gvec_not)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D ~*(vec64 *)(a + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_and)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) & *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_or)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) | *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_xor)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) ^ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_andc)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) &~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_orc)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz =3D simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> +        *(vec64 *)(d + i) =3D *(vec64 *)(a + i) |~ *(vec64 *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> new file mode 100644
> index 0000000000..85570c983a
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.c
> @@ -0,0 +1,1308 @@
> +/*
> + * Generic vector operation expansion
> + *
> + * Copyright (c) 2018 Linaro
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "tcg.h"
> +#include "tcg-op.h"
> +#include "tcg-op-gvec.h"
> +#include "tcg-gvec-desc.h"
> +
> +#define MAX_UNROLL  4
> +
> +/* Verify vector size and alignment rules.  OFS should be the OR of all
> +   of the operand offsets so that we can check them all at once.  */
> +static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t of=
s)
> +{
> +    uint32_t align =3D maxsz > 16 || oprsz >=3D 16 ? 15 : 7;
> +    tcg_debug_assert(oprsz > 0);
> +    tcg_debug_assert(oprsz <=3D maxsz);
> +    tcg_debug_assert((oprsz & align) =3D=3D 0);
> +    tcg_debug_assert((maxsz & align) =3D=3D 0);
> +    tcg_debug_assert((ofs & align) =3D=3D 0);
> +}
> +
> +/* Verify vector overlap rules for two operands.  */
> +static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
> +{
> +    tcg_debug_assert(d =3D=3D a || d + s <=3D a || a + s <=3D d);
> +}
> +
> +/* Verify vector overlap rules for three operands.  */
> +static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t=
 s)
> +{
> +    check_overlap_2(d, a, s);
> +    check_overlap_2(d, b, s);
> +    check_overlap_2(a, b, s);
> +}
> +
> +/* Verify vector overlap rules for four operands.  */
> +static void check_overlap_4(uint32_t d, uint32_t a, uint32_t b,
> +                            uint32_t c, uint32_t s)
> +{
> +    check_overlap_2(d, a, s);
> +    check_overlap_2(d, b, s);
> +    check_overlap_2(d, c, s);
> +    check_overlap_2(a, b, s);
> +    check_overlap_2(a, c, s);
> +    check_overlap_2(b, c, s);
> +}
> +
> +/* Create a descriptor from components.  */
> +uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
> +{
> +    uint32_t desc =3D 0;
> +
> +    assert(oprsz % 8 =3D=3D 0 && oprsz <=3D (8 << SIMD_OPRSZ_BITS));
> +    assert(maxsz % 8 =3D=3D 0 && maxsz <=3D (8 << SIMD_MAXSZ_BITS));
> +    assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));
> +
> +    oprsz =3D (oprsz / 8) - 1;
> +    maxsz =3D (maxsz / 8) - 1;
> +    desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
> +    desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
> +    desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
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
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
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
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +
> +    fn(a0, a1, a2, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with four vector operands.  */
> +void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
> +                        int32_t data, gen_helper_gvec_4 *fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +
> +    fn(a0, a1, a2, a3, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with five vector operands.  */
> +void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, uint32_t xofs, uint32_t oprsz,
> +                        uint32_t maxsz, int32_t data, gen_helper_gvec_5 =
*fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3, a4;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +    a4 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +    tcg_gen_addi_ptr(a4, cpu_env, xofs);
> +
> +    fn(a0, a1, a2, a3, a4, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_ptr(a4);
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
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
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
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +
> +    fn(a0, a1, a2, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Generate a call to a gvec-style helper with four vector operands
> +   and an extra pointer operand.  */
> +void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                        uint32_t cofs, TCGv_ptr ptr, uint32_t oprsz,
> +                        uint32_t maxsz, int32_t data,
> +                        gen_helper_gvec_4_ptr *fn)
> +{
> +    TCGv_ptr a0, a1, a2, a3;
> +    TCGv_i32 desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, data));
> +
> +    a0 =3D tcg_temp_new_ptr();
> +    a1 =3D tcg_temp_new_ptr();
> +    a2 =3D tcg_temp_new_ptr();
> +    a3 =3D tcg_temp_new_ptr();
> +
> +    tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +    tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +    tcg_gen_addi_ptr(a2, cpu_env, bofs);
> +    tcg_gen_addi_ptr(a3, cpu_env, cofs);
> +
> +    fn(a0, a1, a2, a3, ptr, desc);
> +
> +    tcg_temp_free_ptr(a0);
> +    tcg_temp_free_ptr(a1);
> +    tcg_temp_free_ptr(a2);
> +    tcg_temp_free_ptr(a3);
> +    tcg_temp_free_i32(desc);
> +}
> +
> +/* Return true if we want to implement something of OPRSZ bytes
> +   in units of LNSZ.  This limits the expansion of inline code.  */
> +static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
> +{
> +    uint32_t lnct =3D oprsz / lnsz;
> +    return lnct >=3D 1 && lnct <=3D MAX_UNROLL;
> +}
> +
> +static void expand_clr(uint32_t dofs, uint32_t maxsz);
> +
> +/* Duplicate C as per VECE.  */
> +uint64_t (dup_const)(unsigned vece, uint64_t c)
> +{
> +    switch (vece) {
> +    case MO_8:
> +        return 0x0101010101010101ull * (uint8_t)c;
> +    case MO_16:
> +        return 0x0001000100010001ull * (uint16_t)c;
> +    case MO_32:
> +        return 0x0000000100000001ull * (uint32_t)c;
> +    case MO_64:
> +        return c;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +/* Duplicate IN into OUT as per VECE.  */
> +static void gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
> +{
> +    switch (vece) {
> +    case MO_8:
> +        tcg_gen_ext8u_i32(out, in);
> +        tcg_gen_muli_i32(out, out, 0x01010101);
> +        break;
> +    case MO_16:
> +        tcg_gen_deposit_i32(out, in, in, 16, 16);
> +        break;
> +    case MO_32:
> +        tcg_gen_mov_i32(out, in);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
> +{
> +    switch (vece) {
> +    case MO_8:
> +        tcg_gen_ext8u_i64(out, in);
> +        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
> +        break;
> +    case MO_16:
> +        tcg_gen_ext16u_i64(out, in);
> +        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
> +        break;
> +    case MO_32:
> +        tcg_gen_deposit_i64(out, in, in, 32, 32);
> +        break;
> +    case MO_64:
> +        tcg_gen_mov_i64(out, in);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +/* Set OPRSZ bytes at DOFS to replications of IN_32, IN_64 or IN_C.
> + * Only one of IN_32 or IN_64 may be set;
> + * IN_C is used if IN_32 and IN_64 are unset.
> + */
> +static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,
> +                   uint64_t in_c)
> +{
> +    TCGType type;
> +    TCGv_i64 t_64;
> +    TCGv_i32 t_32, t_desc;
> +    TCGv_ptr t_ptr;
> +    uint32_t i;
> +
> +    assert(vece <=3D (in_32 ? MO_32 : MO_64));
> +    assert(in_32 =3D=3D NULL || in_64 =3D=3D NULL);
> +
> +    /* If we're storing 0, expand oprsz to maxsz.  */
> +    if (in_32 =3D=3D NULL && in_64 =3D=3D NULL) {
> +        in_c =3D dup_const(vece, in_c);
> +        if (in_c =3D=3D 0) {
> +            oprsz =3D maxsz;
> +        }
> +    }
> +
> +    type =3D 0;
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        type =3D TCG_TYPE_V256;
> +    } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        type =3D TCG_TYPE_V128;
> +    } else if (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)
> +               /* Prefer integer when 64-bit host and no variable dup.  =
*/
> +               && !(TCG_TARGET_REG_BITS =3D=3D 64 && in_32 =3D=3D NULL
> +                    && (in_64 =3D=3D NULL || vece =3D=3D MO_64))) {
> +        type =3D TCG_TYPE_V64;
> +    }
> +
> +    /* Implement inline with a vector type, if possible.  */
> +    if (type !=3D 0) {
> +        TCGv_vec t_vec =3D tcg_temp_new_vec(type);
> +
> +        if (in_32) {
> +            tcg_gen_dup_i32_vec(vece, t_vec, in_32);
> +        } else if (in_64) {
> +            tcg_gen_dup_i64_vec(vece, t_vec, in_64);
> +        } else {
> +            switch (vece) {
> +            case MO_8:
> +                tcg_gen_dup8i_vec(t_vec, in_c);
> +                break;
> +            case MO_16:
> +                tcg_gen_dup16i_vec(t_vec, in_c);
> +                break;
> +            case MO_32:
> +                tcg_gen_dup32i_vec(t_vec, in_c);
> +                break;
> +            default:
> +                tcg_gen_dup64i_vec(t_vec, in_c);
> +                break;
> +            }
> +        }
> +
> +        i =3D 0;
> +        if (TCG_TARGET_HAS_v256) {
> +            for (; i + 32 <=3D oprsz; i +=3D 32) {
> +                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
> +            }
> +        }
> +        if (TCG_TARGET_HAS_v128) {
> +            for (; i + 16 <=3D oprsz; i +=3D 16) {
> +                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
> +            }
> +        }
> +        if (TCG_TARGET_HAS_v64) {
> +            for (; i < oprsz; i +=3D 8) {
> +                tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
> +            }
> +        }
> +        tcg_temp_free_vec(t_vec);
> +        goto done;
> +    }
> +
> +    /* Otherwise, inline with an integer type, unless "large".  */
> +    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {
> +        t_64 =3D NULL;
> +        t_32 =3D NULL;
> +
> +        if (in_32) {
> +            /* We are given a 32-bit variable input.  For a 64-bit host,
> +               use a 64-bit operation unless the 32-bit operation would
> +               be simple enough.  */
> +            if (TCG_TARGET_REG_BITS =3D=3D 64
> +                && (vece !=3D MO_32 || !check_size_impl(oprsz, 4))) {
> +                t_64 =3D tcg_temp_new_i64();
> +                tcg_gen_extu_i32_i64(t_64, in_32);
> +                gen_dup_i64(vece, t_64, t_64);
> +            } else {
> +                t_32 =3D tcg_temp_new_i32();
> +                gen_dup_i32(vece, t_32, in_32);
> +            }
> +        } else if (in_64) {
> +            /* We are given a 64-bit variable input.  */
> +            t_64 =3D tcg_temp_new_i64();
> +            gen_dup_i64(vece, t_64, in_64);
> +        } else {
> +            /* We are given a constant input.  */
> +            /* For 64-bit hosts, use 64-bit constants for "simple" const=
ants
> +               or when we'd need too many 32-bit stores, or when a 64-bit
> +               constant is really required.  */
> +            if (vece =3D=3D MO_64
> +                || (TCG_TARGET_REG_BITS =3D=3D 64
> +                    && (in_c =3D=3D 0 || in_c =3D=3D -1
> +                        || !check_size_impl(oprsz, 4)))) {
> +                t_64 =3D tcg_const_i64(in_c);
> +            } else {
> +                t_32 =3D tcg_const_i32(in_c);
> +            }
> +        }
> +
> +        /* Implement inline if we picked an implementation size above.  =
*/
> +        if (t_32) {
> +            for (i =3D 0; i < oprsz; i +=3D 4) {
> +                tcg_gen_st_i32(t_32, cpu_env, dofs + i);
> +            }
> +            tcg_temp_free_i32(t_32);
> +            goto done;
> +        }
> +        if (t_64) {
> +            for (i =3D 0; i < oprsz; i +=3D 8) {
> +                tcg_gen_st_i64(t_64, cpu_env, dofs + i);
> +            }
> +            tcg_temp_free_i64(t_64);
> +            goto done;
> +        }
> +    }
> +
> +    /* Otherwise implement out of line.  */
> +    t_ptr =3D tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);
> +    t_desc =3D tcg_const_i32(simd_desc(oprsz, maxsz, 0));
> +
> +    if (vece =3D=3D MO_64) {
> +        if (in_64) {
> +            gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
> +        } else {
> +            t_64 =3D tcg_const_i64(in_c);
> +            gen_helper_gvec_dup64(t_ptr, t_desc, t_64);
> +            tcg_temp_free_i64(t_64);
> +        }
> +    } else {
> +        typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);
> +        static dup_fn * const fns[3] =3D {
> +            gen_helper_gvec_dup8,
> +            gen_helper_gvec_dup16,
> +            gen_helper_gvec_dup32
> +        };
> +
> +        if (in_32) {
> +            fns[vece](t_ptr, t_desc, in_32);
> +        } else {
> +            t_32 =3D tcg_temp_new_i32();
> +            if (in_64) {
> +                tcg_gen_extrl_i64_i32(t_32, in_64);
> +            } else if (vece =3D=3D MO_8) {
> +                tcg_gen_movi_i32(t_32, in_c & 0xff);
> +            } else if (vece =3D=3D MO_16) {
> +                tcg_gen_movi_i32(t_32, in_c & 0xffff);
> +            } else {
> +                tcg_gen_movi_i32(t_32, in_c);
> +            }
> +            fns[vece](t_ptr, t_desc, t_32);
> +            tcg_temp_free_i32(t_32);
> +        }
> +    }
> +
> +    tcg_temp_free_ptr(t_ptr);
> +    tcg_temp_free_i32(t_desc);
> +    return;
> +
> + done:
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +
> +/* Likewise, but with zero.  */
> +static void expand_clr(uint32_t dofs, uint32_t maxsz)
> +{
> +    do_dup(MO_8, dofs, maxsz, maxsz, NULL, NULL, 0);
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using i32 elements.=
  */
> +static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> +                         void (*fni)(TCGv_i32, TCGv_i32))
> +{
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 4) {
> +        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
> +        fni(t0, t0);
> +        tcg_gen_st_i32(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i32 element=
s.  */
> +static void expand_3_i32(uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t oprsz, bool load_dest,
> +                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
> +{
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();
> +    TCGv_i32 t2 =3D tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 4) {
> +        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
> +        }
> +        fni(t2, t0, t1);
> +        tcg_gen_st_i32(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i32 element=
s.  */
> +static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                         uint32_t cofs, uint32_t oprsz,
> +                         void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_=
i32))
> +{
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();
> +    TCGv_i32 t2 =3D tcg_temp_new_i32();
> +    TCGv_i32 t3 =3D tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 4) {
> +        tcg_gen_ld_i32(t1, cpu_env, aofs + i);
> +        tcg_gen_ld_i32(t2, cpu_env, bofs + i);
> +        tcg_gen_ld_i32(t3, cpu_env, cofs + i);
> +        fni(t0, t1, t2, t3);
> +        tcg_gen_st_i32(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t3);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using i64 elements.=
  */
> +static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
> +                         void (*fni)(TCGv_i64, TCGv_i64))
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 8) {
> +        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
> +        fni(t0, t0);
> +        tcg_gen_st_i64(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i64 element=
s.  */
> +static void expand_3_i64(uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t oprsz, bool load_dest,
> +                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 8) {
> +        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
> +        }
> +        fni(t2, t0, t1);
> +        tcg_gen_st_i64(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using i64 element=
s.  */
> +static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                         uint32_t cofs, uint32_t oprsz,
> +                         void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_=
i64))
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 t3 =3D tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 8) {
> +        tcg_gen_ld_i64(t1, cpu_env, aofs + i);
> +        tcg_gen_ld_i64(t2, cpu_env, bofs + i);
> +        tcg_gen_ld_i64(t3, cpu_env, cofs + i);
> +        fni(t0, t1, t2, t3);
> +        tcg_gen_st_i64(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t3);
> +    tcg_temp_free_i64(t2);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of two-operand operations using host vectors.=
  */
> +static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                         uint32_t oprsz, uint32_t tysz, TCGType type,
> +                         void (*fni)(unsigned, TCGv_vec, TCGv_vec))
> +{
> +    TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D tysz) {
> +        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
> +        fni(vece, t0, t0);
> +        tcg_gen_st_vec(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of three-operand operations using host vector=
s.  */
> +static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t oprsz,
> +                         uint32_t tysz, TCGType type, bool load_dest,
> +                         void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_=
vec))
> +{
> +    TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t1 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t2 =3D tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D tysz) {
> +        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
> +        }
> +        fni(vece, t2, t0, t1);
> +        tcg_gen_st_vec(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t2);
> +    tcg_temp_free_vec(t1);
> +    tcg_temp_free_vec(t0);
> +}
> +
> +/* Expand OPSZ bytes worth of four-operand operations using host vectors=
.  */
> +static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                         uint32_t bofs, uint32_t cofs, uint32_t oprsz,
> +                         uint32_t tysz, TCGType type,
> +                         void (*fni)(unsigned, TCGv_vec, TCGv_vec,
> +                                     TCGv_vec, TCGv_vec))
> +{
> +    TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t1 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t2 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t3 =3D tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D tysz) {
> +        tcg_gen_ld_vec(t1, cpu_env, aofs + i);
> +        tcg_gen_ld_vec(t2, cpu_env, bofs + i);
> +        tcg_gen_ld_vec(t3, cpu_env, cofs + i);
> +        fni(vece, t0, t1, t2, t3);
> +        tcg_gen_st_vec(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t3);
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
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. oprsz =3D=3D 80 would be expanded with 2x32 + 1x16.  */
> +    /* ??? For maxsz > oprsz, the host may be able to use an opr-sized
> +       operation, zeroing the balance of the register.  We can then
> +       use a max-sized store to implement the clearing without an extra
> +       store operation.  This is true for aarch64 and x86_64 hosts.  */
> +
> +    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vec=
e))) {
> +        uint32_t some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fn=
iv);
> +        if (some =3D=3D oprsz) {
> +            goto done;
> +        }
> +        dofs +=3D some;
> +        aofs +=3D some;
> +        oprsz -=3D some;
> +        maxsz -=3D some;
> +    }
> +
> +    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vec=
e))) {
> +        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->f=
niv);
> +    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
> +               && g->fniv && check_size_impl(oprsz, 8)
> +               && (!g->opc
> +                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)=
)) {
> +        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fni=
v);
> +    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
> +        expand_2_i64(dofs, aofs, oprsz, g->fni8);
> +    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
> +        expand_2_i32(dofs, aofs, oprsz, g->fni4);
> +    } else {
> +        assert(g->fno !=3D NULL);
> +        tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
> +        return;
> +    }
> +
> + done:
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +
> +/* Expand a vector three-operand operation.  */
> +void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
> +{
> +    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
> +    check_overlap_3(dofs, aofs, bofs, maxsz);
> +
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. oprsz =3D=3D 80 would be expanded with 2x32 + 1x16.  */
> +
> +    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vec=
e))) {
> +        uint32_t some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
> +                     g->load_dest, g->fniv);
> +        if (some =3D=3D oprsz) {
> +            goto done;
> +        }
> +        dofs +=3D some;
> +        aofs +=3D some;
> +        bofs +=3D some;
> +        oprsz -=3D some;
> +        maxsz -=3D some;
> +    }
> +
> +    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vec=
e))) {
> +        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
> +                     g->load_dest, g->fniv);
> +    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
> +               && g->fniv && check_size_impl(oprsz, 8)
> +               && (!g->opc
> +                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)=
)) {
> +        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
> +                     g->load_dest, g->fniv);
> +    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
> +        expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
> +    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
> +        expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
> +    } else {
> +        assert(g->fno !=3D NULL);
> +        tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, g->data, g->f=
no);
> +    }
> +
> + done:
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +
> +/* Expand a vector four-operand operation.  */
> +void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
> +                    uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
> +{
> +    check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
> +    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
> +
> +    /* Recall that ARM SVE allows vector sizes that are not a power of 2.
> +       Expand with successively smaller host vector sizes.  The intent is
> +       that e.g. oprsz =3D=3D 80 would be expanded with 2x32 + 1x16.  */
> +
> +    if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vec=
e))) {
> +        uint32_t some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,
> +                     32, TCG_TYPE_V256, g->fniv);
> +        if (some =3D=3D oprsz) {
> +            goto done;
> +        }
> +        dofs +=3D some;
> +        aofs +=3D some;
> +        bofs +=3D some;
> +        cofs +=3D some;
> +        oprsz -=3D some;
> +        maxsz -=3D some;
> +    }
> +
> +    if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
> +        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vec=
e))) {
> +        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
> +                     16, TCG_TYPE_V128, g->fniv);
> +    } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
> +               && g->fniv && check_size_impl(oprsz, 8)
> +                && (!g->opc
> +                    || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece=
))) {
> +        expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
> +                     8, TCG_TYPE_V64, g->fniv);
> +    } else if (g->fni8 && check_size_impl(oprsz, 8)) {
> +        expand_4_i64(dofs, aofs, bofs, cofs, oprsz, g->fni8);
> +    } else if (g->fni4 && check_size_impl(oprsz, 4)) {
> +        expand_4_i32(dofs, aofs, bofs, cofs, oprsz, g->fni4);
> +    } else {
> +        assert(g->fno !=3D NULL);
> +        tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
> +                           oprsz, maxsz, g->data, g->fno);
> +        return;
> +    }
> +
> + done:
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +
> +/*
> + * Expand specific vector operations.
> + */
> +
> +static void vec_mov2(unsigned vece, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_mov_vec(a, b);
> +}
> +
> +void tcg_gen_gvec_mov(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen2 g =3D {
> +        .fni8 =3D tcg_gen_mov_i64,
> +        .fniv =3D vec_mov2,
> +        .fno =3D gen_helper_gvec_mov,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    if (dofs !=3D aofs) {
> +        tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
> +    } else {
> +        check_size_align(oprsz, maxsz, dofs);
> +        if (oprsz < maxsz) {
> +            expand_clr(dofs + oprsz, maxsz - oprsz);
> +        }
> +    }
> +}
> +
> +void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, TCGv_i32 in)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    tcg_debug_assert(vece <=3D MO_32);
> +    do_dup(vece, dofs, oprsz, maxsz, in, NULL, 0);
> +}
> +
> +void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, TCGv_i64 in)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    tcg_debug_assert(vece <=3D MO_64);
> +    do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
> +}
> +
> +void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                          uint32_t oprsz, uint32_t maxsz)
> +{
> +    if (vece <=3D MO_32) {
> +        TCGv_i32 in =3D tcg_temp_new_i32();
> +        switch (vece) {
> +        case MO_8:
> +            tcg_gen_ld8u_i32(in, cpu_env, aofs);
> +            break;
> +        case MO_16:
> +            tcg_gen_ld16u_i32(in, cpu_env, aofs);
> +            break;
> +        case MO_32:
> +            tcg_gen_ld_i32(in, cpu_env, aofs);
> +            break;
> +        }
> +        tcg_gen_gvec_dup_i32(vece, dofs, oprsz, maxsz, in);
> +        tcg_temp_free_i32(in);
> +    } else if (vece =3D=3D MO_64) {
> +        TCGv_i64 in =3D tcg_temp_new_i64();
> +        tcg_gen_ld_i64(in, cpu_env, aofs);
> +        tcg_gen_gvec_dup_i64(MO_64, dofs, oprsz, maxsz, in);
> +        tcg_temp_free_i64(in);
> +    } else {
> +        /* 128-bit duplicate.  */
> +        /* ??? Dup to 256-bit vector.  */
> +        int i;
> +
> +        tcg_debug_assert(vece =3D=3D 4);
> +        tcg_debug_assert(oprsz >=3D 16);
> +        if (TCG_TARGET_HAS_v128) {
> +            TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V128);
> +
> +            tcg_gen_ld_vec(in, cpu_env, aofs);
> +            for (i =3D 0; i < oprsz; i +=3D 16) {
> +                tcg_gen_st_vec(in, cpu_env, dofs + i);
> +            }
> +            tcg_temp_free_vec(in);
> +        } else {
> +            TCGv_i64 in0 =3D tcg_temp_new_i64();
> +            TCGv_i64 in1 =3D tcg_temp_new_i64();
> +
> +            tcg_gen_ld_i64(in0, cpu_env, aofs);
> +            tcg_gen_ld_i64(in1, cpu_env, aofs + 8);
> +            for (i =3D 0; i < oprsz; i +=3D 16) {
> +                tcg_gen_st_i64(in0, cpu_env, dofs + i);
> +                tcg_gen_st_i64(in1, cpu_env, dofs + i + 8);
> +            }
> +            tcg_temp_free_i64(in0);
> +            tcg_temp_free_i64(in1);
> +        }
> +    }
> +}
> +
> +void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint64_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(MO_64, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
> +void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint32_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(MO_32, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
> +void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint16_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(MO_16, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
> +void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint8_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
> +}
> +
> +void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen2 g =3D {
> +        .fni8 =3D tcg_gen_not_i64,
> +        .fniv =3D tcg_gen_not_vec,
> +        .fno =3D gen_helper_gvec_not,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
> +}
> +
> +/* Perform a vector addition using normal addition and a mask.  The mask
> +   should be the sign bit of each lane.  This 6-operation form is more
> +   efficient than separate additions when there are 4 or more lanes in
> +   the 64-bit operation.  */
> +static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 t3 =3D tcg_temp_new_i64();
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
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
> +    gen_addv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
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
> +void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fni8 =3D tcg_gen_vec_add8_i64,
> +          .fniv =3D tcg_gen_add_vec,
> +          .fno =3D gen_helper_gvec_add8,
> +          .opc =3D INDEX_op_add_vec,
> +          .vece =3D MO_8 },
> +        { .fni8 =3D tcg_gen_vec_add16_i64,
> +          .fniv =3D tcg_gen_add_vec,
> +          .fno =3D gen_helper_gvec_add16,
> +          .opc =3D INDEX_op_add_vec,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_add_i32,
> +          .fniv =3D tcg_gen_add_vec,
> +          .fno =3D gen_helper_gvec_add32,
> +          .opc =3D INDEX_op_add_vec,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_add_i64,
> +          .fniv =3D tcg_gen_add_vec,
> +          .fno =3D gen_helper_gvec_add64,
> +          .opc =3D INDEX_op_add_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .vece =3D MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +/* Perform a vector subtraction using normal subtraction and a mask.
> +   Compare gen_addv_mask above.  */
> +static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 t3 =3D tcg_temp_new_i64();
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
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
> +    gen_subv_mask(d, a, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
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
> +void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] =3D {
> +        { .fni8 =3D tcg_gen_vec_sub8_i64,
> +          .fniv =3D tcg_gen_sub_vec,
> +          .fno =3D gen_helper_gvec_sub8,
> +          .opc =3D INDEX_op_sub_vec,
> +          .vece =3D MO_8 },
> +        { .fni8 =3D tcg_gen_vec_sub16_i64,
> +          .fniv =3D tcg_gen_sub_vec,
> +          .fno =3D gen_helper_gvec_sub16,
> +          .opc =3D INDEX_op_sub_vec,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_sub_i32,
> +          .fniv =3D tcg_gen_sub_vec,
> +          .fno =3D gen_helper_gvec_sub32,
> +          .opc =3D INDEX_op_sub_vec,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_sub_i64,
> +          .fniv =3D tcg_gen_sub_vec,
> +          .fno =3D gen_helper_gvec_sub64,
> +          .opc =3D INDEX_op_sub_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .vece =3D MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +/* Perform a vector negation using normal negation and a mask.
> +   Compare gen_subv_mask above.  */
> +static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
> +{
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 t3 =3D tcg_temp_new_i64();
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
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_8, 0x80));
> +    gen_negv_mask(d, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    TCGv_i64 m =3D tcg_const_i64(dup_const(MO_16, 0x8000));
> +    gen_negv_mask(d, b, m);
> +    tcg_temp_free_i64(m);
> +}
> +
> +void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
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
> +void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen2 g[4] =3D {
> +        { .fni8 =3D tcg_gen_vec_neg8_i64,
> +          .fniv =3D tcg_gen_neg_vec,
> +          .fno =3D gen_helper_gvec_neg8,
> +          .opc =3D INDEX_op_neg_vec,
> +          .vece =3D MO_8 },
> +        { .fni8 =3D tcg_gen_vec_neg16_i64,
> +          .fniv =3D tcg_gen_neg_vec,
> +          .fno =3D gen_helper_gvec_neg16,
> +          .opc =3D INDEX_op_neg_vec,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D tcg_gen_neg_i32,
> +          .fniv =3D tcg_gen_neg_vec,
> +          .fno =3D gen_helper_gvec_neg32,
> +          .opc =3D INDEX_op_neg_vec,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D tcg_gen_neg_i64,
> +          .fniv =3D tcg_gen_neg_vec,
> +          .fno =3D gen_helper_gvec_neg64,
> +          .opc =3D INDEX_op_neg_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .vece =3D MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_and_i64,
> +        .fniv =3D tcg_gen_and_vec,
> +        .fno =3D gen_helper_gvec_and,
> +        .opc =3D INDEX_op_and_vec,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +}
> +
> +void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_or_i64,
> +        .fniv =3D tcg_gen_or_vec,
> +        .fno =3D gen_helper_gvec_or,
> +        .opc =3D INDEX_op_or_vec,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +}
> +
> +void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_xor_i64,
> +        .fniv =3D tcg_gen_xor_vec,
> +        .fno =3D gen_helper_gvec_xor,
> +        .opc =3D INDEX_op_xor_vec,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +}
> +
> +void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_andc_i64,
> +        .fniv =3D tcg_gen_andc_vec,
> +        .fno =3D gen_helper_gvec_andc,
> +        .opc =3D INDEX_op_andc_vec,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +}
> +
> +void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g =3D {
> +        .fni8 =3D tcg_gen_orc_i64,
> +        .fniv =3D tcg_gen_orc_vec,
> +        .fno =3D gen_helper_gvec_orc,
> +        .opc =3D INDEX_op_orc_vec,
> +        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +    };
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +}
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 9e4678878b..ac5b69ccf6 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -73,7 +73,8 @@ static void vec_gen_op2(TCGOpcode opc, unsigned vece, T=
CGv_vec r, TCGv_vec a)
>      TCGTemp *at =3D tcgv_vec_temp(a);
>      TCGType type =3D rt->base_type;
>
> -    tcg_debug_assert(at->base_type =3D=3D type);
> +    /* Must enough inputs for the output.  */
> +    tcg_debug_assert(at->base_type >=3D type);
>      vec_gen_2(opc, type, vece, temp_arg(rt), temp_arg(at));
>  }
>
> @@ -85,8 +86,9 @@ static void vec_gen_op3(TCGOpcode opc, unsigned vece,
>      TCGTemp *bt =3D tcgv_vec_temp(b);
>      TCGType type =3D rt->base_type;
>
> -    tcg_debug_assert(at->base_type =3D=3D type);
> -    tcg_debug_assert(bt->base_type =3D=3D type);
> +    /* Must enough inputs for the output.  */
> +    tcg_debug_assert(at->base_type >=3D type);
> +    tcg_debug_assert(bt->base_type >=3D type);
>      vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
>  }
>
> @@ -99,7 +101,7 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
>
>  #define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_64 : MO_32)
>
> -static void tcg_gen_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
> +static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
>  {
>      TCGTemp *rt =3D tcgv_vec_temp(r);
>      vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
> @@ -108,14 +110,14 @@ static void tcg_gen_dupi_vec(TCGv_vec r, unsigned v=
ece, TCGArg a)
>  TCGv_vec tcg_const_zeros_vec(TCGType type)
>  {
>      TCGv_vec ret =3D tcg_temp_new_vec(type);
> -    tcg_gen_dupi_vec(ret, MO_REG, 0);
> +    do_dupi_vec(ret, MO_REG, 0);
>      return ret;
>  }
>
>  TCGv_vec tcg_const_ones_vec(TCGType type)
>  {
>      TCGv_vec ret =3D tcg_temp_new_vec(type);
> -    tcg_gen_dupi_vec(ret, MO_REG, -1);
> +    do_dupi_vec(ret, MO_REG, -1);
>      return ret;
>  }
>
> @@ -134,9 +136,9 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
>  void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
>  {
>      if (TCG_TARGET_REG_BITS =3D=3D 32 && a =3D=3D deposit64(a, 32, 32, a=
)) {
> -        tcg_gen_dupi_vec(r, MO_32, a);
> +        do_dupi_vec(r, MO_32, a);
>      } else if (TCG_TARGET_REG_BITS =3D=3D 64 || a =3D=3D (uint64_t)(int3=
2_t)a) {
> -        tcg_gen_dupi_vec(r, MO_64, a);
> +        do_dupi_vec(r, MO_64, a);
>      } else {
>          TCGv_i64 c =3D tcg_const_i64(a);
>          tcg_gen_dup_i64_vec(MO_64, r, c);
> @@ -146,17 +148,22 @@ void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
>
>  void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
>  {
> -    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffffffffu) * a);
> +    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
>  }
>
>  void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
>  {
> -    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xffff) * (a & 0xffff));
> +    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
>  }
>
>  void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
>  {
> -    tcg_gen_dupi_vec(r, MO_REG, ((TCGArg)-1 / 0xff) * (a & 0xff));
> +    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
> +}
> +
> +void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
> +{
> +    do_dupi_vec(r, MO_REG, dup_const(vece, a));
>  }
>
>  void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
> @@ -167,14 +174,14 @@ void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r,=
 TCGv_i64 a)
>
>      if (TCG_TARGET_REG_BITS =3D=3D 64) {
>          TCGArg ai =3D tcgv_i64_arg(a);
> -        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
> +        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
>      } else if (vece =3D=3D MO_64) {
>          TCGArg al =3D tcgv_i32_arg(TCGV_LOW(a));
>          TCGArg ah =3D tcgv_i32_arg(TCGV_HIGH(a));
>          vec_gen_3(INDEX_op_dup2_vec, type, MO_64, ri, al, ah);
>      } else {
>          TCGArg ai =3D tcgv_i32_arg(TCGV_LOW(a));
> -        vec_gen_2(INDEX_op_dup_vec, type, MO_64, ri, ai);
> +        vec_gen_2(INDEX_op_dup_vec, type, vece, ri, ai);
>      }
>  }
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 42f0acdf8e..0862cff58a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1403,10 +1403,10 @@ bool tcg_op_supported(TCGOpcode op)
>      case INDEX_op_orc_vec:
>          return have_vec && TCG_TARGET_HAS_orc_vec;
>
> -    case NB_OPS:
> -        break;
> +    default:
> +        tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
> +        return true;
>      }
> -    g_assert_not_reached();
>  }
>
>  /* Note: we convert the 64 bit args to 32 bit and do some alignment
> @@ -3733,3 +3733,10 @@ void tcg_register_jit(void *buf, size_t buf_size)
>  {
>  }
>  #endif /* ELF_HOST_MACHINE */
> +
> +#if !TCG_TARGET_MAYBE_vec
> +void tcg_expand_vec_op(TCGOpcode o, TCGType t, unsigned e, TCGArg a0, ..=
.)
> +{
> +    g_assert_not_reached();
> +}
> +#endif
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index 228cd84fa4..d381a02f34 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -1,6 +1,6 @@
>  obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>  obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
> -obj-y +=3D tcg-runtime.o
> +obj-y +=3D tcg-runtime.o tcg-runtime-gvec.o
>  obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
>  obj-y +=3D translator.o
>
> diff --git a/configure b/configure
> index 044c6fafe2..951253acad 100755
> --- a/configure
> +++ b/configure
> @@ -4958,6 +4958,50 @@ if compile_prog "" "" ; then
>    atomic64=3Dyes
>  fi
>
> +########################################
> +# See if 16-byte vector operations are supported.
> +# Even without a vector unit the compiler may expand these.
> +# There is a bug in old GCC for PPC that crashes here.
> +# Unfortunately it's the system compiler for Centos 7.
> +
> +cat > $TMPC << EOF
> +typedef unsigned char U1 __attribute__((vector_size(16)));
> +typedef unsigned short U2 __attribute__((vector_size(16)));
> +typedef unsigned int U4 __attribute__((vector_size(16)));
> +typedef unsigned long long U8 __attribute__((vector_size(16)));
> +typedef signed char S1 __attribute__((vector_size(16)));
> +typedef signed short S2 __attribute__((vector_size(16)));
> +typedef signed int S4 __attribute__((vector_size(16)));
> +typedef signed long long S8 __attribute__((vector_size(16)));
> +static U1 a1, b1;
> +static U2 a2, b2;
> +static U4 a4, b4;
> +static U8 a8, b8;
> +static S1 c1;
> +static S2 c2;
> +static S4 c4;
> +static S8 c8;
> +static int i;
> +int main(void)
> +{
> +  a1 +=3D b1; a2 +=3D b2; a4 +=3D b4; a8 +=3D b8;
> +  a1 -=3D b1; a2 -=3D b2; a4 -=3D b4; a8 -=3D b8;
> +  a1 *=3D b1; a2 *=3D b2; a4 *=3D b4; a8 *=3D b8;
> +  a1 &=3D b1; a2 &=3D b2; a4 &=3D b4; a8 &=3D b8;
> +  a1 |=3D b1; a2 |=3D b2; a4 |=3D b4; a8 |=3D b8;
> +  a1 ^=3D b1; a2 ^=3D b2; a4 ^=3D b4; a8 ^=3D b8;
> +  a1 <<=3D i; a2 <<=3D i; a4 <<=3D i; a8 <<=3D i;
> +  a1 >>=3D i; a2 >>=3D i; a4 >>=3D i; a8 >>=3D i;
> +  c1 >>=3D i; c2 >>=3D i; c4 >>=3D i; c8 >>=3D i;
> +  return 0;
> +}
> +EOF
> +
> +vector16=3Dno
> +if compile_prog "" "" ; then
> +  vector16=3Dyes
> +fi
> +
>  ########################################
>  # check if getauxval is available.
>
> @@ -6226,6 +6270,10 @@ if test "$atomic64" =3D "yes" ; then
>    echo "CONFIG_ATOMIC64=3Dy" >> $config_host_mak
>  fi
>
> +if test "$vector16" =3D "yes" ; then
> +  echo "CONFIG_VECTOR16=3Dy" >> $config_host_mak
> +fi
> +
>  if test "$getauxval" =3D "yes" ; then
>    echo "CONFIG_GETAUXVAL=3Dy" >> $config_host_mak
>  fi


--
Alex Benn=C3=A9e
