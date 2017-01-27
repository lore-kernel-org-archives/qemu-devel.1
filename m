Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7rq-0000hM-7z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7ro-0000C0-3j
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:51:10 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX7rn-0000Bh-QQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:51:08 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c206so141740702wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:51:07 -0800 (PST)
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-11-git-send-email-batuzovk@ispras.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484644078-21312-11-git-send-email-batuzovk@ispras.ru>
Date: Fri, 27 Jan 2017 14:51:04 +0000
Message-ID: <87sho48skn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/18] tcg/i386: add support for vector
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Kirill Batuzov <batuzovk@ispras.ru> writes:

> To be able to generate vector operations in a TCG backend we need to do
> several things.
>
> 1. We need to tell the register allocator about vector target's register.
>    In case of x86 we'll use xmm0..xmm7. xmm7 is designated as a scratch
>    register, others can be used by the register allocator.
>
> 2. We need a new constraint to indicate where to use vector registers. In
>    this commit the 'V' constraint is introduced.
>
> 3. We need to be able to generate bare minimum: load, store and reg-to-reg
>    move. MOVDQU is used for loads and stores. MOVDQA is used for reg-to-reg
>    moves.
>
> 4. Finally we need to support any other opcodes we want. INDEX_op_add_i32x4
>    is the only one for now. The PADDD instruction handles it perfectly.
>
> Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>

This currently fails to apply cleanly to master because of other updates
however I see you have changes to make so I assume you'll re-base then ;-)

> ---
>  tcg/i386/tcg-target.h     |  24 +++++++++-
>  tcg/i386/tcg-target.inc.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 125 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 524cfc6..974a58b 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -29,8 +29,14 @@
>  #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
>
>  #ifdef __x86_64__
> -# define TCG_TARGET_REG_BITS  64
> -# define TCG_TARGET_NB_REGS   16
> +# define TCG_TARGET_HAS_REG128 1
> +# ifdef TCG_TARGET_HAS_REG128
> +#  define TCG_TARGET_REG_BITS  64
> +#  define TCG_TARGET_NB_REGS   24
> +# else
> +#  define TCG_TARGET_REG_BITS  64
> +#  define TCG_TARGET_NB_REGS   16
> +# endif
>  #else
>  # define TCG_TARGET_REG_BITS  32
>  # define TCG_TARGET_NB_REGS    8
> @@ -56,6 +62,16 @@ typedef enum {
>      TCG_REG_R13,
>      TCG_REG_R14,
>      TCG_REG_R15,
> +#ifdef TCG_TARGET_HAS_REG128
> +    TCG_REG_XMM0,
> +    TCG_REG_XMM1,
> +    TCG_REG_XMM2,
> +    TCG_REG_XMM3,
> +    TCG_REG_XMM4,
> +    TCG_REG_XMM5,
> +    TCG_REG_XMM6,
> +    TCG_REG_XMM7,
> +#endif
>      TCG_REG_RAX = TCG_REG_EAX,
>      TCG_REG_RCX = TCG_REG_ECX,
>      TCG_REG_RDX = TCG_REG_EDX,
> @@ -133,6 +149,10 @@ extern bool have_bmi1;
>  #define TCG_TARGET_HAS_mulsh_i64        0
>  #endif
>
> +#ifdef TCG_TARGET_HAS_REG128
> +#define TCG_TARGET_HAS_add_i32x4        1
> +#endif
> +
>  #define TCG_TARGET_deposit_i32_valid(ofs, len) \
>      (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
>       ((ofs) == 0 && (len) == 16))
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index eeb1777..69e3198 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -32,6 +32,9 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
>  #else
>      "%eax", "%ecx", "%edx", "%ebx", "%esp", "%ebp", "%esi", "%edi",
>  #endif
> +#ifdef TCG_TARGET_HAS_REG128
> +    "%xmm0", "%xmm1", "%xmm2", "%xmm3", "%xmm4", "%xmm5", "%xmm6", "%xmm7",
> +#endif
>  };
>  #endif
>
> @@ -61,6 +64,16 @@ static const int tcg_target_reg_alloc_order[] = {
>      TCG_REG_EDX,
>      TCG_REG_EAX,
>  #endif
> +#ifdef TCG_TARGET_HAS_REG128
> +    TCG_REG_XMM0,
> +    TCG_REG_XMM1,
> +    TCG_REG_XMM2,
> +    TCG_REG_XMM3,
> +    TCG_REG_XMM4,
> +    TCG_REG_XMM5,
> +    TCG_REG_XMM6,
> +/*  TCG_REG_XMM7, <- scratch register */
> +#endif
>  };
>
>  static const int tcg_target_call_iarg_regs[] = {
> @@ -247,6 +260,10 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
>      case 'I':
>          ct->ct |= TCG_CT_CONST_I32;
>          break;
> +    case 'V':
> +        ct->ct |= TCG_CT_REG;
> +        tcg_regset_set32(ct->u.regs, 0, 0xff0000);
> +        break;
>
>      default:
>          return -1;
> @@ -301,6 +318,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
>  #define P_SIMDF3        0x10000         /* 0xf3 opcode prefix */
>  #define P_SIMDF2        0x20000         /* 0xf2 opcode prefix */
>
> +#define P_SSE_660F      (P_DATA16 | P_EXT)
> +#define P_SSE_F30F      (P_SIMDF3 | P_EXT)
> +
>  #define OPC_ARITH_EvIz	(0x81)
>  #define OPC_ARITH_EvIb	(0x83)
>  #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
> @@ -351,6 +371,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
>  #define OPC_GRP3_Ev	(0xf7)
>  #define OPC_GRP5	(0xff)
>
> +#define OPC_MOVDQU_M2R  (0x6f | P_SSE_F30F)  /* store 128-bit value */
> +#define OPC_MOVDQU_R2M  (0x7f | P_SSE_F30F)  /* load 128-bit value */
> +#define OPC_MOVDQA_R2R  (0x6f | P_SSE_660F)  /* reg-to-reg 128-bit mov */
> +#define OPC_PADDD       (0xfe | P_SSE_660F)
> +
>  /* Group 1 opcode extensions for 0x80-0x83.
>     These are also used as modifiers for OPC_ARITH.  */
>  #define ARITH_ADD 0
> @@ -428,6 +453,9 @@ static void tcg_out_opc(TCGContext *s, int opc, int r, int rm, int x)
>          tcg_debug_assert((opc & P_REXW) == 0);
>          tcg_out8(s, 0x66);
>      }
> +    if (opc & P_SIMDF3) {
> +        tcg_out8(s, 0xf3);
> +    }
>      if (opc & P_ADDR32) {
>          tcg_out8(s, 0x67);
>      }
> @@ -634,9 +662,24 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
>  static inline void tcg_out_mov(TCGContext *s, TCGType type,
>                                 TCGReg ret, TCGReg arg)
>  {
> +    int opc;
>      if (arg != ret) {
> -        int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> -        tcg_out_modrm(s, opc, ret, arg);
> +        switch (type) {
> +#ifdef TCG_TARGET_HAS_REG128
> +        case TCG_TYPE_V128:
> +            ret -= TCG_REG_XMM0;
> +            arg -= TCG_REG_XMM0;
> +            tcg_out_modrm(s, OPC_MOVDQA_R2R, ret, arg);
> +            break;
> +#endif
> +        case TCG_TYPE_I32:
> +        case TCG_TYPE_I64:
> +            opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> +            tcg_out_modrm(s, opc, ret, arg);
> +            break;
> +        default:
> +            assert(0);
> +        }
>      }
>  }
>
> @@ -711,15 +754,43 @@ static inline void tcg_out_pop(TCGContext *s, int reg)
>  static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
>                                TCGReg arg1, intptr_t arg2)
>  {
> -    int opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> -    tcg_out_modrm_offset(s, opc, ret, arg1, arg2);
> +    int opc;
> +    switch (type) {
> +#ifdef TCG_TARGET_HAS_REG128
> +    case TCG_TYPE_V128:
> +        ret -= TCG_REG_XMM0;
> +        tcg_out_modrm_offset(s, OPC_MOVDQU_M2R, ret, arg1, arg2);
> +        break;
> +#endif
> +    case TCG_TYPE_I32:
> +    case TCG_TYPE_I64:
> +        opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> +        tcg_out_modrm_offset(s, opc, ret, arg1, arg2);
> +        break;
> +    default:
> +        assert(0);
> +    }
>  }
>
>  static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
>                                TCGReg arg1, intptr_t arg2)
>  {
> -    int opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> -    tcg_out_modrm_offset(s, opc, arg, arg1, arg2);
> +    int opc;
> +    switch (type) {
> +#ifdef TCG_TARGET_HAS_REG128
> +    case TCG_TYPE_V128:
> +        arg -= TCG_REG_XMM0;
> +        tcg_out_modrm_offset(s, OPC_MOVDQU_R2M, arg, arg1, arg2);
> +        break;
> +#endif
> +    case TCG_TYPE_I32:
> +    case TCG_TYPE_I64:
> +        opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
> +        tcg_out_modrm_offset(s, opc, arg, arg1, arg2);
> +        break;
> +    default:
> +        assert(0);
> +    }
>  }
>
>  static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
> @@ -1856,6 +1927,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>      case INDEX_op_ld_i32:
>          tcg_out_ld(s, TCG_TYPE_I32, args[0], args[1], args[2]);
>          break;
> +#ifdef TCG_TARGET_HAS_REG128
> +    case INDEX_op_ld_v128:
> +        tcg_out_ld(s, TCG_TYPE_V128, args[0], args[1], args[2]);
> +        break;
> +#endif
>
>      OP_32_64(st8):
>          if (const_args[0]) {
> @@ -1888,6 +1964,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>              tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
>          }
>          break;
> +#ifdef TCG_TARGET_HAS_REG128
> +    case INDEX_op_st_v128:
> +        tcg_out_st(s, TCG_TYPE_V128, args[0], args[1], args[2]);
> +        break;
> +#endif
>
>      OP_32_64(add):
>          /* For 3-operand addition, use LEA.  */
> @@ -2146,6 +2227,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>      case INDEX_op_mb:
>          tcg_out_mb(s, args[0]);
>          break;
> +
> +#ifdef TCG_TARGET_HAS_REG128
> +    case INDEX_op_add_i32x4:
> +        tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
> +        break;
> +#endif
> +
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
>      case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> @@ -2171,6 +2259,11 @@ static const TCGTargetOpDef x86_op_defs[] = {
>      { INDEX_op_st16_i32, { "ri", "r" } },
>      { INDEX_op_st_i32, { "ri", "r" } },
>
> +#ifdef TCG_TARGET_HAS_REG128
> +    { INDEX_op_ld_v128, { "V", "r" } },
> +    { INDEX_op_st_v128, { "V", "r" } },
> +#endif
> +
>      { INDEX_op_add_i32, { "r", "r", "ri" } },
>      { INDEX_op_sub_i32, { "r", "0", "ri" } },
>      { INDEX_op_mul_i32, { "r", "0", "ri" } },
> @@ -2289,6 +2382,10 @@ static const TCGTargetOpDef x86_op_defs[] = {
>      { INDEX_op_qemu_ld_i64, { "r", "r", "L", "L" } },
>      { INDEX_op_qemu_st_i64, { "L", "L", "L", "L" } },
>  #endif
> +
> +#ifdef TCG_TARGET_HAS_REG128
> +    { INDEX_op_add_i32x4, { "V", "0", "V" } },
> +#endif
>      { -1 },
>  };


--
Alex Bennée
