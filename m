Received: from eggs.gnu.org ([2001:4830:134:3::10]:52433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBU-00079q-Cc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBT-0003As-EG
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:61964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBT-0003AS-3H
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:27 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:41:05 +0100
Message-Id: <20180102234108.32713-15-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 14/17] target/m68k: add 680x0 "move to SR"
 instruction
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

Some cleanup, and allows SR to be moved from any addressing mode.
Previous code was wrong for coldfire: coldfire also allows to
use addressing mode to set SR/CCR. It only supports Data register
to get SR/CCR (move from)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d879574c1a..d007943d93 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2162,27 +2162,34 @@ static void gen_set_sr_im(DisasContext *s, uint16_t val, int ccr_only)
         tcg_gen_movi_i32(QREG_CC_N, val & CCF_N ? -1 : 0);
         tcg_gen_movi_i32(QREG_CC_X, val & CCF_X ? 1 : 0);
     } else {
-        gen_helper_set_sr(cpu_env, tcg_const_i32(val));
+        TCGv sr = tcg_const_i32(val);
+        gen_helper_set_sr(cpu_env, sr);
+        tcg_temp_free(sr);
     }
     set_cc_op(s, CC_OP_FLAGS);
 }
 
-static void gen_set_sr(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                       int ccr_only)
+static void gen_set_sr(DisasContext *s, TCGv val, int ccr_only)
 {
-    if ((insn & 0x38) == 0) {
-        if (ccr_only) {
-            gen_helper_set_ccr(cpu_env, DREG(insn, 0));
-        } else {
-            gen_helper_set_sr(cpu_env, DREG(insn, 0));
-        }
-        set_cc_op(s, CC_OP_FLAGS);
-    } else if ((insn & 0x3f) == 0x3c) {
+    if (ccr_only) {
+        gen_helper_set_ccr(cpu_env, val);
+    } else {
+        gen_helper_set_sr(cpu_env, val);
+    }
+    set_cc_op(s, CC_OP_FLAGS);
+}
+
+static void gen_move_to_sr(CPUM68KState *env, DisasContext *s, uint16_t insn,
+                           bool ccr_only)
+{
+    if ((insn & 0x3f) == 0x3c) {
         uint16_t val;
         val = read_im16(env, s);
         gen_set_sr_im(s, val, ccr_only);
     } else {
-        disas_undef(env, s, insn);
+        TCGv src;
+        SRC_EA(env, src, OS_WORD, 0, NULL);
+        gen_set_sr(s, src, ccr_only);
     }
 }
 
@@ -2557,7 +2564,7 @@ DISAS_INSN(neg)
 
 DISAS_INSN(move_to_ccr)
 {
-    gen_set_sr(env, s, insn, 1);
+    gen_move_to_sr(env, s, insn, true);
 }
 
 DISAS_INSN(not)
@@ -4410,7 +4417,7 @@ DISAS_INSN(move_to_sr)
         gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
         return;
     }
-    gen_set_sr(env, s, insn, 0);
+    gen_move_to_sr(env, s, insn, false);
     gen_lookup_tb(s);
 }
 
@@ -5557,9 +5564,8 @@ void register_m68k_insns (CPUM68KState *env)
     BASE(move_to_ccr, 44c0, ffc0);
     INSN(not,       4680, fff8, CF_ISA_A);
     INSN(not,       4600, ff00, M68000);
-    INSN(undef,     46c0, ffc0, M68000);
 #if defined(CONFIG_SOFTMMU)
-    INSN(move_to_sr, 46c0, ffc0, CF_ISA_A);
+    BASE(move_to_sr, 46c0, ffc0);
 #endif
     INSN(nbcd,      4800, ffc0, M68000);
     INSN(linkl,     4808, fff8, M68000);
-- 
2.14.3
