Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5WjH-00037C-3T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5WjD-00023P-3W
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:16:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5WjC-00022i-SR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:16:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id o4so2590902qkb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:16:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170501221046.9369-1-aurelien@aurel32.net>
	<20170501221046.9369-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <679953aa-5a89-1d48-b623-f0d17340c02d@amsat.org>
Date: Tue, 2 May 2017 09:16:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170501221046.9369-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] target/sh4: split ctx->flags into
 ctx->tbflags and ctx->envflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

Hi Aurelien,

On 05/01/2017 07:10 PM, Aurelien Jarno wrote:
> There is a confusion (and not only in the SH4 target) between tb->flags,
> env->flags and ctx->flags. To avoid it, split ctx->flags into
> ctx->tbflags and ctx->envflags. ctx->tbflags stays unchanged during the
> whole TB translation, while ctx->envflags evolves and is kept in sync
> with env->flags using TCG instructions. ctx->envflags now only contains
> the part that of env->flags that is contained in the TB state, i.e. the
> DELAY_SLOT* flags.

I agree with your split, but I'd rather put the 2nd part of your commit 
description as comments in the struct DisasContext declaration, if you 
mind :)

>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/sh4/translate.c | 161 +++++++++++++++++++++++++------------------------
>  1 file changed, 82 insertions(+), 79 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index c89a14733f..0b16ff33ea 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -37,7 +37,8 @@ typedef struct DisasContext {
>      struct TranslationBlock *tb;
>      target_ulong pc;
>      uint16_t opcode;
> -    uint32_t flags;
> +    uint32_t tbflags;
> +    uint32_t envflags;
>      int bstate;
>      int memidx;
>      uint32_t delayed_pc;
> @@ -49,7 +50,7 @@ typedef struct DisasContext {
>  #if defined(CONFIG_USER_ONLY)
>  #define IS_USER(ctx) 1
>  #else
> -#define IS_USER(ctx) (!(ctx->flags & (1u << SR_MD)))
> +#define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
>  #endif
>
>  enum {
> @@ -317,51 +318,50 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
>  #define B11_8 ((ctx->opcode >> 8) & 0xf)
>  #define B15_12 ((ctx->opcode >> 12) & 0xf)
>
> -#define REG(x) ((x) < 8 && (ctx->flags & (1u << SR_MD))\
> -                        && (ctx->flags & (1u << SR_RB))\
> +#define REG(x) ((x) < 8 && (ctx->tbflags & (1u << SR_MD))\
> +                        && (ctx->tbflags & (1u << SR_RB))\
>                  ? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
>
> -#define ALTREG(x) ((x) < 8 && (!(ctx->flags & (1u << SR_MD))\
> -                               || !(ctx->flags & (1u << SR_RB)))\
> +#define ALTREG(x) ((x) < 8 && (!(ctx->tbflags & (1u << SR_MD))\
> +                               || !(ctx->tbflags & (1u << SR_RB)))\
>  		? (cpu_gregs[x + 16]) : (cpu_gregs[x]))
>
> -#define FREG(x) (ctx->flags & FPSCR_FR ? (x) ^ 0x10 : (x))
> +#define FREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
>  #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
> -#define XREG(x) (ctx->flags & FPSCR_FR ? XHACK(x) ^ 0x10 : XHACK(x))
> +#define XREG(x) (ctx->tbflags & FPSCR_FR ? XHACK(x) ^ 0x10 : XHACK(x))
>  #define DREG(x) FREG(x) /* Assumes lsb of (x) is always 0 */
>
>  #define CHECK_NOT_DELAY_SLOT \
> -  if (ctx->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL))     \
> -  {                                                           \
> -      tcg_gen_movi_i32(cpu_pc, ctx->pc);                      \
> -      gen_helper_raise_slot_illegal_instruction(cpu_env);     \
> -      ctx->bstate = BS_BRANCH;                                \
> -      return;                                                 \
> -  }
> -
> -#define CHECK_PRIVILEGED                                        \
> -  if (IS_USER(ctx)) {                                           \
> -      tcg_gen_movi_i32(cpu_pc, ctx->pc);                        \
> -      if (ctx->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> -          gen_helper_raise_slot_illegal_instruction(cpu_env);   \
> -      } else {                                                  \
> -          gen_helper_raise_illegal_instruction(cpu_env);        \
> -      }                                                         \
> -      ctx->bstate = BS_BRANCH;                                  \
> -      return;                                                   \
> -  }
> -
> -#define CHECK_FPU_ENABLED                                       \
> -  if (ctx->flags & (1u << SR_FD)) {                             \
> -      tcg_gen_movi_i32(cpu_pc, ctx->pc);                        \
> -      if (ctx->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> -          gen_helper_raise_slot_fpu_disable(cpu_env);           \
> -      } else {                                                  \
> -          gen_helper_raise_fpu_disable(cpu_env);                \
> -      }                                                         \
> -      ctx->bstate = BS_BRANCH;                                  \
> -      return;                                                   \
> -  }
> +    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {     \
> +        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
> +        gen_helper_raise_slot_illegal_instruction(cpu_env);          \
> +        ctx->bstate = BS_BRANCH;                                     \
> +        return;                                                      \
> +    }
> +
> +#define CHECK_PRIVILEGED                                             \
> +    if (IS_USER(ctx)) {                                              \
> +        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
> +        if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> +            gen_helper_raise_slot_illegal_instruction(cpu_env);      \
> +        } else {                                                     \
> +            gen_helper_raise_illegal_instruction(cpu_env);           \
> +        }                                                            \
> +        ctx->bstate = BS_BRANCH;                                     \
> +        return;                                                      \
> +    }
> +
> +#define CHECK_FPU_ENABLED                                            \
> +    if (ctx->tbflags & (1u << SR_FD)) {                              \
> +        tcg_gen_movi_i32(cpu_pc, ctx->pc);                           \
> +        if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> +            gen_helper_raise_slot_fpu_disable(cpu_env);              \
> +        } else {                                                     \
> +            gen_helper_raise_fpu_disable(cpu_env);                   \
> +        }                                                            \
> +        ctx->bstate = BS_BRANCH;                                     \
> +        return;                                                      \
> +    }
>
>  static void _decode_opc(DisasContext * ctx)
>  {
> @@ -409,7 +409,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0x000b:		/* rts */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_mov_i32(cpu_delayed_pc, cpu_pr);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x0028:		/* clrmac */
> @@ -431,7 +431,7 @@ static void _decode_opc(DisasContext * ctx)
>  	CHECK_NOT_DELAY_SLOT
>          gen_write_sr(cpu_ssr);
>  	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x0058:		/* sets */
> @@ -498,14 +498,14 @@ static void _decode_opc(DisasContext * ctx)
>  	CHECK_NOT_DELAY_SLOT
>  	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
>  	tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	return;
>      case 0xb000:		/* bsr disp */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
>  	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
>  	tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	return;
>      }
>
> @@ -939,7 +939,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf00c: /* fmov {F,D,X}Rm,{F,D,X}Rn - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_SZ) {
> +        if (ctx->tbflags & FPSCR_SZ) {
>  	    TCGv_i64 fp = tcg_temp_new_i64();
>  	    gen_load_fpr64(fp, XREG(B7_4));
>  	    gen_store_fpr64(fp, XREG(B11_8));
> @@ -950,7 +950,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf00a: /* fmov {F,D,X}Rm,@Rn - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_SZ) {
> +        if (ctx->tbflags & FPSCR_SZ) {
>  	    TCGv addr_hi = tcg_temp_new();
>  	    int fr = XREG(B7_4);
>  	    tcg_gen_addi_i32(addr_hi, REG(B11_8), 4);
> @@ -966,7 +966,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf008: /* fmov @Rm,{F,D,X}Rn - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_SZ) {
> +        if (ctx->tbflags & FPSCR_SZ) {
>  	    TCGv addr_hi = tcg_temp_new();
>  	    int fr = XREG(B11_8);
>  	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
> @@ -980,7 +980,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf009: /* fmov @Rm+,{F,D,X}Rn - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_SZ) {
> +        if (ctx->tbflags & FPSCR_SZ) {
>  	    TCGv addr_hi = tcg_temp_new();
>  	    int fr = XREG(B11_8);
>  	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
> @@ -998,7 +998,7 @@ static void _decode_opc(DisasContext * ctx)
>  	CHECK_FPU_ENABLED
>          TCGv addr = tcg_temp_new_i32();
>          tcg_gen_subi_i32(addr, REG(B11_8), 4);
> -        if (ctx->flags & FPSCR_SZ) {
> +        if (ctx->tbflags & FPSCR_SZ) {
>  	    int fr = XREG(B7_4);
>              tcg_gen_qemu_st_i32(cpu_fregs[fr+1], addr, ctx->memidx, MO_TEUL);
>  	    tcg_gen_subi_i32(addr, addr, 4);
> @@ -1015,7 +1015,7 @@ static void _decode_opc(DisasContext * ctx)
>  	{
>  	    TCGv addr = tcg_temp_new_i32();
>  	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
> -            if (ctx->flags & FPSCR_SZ) {
> +            if (ctx->tbflags & FPSCR_SZ) {
>  		int fr = XREG(B11_8);
>                  tcg_gen_qemu_ld_i32(cpu_fregs[fr], addr,
>                                      ctx->memidx, MO_TEUL);
> @@ -1034,7 +1034,7 @@ static void _decode_opc(DisasContext * ctx)
>  	{
>  	    TCGv addr = tcg_temp_new();
>  	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
> -            if (ctx->flags & FPSCR_SZ) {
> +            if (ctx->tbflags & FPSCR_SZ) {
>  		int fr = XREG(B7_4);
>                  tcg_gen_qemu_ld_i32(cpu_fregs[fr], addr,
>                                      ctx->memidx, MO_TEUL);
> @@ -1056,7 +1056,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0xf005: /* fcmp/gt Rm,Rn - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
>  	{
>  	    CHECK_FPU_ENABLED
> -            if (ctx->flags & FPSCR_PR) {
> +            if (ctx->tbflags & FPSCR_PR) {
>                  TCGv_i64 fp0, fp1;
>
>  		if (ctx->opcode & 0x0110)
> @@ -1125,7 +1125,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0xf00e: /* fmac FR0,RM,Rn */
>          {
>              CHECK_FPU_ENABLED
> -            if (ctx->flags & FPSCR_PR) {
> +            if (ctx->tbflags & FPSCR_PR) {
>                  break; /* illegal instruction */
>              } else {
>                  gen_helper_fmac_FT(cpu_fregs[FREG(B11_8)], cpu_env,
> @@ -1162,7 +1162,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0x8f00:		/* bf/s label */
>  	CHECK_NOT_DELAY_SLOT
>  	gen_branch_slot(ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2, 0);
> -	ctx->flags |= DELAY_SLOT_CONDITIONAL;
> +        ctx->envflags |= DELAY_SLOT_CONDITIONAL;
>  	return;
>      case 0x8900:		/* bt label */
>  	CHECK_NOT_DELAY_SLOT
> @@ -1173,7 +1173,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0x8d00:		/* bt/s label */
>  	CHECK_NOT_DELAY_SLOT
>  	gen_branch_slot(ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2, 1);
> -	ctx->flags |= DELAY_SLOT_CONDITIONAL;
> +        ctx->envflags |= DELAY_SLOT_CONDITIONAL;
>  	return;
>      case 0x8800:		/* cmp/eq #imm,R0 */
>          tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, REG(0), B7_0s);
> @@ -1354,14 +1354,14 @@ static void _decode_opc(DisasContext * ctx)
>      case 0x0023:		/* braf Rn */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_addi_i32(cpu_delayed_pc, REG(B11_8), ctx->pc + 4);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x0003:		/* bsrf Rn */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
>  	tcg_gen_add_i32(cpu_delayed_pc, REG(B11_8), cpu_pr);
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x4015:		/* cmp/pl Rn */
> @@ -1377,14 +1377,14 @@ static void _decode_opc(DisasContext * ctx)
>      case 0x402b:		/* jmp @Rn */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x400b:		/* jsr @Rn */
>  	CHECK_NOT_DELAY_SLOT
>  	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
>  	tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
> -	ctx->flags |= DELAY_SLOT;
> +        ctx->envflags |= DELAY_SLOT;
>  	ctx->delayed_pc = (uint32_t) - 1;
>  	return;
>      case 0x400e:		/* ldc Rm,SR */
> @@ -1663,7 +1663,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf02d: /* float FPUL,FRn/DRn - FPSCR: R[PR,Enable.I]/W[Cause,Flag] */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_PR) {
> +        if (ctx->tbflags & FPSCR_PR) {
>  	    TCGv_i64 fp;
>  	    if (ctx->opcode & 0x0100)
>  		break; /* illegal instruction */
> @@ -1678,7 +1678,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf03d: /* ftrc FRm/DRm,FPUL - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_PR) {
> +        if (ctx->tbflags & FPSCR_PR) {
>  	    TCGv_i64 fp;
>  	    if (ctx->opcode & 0x0100)
>  		break; /* illegal instruction */
> @@ -1699,7 +1699,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf05d: /* fabs FRn/DRn */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_PR) {
> +        if (ctx->tbflags & FPSCR_PR) {
>  	    if (ctx->opcode & 0x0100)
>  		break; /* illegal instruction */
>  	    TCGv_i64 fp = tcg_temp_new_i64();
> @@ -1713,7 +1713,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf06d: /* fsqrt FRn */
>  	CHECK_FPU_ENABLED
> -        if (ctx->flags & FPSCR_PR) {
> +        if (ctx->tbflags & FPSCR_PR) {
>  	    if (ctx->opcode & 0x0100)
>  		break; /* illegal instruction */
>  	    TCGv_i64 fp = tcg_temp_new_i64();
> @@ -1731,13 +1731,13 @@ static void _decode_opc(DisasContext * ctx)
>  	break;
>      case 0xf08d: /* fldi0 FRn - FPSCR: R[PR] */
>  	CHECK_FPU_ENABLED
> -        if (!(ctx->flags & FPSCR_PR)) {
> +        if (!(ctx->tbflags & FPSCR_PR)) {
>  	    tcg_gen_movi_i32(cpu_fregs[FREG(B11_8)], 0);
>  	}
>  	return;
>      case 0xf09d: /* fldi1 FRn - FPSCR: R[PR] */
>  	CHECK_FPU_ENABLED
> -        if (!(ctx->flags & FPSCR_PR)) {
> +        if (!(ctx->tbflags & FPSCR_PR)) {
>  	    tcg_gen_movi_i32(cpu_fregs[FREG(B11_8)], 0x3f800000);
>  	}
>  	return;
> @@ -1761,7 +1761,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf0ed: /* fipr FVm,FVn */
>          CHECK_FPU_ENABLED
> -        if ((ctx->flags & FPSCR_PR) == 0) {
> +        if ((ctx->tbflags & FPSCR_PR) == 0) {
>              TCGv m, n;
>              m = tcg_const_i32((ctx->opcode >> 8) & 3);
>              n = tcg_const_i32((ctx->opcode >> 10) & 3);
> @@ -1774,7 +1774,7 @@ static void _decode_opc(DisasContext * ctx)
>      case 0xf0fd: /* ftrv XMTRX,FVn */
>          CHECK_FPU_ENABLED
>          if ((ctx->opcode & 0x0300) == 0x0100 &&
> -            (ctx->flags & FPSCR_PR) == 0) {
> +            (ctx->tbflags & FPSCR_PR) == 0) {
>              TCGv n;
>              n = tcg_const_i32((ctx->opcode >> 10) & 3);
>              gen_helper_ftrv(cpu_env, n);
> @@ -1789,7 +1789,7 @@ static void _decode_opc(DisasContext * ctx)
>      fflush(stderr);
>  #endif
>      tcg_gen_movi_i32(cpu_pc, ctx->pc);
> -    if (ctx->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> +    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
>          gen_helper_raise_slot_illegal_instruction(cpu_env);
>      } else {
>          gen_helper_raise_illegal_instruction(cpu_env);
> @@ -1799,20 +1799,20 @@ static void _decode_opc(DisasContext * ctx)
>
>  static void decode_opc(DisasContext * ctx)
>  {
> -    uint32_t old_flags = ctx->flags;
> +    uint32_t old_flags = ctx->envflags;
>
>      _decode_opc(ctx);
>
>      if (old_flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> -        if (ctx->flags & DELAY_SLOT_CLEARME) {
> +        if (ctx->envflags & DELAY_SLOT_CLEARME) {
>              gen_store_flags(0);
>          } else {
>  	    /* go out of the delay slot */
> -	    uint32_t new_flags = ctx->flags;
> +            uint32_t new_flags = ctx->envflags;
>  	    new_flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
>  	    gen_store_flags(new_flags);
>          }
> -        ctx->flags = 0;
> +        ctx->envflags = 0;
>          ctx->bstate = BS_BRANCH;
>          if (old_flags & DELAY_SLOT_CONDITIONAL) {
>  	    gen_delayed_conditional_jump(ctx);
> @@ -1823,8 +1823,9 @@ static void decode_opc(DisasContext * ctx)
>      }
>
>      /* go into a delay slot */
> -    if (ctx->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL))
> -        gen_store_flags(ctx->flags);
> +    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> +        gen_store_flags(ctx->envflags);
> +    }
>  }
>
>  void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
> @@ -1838,16 +1839,18 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>
>      pc_start = tb->pc;
>      ctx.pc = pc_start;
> -    ctx.flags = (uint32_t)tb->flags;
> +    ctx.tbflags = (uint32_t)tb->flags;
> +    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL |
> +                                DELAY_SLOT_CLEARME);
>      ctx.bstate = BS_NONE;
> -    ctx.memidx = (ctx.flags & (1u << SR_MD)) == 0 ? 1 : 0;
> +    ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
>      /* We don't know if the delayed pc came from a dynamic or static branch,
>         so assume it is a dynamic branch.  */
>      ctx.delayed_pc = -1; /* use delayed pc from env pointer */
>      ctx.tb = tb;
>      ctx.singlestep_enabled = cs->singlestep_enabled;
>      ctx.features = env->features;
> -    ctx.has_movcal = (ctx.flags & TB_FLAG_PENDING_MOVCA);
> +    ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
>
>      num_insns = 0;
>      max_insns = tb->cflags & CF_COUNT_MASK;
> @@ -1860,7 +1863,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>
>      gen_tb_start(tb);
>      while (ctx.bstate == BS_NONE && !tcg_op_buf_full()) {
> -        tcg_gen_insn_start(ctx.pc, ctx.flags);
> +        tcg_gen_insn_start(ctx.pc, ctx.envflags);
>          num_insns++;
>
>          if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
> @@ -1904,8 +1907,8 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>              /* gen_op_interrupt_restart(); */
>              /* fall through */
>          case BS_NONE:
> -            if (ctx.flags) {
> -                gen_store_flags(ctx.flags | DELAY_SLOT_CLEARME);
> +            if (ctx.envflags) {
> +                gen_store_flags(ctx.envflags | DELAY_SLOT_CLEARME);
>  	    }
>              gen_goto_tb(&ctx, 0, ctx.pc);
>              break;
>
