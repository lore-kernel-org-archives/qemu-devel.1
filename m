Received: from eggs.gnu.org ([2001:4830:134:3::10]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1g0Bff-0007OW-1z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1g0Bfa-00044y-Gr
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:23:30 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:42224
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1g0Bfa-00042S-5N
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:23:26 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23993060AbeILUXS26Bud (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Wed, 12 Sep 2018 22:23:18 +0200
Date: Wed, 12 Sep 2018 21:23:18 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20180907191619.GA11275@r52>
Message-ID: <alpine.LFD.2.21.1809080119040.19783@eddie.linux-mips.org>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>
	<20180907191619.GA11275@r52>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: Initial support for MIPS
 R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Fredrik,

> Aleksandar, Aurelien, Maciej -- are you happy with this initial v2 patch?

 I have been more thorough on this occasion, and I do hope I have caught 
everything.  See the notes below, in addition to what the others wrote.  

 Please apply to v3 accordingly; I started writing this before you sent 
that version.

> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -62,6 +63,7 @@
>  #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
>  #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
>  #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
> +#define		CPU_R5900	(CPU_MIPS4 | INSN_R5900)

 I think this has to be (CPU_MIPS3 | INSN_R5900) really.

 While the CPU does support MIPS IV MOVN, MOVZ and PREF instructions, 
that's all it has from that ISA.  Even the Tx79, which was supposed to 
have a regular IEEE-754 FPU, did not have the extra FP condition bits, 
MOVN.fmt, MOVZ.fmt or any of the MOVF* or MOVT* instructions, indexed 
load/store instructions, multiply-accumulate instructions, etc. defined.

 So I think the R5900 has to be treated as a MIPS III implementation, with 
some aberrations.  I don't expect it to be a big deal to add INSN_R5900 
qualification to MOVN, MOVZ and PREF instruction emulation code right 
away.

 Then presumably you are going to add emulation for all the missing MIPS 
III instructions to the Linux kernel eventually, to match the MIPS III 
Linux user ABI?  Apart from LLD and SCD discussed previously this will 
have to include DDIV, DDIVU, DMULT and DMULTU.

 Eventually you'll have to remove all these instructions (plus LL and SC) 
from the system emulation mode.  In fact I think it would make sense to do 
that right away, because I believe it will be a reasonably simple update. 
However if it turns out to be a can of worms after all, then I think we 
can defer it, because we do not have a bare-metal environment ready for 
this CPU anyway (or do we?).

> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17357,7 +17382,11 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
>          break;
>      case OPC_MULT:
>      case OPC_MULTU:
> -        if (sa) {
> +        if (ctx->insn_flags & INSN_R5900) {
> +            gen_muldiv(ctx, op1, 0, rs, rt);
> +            if (rd != 0)
> +                gen_mul_r5900(ctx, op1, rd, rs, rt);
> +        } else if (sa) {
>              check_insn(ctx, INSN_VR54XX);
>              op1 = MASK_MUL_VR54XX(ctx->opcode);
>              gen_mul_vr54xx(ctx, op1, rd, rs, rt);

 I think there is no point in executing the multiplication twice if `rd != 
0' and also we want to continue trapping on `sa != 0' for the non-Vr54xx 
case, so how about:

        if (sa) {
            check_insn(ctx, INSN_VR54XX);
            op1 = MASK_MUL_VR54XX(ctx->opcode);
            gen_mul_vr54xx(ctx, op1, rd, rs, rt);
        } else if (rd && (ctx->insn_flags & INSN_R5900)) {
            gen_mul_r5900(ctx, op1, rd, rs, rt);
        } else {
            gen_muldiv(ctx, op1, rd & 3, rs, rt);
        }

?

> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -410,6 +410,50 @@ const mips_def_t mips_defs[] =
>          .insn_flags = CPU_MIPS32R5 | ASE_MSA,
>          .mmu_type = MMU_TYPE_R4000,
>      },
> +    {
> +        .name = "R5900",
> +        .CP0_PRid = 0x00003800,
> +        /* No L2 cache, icache size 32k, dcache size 32k, uncached coherency. */
> +        .CP0_Config0 = (1 << 17) | (0x3 << 9) | (0x3 << 6) | (0x2 << CP0C0_K0),

 Why ICE set but DCE clear?  I guess this corresponds to the incorrect L2 
cache reference as bit #17 is SC on the original R4000.  That reference 
has to go, obviously, as there's no L2 cache indication in the R5900's 
Config register.

 As to ICE and DCE their reset defaults are both 0, so we might as well 
use that, as we don't emulate caches anyway.  If it turns out to matter to 
any software, then we'll have to provide a more correct Config register 
emulation as its writable bits are processor-specific.

> +        /* Note: Config1 is only used internally, the R5900 has only Config0. */
> +        .CP0_Status_rw_bitmask = 0xF4C79C1F,

 Maybe swap the two lines so that the Config1 register reference does not 
confusingly seem to describe the Status r/w bitmask?

> +#ifdef CONFIG_USER_ONLY
> +	/*
> +	 * R5900 hardware traps to the Linux kernel for IEEE 754-1985 and LL/SC
> +	 * emulation. For user-only, qemu is the kernel, so we emulate the traps
> +	 * by simply emulating the instructions directly.
> +	 */

 Please use spaces rather than tabs for indentation, as per QEMU's coding 
standard.

> +        .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
> +        .CP0_LLAddr_rw_bitmask = 0xFFFFFFFF,
> +        .CP0_LLAddr_shift = 4,
> +        .CP1_fcr0 = (0x38 << FCR0_PRID) | (0x0 << FCR0_REV),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0x0183FFFF,
> +#else
> +	/*
> +	 * The R5900 COP1 FPU implements single-precision floating-point
> +	 * operations but is not entirely IEEE 754-1985 compatible. In
> +	 * particular,
> +	 *
> +	 * - NaN (not a number) and plus/minus infinities are not supported;
> +	 * - exception mechanisms are not fully supported;
> +	 * - denormalized numbers are not supported;
> +	 * - rounding towards nearest and plus/minus infinities are not supported;
> +	 * - computed results usually differs in the least significant bit;
> +	 * - saturating instructions can differ more than the least significant bit.
> +	 *
> +	 * Since only rounding towards zero is supported, the two least
> +	 * significant bits of FCR31 are hardwired to 01.
> +	 *
> +	 * FPU emulation is disabled here until it is implemented.
> +	 */
> +        .CP0_Config1 = (47 << CP0C1_MMU),
> +#endif /* CONFIG_USER_ONLY */
> +        .SEGBITS = 19,

 This has to be 32, as with any MIPS CPU that implements 32-bit virtual 
addressing only.  Specifically EntryHi register's VPN2 field goes up to 
bit #31, which is (SEGBITS - 1).

> +        .PABITS = 20,

 And this has to be 32 as well, reflecting EntryLo0/1 registers' PFN 
fields going up to bit #25.  This corresponds to bit #31 on the external 
address bus, which is (PABITS - 1).

  Maciej
