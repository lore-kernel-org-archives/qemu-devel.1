Received: from eggs.gnu.org ([2001:4830:134:3::10]:37423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvx0-0008VW-8f
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwv-00007Z-SF
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:14 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cLvwv-000074-Fv
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:09 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Dec 2016 18:53:55 +0100
Message-Id: <1482861241-17678-7-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
References: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 06/12] target-m68k: add abcd/sbcd/nbcd
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/m68k/translate.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 737009e..1567647 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1313,6 +1313,221 @@ DISAS_INSN(divl)
     set_cc_op(s, CC_OP_FLAGS);
 }
 
+static void bcd_add(TCGv dest, TCGv src)
+{
+    TCGv t0, t1;
+
+    /*  dest10 = dest10 + src10 + X
+     *
+     *        t1 = src
+     *        t2 = t1 + 0x066
+     *        t3 = t2 + dest + X
+     *        t4 = t2 ^ dest
+     *        t5 = t3 ^ t4
+     *        t6 = ~t5 & 0x110
+     *        t7 = (t6 >> 2) | (t6 >> 3)
+     *        return t3 - t7
+     */
+
+    /* t1 = (src + 0x066) + dest + X
+     *    = result with some possible exceding 0x6
+     */
+
+    t0 = tcg_const_i32(0x066);
+    tcg_gen_add_i32(t0, t0, src);
+
+    t1 = tcg_temp_new();
+    tcg_gen_add_i32(t1, t0, dest);
+    tcg_gen_add_i32(t1, t1, QREG_CC_X);
+
+    /* we will remove exceding 0x6 where there is no carry */
+
+    /* t0 = (src + 0x0066) ^ dest
+     *    = t1 without carries
+     */
+
+    tcg_gen_xor_i32(t0, t0, dest);
+
+    /* extract the carries
+     * t0 = t0 ^ t1
+     *    = only the carries
+     */
+
+    tcg_gen_xor_i32(t0, t0, t1);
+
+    /* generate 0x1 where there is no carry
+     * and for each 0x10, generate a 0x6
+     */
+
+    tcg_gen_shri_i32(t0, t0, 3);
+    tcg_gen_not_i32(t0, t0);
+    tcg_gen_andi_i32(t0, t0, 0x22);
+    tcg_gen_add_i32(dest, t0, t0);
+    tcg_gen_add_i32(dest, dest, t0);
+    tcg_temp_free(t0);
+
+    /* remove the exceding 0x6
+     * for digits that have not generated a carry
+     */
+
+    tcg_gen_sub_i32(dest, t1, dest);
+    tcg_temp_free(t1);
+}
+
+static void bcd_sub(TCGv dest, TCGv src)
+{
+    TCGv t0, t1, t2;
+
+    /*  dest10 = dest10 - src10 - X
+     *         = bcd_add(dest + 1 - X, 0x199 - src)
+     */
+
+    /* t0 = 0x066 + (0x199 - src) */
+
+    t0 = tcg_temp_new();
+    tcg_gen_subfi_i32(t0, 0x1ff, src);
+
+    /* t1 = t0 + dest + 1 - X*/
+
+    t1 = tcg_temp_new();
+    tcg_gen_add_i32(t1, t0, dest);
+    tcg_gen_addi_i32(t1, t1, 1);
+    tcg_gen_sub_i32(t1, t1, QREG_CC_X);
+
+    /* t2 = t0 ^ dest */
+
+    t2 = tcg_temp_new();
+    tcg_gen_xor_i32(t2, t0, dest);
+
+    /* t0 = t1 ^ t2 */
+
+    tcg_gen_xor_i32(t0, t1, t2);
+
+    /* t2 = ~t0 & 0x110
+     * t0 = (t2 >> 2) | (t2 >> 3)
+     *
+     * to fit on 8bit operands, changed in:
+     *
+     * t2 = ~(t0 >> 3) & 0x22
+     * t0 = t2 + t2
+     * t0 = t0 + t2
+     */
+
+    tcg_gen_shri_i32(t2, t0, 3);
+    tcg_gen_not_i32(t2, t2);
+    tcg_gen_andi_i32(t2, t2, 0x22);
+    tcg_gen_add_i32(t0, t2, t2);
+    tcg_gen_add_i32(t0, t0, t2);
+    tcg_temp_free(t2);
+
+    /* return t1 - t0 */
+
+    tcg_gen_sub_i32(dest, t1, t0);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+static void bcd_flags(TCGv val)
+{
+    tcg_gen_andi_i32(QREG_CC_C, val, 0x0ff);
+    tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_C);
+
+    tcg_gen_shri_i32(QREG_CC_C, val, 8);
+    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
+
+    tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
+}
+
+DISAS_INSN(abcd_reg)
+{
+    TCGv src;
+    TCGv dest;
+
+    gen_flush_flags(s); /* !Z is sticky */
+
+    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+    bcd_add(dest, src);
+    gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
+
+    bcd_flags(dest);
+}
+
+DISAS_INSN(abcd_mem)
+{
+    TCGv src, dest, addr;
+
+    gen_flush_flags(s); /* !Z is sticky */
+
+    /* Indirect pre-decrement load (mode 4) */
+
+    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                      NULL_QREG, NULL, EA_LOADU);
+    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                       NULL_QREG, &addr, EA_LOADU);
+
+    bcd_add(dest, src);
+
+    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr, EA_STORE);
+
+    bcd_flags(dest);
+}
+
+DISAS_INSN(sbcd_reg)
+{
+    TCGv src, dest;
+
+    gen_flush_flags(s); /* !Z is sticky */
+
+    src = gen_extend(DREG(insn, 0), OS_BYTE, 0);
+    dest = gen_extend(DREG(insn, 9), OS_BYTE, 0);
+
+    bcd_sub(dest, src);
+
+    gen_partset_reg(OS_BYTE, DREG(insn, 9), dest);
+
+    bcd_flags(dest);
+}
+
+DISAS_INSN(sbcd_mem)
+{
+    TCGv src, dest, addr;
+
+    gen_flush_flags(s); /* !Z is sticky */
+
+    /* Indirect pre-decrement load (mode 4) */
+
+    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                      NULL_QREG, NULL, EA_LOADU);
+    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                       NULL_QREG, &addr, EA_LOADU);
+
+    bcd_sub(dest, src);
+
+    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr, EA_STORE);
+
+    bcd_flags(dest);
+}
+
+DISAS_INSN(nbcd)
+{
+    TCGv src, dest;
+    TCGv addr;
+
+    gen_flush_flags(s); /* !Z is sticky */
+
+    SRC_EA(env, src, OS_BYTE, 0, &addr);
+
+    dest = tcg_const_i32(0);
+    bcd_sub(dest, src);
+
+    DEST_EA(env, insn, OS_BYTE, dest, &addr);
+
+    bcd_flags(dest);
+
+    tcg_temp_free(dest);
+}
+
 DISAS_INSN(addsub)
 {
     TCGv reg;
@@ -3448,6 +3663,7 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(not,       4600, ff00, M68000);
     INSN(undef,     46c0, ffc0, M68000);
     INSN(move_to_sr, 46c0, ffc0, CF_ISA_A);
+    INSN(nbcd,      4800, ffc0, M68000);
     INSN(linkl,     4808, fff8, M68000);
     BASE(pea,       4840, ffc0);
     BASE(swap,      4840, fff8);
@@ -3499,6 +3715,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(mvzs,      7100, f100, CF_ISA_B);
     BASE(or,        8000, f000);
     BASE(divw,      80c0, f0c0);
+    INSN(sbcd_reg,  8100, f1f8, M68000);
+    INSN(sbcd_mem,  8108, f1f8, M68000);
     BASE(addsub,    9000, f000);
     INSN(undef,     90c0, f0c0, CF_ISA_A);
     INSN(subx_reg,  9180, f1f8, CF_ISA_A);
@@ -3536,6 +3754,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(exg_aa,    c148, f1f8, M68000);
     INSN(exg_da,    c188, f1f8, M68000);
     BASE(mulw,      c0c0, f0c0);
+    INSN(abcd_reg,  c100, f1f8, M68000);
+    INSN(abcd_mem,  c108, f1f8, M68000);
     BASE(addsub,    d000, f000);
     INSN(undef,     d0c0, f0c0, CF_ISA_A);
     INSN(addx_reg,      d180, f1f8, CF_ISA_A);
-- 
2.7.4
