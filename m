Received: from eggs.gnu.org ([2001:4830:134:3::10]:44896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gC4ut-0004zL-KF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gC4un-0006VB-4B
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:36:23 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:33237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gC4uk-0006Tr-6D
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:36:14 -0400
Date: Mon, 15 Oct 2018 17:36:10 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181015153610.GA2364@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Philippe,

> That's true it is not reachable, it lacks the INSN_R3900 definition,
> used by the R3900 mips_def_t.
> 
> I'll stop bothering with this until the code is reachable (my branch posted).

I would be happy if your patch could be merged soon. Adding the following
five lines to it would make both MADD and MADDU immediately reachable and
testable, at least for the R5900 to begin with:

--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -22768,6 +22768,11 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     switch (op1) {
     case OPC_MADD: /* Multiply and add/sub */
     case OPC_MADDU:
+        if (ctx->insn_flags & INSN_R5900) {
+            gen_mul_txx9(ctx, op1, 0, rd, rs, rt);
+            break;
+        }
+        /* Fallthrough */
     case OPC_MSUB:
     case OPC_MSUBU:
         check_insn(ctx, ISA_MIPS32);

> To be able to use the 64-bit result we need to use tcg_gen_mul_i64().

tcg_gen_muls2_i32 produces a 64-bit result in two 32-bit registers, and
tcg_gen_add2_i32 seems to correspond to adding such registers. And then
tcg_gen_ext_i32_tl could be used to extend the results to 64 bits. Look
at the cases for MULT and MULTU, since they are very similar.

Fredrik
