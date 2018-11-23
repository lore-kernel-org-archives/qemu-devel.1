Received: from eggs.gnu.org ([2001:4830:134:3::10]:44051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiv-0008Ui-UH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCis-0003SS-7W
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:24 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCiq-0003Nq-9G
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id j10so12585832wru.4
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:38 +0100
Message-Id: <20181123144558.5048-18-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 17/37] tcg/arm: Reduce the number of
 temps for tcg_out_tlb_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

When moving the qemu_ld/st thunk out of line, we no longer have LR for
use as a temporary.  In the worst case we must make do with 3 temps,
when dealing with a 64-bit guest address.  This in turn imples that we
cannot use LDRD anymore, as there are not enough temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 97 ++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 4339c472e8..2deeb1f5d1 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1251,13 +1251,12 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 QEMU_BUILD_BUG_ON(CPU_TLB_BITS > 8);
 
 /*
- *Load and compare a TLB entry, leaving the flags set.  Returns the register
- * containing the addend of the tlb entry.  Clobbers t0, t1, t2, t3.
- * T0 and T1 must be consecutive for LDRD.
+ * Load and compare a TLB entry, leaving the flags set.  Returns the register
+ * containing the addend of the tlb entry.  Clobbers t0, t1, t2.
  */
 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
                                TCGMemOp opc, int mem_index, bool is_load,
-                               TCGReg t0, TCGReg t1, TCGReg t2, TCGReg t3)
+                               TCGReg t0, TCGReg t1, TCGReg t2)
 {
     TCGReg base = TCG_AREG0;
     int cmp_off =
@@ -1265,49 +1264,64 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
          ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
          : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
     int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
-    int mask_off;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
     /* V7 generates the following:
      *   ubfx   t0, addrlo, #TARGET_PAGE_BITS, #CPU_TLB_BITS
      *   add    t2, env, #high
-     *   add    t2, t2, r0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    t0, [t2, #cmp]  (and t1 w/ldrd)
+     *   add    t2, t2, t0, lsl #CPU_TLB_ENTRY_BITS
+     *   ldr    t0, [t2, #cmp]
      *   ldr    t2, [t2, #add]
-     *   movw   t3, #page_align_mask
-     *   bic    t3, addrlo, t3
-     *   cmp    t0, t3
+     *   movw   t1, #page_align_mask
+     *   bic    t1, addrlo, t1
+     *   cmp    t0, t1
+     *
+     *   ubfx   t0, addrlo, #TPB, #CTB   -- 64-bit address
+     *   add    t2, env, #high
+     *   add    t2, t2, t0, lsl #CTEB
+     *   ldr    t0, [t2, #cmplo]
+     *   movw   t1, #page_align_mask
+     *   bic    t1, addrlo, t1
+     *   cmp    t0, t1
+     *   ldr    t0, [t2, #cmphi]
+     *   ldr    t2, [t2, #add]
+     *   cmpeq  t0, addrhi
      *
      * Otherwise we generate:
      *   shr    t3, addrlo, #TARGET_PAGE_BITS
      *   add    t2, env, #high
      *   and    t0, t3, #(CPU_TLB_SIZE - 1)
      *   add    t2, t2, t0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    t0, [t2, #cmp]  (and t1 w/ldrd)
+     *   ldr    t0, [t2, #cmp]
      *   ldr    t2, [t2, #add]
      *   tst    addrlo, #s_mask
      *   cmpeq  t0, t3, lsl #TARGET_PAGE_BITS
+     *
+     *   shr    t1, addrlo, #TPB         -- 64-bit address
+     *   add    t2, env, #high
+     *   and    t0, t1, #CTS-1
+     *   add    t2, t2, t0, lsl #CTEB
+     *   ldr    t0, [t2, #cmplo]
+     *   tst    addrlo, #s_mask
+     *   cmpeq  t0, t1, lsl #TBP
+     *   ldr    t0, [t2, #cmphi]
+     *   ldr    t2, [t2, #add]
+     *   cmpeq  t0, addrhi
      */
     if (use_armv7_instructions) {
         tcg_out_extract(s, COND_AL, t0, addrlo,
                         TARGET_PAGE_BITS, CPU_TLB_BITS);
     } else {
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, t3,
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, t1,
                         0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
     }
 
     /* Add portions of the offset until the memory access is in range.
-     * If we plan on using ldrd, reduce to an 8-bit offset; otherwise
-     * we can use a 12-bit offset.
+     * We are not using ldrd, so we can use a 12-bit offset.
      */
-    if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        mask_off = 0xff;
-    } else {
-        mask_off = 0xfff;
-    }
-    while (cmp_off > mask_off) {
-        int shift = ctz32(cmp_off & ~mask_off) & ~1;
+    while (cmp_off > 0xfff) {
+        int shift = ctz32(cmp_off & ~0xfff) & ~1;
         int rot = ((32 - shift) << 7) & 0xf00;
         int addend = cmp_off & (0xff << shift);
         tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t2, base,
@@ -1318,25 +1332,13 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     if (!use_armv7_instructions) {
-        tcg_out_dat_imm(s, COND_AL, ARITH_AND, t0, t3, CPU_TLB_SIZE - 1);
+        tcg_out_dat_imm(s, COND_AL, ARITH_AND, t0, t1, CPU_TLB_SIZE - 1);
     }
     tcg_out_dat_reg(s, COND_AL, ARITH_ADD, t2, base, t0,
                     SHIFT_IMM_LSL(CPU_TLB_ENTRY_BITS));
 
-    /* Load the tlb comparator.  Use ldrd if needed and available,
-       but due to how the pointer needs setting up, ldm isn't useful.
-       Base arm5 doesn't have ldrd, but armv5te does.  */
-    if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        tcg_out_ldrd_8(s, COND_AL, t0, t2, cmp_off);
-    } else {
-        tcg_out_ld32_12(s, COND_AL, t0, t2, cmp_off);
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_ld32_12(s, COND_AL, t1, t2, cmp_off + 4);
-        }
-    }
-
-    /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, t2, t2, add_off);
+    /* Load the tlb comparator (low part).  */
+    tcg_out_ld32_12(s, COND_AL, t0, t2, cmp_off);
 
     /* Check alignment.  We don't support inline unaligned acceses,
        but we can easily support overalignment checks.  */
@@ -1349,24 +1351,31 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         int rot = encode_imm(mask);
 
         if (rot >= 0) { 
-            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, t3, addrlo,
+            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, t1, addrlo,
                             rotl(mask, rot) | (rot << 7));
         } else {
-            tcg_out_movi32(s, COND_AL, t3, mask);
-            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, t3, addrlo, t3, 0);
+            tcg_out_movi32(s, COND_AL, t1, mask);
+            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, t1, addrlo, t1, 0);
         }
-        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, t0, t3, 0);
+        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, t0, t1, 0);
     } else {
         if (a_bits) {
             tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo,
                             (1 << a_bits) - 1);
         }
         tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP,
-                        0, t0, t3, SHIFT_IMM_LSL(TARGET_PAGE_BITS));
+                        0, t0, t1, SHIFT_IMM_LSL(TARGET_PAGE_BITS));
     }
 
+    /* Load the tlb comparator (high part).  */
     if (TARGET_LONG_BITS == 64) {
-        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, t1, addrhi, 0);
+        tcg_out_ld32_12(s, COND_AL, t0, t2, cmp_off + 4);
+    }
+    /* Load the tlb addend.  */
+    tcg_out_ld32_12(s, COND_AL, t2, t2, add_off);
+
+    if (TARGET_LONG_BITS == 64) {
+        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, t0, addrhi, 0);
     }
 
     return t2;
@@ -1636,7 +1645,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
     addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 1,
-                              TCG_REG_R0, TCG_REG_R1, TCG_REG_R2, TCG_REG_R14);
+                              TCG_REG_R0, TCG_REG_R1, TCG_REG_TMP);
 
     /* This a conditional BL only to load a pointer within this opcode into LR
        for the slow path.  We will not be using the value for a tail call.  */
@@ -1768,7 +1777,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
     addend = tcg_out_tlb_read(s, addrlo, addrhi, opc, mem_index, 0,
-                              TCG_REG_R0, TCG_REG_R1, TCG_REG_R2, TCG_REG_R14);
+                              TCG_REG_R0, TCG_REG_R1, TCG_REG_TMP);
 
     tcg_out_qemu_st_index(s, COND_EQ, opc, datalo, datahi, addrlo, addend);
 
-- 
2.17.2
