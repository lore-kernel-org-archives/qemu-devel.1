Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBT-00079F-Mj
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBS-0003AZ-JE
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:27 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:64309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBS-0003A5-7Y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:26 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:41:04 +0100
Message-Id: <20180102234108.32713-14-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 13/17] target/m68k: move CCR/SR functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

The following patches will be clearer if we move
functions before adding new ones.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 111 ++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 56 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index baaa260875..d879574c1a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2131,6 +2131,61 @@ DISAS_INSN(bitop_im)
     }
 }
 
+static TCGv gen_get_ccr(DisasContext *s)
+{
+    TCGv dest;
+
+    update_cc_op(s);
+    dest = tcg_temp_new();
+    gen_helper_get_ccr(dest, cpu_env);
+    return dest;
+}
+
+static TCGv gen_get_sr(DisasContext *s)
+{
+    TCGv ccr;
+    TCGv sr;
+
+    ccr = gen_get_ccr(s);
+    sr = tcg_temp_new();
+    tcg_gen_andi_i32(sr, QREG_SR, 0xffe0);
+    tcg_gen_or_i32(sr, sr, ccr);
+    return sr;
+}
+
+static void gen_set_sr_im(DisasContext *s, uint16_t val, int ccr_only)
+{
+    if (ccr_only) {
+        tcg_gen_movi_i32(QREG_CC_C, val & CCF_C ? 1 : 0);
+        tcg_gen_movi_i32(QREG_CC_V, val & CCF_V ? -1 : 0);
+        tcg_gen_movi_i32(QREG_CC_Z, val & CCF_Z ? 0 : 1);
+        tcg_gen_movi_i32(QREG_CC_N, val & CCF_N ? -1 : 0);
+        tcg_gen_movi_i32(QREG_CC_X, val & CCF_X ? 1 : 0);
+    } else {
+        gen_helper_set_sr(cpu_env, tcg_const_i32(val));
+    }
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+static void gen_set_sr(CPUM68KState *env, DisasContext *s, uint16_t insn,
+                       int ccr_only)
+{
+    if ((insn & 0x38) == 0) {
+        if (ccr_only) {
+            gen_helper_set_ccr(cpu_env, DREG(insn, 0));
+        } else {
+            gen_helper_set_sr(cpu_env, DREG(insn, 0));
+        }
+        set_cc_op(s, CC_OP_FLAGS);
+    } else if ((insn & 0x3f) == 0x3c) {
+        uint16_t val;
+        val = read_im16(env, s);
+        gen_set_sr_im(s, val, ccr_only);
+    } else {
+        disas_undef(env, s, insn);
+    }
+}
+
 DISAS_INSN(arith_im)
 {
     int op;
@@ -2474,16 +2529,6 @@ DISAS_INSN(clr)
     tcg_temp_free(zero);
 }
 
-static TCGv gen_get_ccr(DisasContext *s)
-{
-    TCGv dest;
-
-    update_cc_op(s);
-    dest = tcg_temp_new();
-    gen_helper_get_ccr(dest, cpu_env);
-    return dest;
-}
-
 DISAS_INSN(move_from_ccr)
 {
     TCGv ccr;
@@ -2510,40 +2555,6 @@ DISAS_INSN(neg)
     tcg_temp_free(dest);
 }
 
-static void gen_set_sr_im(DisasContext *s, uint16_t val, int ccr_only)
-{
-    if (ccr_only) {
-        tcg_gen_movi_i32(QREG_CC_C, val & CCF_C ? 1 : 0);
-        tcg_gen_movi_i32(QREG_CC_V, val & CCF_V ? -1 : 0);
-        tcg_gen_movi_i32(QREG_CC_Z, val & CCF_Z ? 0 : 1);
-        tcg_gen_movi_i32(QREG_CC_N, val & CCF_N ? -1 : 0);
-        tcg_gen_movi_i32(QREG_CC_X, val & CCF_X ? 1 : 0);
-    } else {
-        gen_helper_set_sr(cpu_env, tcg_const_i32(val));
-    }
-    set_cc_op(s, CC_OP_FLAGS);
-}
-
-static void gen_set_sr(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                       int ccr_only)
-{
-    if ((insn & 0x38) == 0) {
-        if (ccr_only) {
-            gen_helper_set_ccr(cpu_env, DREG(insn, 0));
-        } else {
-            gen_helper_set_sr(cpu_env, DREG(insn, 0));
-        }
-        set_cc_op(s, CC_OP_FLAGS);
-    } else if ((insn & 0x3f) == 0x3c) {
-        uint16_t val;
-        val = read_im16(env, s);
-        gen_set_sr_im(s, val, ccr_only);
-    } else {
-        disas_undef(env, s, insn);
-    }
-}
-
-
 DISAS_INSN(move_to_ccr)
 {
     gen_set_sr(env, s, insn, 1);
@@ -4360,18 +4371,6 @@ DISAS_INSN(move16_mem)
     }
 }
 
-static TCGv gen_get_sr(DisasContext *s)
-{
-    TCGv ccr;
-    TCGv sr;
-
-    ccr = gen_get_ccr(s);
-    sr = tcg_temp_new();
-    tcg_gen_andi_i32(sr, QREG_SR, 0xffe0);
-    tcg_gen_or_i32(sr, sr, ccr);
-    return sr;
-}
-
 DISAS_INSN(strldsr)
 {
     uint16_t ext;
-- 
2.14.3
