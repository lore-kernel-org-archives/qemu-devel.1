Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJjMm-0003Vz-Tp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJjMk-0006tP-7N
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:12:48 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:33442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gJjMj-0006sa-R7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:12:46 -0500
Date: Mon, 5 Nov 2018 19:12:42 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181105181242.GB2383@sx9>
References: <cover.1541174426.git.noring@nocrew.org>
	<BN6PR2201MB1251AFA493032E33B49A5376C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251AFA493032E33B49A5376C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Fix decoding mechanisms
 of R5900 M{F, T}{HI, LO}1 and DIV[U]1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Thank you for your review, Aleksandar,

> For LL, SC, LLD and SCD instructions, there is a need to properly insulate
> their R5900 versions too, similar to this:
> 
>     case OPC_SC:
>         if(ctx->insn_flags & INSN_R5900) {
>              check_insn_opc_user_only(ctx, INSN_R5900);
>         } else {
>             check_insn(ctx, ISA_MIPS2);
>         }
>         gen_st_cond(ctx, op, rt, rs, imm);
>         break;

Would you accept the simplification to omit the else clause? Like this:

    case OPC_SC:
        if (ctx->insn_flags & INSN_R5900) {
            check_insn_opc_user_only(ctx, INSN_R5900);
        }
        check_insn(ctx, ISA_MIPS2);
        check_insn_opc_removed(ctx, ISA_MIPS32R6);
        gen_st_cond(ctx, op, rt, rs, imm);
        break;

The code will, of course, expand into a double-check of INSN_R5900:

        if (ctx->insn_flags & INSN_R5900) {
#ifndef CONFIG_USER_ONLY
            if (unlikely(ctx->insn_flags & INSN_R5900)) {
                generate_exception_end(ctx, EXCP_RI);
            }
#endif
        }

> (the code above is just a form of pseudocode illustrating the idea; I
> don't guarantee the correctness for build purposes, or if this is the best
> code organization)
> 
> Non-R5900 code (for the time being) should never invoke
> check_insn_opc_user_only(). *The only way* of distinguishing R5900 code
> paths from the other CPUs code paths should be by using
> "if(ctx->insn_flags & INSN_R5900)"!

OK.

> For changes in decode_opc_special_legacy(), there shouldn't be there, but
> there should be a separate function decode_opc_special_tx59() or so.

Sure, I will copy the 82 line function then, and patch the following:

--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23904,7 +23904,7 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MOVN:         /* Conditional move */
     case OPC_MOVZ:
         check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_LOONGSON2E | INSN_LOONGSON2F | INSN_R5900);
+                   INSN_LOONGSON2E | INSN_LOONGSON2F);
         gen_cond_move(ctx, op1, rd, rs, rt);
         break;
     case OPC_MFHI:          /* Move from HI/LO */
@@ -23931,8 +23931,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, INSN_VR54XX);
             op1 = MASK_MUL_VR54XX(ctx->opcode);
             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
-        } else if (ctx->insn_flags & INSN_R5900) {
-            gen_mul_txx9(ctx, op1, rd, rs, rt);
         } else {
             gen_muldiv(ctx, op1, rd & 3, rs, rt);
         }
@@ -23947,7 +23945,6 @@ static void decode_opc_special_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DDIV:
     case OPC_DDIVU:
         check_insn(ctx, ISA_MIPS3);
-        check_insn_opc_user_only(ctx, INSN_R5900);
         check_mips_64(ctx);
         gen_muldiv(ctx, op1, 0, rs, rt);
         break;

Fredrik
