Received: from eggs.gnu.org ([2001:4830:134:3::10]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDfj-0000IN-QI
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDfe-0005C4-Pr
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:31:11 -0500
Received: from bran.ispras.ru ([83.149.199.196]:36688 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eUDfe-00059x-EO
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 10:31:06 -0500
Date: Wed, 27 Dec 2017 18:31:04 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <20171218171758.16964-9-richard.henderson@linaro.org>
Message-ID: <alpine.DEB.2.20.1712271821081.4787@bulbul.intra.ispras.ru>
References: <20171218171758.16964-1-richard.henderson@linaro.org>
	<20171218171758.16964-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v7 08/26] tcg/i386: Add vector operations
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

> The x86 vector instruction set is extremely irregular.  With newer
> editions, Intel has filled in some of the blanks.  However, we don't
> get many 64-bit operations until SSE4.2, introduced in 2009.
> 
> The subsequent edition was for AVX1, introduced in 2011, which added
> three-operand addressing, and adjusts how all instructions should be
> encoded.
> 
> Given the relatively narrow 2 year window between possible to support
> and desirable to support, and to vastly simplify code maintainence,
> I am only planning to support AVX1 and later cpus.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  36 ++-
>  tcg/i386/tcg-target.inc.c | 561 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 546 insertions(+), 51 deletions(-)
> 

> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 63d27f10e7..e9a4d92598 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c

> -static inline void tcg_out_mov(TCGContext *s, TCGType type,
> -                               TCGReg ret, TCGReg arg)
> +static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +{
> +    int rexw = 0;
> +
> +    if (arg == ret) {
> +        return;
> +    }
> +    switch (type) {
> +    case TCG_TYPE_I64:
> +        rexw = P_REXW;
> +        /* fallthru */
> +    case TCG_TYPE_I32:
> +        if (ret < 16) {
> +            if (arg < 16) {
> +                tcg_out_modrm(s, OPC_MOVL_GvEv + rexw, ret, arg);
> +            } else {
> +                tcg_out_vex_modrm(s, OPC_MOVD_EyVy + rexw, ret, 0, arg);
> +            }
> +        } else {
> +            if (arg < 16) {
> +                tcg_out_vex_modrm(s, OPC_MOVD_VyEy + rexw, ret, 0, arg);
> +            } else {
> +                tcg_out_vex_modrm(s, OPC_MOVQ_VqWq, ret, 0, arg);
> +            }
> +        }
> +        break;
> +
> +    case TCG_TYPE_V64:
> +        tcg_debug_assert(ret >= 16 && arg >= 16);
> +        tcg_out_vex_modrm(s, OPC_MOVQ_VqWq, ret, 0, arg);
> +        break;
> +    case TCG_TYPE_V128:
> +        tcg_debug_assert(ret >= 16 && arg >= 16);
> +        tcg_out_vex_modrm(s, OPC_MOVDQA_VxWx, ret, 0, arg);
> +        break;
> +    case TCG_TYPE_V256:
> +        tcg_debug_assert(ret >= 16 && arg >= 16);
> +        tcg_out_vex_modrm(s, OPC_MOVDQA_VxWx | P_VEXL, ret, 0, arg);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

I think something is wrong with instruction encodings here. Looks like
  tcg_out_mov(&tcg_ctx, TCG_TYPE_I64, TCG_REG_EBP, TCG_REG_XMM0)
produces
  vmovq %xmm5, %rax
instead.

Here is the dump.

IN: 
0x00400580:  4e040c41  dup      v1.4s, w2
0x00400584:  4b0203e2  neg      w2, w2
0x00400588:  3d800021  str      q1, [x1]
0x0040058c:  d65f03c0  ret      

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xffffffffffffffec              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0                      dead: 0 1

 ---- 0000000000400580 0000000000000000 0000000000000000
 dup_vec v128,e32,tmp2,x2
 st_vec v128,e8,tmp2,env,$0x8b0                   dead: 0

 ---- 0000000000400584 0000000000000000 0000000000000000
 ext32u_i64 tmp4,x2                               dead: 1
 neg_i64 tmp5,tmp4                                dead: 1
 ext32u_i64 x2,tmp5                               sync: 0  dead: 0 1

<...>

OUT: [size=111]
0x6075bf40:  41 8b 6e ec              movl     -0x14(%r14), %ebp
0x6075bf44:  85 ed                    testl    %ebp, %ebp
0x6075bf46:  0f 8c 59 00 00 00        jl       0x6075bfa5
0x6075bf4c:  c4 c1 7a 7e 46 50        vmovq    0x50(%r14), %xmm0
0x6075bf52:  c5 f9 70 c8 00           vpshufd  $0, %xmm0, %xmm1
0x6075bf57:  c4 c1 7a 7f 8e b0 08 00  vmovdqu  %xmm1, 0x8b0(%r14)
0x6075bf5f:  00
0x6075bf60:  c4 e1 f9 7e e8           vmovq    %xmm5, %rax
0x6075bf65:  8b ed                    movl     %ebp, %ebp
0x6075bf67:  48 f7 dd                 negq     %rbp
0x6075bf6a:  8b ed                    movl     %ebp, %ebp
0x6075bf6c:  49 89 6e 50              movq     %rbp, 0x50(%r14)
<...>

%xmm5 is used uninitialized, there is no move from either %xmm0 or
0x50(%r14) to %ebp, there are two unnecessary movl %ebp, %ebp.

-- 
Kirill
