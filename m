Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFok-0004Ef-Vs
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFog-00041H-Su
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:02 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFof-00040D-Ai
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:38:58 -0400
Date: Sun, 21 Oct 2018 17:38:49 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <d32c7913a5cd924bb58e05af4860e31c0808516c.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 19/38] target/mips: Support R5900 MFLO1,
 MTLO1, MFHI1 and MTHI1
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
 target/mips/translate.c | 23 +++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index ae72059c46..e86a2b8764 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2594,8 +2594,10 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mfdr",    "t,G",	0x7000003d, 0xffe007ff,	LCD|WR_t|RD_C0,		0,		N5      },
 {"mfhi",    "d",	0x00000010, 0xffff07ff,	WR_d|RD_HI,		0,		I1	},
 {"mfhi",    "d,9",	0x00000010, 0xff9f07ff, WR_d|RD_HI,		0,		D32	},
+{"mfhi1",   "d",        0x70000010, 0xffff07ff, WR_d|RD_HI,             0,              EE      },
 {"mflo",    "d",	0x00000012, 0xffff07ff,	WR_d|RD_LO,		0,		I1	},
 {"mflo",    "d,9",	0x00000012, 0xff9f07ff, WR_d|RD_LO,		0,		D32	},
+{"mflo1",   "d",        0x70000012, 0xffff07ff, WR_d|RD_LO,             0,              EE      },
 {"mflhxu",  "d",	0x00000052, 0xffff07ff,	WR_d|MOD_HILO,		0,		SMT	},
 {"min.ob",  "X,Y,Q",	0x78000006, 0xfc20003f,	WR_D|RD_S|RD_T|FP_D,	0,		MX|SB1	},
 {"min.ob",  "D,S,T",	0x4ac00006, 0xffe0003f,	WR_D|RD_S|RD_T,		0,		N54	},
@@ -2661,8 +2663,10 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"mtdr",    "t,G",	0x7080003d, 0xffe007ff,	COD|RD_t|WR_C0,		0,		N5	},
 {"mthi",    "s",	0x00000011, 0xfc1fffff,	RD_s|WR_HI,		0,		I1	},
 {"mthi",    "s,7",	0x00000011, 0xfc1fe7ff, RD_s|WR_HI,		0,		D32	},
+{"mthi1",   "s",        0x70000011, 0xfc1fffff, RD_s|WR_HI,             0,              EE      },
 {"mtlo",    "s",	0x00000013, 0xfc1fffff,	RD_s|WR_LO,		0,		I1	},
 {"mtlo",    "s,7",	0x00000013, 0xfc1fe7ff, RD_s|WR_LO,		0,		D32	},
+{"mtlo1",   "s",        0x70000013, 0xfc1fffff, RD_s|WR_LO,             0,              EE      },
 {"mtlhx",   "s",	0x00000053, 0xfc1fffff,	RD_s|MOD_HILO,		0,		SMT	},
 {"mttc0",   "t,G",	0x41800000, 0xffe007ff, TRAP|COD|RD_t|WR_C0|WR_CC, 0,		MT32	},
 {"mttc0",   "t,+D",	0x41800000, 0xffe007f8, TRAP|COD|RD_t|WR_C0|WR_CC, 0,		MT32	},
diff --git a/target/mips/translate.c b/target/mips/translate.c
index df69fa0e9f..2cff740bac 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4229,17 +4229,21 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
 /* Arithmetic on HI/LO registers */
 static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
 {
-    if (reg == 0 && (opc == OPC_MFHI || opc == OPC_MFLO)) {
+    if (reg == 0 && (opc == OPC_MFHI || opc == TX79_MMI_MFHI1 ||
+                     opc == OPC_MFLO || opc == TX79_MMI_MFLO1)) {
         /* Treat as NOP. */
         return;
     }
 
     if (acc != 0) {
-        check_dsp(ctx);
+        if (!(ctx->insn_flags & INSN_R5900)) {
+            check_dsp(ctx);
+        }
     }
 
     switch (opc) {
     case OPC_MFHI:
+    case TX79_MMI_MFHI1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
@@ -4250,6 +4254,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MFLO:
+    case TX79_MMI_MFLO1:
 #if defined(TARGET_MIPS64)
         if (acc != 0) {
             tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
@@ -4260,6 +4265,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTHI:
+    case TX79_MMI_MTHI1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -4274,6 +4280,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc, int acc, int reg)
         }
         break;
     case OPC_MTLO:
+    case TX79_MMI_MTLO1:
         if (reg != 0) {
 #if defined(TARGET_MIPS64)
             if (acc != 0) {
@@ -24658,13 +24665,17 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
+    case TX79_MMI_MTLO1:
+    case TX79_MMI_MTHI1:
+        gen_HILO(ctx, opc, 1, rs);
+        break;
+    case TX79_MMI_MFLO1:
+    case TX79_MMI_MFHI1:
+        gen_HILO(ctx, opc, 1, rd);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MFHI1:         /* TODO: TX79_MMI_MFHI1 */
-    case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
-    case TX79_MMI_MFLO1:         /* TODO: TX79_MMI_MFLO1 */
-    case TX79_MMI_MTLO1:         /* TODO: TX79_MMI_MTLO1 */
     case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
     case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-- 
2.18.1
