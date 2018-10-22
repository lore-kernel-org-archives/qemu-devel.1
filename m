Received: from eggs.gnu.org ([2001:4830:134:3::10]:49014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEdvs-0007db-GC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 13:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEdvp-00029R-5t
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 13:24:00 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:49220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEdvl-00024k-9e
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 13:23:54 -0400
Date: Mon, 22 Oct 2018 19:23:43 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181022172343.GB2331@sx9>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Many thanks, Aleksandar,

> I added ASE_MMI flag along with INSN_R5900, I think this fits better in
> the overall MIPS for QEMU design.

Maciej -- can we add "MMI" under "ASEs implemented" in the kernel too,
even if it is a vendor-specific architecture extension that normally
isn't counted as an ASE? QEMU simply calls these "vendor specific ASEs".

Aleksandar -- please or ASE_MMI to insn_flags here:

--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -466,7 +466,7 @@ const mips_def_t mips_defs[] =
 #endif /* !CONFIG_USER_ONLY */
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_R5900,
+        .insn_flags = CPU_R5900 | ASE_MMI,
         .mmu_type = MMU_TYPE_R4000,
     },
     {

Strictly speaking, MADD, MADDU, MULT, MULTU, MULT1, MULTU1, DIV1, DIVU1,
MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1 are not part of what the
Toshiba TX System RISC TX79 Core Architecture manual specifies as
"Multimedia Instructions", section B.3.2, on page B-3, even though
their opcodes are covered by TX79_CLASS_MMI and the decode_tx79_mmi
function. Can we adjust ASE_MMI for QEMU accordingly?

Also, doesn't it make sense to cover LQ and SQ with ASE_MMI as well, as
those two really are MMIs?

Finally, as far as I know, the MMIs cannot be disabled on R5900 hardware.

--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26099,7 +26099,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SPECIAL3:
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_tx79_sq(env, ctx);    /* TX79_SQ */
         } else {
             decode_opc_special3(env, ctx);
@@ -26763,7 +26763,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MSA: /* OPC_MDMX */
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_tx79_lq(env, ctx);    /* TX79_LQ */
         } else {
             /* MDMX: Not implemented. */

> I experienced some build errors (see the end of this mail), so I had to
> exclude some patches, but all others are fine, and had my "Reviewed-by".
> 32 patches will be included in the next MIPS queue.

Ah, I didn't test the 64-bit build on the MADD[U][1] instructions. I will
look into them and post updated patches.

Regarding the R5900 FPU: It appears reasonable to introduce an ELF ABI
variant for the nonstandard R5900 FPU. A testsuite covering the anomalies
seems to be needed as well. Careful verification on hardware is needed.
I think it's probably best to keep the R5900 FPU disabled in QEMU until
these things have been sorted out.

I discovered that I lost the disassembly of MULT1 and MULTU1 in v8, as
shown in the attached patch below. This small change belongs to commit
bebf09ef3977 ("target/mips: Support R5900 three-operand MULT1 and MULTU1
instructions") in your tags/mips-queue-oct-2018-part-2. Please apply:

--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2736,10 +2736,14 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mult",    "s,t",      0x00000018, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, 0,		I1	},
 {"mult",    "7,s,t",	0x00000018, 0xfc00e7ff, WR_a|RD_s|RD_t,         0,              D33	},
 {"mult",    "d,s,t",    0x00000018, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"mult1",   "s,t",      0x70000018, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"mult1",   "d,s,t",    0x70000018, 0xfc0007ff, WR_d | RD_s | RD_t | WR_HILO | IS_M, 0, EE },
 {"multp",   "s,t",	0x00000459, 0xfc00ffff,	RD_s|RD_t|MOD_HILO,	0,		SMT	},
 {"multu",   "s,t",      0x00000019, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, 0,		I1	},
 {"multu",   "7,s,t",	0x00000019, 0xfc00e7ff, WR_a|RD_s|RD_t,         0,              D33	},
 {"multu",   "d,s,t",    0x00000019, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"multu1",  "s,t",      0x70000019, 0xfc00ffff, RD_s | RD_t | WR_HILO | IS_M, 0, EE },
+{"multu1",  "d,s,t",    0x70000019, 0xfc0007ff, WR_d | RD_s | RD_t | WR_HILO | IS_M, 0, EE },
 {"mulu",    "d,s,t",	0x00000059, 0xfc0007ff,	RD_s|RD_t|WR_HILO|WR_d,	0,		N5	},
 {"neg",     "d,w",	0x00000022, 0xffe007ff,	WR_d|RD_t,		0,		I1	}, /* sub 0 */
 {"negu",    "d,w",	0x00000023, 0xffe007ff,	WR_d|RD_t,		0,		I1	}, /* subu 0 */

Fredrik
