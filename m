Received: from eggs.gnu.org ([2001:4830:134:3::10]:54237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3K-0003z7-Ed
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMK3H-00052J-1P
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:24 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMK3G-00051Y-Hw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:47:22 -0500
Received: by mail-wm1-x344.google.com with SMTP id s11so183367wmh.1
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:47:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 12 Nov 2018 22:44:59 +0100
Message-Id: <20181112214503.22941-14-richard.henderson@linaro.org>
In-Reply-To: <20181112214503.22941-1-richard.henderson@linaro.org>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 13/17] tcg/arm: Parameterize the temps
 for tcg_out_tlb_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

When moving the qemu_ld/st arguments to the right place for
a function call, we'll need to move the temps out of the way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 89 +++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 80d174ef44..414c91c9ea 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1245,11 +1245,14 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 /* We're expecting to use an 8-bit immediate and to mask.  */
 QEMU_BUILD_BUG_ON(CPU_TLB_BITS > 8);
 
-/* Load and compare a TLB entry, leaving the flags set.  Returns the register
-   containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
-
+/*
+ *Load and compare a TLB entry, leaving the flags set.  Returns the register
+ * containing the addend of the tlb entry.  Clobbers t0, t1, t2, t3.
+ * T0 and T1 must be consecutive for LDRD.
+ */
 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
-                               TCGMemOp opc, int mem_index, bool is_load)
+                               TCGMemOp opc, int mem_index, bool is_load,
+                               TCGReg t0, TCGReg t1, TCGReg t2, TCGReg t3)
 {
     TCGReg base = TCG_AREG0;
     int cmp_off =
@@ -1262,36 +1265,37 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     unsigned a_bits = get_alignment_bits(opc);
 
     /* V7 generates the following:
-     *   ubfx   r0, addrlo, #TARGET_PAGE_BITS, #CPU_TLB_BITS
-     *   add    r2, env, #high
-     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    r0, [r2, #cmp]
-     *   ldr    r2, [r2, #add]
-     *   movw   tmp, #page_align_mask
-     *   bic    tmp, addrlo, tmp
-     *   cmp    r0, tmp
+     *   ubfx   t0, addrlo, #TARGET_PAGE_BITS, #CPU_TLB_BITS
+     *   add    t2, env, #high
+     *   add    t2, t2, r0, lsl #CPU_TLB_ENTRY_BITS
+     *   ldr    t0, [t2, #cmp]  (and t1 w/ldrd)
+     *   ldr    t2, [t2, #add]
+     *   movw   t3, #page_align_mask
+     *   bic    t3, addrlo, t3
+     *   cmp    t0, t3
      *
      * Otherwise we generate:
-     *   shr    tmp, addrlo, #TARGET_PAGE_BITS
-     *   add    r2, env, #high
-     *   and    r0, tmp, #(CPU_TLB_SIZE - 1)
-     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    r0, [r2, #cmp]
-     *   ldr    r2, [r2, #add]
+     *   shr    t3, addrlo, #TARGET_PAGE_BITS
+     *   add    t2, env, #high
+     *   and    t0, t3, #(CPU_TLB_SIZE - 1)
+     *   add    t2, t2, t0, lsl #CPU_TLB_ENTRY_BITS
+     *   ldr    t0, [t2, #cmp]  (and t1 w/ldrd)
+     *   ldr    t2, [t2, #add]
      *   tst    addrlo, #s_mask
-     *   cmpeq  r0, tmp, lsl #TARGET_PAGE_BITS
+     *   cmpeq  t0, t3, lsl #TARGET_PAGE_BITS
      */
     if (use_armv7_instructions) {
-        tcg_out_extract(s, COND_AL, TCG_REG_R0, addrlo,
+        tcg_out_extract(s, COND_AL, t0, addrlo,
                         TARGET_PAGE_BITS, CPU_TLB_BITS);
     } else {
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP,
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, t3,
                         0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
     }
 
     /* Add portions of the offset until the memory access is in range.
      * If we plan on using ldrd, reduce to an 8-bit offset; otherwise
-     * we can use a 12-bit offset.  */
+     * we can use a 12-bit offset.
+     */
     if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
         mask_off = 0xff;
     } else {
@@ -1301,34 +1305,33 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         int shift = ctz32(cmp_off & ~mask_off) & ~1;
         int rot = ((32 - shift) << 7) & 0xf00;
         int addend = cmp_off & (0xff << shift);
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
+        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t2, base,
                         rot | ((cmp_off >> shift) & 0xff));
-        base = TCG_REG_R2;
+        base = t2;
         add_off -= addend;
         cmp_off -= addend;
     }
 
     if (!use_armv7_instructions) {
-        tcg_out_dat_imm(s, COND_AL, ARITH_AND,
-                        TCG_REG_R0, TCG_REG_TMP, CPU_TLB_SIZE - 1);
+        tcg_out_dat_imm(s, COND_AL, ARITH_AND, t0, t3, CPU_TLB_SIZE - 1);
     }
-    tcg_out_dat_reg(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
-                    TCG_REG_R0, SHIFT_IMM_LSL(CPU_TLB_ENTRY_BITS));
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADD, t2, base, t0,
+                    SHIFT_IMM_LSL(CPU_TLB_ENTRY_BITS));
 
     /* Load the tlb comparator.  Use ldrd if needed and available,
        but due to how the pointer needs setting up, ldm isn't useful.
        Base arm5 doesn't have ldrd, but armv5te does.  */
     if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
+        tcg_out_ldrd_8(s, COND_AL, t0, t2, cmp_off);
     } else {
-        tcg_out_ld32_12(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
+        tcg_out_ld32_12(s, COND_AL, t0, t2, cmp_off);
         if (TARGET_LONG_BITS == 64) {
-            tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R2, cmp_off + 4);
+            tcg_out_ld32_12(s, COND_AL, t1, t2, cmp_off + 4);
         }
     }
 
     /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2, add_off);
+    tcg_out_ld32_12(s, COND_AL, t2, t2, add_off);
 
     /* Check alignment.  We don't support inline unaligned acceses,
        but we can easily support overalignment checks.  */
@@ -1341,29 +1344,27 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         int rot = encode_imm(mask);
 
         if (rot >= 0) { 
-            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, TCG_REG_TMP, addrlo,
+            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, t3, addrlo,
                             rotl(mask, rot) | (rot << 7));
         } else {
-            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, mask);
-            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
-                            addrlo, TCG_REG_TMP, 0);
+            tcg_out_movi32(s, COND_AL, t3, mask);
+            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, t3, addrlo, t3, 0);
         }
-        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R0, TCG_REG_TMP, 0);
+        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, t0, t3, 0);
     } else {
         if (a_bits) {
             tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo,
                             (1 << a_bits) - 1);
         }
         tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP,
-                        0, TCG_REG_R0, TCG_REG_TMP,
-                        SHIFT_IMM_LSL(TARGET_PAGE_BITS));
+                        0, t0, t3, SHIFT_IMM_LSL(TARGET_PAGE_BITS));
     }
 
     if (TARGET_LONG_BITS == 64) {
-        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R1, addrhi, 0);
+        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, t1, addrhi, 0);
     }
 
-    return TCG_REG_R2;
+    return t2;
 }
 
 /* Record the context of a call to the out of line helper code for the slow
@@ -1629,7 +1630,8 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 1);
+    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 1,
+                              TCG_REG_R0, TCG_REG_R1, TCG_REG_R2, TCG_REG_R14);
 
     /* This a conditional BL only to load a pointer within this opcode into LR
        for the slow path.  We will not be using the value for a tail call.  */
@@ -1760,7 +1762,8 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 0);
+    addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 0,
+                              TCG_REG_R0, TCG_REG_R1, TCG_REG_R2, TCG_REG_R14);
 
     tcg_out_qemu_st_index(s, COND_EQ, opc, datalo, datahi, addrlo, addend);
 
-- 
2.17.2
