Received: from eggs.gnu.org ([208.118.235.92]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoP3-0000X9-Q4
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoP1-00036K-Bh
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:01 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49206 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoP0-00034d-U1
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:25:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:16 +0100
Message-Id: <1545989148-13582-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/41] target/mips: Support R5900 three-operand
 MADD and MADDU instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The three-operand MADD and MADDU are specific to Sony R5900 core,
and Toshiba TX19/TX39/TX79 cores as well.

The "32-Bit TX System RISC TX39 Family Architecture manual"
is available at https://wiki.qemu.org/File:DSAE0022432.pdf

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9<f4bug@amsat.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Tested-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 58 +++++++++++++++++++++++++++++++++++++++++++=
+-----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e3a5a73..3ad3b31 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5027,8 +5027,8 @@ static void gen_muldiv(DisasContext *ctx, uint32_t =
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
@@ -5037,6 +5037,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t=
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
@@ -5093,8 +5101,48 @@ static void gen_mul_txx9(DisasContext *ctx, uint32=
_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case MMI_OPC_MADD:
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
+    case MMI_OPC_MADDU:
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
@@ -26703,6 +26751,8 @@ static void decode_mmi(CPUMIPSState *env, DisasCo=
ntext *ctx)
         break;
     case MMI_OPC_MULT1:
     case MMI_OPC_MULTU1:
+    case MMI_OPC_MADD:
+    case MMI_OPC_MADDU:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case MMI_OPC_DIV1:
@@ -26717,8 +26767,6 @@ static void decode_mmi(CPUMIPSState *env, DisasCo=
ntext *ctx)
     case MMI_OPC_MFHI1:
         gen_HILO1_tx79(ctx, opc, rd);
         break;
-    case MMI_OPC_MADD:          /* TODO: MMI_OPC_MADD */
-    case MMI_OPC_MADDU:         /* TODO: MMI_OPC_MADDU */
     case MMI_OPC_PLZCW:         /* TODO: MMI_OPC_PLZCW */
     case MMI_OPC_MADD1:         /* TODO: MMI_OPC_MADD1 */
     case MMI_OPC_MADDU1:        /* TODO: MMI_OPC_MADDU1 */
--=20
2.7.4
