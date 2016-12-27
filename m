Received: from eggs.gnu.org ([2001:4830:134:3::10]:37424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvx0-0008VX-8i
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwy-00009L-VM
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:14 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cLvwy-00007v-JF
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Dec 2016 18:54:01 +0100
Message-Id: <1482861241-17678-13-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
References: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 12/12] target-m68k: free TCG variables that
 are not
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

This is a cleanup patch. It adds call to tcg_temp_free()
when it is missing.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/m68k/translate.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bb5a299..5329317 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -679,12 +679,14 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
         tmp = tcg_temp_new();
         tcg_gen_ext8u_i32(tmp, val);
         tcg_gen_or_i32(reg, reg, tmp);
+        tcg_temp_free(tmp);
         break;
     case OS_WORD:
         tcg_gen_andi_i32(reg, reg, 0xffff0000);
         tmp = tcg_temp_new();
         tcg_gen_ext16u_i32(tmp, val);
         tcg_gen_or_i32(reg, reg, tmp);
+        tcg_temp_free(tmp);
         break;
     case OS_LONG:
     case OS_SINGLE:
@@ -1105,11 +1107,19 @@ static void gen_jmp(DisasContext *s, TCGv dest)
     s->is_jmp = DISAS_JUMP;
 }
 
+static void gen_raise_exception(int nr)
+{
+    TCGv_i32 tmp = tcg_const_i32(nr);
+
+    gen_helper_raise_exception(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
+}
+
 static void gen_exception(DisasContext *s, uint32_t where, int nr)
 {
     update_cc_op(s);
     gen_jmp_im(s, where);
-    gen_helper_raise_exception(cpu_env, tcg_const_i32(nr));
+    gen_raise_exception(nr);
 }
 
 static inline void gen_addr_fault(DisasContext *s)
@@ -1240,6 +1250,7 @@ DISAS_INSN(mulw)
     tcg_gen_mul_i32(tmp, tmp, src);
     tcg_gen_mov_i32(reg, tmp);
     gen_logic_cc(s, tmp, OS_LONG);
+    tcg_temp_free(tmp);
 }
 
 DISAS_INSN(divw)
@@ -1645,6 +1656,7 @@ static void gen_push(DisasContext *s, TCGv val)
     tcg_gen_subi_i32(tmp, QREG_SP, 4);
     gen_store(s, OS_LONG, tmp, val);
     tcg_gen_mov_i32(QREG_SP, tmp);
+    tcg_temp_free(tmp);
 }
 
 static TCGv mreg(int reg)
@@ -2135,10 +2147,14 @@ DISAS_INSN(lea)
 DISAS_INSN(clr)
 {
     int opsize;
+    TCGv zero;
+
+    zero = tcg_const_i32(0);
 
     opsize = insn_opsize(insn);
-    DEST_EA(env, insn, opsize, tcg_const_i32(0), NULL);
-    gen_logic_cc(s, tcg_const_i32(0), opsize);
+    DEST_EA(env, insn, opsize, zero, NULL);
+    gen_logic_cc(s, zero, opsize);
+    tcg_temp_free(zero);
 }
 
 static TCGv gen_get_ccr(DisasContext *s)
@@ -2244,6 +2260,8 @@ DISAS_INSN(swap)
     tcg_gen_shli_i32(src1, reg, 16);
     tcg_gen_shri_i32(src2, reg, 16);
     tcg_gen_or_i32(reg, src1, src2);
+    tcg_temp_free(src2);
+    tcg_temp_free(src1);
     gen_logic_cc(s, reg, OS_LONG);
 }
 
@@ -2282,6 +2300,7 @@ DISAS_INSN(ext)
     else
         tcg_gen_mov_i32(reg, tmp);
     gen_logic_cc(s, tmp, OS_LONG);
+    tcg_temp_free(tmp);
 }
 
 DISAS_INSN(tst)
@@ -2316,6 +2335,7 @@ DISAS_INSN(tas)
     gen_logic_cc(s, src1, OS_BYTE);
     tcg_gen_ori_i32(dest, src1, 0x80);
     DEST_EA(env, insn, OS_BYTE, dest, &addr);
+    tcg_temp_free(dest);
 }
 
 DISAS_INSN(mull)
@@ -2423,6 +2443,7 @@ DISAS_INSN(unlk)
     tmp = gen_load(s, OS_LONG, src, 0);
     tcg_gen_mov_i32(reg, tmp);
     tcg_gen_addi_i32(QREG_SP, src, 4);
+    tcg_temp_free(src);
 }
 
 DISAS_INSN(nop)
@@ -2499,7 +2520,9 @@ DISAS_INSN(addsubq)
         }
         gen_update_cc_add(dest, val, opsize);
     }
+    tcg_temp_free(val);
     DEST_EA(env, insn, opsize, dest, &addr);
+    tcg_temp_free(dest);
 }
 
 DISAS_INSN(tpf)
@@ -2552,11 +2575,8 @@ DISAS_INSN(branch)
 
 DISAS_INSN(moveq)
 {
-    uint32_t val;
-
-    val = (int8_t)insn;
-    tcg_gen_movi_i32(DREG(insn, 9), val);
-    gen_logic_cc(s, tcg_const_i32(val), OS_LONG);
+    tcg_gen_movi_i32(DREG(insn, 9), (int8_t)insn);
+    gen_logic_cc(s, DREG(insn, 9), OS_LONG);
 }
 
 DISAS_INSN(mvzs)
@@ -2596,6 +2616,7 @@ DISAS_INSN(or)
         gen_partset_reg(opsize, DREG(insn, 9), dest);
     }
     gen_logic_cc(s, dest, opsize);
+    tcg_temp_free(dest);
 }
 
 DISAS_INSN(suba)
@@ -2690,6 +2711,7 @@ DISAS_INSN(mov3q)
     src = tcg_const_i32(val);
     gen_logic_cc(s, src, OS_LONG);
     DEST_EA(env, insn, OS_LONG, src, NULL);
+    tcg_temp_free(src);
 }
 
 DISAS_INSN(cmp)
@@ -2749,6 +2771,7 @@ DISAS_INSN(eor)
     tcg_gen_xor_i32(dest, src, DREG(insn, 9));
     gen_logic_cc(s, dest, opsize);
     DEST_EA(env, insn, opsize, dest, &addr);
+    tcg_temp_free(dest);
 }
 
 static void do_exg(TCGv reg1, TCGv reg2)
@@ -2799,8 +2822,8 @@ DISAS_INSN(and)
         tcg_gen_and_i32(dest, src, reg);
         gen_partset_reg(opsize, reg, dest);
     }
-    tcg_temp_free(dest);
     gen_logic_cc(s, dest, opsize);
+    tcg_temp_free(dest);
 }
 
 DISAS_INSN(adda)
-- 
2.7.4
