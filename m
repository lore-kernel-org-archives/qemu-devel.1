Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFNbJ-00044v-1P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFNTK-00050C-Pe
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:01:37 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFNTI-0004rK-4f
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:01:34 -0400
Date: Wed, 24 Oct 2018 20:01:15 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181024180114.GB5731@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181014142928.2784-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
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
Cc: "Maciej W . Rozycki" <macro@linux-mips.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Philippe,

> The three-operand MADD and MADDU are specific to the
> Toshiba TX19/TX39/TX79 cores.
>=20
> The "32-Bit TX System RISC TX39 Family Architecture manual"
> is available at https://wiki.qemu.org/File:DSAE0022432.pdf
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9<f4bug@amsat.org>

I'm queueing your MADD and MADDU patch, with minor modifications as shown
below, to amend the support for the R5900, based on Aleksandar's latest
v2 tag:

https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2-v2

It looks like gen_move_{low32,high32} do sign-extend properly. However,
their notes say "sign-extract" as in:

/* Sign-extract the low 32-bits to a target_long.  */
static inline void gen_move_low32(TCGv ret, TCGv_i64 arg)
...
/* Sign-extract the high 32-bits to a target_long.  */
static inline void gen_move_high32(TCGv ret, TCGv_i64 arg)

Perhaps these are typos? Also, looking at the code for tcg_gen_mulu2_i32
and tcg_gen_add2_i32, they don't appear to be particularly more efficient
anyway, in particular since more registers are needed, so let's go with
your version. (A subsequent patch will do MADD1 and MADDU1 as well.)

Thanks!

Fredrik

--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4801,8 +4801,8 @@ static void gen_muldiv(DisasContext *ctx, uint32_t =
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
@@ -4811,6 +4811,14 @@ static void gen_muldiv(DisasContext *ctx, uint32_t=
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
@@ -4867,8 +4875,48 @@ static void gen_mul_txx9(DisasContext *ctx, uint32=
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
@@ -24699,6 +24747,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, Di=
sasContext *ctx)
         break;
     case TX79_MMI_MULT1:
     case TX79_MMI_MULTU1:
+    case TX79_MMI_MADD:
+    case TX79_MMI_MADDU:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -24713,8 +24763,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, Di=
sasContext *ctx)
     case TX79_MMI_MFHI1:
         gen_HILO(ctx, opc, 1, rd);
         break;
-    case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
-    case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
