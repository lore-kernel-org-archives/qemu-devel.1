Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFpd-0004ti-Vu
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFpb-0004W4-VA
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:57 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFpa-0004Tu-Ex
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:39:54 -0400
Date: Sun, 21 Oct 2018 17:39:46 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <db6e2ca1ade5c6733c076af09e67670281391546.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 22/38] target/mips: Support R5900
 three-operand MADD and MADD1
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
 target/mips/translate.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/disas/mips.c b/disas/mips.c
index 79bd119c51..242bf68b9c 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -2553,6 +2553,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
 {"madd",    "s,t",      0x70000000, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,		G1	},
 {"madd",    "7,s,t",	0x70000000, 0xfc00e7ff, MOD_a|RD_s|RD_t,             0,         D33	},
 {"madd",    "d,s,t",    0x70000000, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,		G1	},
+{"madd1",   "s,t",      0x70000020, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M,      0,         EE      },
+{"madd1",   "d,s,t",    0x70000020, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|IS_M, 0,         EE      },
 {"maddp",   "s,t",      0x70000441, 0xfc00ffff,	RD_s|RD_t|MOD_HILO,	     0,		SMT	},
 {"maddu",   "s,t",      0x0000001d, 0xfc00ffff, RD_s|RD_t|WR_HILO,           0,		L1	},
 {"maddu",   "s,t",      0x70000001, 0xfc00ffff, RD_s|RD_t|MOD_HILO,          0,		I32|N55	},
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1f3dc3d406..153b7e869a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4778,8 +4778,8 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
 }
 
 /*
- * These MULT and MULTU instructions implemented in for example the
- * Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
+ * These MULT[U] and MADD instructions implemented in for example
+ * the Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
  * architectures are special three-operand variants with the syntax
  *
  *     MULT[U][1] rd, rs, rt
@@ -4788,6 +4788,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  *
  *     (rd, LO, HI) <- rs * rt
  *
+ * and
+ *
+ *     MADD[1]    rd, rs, rt
+ *
+ * such that
+ *
+ *     (rd, LO, HI) <- (LO, HI) + rs * rt
+ *
  * where the low-order 32-bits of the result is placed into both the
  * GPR rd and the special register LO. The high-order 32-bits of the
  * result is placed into the special register HI.
@@ -4844,8 +4852,28 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MADD1:
+        acc = 1;
+        /* Fall through */
+    case TX79_MMI_MADD:
+        {
+            TCGv_i32 t2 = tcg_temp_new_i32();
+            TCGv_i32 t3 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t2, t0);
+            tcg_gen_trunc_tl_i32(t3, t1);
+            tcg_gen_muls2_i32(t2, t3, t2, t3);
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
-        MIPS_INVAL("mul TXx9");
+        MIPS_INVAL("mul/madd TXx9");
         generate_exception_end(ctx, EXCP_RI);
         goto out;
     }
@@ -24667,6 +24695,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
         break;
     case TX79_MMI_MULT1:
     case TX79_MMI_MULTU1:
+    case TX79_MMI_MADD:
+    case TX79_MMI_MADD1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -24681,10 +24711,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MFHI1:
         gen_HILO(ctx, opc, 1, rd);
         break;
-    case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
-- 
2.18.1
