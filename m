Received: from eggs.gnu.org ([2001:4830:134:3::10]:51960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDVt-0006GV-KD
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDVq-0004xQ-Ia
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:21:01 -0500
Received: from bran.ispras.ru ([83.149.199.196]:55034 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDVq-0004qy-1h
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:20:58 -0500
Date: Wed, 27 Dec 2017 18:20:53 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <20171218171758.16964-3-richard.henderson@linaro.org>
Message-ID: <alpine.DEB.2.20.1712271812080.4787@bulbul.intra.ispras.ru>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
	<20171218171758.16964-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v7 02/26] tcg: Add generic vector expanders
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

On Mon, 18 Dec 2017, Richard Henderson wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile.target              |    2 +-
>  accel/tcg/tcg-runtime.h      |   29 ++
>  tcg/tcg-gvec-desc.h          |   49 ++
>  tcg/tcg-op-gvec.h            |  152 ++++++
>  tcg/tcg-op.h                 |    1 +
>  accel/tcg/tcg-runtime-gvec.c |  295 ++++++++++++
>  tcg/tcg-op-gvec.c            | 1099 ++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c             |   36 +-
>  accel/tcg/Makefile.objs      |    2 +-
>  9 files changed, 1655 insertions(+), 10 deletions(-)
>  create mode 100644 tcg/tcg-gvec-desc.h
>  create mode 100644 tcg/tcg-op-gvec.h
>  create mode 100644 accel/tcg/tcg-runtime-gvec.c
>  create mode 100644 tcg/tcg-op-gvec.c
> 

> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> new file mode 100644
> index 0000000000..120e301096
> --- /dev/null
> +++ b/tcg/tcg-op-gvec.c

> +/* Set OPRSZ bytes at DOFS to replications of IN or IN_C.  */
> +static void do_dup_i32(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                       uint32_t maxsz, TCGv_i32 in, uint32_t in_c,
> +                       void (*ool)(TCGv_ptr, TCGv_i32, TCGv_i32))
> +{
> +    TCGType type;
> +    TCGv_vec t_vec;
> +    uint32_t i;
> +
> +    assert(vece <= MO_32);
> +
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        type = TCG_TYPE_V256;
> +    } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        type = TCG_TYPE_V128;
> +    } else if (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)) {
> +        type = TCG_TYPE_V64;
> +    } else {
> +        if (check_size_impl(oprsz, 4)) {
> +            TCGv_i32 t_i32 = tcg_temp_new_i32();
> +
> +            if (in) {
> +                switch (vece) {
> +                case MO_8:
> +                    tcg_gen_deposit_i32(t_i32, in, in, 8, 24);
> +                    in = t_i32;
> +                    /* fallthru */
> +                case MO_16:
> +                    tcg_gen_deposit_i32(t_i32, in, in, 16, 16);
> +                    break;
> +                }

If vece == MO_32 then t_i32 will be left uninitialized here... 

> +            } else {
> +                switch (vece) {
> +                case MO_8:
> +                    in_c = (in_c & 0xff) * 0x01010101;
> +                    break;
> +                case MO_16:
> +                    in_c = deposit32(in_c, 16, 16, in_c);
> +                    break;
> +                }
> +                tcg_gen_movi_i32(t_i32, in_c);
> +            }
> +
> +            for (i = 0; i < oprsz; i += 4) {
> +                tcg_gen_st_i32(t_i32, cpu_env, dofs + i);
> +            }

...and used uninitialized here.

> +            tcg_temp_free_i32(t_i32);
> +            goto done;
> +        } else {
> +            TCGv_i32 t_i32 = in ? in : tcg_const_i32(in_c);
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
> +    t_vec = tcg_temp_new_vec(type);
> +    if (in) {
> +        tcg_gen_dup_i32_vec(vece, t_vec, in);
> +    } else {
> +        switch (vece) {
> +        case MO_8:
> +            tcg_gen_dup8i_vec(t_vec, in_c);
> +            break;
> +        case MO_16:
> +            tcg_gen_dup16i_vec(t_vec, in_c);
> +            break;
> +        default:
> +            tcg_gen_dup32i_vec(t_vec, in_c);
> +            break;
> +        }
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
> +    tcg_temp_free_vec(t_vec);
> +
> + done:
> +    tcg_debug_assert(i == oprsz);
> +    if (i < maxsz) {
> +        expand_clr(dofs + i, maxsz - i);
> +    }
> +}
> +
> +/* Likewise, but with 64-bit quantities.  */
> +static void do_dup_i64(unsigned vece, uint32_t dofs, uint32_t oprsz,
> +                       uint32_t maxsz, TCGv_i64 in, uint64_t in_c)
> +{
> +    TCGType type;
> +    TCGv_vec t_vec;
> +    uint32_t i;
> +
> +    assert(vece <= MO_64);
> +
> +    if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        type = TCG_TYPE_V256;
> +    } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        type = TCG_TYPE_V128;
> +    } else if (TCG_TARGET_HAS_v64 && TCG_TARGET_REG_BITS == 32
> +               && check_size_impl(oprsz, 8)) {
> +        type = TCG_TYPE_V64;
> +    } else {
> +        if (check_size_impl(oprsz, 8)) {
> +            TCGv_i64 t_i64 = tcg_temp_new_i64();
> +
> +            if (in) {
> +                switch (vece) {
> +                case MO_8:
> +                    tcg_gen_deposit_i64(t_i64, in, in, 8, 56);
> +                    in = t_i64;
> +                    /* fallthru */
> +                case MO_16:
> +                    tcg_gen_deposit_i64(t_i64, in, in, 16, 48);
> +                    in = t_i64;
> +                    /* fallthru */
> +                case MO_32:
> +                    tcg_gen_deposit_i64(t_i64, in, in, 32, 32);
> +                    break;
> +                }

The same thing happens here when vece == MO_64.

> +            } else {
> +                switch (vece) {
> +                case MO_8:
> +                    in_c = (in_c & 0xff) * 0x0101010101010101ull;
> +                    break;
> +                case MO_16:
> +                    in_c = (in_c & 0xffff) * 0x0001000100010001ull;
> +                    break;
> +                case MO_32:
> +                    in_c = deposit64(in_c, 32, 32, in_c);
> +                    break;
> +                }
> +                tcg_gen_movi_i64(t_i64, in_c);
> +            }
> +
> +            for (i = 0; i < oprsz; i += 8) {
> +                tcg_gen_st_i64(t_i64, cpu_env, dofs + i);
> +            }
> +            tcg_temp_free_i64(t_i64);
> +            goto done;
> +        } else {
> +            TCGv_i64 t_i64 = in ? in : tcg_const_i64(in_c);
> +            TCGv_ptr a0 = tcg_temp_new_ptr();
> +            TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, 0));
> +
> +            tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +            gen_helper_gvec_dup64(a0, desc, t_i64);
> +
> +            tcg_temp_free_ptr(a0);
> +            tcg_temp_free_i32(desc);
> +            if (in == NULL) {
> +                tcg_temp_free_i64(t_i64);
> +            }
> +            return;
> +        }
> +    }
> +
> +    t_vec = tcg_temp_new_vec(type);
> +    if (in) {
> +        tcg_gen_dup_i64_vec(vece, t_vec, in);
> +    } else {
> +        switch (vece) {
> +        case MO_8:
> +            tcg_gen_dup8i_vec(t_vec, in_c);
> +            break;
> +        case MO_16:
> +            tcg_gen_dup16i_vec(t_vec, in_c);
> +            break;
> +        case MO_32:
> +            tcg_gen_dup32i_vec(t_vec, in_c);
> +            break;
> +        default:
> +            tcg_gen_dup64i_vec(t_vec, in_c);
> +            break;
> +        }
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
> +    tcg_temp_free_vec(t_vec);
> +
> + done:
> +    tcg_debug_assert(i == oprsz);
> +    if (i < maxsz) {
> +        expand_clr(dofs + i, maxsz - i);
> +    }
> +}
> +
