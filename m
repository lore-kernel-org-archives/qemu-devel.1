Received: from eggs.gnu.org ([2001:4830:134:3::10]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGsa-0002uB-6Y
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGsN-0001Pu-CX
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:29 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:51678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGsL-0001EO-Bx
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:23 -0400
Date: Thu, 1 Nov 2018 18:35:02 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <271abfb6f60e857af1f91b4772c221239b543b05.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/12] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The three-operand MADD and MADDU are specific to the
Toshiba TX19/TX39/TX79 cores.

The "32-Bit TX System RISC TX39 Family Architecture manual"
is available at https://wiki.qemu.org/File:DSAE0022432.pdf

Signed-off-by: Philippe Mathieu-Daud=C3=A9<f4bug@amsat.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Tested-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 58 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 624e53644d..4808cb49c3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5009,8 +5009,8 @@ static void gen_muldiv(DisasContext *ctx, uint32_t =
opc,
 }
=20
 /*
- * These MULT and MULTU instructions implemented in for example the
- * Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
+ * These MULT[U] and MADD[U] instructions implemented in for example
+ * the Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
  * architectures are special three-operand variants with the syntax
  *
  *     MULT[U][1] rd, rs, rt
@@ -5019,6 +5019,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t=
 opc,
  *
  *     (rd, LO, HI) <- rs * rt
  *
+ * and
+ *
+ *     MADD[U]    rd, rs, rt
+ *
+ * such that
+ *
+ *     (rd, LO, HI) <- (LO, HI) + rs * rt
+ *
  * where the low-order 32-bits of the result is placed into both the
  * GPR rd and the special register LO. The high-order 32-bits of the
  * result is placed into the special register HI.
@@ -5075,8 +5083,48 @@ static void gen_mul_txx9(DisasContext *ctx, uint32=
_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MADD:
+        {
+            TCGv_i64 t2 =3D tcg_temp_new_i64();
+            TCGv_i64 t3 =3D tcg_temp_new_i64();
+
+            tcg_gen_ext_tl_i64(t2, t0);
+            tcg_gen_ext_tl_i64(t3, t1);
+            tcg_gen_mul_i64(t2, t2, t3);
+            tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+            tcg_gen_add_i64(t2, t2, t3);
+            tcg_temp_free_i64(t3);
+            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_high32(cpu_HI[acc], t2);
+            if (rd) {
+                gen_move_low32(cpu_gpr[rd], t2);
+            }
+            tcg_temp_free_i64(t2);
+        }
+        break;
+    case TX79_MMI_MADDU:
+        {
+            TCGv_i64 t2 =3D tcg_temp_new_i64();
+            TCGv_i64 t3 =3D tcg_temp_new_i64();
+
+            tcg_gen_ext32u_tl(t0, t0);
+            tcg_gen_ext32u_tl(t1, t1);
+            tcg_gen_extu_tl_i64(t2, t0);
+            tcg_gen_extu_tl_i64(t3, t1);
+            tcg_gen_mul_i64(t2, t2, t3);
+            tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
+            tcg_gen_add_i64(t2, t2, t3);
+            tcg_temp_free_i64(t3);
+            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_high32(cpu_HI[acc], t2);
+            if (rd) {
+                gen_move_low32(cpu_gpr[rd], t2);
+            }
+            tcg_temp_free_i64(t2);
+        }
+        break;
     default:
-        MIPS_INVAL("mul TXx9");
+        MIPS_INVAL("mul/madd TXx9");
         generate_exception_end(ctx, EXCP_RI);
         goto out;
     }
@@ -26590,6 +26638,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, Di=
sasContext *ctx)
         break;
     case TX79_MMI_MULT1:
     case TX79_MMI_MULTU1:
+    case TX79_MMI_MADD:
+    case TX79_MMI_MADDU:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -26604,8 +26654,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, Di=
sasContext *ctx)
     case TX79_MMI_MFHI1:
         gen_HILO1_tx79(ctx, opc, rd);
         break;
-    case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
-    case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
--=20
2.18.1
