Received: from eggs.gnu.org ([2001:4830:134:3::10]:46238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFoy-0004Mx-AT
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFou-00047B-Ri
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:16 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFou-000469-EI
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:12 -0400
Date: Sun, 21 Oct 2018 17:39:03 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <05fe58636a0aa1294f9990a49dfc74ad83c40288.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 20/38] target/mips: Support R5900 DIV1 and
 DIVU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 disas/mips.c            |  4 ++++
 target/mips/translate.c | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index e86a2b8764..79bd119c51 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2323,6 +2323,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"div",     "z,t",      0x0000001a, 0xffe0ffff, RD_s|RD_t|WR_HILO,      0,		I1      },
 {"div",     "d,v,t",	0,    (int) M_DIV_3,	INSN_MACRO,		0,		I1	},
 {"div",     "d,v,I",	0,    (int) M_DIV_3I,	INSN_MACRO,		0,		I1	},
+{"div1",    "z,s,t",    0x7000001a, 0xfc00ffff, RD_s|RD_t|WR_HILO,      0,              EE,     },
+{"div1",    "z,t",      0x7000001a, 0xffe0ffff, RD_s|RD_t|WR_HILO,      0,              EE,     },
 {"div.d",   "D,V,T",	0x46200003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_D,	0,		I1	},
 {"div.s",   "D,V,T",	0x46000003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_S,	0,		I1	},
 {"div.ps",  "D,V,T",	0x46c00003, 0xffe0003f,	WR_D|RD_S|RD_T|FP_D,	0,		SB1	},
@@ -2331,6 +2333,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"divu",    "z,t",      0x0000001b, 0xffe0ffff, RD_s|RD_t|WR_HILO,      0,		I1      },
 {"divu",    "d,v,t",	0,    (int) M_DIVU_3,	INSN_MACRO,		0,		I1	},
 {"divu",    "d,v,I",	0,    (int) M_DIVU_3I,	INSN_MACRO,		0,		I1	},
+{"divu1",   "z,s,t",    0x7000001b, 0xfc00ffff, RD_s|RD_t|WR_HILO,      0,              EE      },
+{"divu1",   "z,t",      0x7000001b, 0xffe0ffff, RD_s|WR_HILO,           0,              EE,     },
 {"dla",     "t,A(b)",	0,    (int) M_DLA_AB,	INSN_MACRO,		0,		I3	},
 {"dlca",    "t,A(b)",	0,    (int) M_DLCA_AB,	INSN_MACRO,		0,		I3	},
 {"dli",     "t,j",      0x24000000, 0xffe00000, WR_t,			0,		I3	}, /* addiu */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2cff740bac..e2ac401d42 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4593,11 +4593,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
     gen_load_gpr(t1, rt);
 
     if (acc != 0) {
-        check_dsp(ctx);
+        if (!(ctx->insn_flags & INSN_R5900)) {
+            check_dsp(ctx);
+        }
     }
 
     switch (opc) {
     case OPC_DIV:
+    case TX79_MMI_DIV1:
         {
             TCGv t2 = tcg_temp_new();
             TCGv t3 = tcg_temp_new();
@@ -4619,6 +4622,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
         }
         break;
     case OPC_DIVU:
+    case TX79_MMI_DIVU1:
         {
             TCGv t2 = tcg_const_tl(0);
             TCGv t3 = tcg_const_tl(1);
@@ -24665,6 +24669,10 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
+    case TX79_MMI_DIV1:
+    case TX79_MMI_DIVU1:
+        gen_muldiv(ctx, opc, 1, rs, rt);
+        break;
     case TX79_MMI_MTLO1:
     case TX79_MMI_MTHI1:
         gen_HILO(ctx, opc, 1, rs);
@@ -24676,8 +24684,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
-    case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
-- 
2.18.1
