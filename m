Received: from eggs.gnu.org ([2001:4830:134:3::10]:46477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFq2-0005Dj-Qg
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFpx-0004hb-Q7
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:22 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFpx-0004fo-17
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:40:17 -0400
Date: Sun, 21 Oct 2018 17:40:07 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <d099d2b39c46c6e1ea830c49c49bab46eee96ae9.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 23/38] target/mips: Support R5900
 three-operand MADDU and MADDU1
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
 disas/mips.c            |  2 ++
 target/mips/translate.c | 28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index 242bf68b9c..78c4fb6efa 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2561,6 +2561,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"maddu",   "s,t",      0x70000001, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,		G1	},
 {"maddu",   "7,s,t",	0x70000001, 0xfc00e7ff, MOD_a|RD_s|RD_t,             0,         D33	},
 {"maddu",   "d,s,t",    0x70000001, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"maddu1",  "s,t",      0x70000021, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,         EE      },
+{"maddu1",  "d,s,t",    0x70000021, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,         EE      },
 {"madd16",  "s,t",      0x00000028, 0xfc00ffff, RD_s|RD_t|MOD_HILO,	0,		N411    },
 {"max.ob",  "X,Y,Q",	0x78000007, 0xfc20003f,	WR_D|RD_S|RD_T|FP_D,	0,		MX|SB1	},
 {"max.ob",  "D,S,T",	0x4ac00007, 0xffe0003f,	WR_D|RD_S|RD_T,		0,		N54	},
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 153b7e869a..3977c57a22 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4778,7 +4778,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
 }
 
 /*
- * These MULT[U] and MADD instructions implemented in for example
+ * These MULT[U] and MADD[U] instructions implemented in for example
  * the Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
  * architectures are special three-operand variants with the syntax
  *
@@ -4790,7 +4790,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  *
  * and
  *
- *     MADD[1]    rd, rs, rt
+ *     MADD[U][1] rd, rs, rt
  *
  * such that
  *
@@ -4872,6 +4872,26 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MADDU1:
+        acc = 1;
+        /* Fall through */
+    case TX79_MMI_MADDU:
+        {
+            TCGv_i32 t2 = tcg_temp_new_i32();
+            TCGv_i32 t3 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t2, t0);
+            tcg_gen_trunc_tl_i32(t3, t1);
+            tcg_gen_mulu2_i32(t2, t3, t2, t3);
+            tcg_gen_add2_i32(t2, t3, cpu_LO[acc], cpu_HI[acc], t2, t3);
+            if (rd) {
+                tcg_gen_ext_i32_tl(cpu_gpr[rd], t2);
+            }
+            tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
+            tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
+            tcg_temp_free_i32(t2);
+            tcg_temp_free_i32(t3);
+        }
+        break;
     default:
         MIPS_INVAL("mul/madd TXx9");
         generate_exception_end(ctx, EXCP_RI);
@@ -24697,6 +24717,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
     case TX79_MMI_MADD:
     case TX79_MMI_MADD1:
+    case TX79_MMI_MADDU:
+    case TX79_MMI_MADDU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -24711,9 +24733,7 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MFHI1:
         gen_HILO(ctx, opc, 1, rd);
         break;
-    case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
     case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
-- 
2.18.1
