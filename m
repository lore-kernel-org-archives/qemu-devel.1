Received: from eggs.gnu.org ([209.51.188.92]:41043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSy-0006EN-7a
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSk-0004K1-K3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:43 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSj-0004CT-W2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:38 -0500
Received: by mail-pf1-x442.google.com with SMTP id q1so1934978pfi.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:57:01 -0800
Message-Id: <20190123225705.28963-10-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] tcg/arm: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     |   2 +-
 tcg/arm/tcg-target.inc.c | 143 +++++++++++++++++++--------------------
 2 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index c5a7064bdc..679aaf097e 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -60,7 +60,7 @@ extern int arm_arch;
 #undef TCG_TARGET_STACK_GROWSUP
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum {
     TCG_REG_R0 = 0,
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 49f57d655e..2245a8aeb9 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -500,6 +500,12 @@ static inline void tcg_out_ldrd_r(TCGContext *s, int cond, TCGReg rt,
     tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 0);
 }
 
+static inline void tcg_out_ldrd_rwb(TCGContext *s, int cond, TCGReg rt,
+                                    TCGReg rn, TCGReg rm)
+{
+    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 1);
+}
+
 static inline void tcg_out_strd_8(TCGContext *s, int cond, TCGReg rt,
                                    TCGReg rn, int imm8)
 {
@@ -1229,8 +1235,13 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 
 #define TLB_SHIFT	(CPU_TLB_ENTRY_BITS + CPU_TLB_BITS)
 
-/* We're expecting to use an 8-bit immediate and to mask.  */
-QEMU_BUILD_BUG_ON(CPU_TLB_BITS > 8);
+/* We expect tlb_mask to be before tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
+                  offsetof(CPUArchState, tlb_mask));
+
+/* We expect to use a 20-bit unsigned offset from ENV.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
+                  > 0xfffff);
 
 /* Load and compare a TLB entry, leaving the flags set.  Returns the register
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
@@ -1238,84 +1249,72 @@ QEMU_BUILD_BUG_ON(CPU_TLB_BITS > 8);
 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
                                TCGMemOp opc, int mem_index, bool is_load)
 {
-    TCGReg base = TCG_AREG0;
-    int cmp_off =
-        (is_load
-         ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
-         : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
-    int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
-    int mask_off;
+    int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
+                   : offsetof(CPUTLBEntry, addr_write));
+    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    /* V7 generates the following:
-     *   ubfx   r0, addrlo, #TARGET_PAGE_BITS, #CPU_TLB_BITS
-     *   add    r2, env, #high
-     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    r0, [r2, #cmp]
-     *   ldr    r2, [r2, #add]
-     *   movw   tmp, #page_align_mask
-     *   bic    tmp, addrlo, tmp
-     *   cmp    r0, tmp
-     *
-     * Otherwise we generate:
-     *   shr    tmp, addrlo, #TARGET_PAGE_BITS
-     *   add    r2, env, #high
-     *   and    r0, tmp, #(CPU_TLB_SIZE - 1)
-     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
-     *   ldr    r0, [r2, #cmp]
-     *   ldr    r2, [r2, #add]
-     *   tst    addrlo, #s_mask
-     *   cmpeq  r0, tmp, lsl #TARGET_PAGE_BITS
-     */
-    if (use_armv7_instructions) {
-        tcg_out_extract(s, COND_AL, TCG_REG_R0, addrlo,
-                        TARGET_PAGE_BITS, CPU_TLB_BITS);
-    } else {
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP,
-                        0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
-    }
+    if (table_off > 0xfff) {
+        int mask_hi = mask_off & ~0xfff;
+        int table_hi = table_off & ~0xfff;
+        int rot;
 
-    /* Add portions of the offset until the memory access is in range.
-     * If we plan on using ldrd, reduce to an 8-bit offset; otherwise
-     * we can use a 12-bit offset.  */
-    if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        mask_off = 0xff;
-    } else {
-        mask_off = 0xfff;
-    }
-    while (cmp_off > mask_off) {
-        int shift = ctz32(cmp_off & ~mask_off) & ~1;
-        int rot = ((32 - shift) << 7) & 0xf00;
-        int addend = cmp_off & (0xff << shift);
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
-                        rot | ((cmp_off >> shift) & 0xff));
-        base = TCG_REG_R2;
-        add_off -= addend;
-        cmp_off -= addend;
-    }
-
-    if (!use_armv7_instructions) {
-        tcg_out_dat_imm(s, COND_AL, ARITH_AND,
-                        TCG_REG_R0, TCG_REG_TMP, CPU_TLB_SIZE - 1);
-    }
-    tcg_out_dat_reg(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
-                    TCG_REG_R0, SHIFT_IMM_LSL(CPU_TLB_ENTRY_BITS));
-
-    /* Load the tlb comparator.  Use ldrd if needed and available,
-       but due to how the pointer needs setting up, ldm isn't useful.
-       Base arm5 doesn't have ldrd, but armv5te does.  */
-    if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
-        tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
-    } else {
-        tcg_out_ld32_12(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
-        if (TARGET_LONG_BITS == 64) {
-            tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R2, cmp_off + 4);
+        table_base = TCG_REG_R2;
+        if (mask_hi == table_hi) {
+            mask_base = table_base;
+        } else if (mask_hi) {
+            mask_base = TCG_REG_TMP;
+            rot = encode_imm(mask_hi);
+            assert(rot >= 0);
+            tcg_out_dat_imm(s, COND_AL, ARITH_ADD, mask_base, TCG_AREG0,
+                            rotl(mask_hi, rot) | (rot << 7));
         }
+        rot = encode_imm(table_hi);
+        assert(rot >= 0);
+        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, table_base, TCG_AREG0,
+                        rotl(table_hi, rot) | (rot << 7));
+
+        mask_off -= mask_hi;
+        table_off -= table_hi;
+    }
+
+    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP, mask_base, mask_off);
+    tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R2, table_base, table_off);
+
+    /* Extract the tlb index from the address into TMP.  */
+    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_TMP, TCG_REG_TMP, addrlo,
+                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
+
+    /*
+     * Add the tlb_table pointer, creating the CPUTLBEntry address in R2.
+     * Load the tlb comparator into R0/R1 and the fast path addend into R2.
+     */
+    if (cmp_off == 0) {
+	if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
+            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
+        } else {
+            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R0, TCG_REG_R2, TCG_REG_TMP);
+        }
+    } else {
+        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
+		        TCG_REG_R2, TCG_REG_R2, TCG_REG_TMP, 0);
+        if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
+            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
+        } else {
+            tcg_out_ld32_12(s, COND_AL, TCG_REG_R0, TCG_REG_R2, cmp_off);
+	}
+    }
+    if (!use_armv6_instructions && TARGET_LONG_BITS == 64) {
+        tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R2, cmp_off + 4);
     }
 
     /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2, add_off);
+    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2,
+                    offsetof(CPUTLBEntry, addend));
 
     /* Check alignment.  We don't support inline unaligned acceses,
        but we can easily support overalignment checks.  */
-- 
2.17.2
