Received: from eggs.gnu.org ([2001:4830:134:3::10]:52454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBX-0007CW-6n
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWBU-0003BP-GC
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:31 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWBU-0003Ao-4f
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:41:28 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  3 Jan 2018 00:41:06 +0100
Message-Id: <20180102234108.32713-16-laurent@vivier.eu>
In-Reply-To: <20180102234108.32713-1-laurent@vivier.eu>
References: <20180102234108.32713-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v6 15/17] target/m68k: add andi/ori/eori to
 SR/CCR
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

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 53 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d007943d93..205c3b8f35 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2201,6 +2201,7 @@ DISAS_INSN(arith_im)
     TCGv dest;
     TCGv addr;
     int opsize;
+    bool with_SR = ((insn & 0x3f) == 0x3c);
 
     op = (insn >> 9) & 7;
     opsize = insn_opsize(insn);
@@ -2217,32 +2218,73 @@ DISAS_INSN(arith_im)
     default:
        abort();
     }
-    SRC_EA(env, src1, opsize, 1, (op == 6) ? NULL : &addr);
+
+    if (with_SR) {
+        /* SR/CCR can only be used with andi/eori/ori */
+        if (op == 2 || op == 3 || op == 6) {
+            disas_undef(env, s, insn);
+            return;
+        }
+        switch (opsize) {
+        case OS_BYTE:
+            src1 = gen_get_ccr(s);
+            break;
+        case OS_WORD:
+            if (IS_USER(s)) {
+                gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+                return;
+            }
+            src1 = gen_get_sr(s);
+            break;
+        case OS_LONG:
+            disas_undef(env, s, insn);
+            return;
+        }
+    } else {
+        SRC_EA(env, src1, opsize, 1, (op == 6) ? NULL : &addr);
+    }
     dest = tcg_temp_new();
     switch (op) {
     case 0: /* ori */
         tcg_gen_or_i32(dest, src1, im);
-        gen_logic_cc(s, dest, opsize);
+        if (with_SR) {
+            gen_set_sr(s, dest, opsize == OS_BYTE);
+        } else {
+            DEST_EA(env, insn, opsize, dest, &addr);
+            gen_logic_cc(s, dest, opsize);
+        }
         break;
     case 1: /* andi */
         tcg_gen_and_i32(dest, src1, im);
-        gen_logic_cc(s, dest, opsize);
+        if (with_SR) {
+            gen_set_sr(s, dest, opsize == OS_BYTE);
+        } else {
+            DEST_EA(env, insn, opsize, dest, &addr);
+            gen_logic_cc(s, dest, opsize);
+        }
         break;
     case 2: /* subi */
         tcg_gen_setcond_i32(TCG_COND_LTU, QREG_CC_X, src1, im);
         tcg_gen_sub_i32(dest, src1, im);
         gen_update_cc_add(dest, im, opsize);
         set_cc_op(s, CC_OP_SUBB + opsize);
+        DEST_EA(env, insn, opsize, dest, &addr);
         break;
     case 3: /* addi */
         tcg_gen_add_i32(dest, src1, im);
         gen_update_cc_add(dest, im, opsize);
         tcg_gen_setcond_i32(TCG_COND_LTU, QREG_CC_X, dest, im);
         set_cc_op(s, CC_OP_ADDB + opsize);
+        DEST_EA(env, insn, opsize, dest, &addr);
         break;
     case 5: /* eori */
         tcg_gen_xor_i32(dest, src1, im);
-        gen_logic_cc(s, dest, opsize);
+        if (with_SR) {
+            gen_set_sr(s, dest, opsize == OS_BYTE);
+        } else {
+            DEST_EA(env, insn, opsize, dest, &addr);
+            gen_logic_cc(s, dest, opsize);
+        }
         break;
     case 6: /* cmpi */
         gen_update_cc_cmp(s, src1, im, opsize);
@@ -2251,9 +2293,6 @@ DISAS_INSN(arith_im)
         abort();
     }
     tcg_temp_free(im);
-    if (op != 6) {
-        DEST_EA(env, insn, opsize, dest, &addr);
-    }
     tcg_temp_free(dest);
 }
 
-- 
2.14.3
