Received: from eggs.gnu.org ([2001:4830:134:3::10]:48693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCI-0007L2-RF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCG-0000oM-Of
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47459 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fYFCG-0000lP-HC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Jun 2018 20:29:07 +0200
Message-Id: <1530124149-3900-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 7/9] target/mips: Update gen_flt_ldst()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Update gen_flt_ldst() in order to reuse the functions for nanoMIPS

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/translate.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2eb211a..e923d27 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2433,11 +2433,8 @@ static void gen_st_cond (DisasContext *ctx, uint32=
_t opc, int rt,
=20
 /* Load and store */
 static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
-                          int base, int16_t offset)
+                          TCGv t0)
 {
-    TCGv t0 =3D tcg_temp_new();
-
-    gen_base_offset_addr(ctx, t0, base, offset);
     /* Don't do NOP if destination is zero: we must perform the actual
        memory access. */
     switch (opc) {
@@ -2480,15 +2477,15 @@ static void gen_flt_ldst (DisasContext *ctx, uint=
32_t opc, int ft,
     default:
         MIPS_INVAL("flt_ldst");
         generate_exception_end(ctx, EXCP_RI);
-        goto out;
+        break;
     }
- out:
-    tcg_temp_free(t0);
 }
=20
 static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
                           int rs, int16_t imm)
 {
+    TCGv t0 =3D tcg_temp_new();
+
     if (ctx->CP0_Config1 & (1 << CP0C1_FP)) {
         check_cp1_enabled(ctx);
         switch (op) {
@@ -2497,11 +2494,13 @@ static void gen_cop1_ldst(DisasContext *ctx, uint=
32_t op, int rt,
             check_insn(ctx, ISA_MIPS2);
             /* Fallthrough */
         default:
-            gen_flt_ldst(ctx, op, rt, rs, imm);
+            gen_base_offset_addr(ctx, t0, rs, imm);
+            gen_flt_ldst(ctx, op, rt, t0);
         }
     } else {
         generate_exception_err(ctx, EXCP_CpU, 1);
     }
+    tcg_temp_free(t0);
 }
=20
 /* Arithmetic with immediate operand */
--=20
2.7.4
