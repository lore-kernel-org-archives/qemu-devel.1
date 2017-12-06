Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMWpN-0002Er-IH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMWpK-0001xD-B7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:21:21 -0500
Received: from bran.ispras.ru ([83.149.199.196]:55232 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eMWpJ-0001vk-NE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:21:18 -0500
Date: Wed, 6 Dec 2017 13:21:16 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <20171121212534.5177-6-richard.henderson@linaro.org>
Message-ID: <alpine.DEB.2.20.1712061300570.7159@bulbul.intra.ispras.ru>
References: <20171121212534.5177-1-richard.henderson@linaro.org>
	<20171121212534.5177-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v6 05/26] tcg: Add generic vector expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 21 Nov 2017, Richard Henderson wrote:

> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> new file mode 100644
> index 0000000000..925c293f9c
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.c

<...>

> +/* Set OPRSZ bytes at DOFS to replications of IN or IN_C.  */
> +static void do_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                       uint32_t maxsz, TCGv_i32 in, uint32_t in_c,
> +                       void (*ool)(TCGv_ptr, TCGv_i32, TCGv_i32))
> +{
> +    TCGv_vec t_vec;
> +    uint32_t i;
> +
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        t_vec = tcg_temp_new_vec(TCG_TYPE_V256);
> +    } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        t_vec = tcg_temp_new_vec(TCG_TYPE_V128);
> +    } else if (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)) {
> +        t_vec = tcg_temp_new_vec(TCG_TYPE_V64);
> +    } else  {
> +        TCGv_i32 t_i32 = in ? in : tcg_const_i32(in_c);
> +
> +        if (check_size_impl(oprsz, 4)) {
> +            for (i = 0; i < oprsz; i += 4) {
> +                tcg_gen_st_i32(t_i32, cpu_env, dofs + i);
> +            }

You are ignoring VECE argument here and always duplicate a 32-bit value.
For this to be correct for smaller VECE, you need to prepare this 32-bit
value beforehand. The current code produces incorrect expansion:

IN: 
0x004005e8:  d2824682  movz     x2, #0x1234
0x004005ec:  4e010c41  dup      v1.16b, w2

OP:

 ---- 00000000004005e8 0000000000000000 0000000000000000
 movi_i64 x2,$0x1234

 ---- 00000000004005ec 0000000000000000 0000000000000000
 st_i32 x2,env,$0x8b0
 st_i32 x2,env,$0x8b4
 st_i32 x2,env,$0x8b8
 st_i32 x2,env,$0x8bc



> +            if (in == NULL) {
> +                tcg_temp_free_i32(t_i32);
> +            }
> +            goto done;
> +        } else {
> +            TCGv_ptr a0 = tcg_temp_new_ptr();
> +            TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, 0));
> +
> +            tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +            ool(a0, desc, t_i32);
> +
> +            tcg_temp_free_ptr(a0);
> +            tcg_temp_free_i32(desc);
> +            if (in == NULL) {
> +                tcg_temp_free_i32(t_i32);
> +            }
> +            return;
> +        }
> +    }
> +
> +    if (in) {
> +        tcg_gen_dup_i32_vec(vece, t_vec, in);
> +    } else {
> +        tcg_gen_dup32i_vec(t_vec, in_c);

May be it'll be better to call this function tcg_gen_dupi_i32_vec?
This will go along with current naming conventions like tcg_gen_addi_i32.

> +    }
> +
> +    i = 0;
> +    if (TCG_TARGET_HAS_v256) {
> +        for (; i + 32 <= oprsz; i += 32) {
> +            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V256);
> +        }
> +    }
> +    if (TCG_TARGET_HAS_v128) {
> +        for (; i + 16 <= oprsz; i += 16) {
> +            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V128);
> +        }
> +    }
> +    if (TCG_TARGET_HAS_v64) {
> +        for (; i < oprsz; i += 8) {
> +            tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
> +        }
> +    }
> +
> + done:
> +    tcg_debug_assert(i == oprsz);
> +    if (i < maxsz) {
> +        expand_clr(dofs + i, maxsz - i);
> +    }
> +}
> +

<...>
(the following is context)

> +void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, TCGv_i32 in)
> +{
> +    typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);
> +    static dup_fn * const fns[3] = {
> +        gen_helper_gvec_dup8,
> +        gen_helper_gvec_dup16,
> +        gen_helper_gvec_dup32
> +    };
> +
> +    check_size_align(oprsz, maxsz, dofs);
> +    tcg_debug_assert(vece <= MO_32);
> +    do_dup_i32(vece, dofs, oprsz, maxsz, in, 0, fns[vece]);
> +}
> +
> +void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                          uint32_t maxsz, TCGv_i64 in)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    tcg_debug_assert(vece <= MO_64);
> +    if (vece <= MO_32) {
> +        /* This works for both host register sizes.  */
> +        tcg_gen_gvec_dup_i32(vece, dofs, oprsz, maxsz, (TCGv_i32)in);
> +    } else {
> +        do_dup_i64(vece, dofs, oprsz, maxsz, in, 0);
> +    }
> +}
> +
> +void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                          uint32_t oprsz, uint32_t maxsz)
> +{
> +    tcg_debug_assert(vece <= MO_64);
> +    if (vece <= MO_32) {
> +        TCGv_i32 in = tcg_temp_new_i32();
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
> +    } else {
> +        TCGv_i64 in = tcg_temp_new_i64();
> +        tcg_gen_ld_i64(in, cpu_env, aofs);
> +        tcg_gen_gvec_dup_i64(MO_64, dofs, oprsz, maxsz, in);
> +        tcg_temp_free_i64(in);
> +    }
> +}
> +
> +void tcg_gen_gvec_dup64i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint64_t x)
> +{
> +    check_size_align(oprsz, maxsz, dofs);
> +    do_dup_i64(MO_64, dofs, oprsz, maxsz, NULL, x);
> +}
> +
> +void tcg_gen_gvec_dup32i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint32_t x)
> +{
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        do_dup_i64(MO_64, dofs, oprsz, maxsz, NULL, deposit64(x, 32, 32, x));
> +    } else {
> +        do_dup_i32(MO_32, dofs, oprsz, maxsz, NULL, x, gen_helper_gvec_dup32);
> +    }
> +}
> +
> +void tcg_gen_gvec_dup16i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint16_t x)
> +{
> +    tcg_gen_gvec_dup32i(dofs, oprsz, maxsz, 0x00010001 * x);
> +}
> +
> +void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
> +                         uint32_t maxsz, uint8_t x)
> +{
> +    tcg_gen_gvec_dup32i(dofs, oprsz, maxsz, 0x01010101 * x);
> +}
> +

-- 
Kirill
