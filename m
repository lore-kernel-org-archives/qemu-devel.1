Received: from eggs.gnu.org ([2001:4830:134:3::10]:42825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHoe-0006sS-19
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBHoZ-0008Rd-1v
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:39 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:25123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBHoY-0008R9-KR
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 07:10:34 -0400
Date: Sat, 13 Oct 2018 13:10:21 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <dec930c802e8e07388f75477f1063f50e543feb4.1539428198.git.noring@nocrew.org>
References: <cover.1539428198.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539428198.git.noring@nocrew.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 2/7] target/mips: Support R5900 specific
 three-operand MULT and MULTU
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

The three-operand MULT and MULTU are the only R5900 specific
instructions emitted by GCC 7.3. The R5900 also implements the three-
operand MADD and MADDU instructions, but they are omitted in QEMU for
now since they are absent in programs compiled by current GCC versions.

Likewise, the R5900 specific pipeline 1 instruction variants MULT1,
MULTU1, DIV1, DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1
are omitted here as well.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/translate.c | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 73 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ab16cdb911..a32e021745 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3768,6 +3768,77 @@ static void gen_muldiv(DisasContext *ctx, uint32_t=
 opc,
     tcg_temp_free(t1);
 }
=20
+/*
+ * These MULT and MULTU instructions implemented in for example the
+ * Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
+ * architectures are special three-operand variants with the syntax
+ *
+ *     MULT[U] rd, rs, rt
+ *
+ * such that
+ *
+ *     (rd, LO, HI) <- rs * rt
+ *
+ * where the low-order 32-bits of the result is placed into both the
+ * GPR rd and the special register LO. The high-order 32-bits of the
+ * result is placed into the special register HI.
+ *
+ * If the GPR rd is omitted in assembly language, it is taken to be 0,
+ * which is the zero register that always reads as 0.
+ */
+static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
+                         int acc, int rd, int rs, int rt)
+{
+    TCGv t0 =3D tcg_temp_new();
+    TCGv t1 =3D tcg_temp_new();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    switch (opc) {
+    case OPC_MULT:
+        {
+            TCGv_i32 t2 =3D tcg_temp_new_i32();
+            TCGv_i32 t3 =3D tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t2, t0);
+            tcg_gen_trunc_tl_i32(t3, t1);
+            tcg_gen_muls2_i32(t2, t3, t2, t3);
+            if (rd) {
+                tcg_gen_ext_i32_tl(cpu_gpr[rd], t2);
+            }
+            tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
+            tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
+            tcg_temp_free_i32(t2);
+            tcg_temp_free_i32(t3);
+        }
+        break;
+    case OPC_MULTU:
+        {
+            TCGv_i32 t2 =3D tcg_temp_new_i32();
+            TCGv_i32 t3 =3D tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t2, t0);
+            tcg_gen_trunc_tl_i32(t3, t1);
+            tcg_gen_mulu2_i32(t2, t3, t2, t3);
+            if (rd) {
+                tcg_gen_ext_i32_tl(cpu_gpr[rd], t2);
+            }
+            tcg_gen_ext_i32_tl(cpu_LO[acc], t2);
+            tcg_gen_ext_i32_tl(cpu_HI[acc], t3);
+            tcg_temp_free_i32(t2);
+            tcg_temp_free_i32(t3);
+        }
+        break;
+    default:
+        MIPS_INVAL("mul TXx9");
+        generate_exception_end(ctx, EXCP_RI);
+        goto out;
+    }
+
+ out:
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
 static void gen_mul_vr54xx (DisasContext *ctx, uint32_t opc,
                             int rd, int rs, int rt)
 {
@@ -22378,6 +22449,8 @@ static void decode_opc_special_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
             check_insn(ctx, INSN_VR54XX);
             op1 =3D MASK_MUL_VR54XX(ctx->opcode);
             gen_mul_vr54xx(ctx, op1, rd, rs, rt);
+        } else if (ctx->insn_flags & INSN_R5900) {
+            gen_mul_txx9(ctx, op1, 0, rd, rs, rt);
         } else {
             gen_muldiv(ctx, op1, rd & 3, rs, rt);
         }
--=20
2.16.4
