Received: from eggs.gnu.org ([2001:4830:134:3::10]:45359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgw-0007KF-Cm
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgt-0007xg-0L
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:46 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgs-0007xH-Ej
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:42 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:25 +0100
Message-Id: <1482579633-3393-5-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 04/12] target-m68k: add 64bit mull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twidle.net>
---
 target/m68k/translate.c | 62 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 97edb7b..6678b57 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1863,24 +1863,62 @@ DISAS_INSN(tas)
 DISAS_INSN(mull)
 {
     uint16_t ext;
-    TCGv reg;
     TCGv src1;
-    TCGv dest;
+    int sign;
 
-    /* The upper 32 bits of the product are discarded, so
-       muls.l and mulu.l are functionally equivalent.  */
     ext = read_im16(env, s);
-    if (ext & 0x87ff) {
-        gen_exception(s, s->pc - 4, EXCP_UNSUPPORTED);
+
+    sign = ext & 0x800;
+
+    if (ext & 0x400) {
+        if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
+            gen_exception(s, s->pc - 4, EXCP_UNSUPPORTED);
+            return;
+        }
+
+        SRC_EA(env, src1, OS_LONG, 0, NULL);
+
+        if (sign) {
+            tcg_gen_muls2_i32(QREG_CC_Z, QREG_CC_N, src1, DREG(ext, 12));
+        } else {
+            tcg_gen_mulu2_i32(QREG_CC_Z, QREG_CC_N, src1, DREG(ext, 12));
+        }
+        /* if Dl == Dh, 68040 returns low word */
+        tcg_gen_mov_i32(DREG(ext, 0), QREG_CC_N);
+        tcg_gen_mov_i32(DREG(ext, 12), QREG_CC_Z);
+        tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_N);
+
+        tcg_gen_movi_i32(QREG_CC_V, 0);
+        tcg_gen_movi_i32(QREG_CC_C, 0);
+
+        set_cc_op(s, CC_OP_FLAGS);
         return;
     }
-    reg = DREG(ext, 12);
     SRC_EA(env, src1, OS_LONG, 0, NULL);
-    dest = tcg_temp_new();
-    tcg_gen_mul_i32(dest, src1, reg);
-    tcg_gen_mov_i32(reg, dest);
-    /* Unlike m68k, coldfire always clears the overflow bit.  */
-    gen_logic_cc(s, dest, OS_LONG);
+    if (m68k_feature(s->env, M68K_FEATURE_M68000)) {
+        tcg_gen_movi_i32(QREG_CC_C, 0);
+        if (sign) {
+            tcg_gen_muls2_i32(QREG_CC_N, QREG_CC_V, src1, DREG(ext, 12));
+            /* QREG_CC_V is -(QREG_CC_V != (QREG_CC_N >> 31)) */
+            tcg_gen_sari_i32(QREG_CC_Z, QREG_CC_N, 31);
+            tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, QREG_CC_Z);
+        } else {
+            tcg_gen_mulu2_i32(QREG_CC_N, QREG_CC_V, src1, DREG(ext, 12));
+            /* QREG_CC_V is -(QREG_CC_V != 0), use QREG_CC_C as 0 */
+            tcg_gen_setcond_i32(TCG_COND_NE, QREG_CC_V, QREG_CC_V, QREG_CC_C);
+        }
+        tcg_gen_neg_i32(QREG_CC_V, QREG_CC_V);
+        tcg_gen_mov_i32(DREG(ext, 12), QREG_CC_N);
+
+        tcg_gen_mov_i32(QREG_CC_Z, QREG_CC_N);
+
+        set_cc_op(s, CC_OP_FLAGS);
+    } else {
+        /* The upper 32 bits of the product are discarded, so
+           muls.l and mulu.l are functionally equivalent.  */
+        tcg_gen_mul_i32(DREG(ext, 12), src1, DREG(ext, 12));
+        gen_logic_cc(s, DREG(ext, 12), OS_LONG);
+    }
 }
 
 static void gen_link(DisasContext *s, uint16_t insn, int32_t offset)
-- 
2.7.4
