Received: from eggs.gnu.org ([209.51.188.92]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSj-00063J-Gk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSf-0004Gz-Ll
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:37 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRST-0004Ah-66
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:26 -0500
Received: by mail-pl1-x643.google.com with SMTP id w4so1920755plz.1
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:56:58 -0800
Message-Id: <20190123225705.28963-7-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/13] tcg/sparc: enable dynamic TLB sizing
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
 tcg/sparc/tcg-target.h     |  2 +-
 tcg/sparc/tcg-target.inc.c | 82 +++++++++++++++++++++++---------------
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index dc0a227890..6020a670c0 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -29,7 +29,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 55144c437c..7a61839dc1 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1074,54 +1074,72 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
    The result of the TLB comparison is in %[ix]cc.  The sanitized address
    is in the returned register, maybe %o0.  The TLB addend is in %o1.  */
 
+/* We expect tlb_mask to be before tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
+                  offsetof(CPUArchState, tlb_mask));
+
+/* We expect tlb_mask to be "near" tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
+                  offsetof(CPUArchState, tlb_mask) >= (1 << 13));
+
 static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,
                                TCGMemOp opc, int which)
 {
+    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    TCGReg base = TCG_AREG0;
     const TCGReg r0 = TCG_REG_O0;
     const TCGReg r1 = TCG_REG_O1;
     const TCGReg r2 = TCG_REG_O2;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
-    int tlb_ofs;
+    tcg_target_long compare_mask;
 
-    /* Shift the page number down.  */
-    tcg_out_arithi(s, r1, addr, TARGET_PAGE_BITS, SHIFT_SRL);
+    if (!check_fit_i32(table_off, 13)) {
+        int table_hi;
+
+        base = r1;
+        if (table_off <= 2 * 0xfff) {
+            table_hi = 0xfff;
+            tcg_out_arithi(s, base, TCG_AREG0, table_hi, ARITH_ADD);
+        } else {
+            table_hi = table_off & ~0x3ff;
+            tcg_out_sethi(s, base, table_hi);
+            tcg_out_arith(s, base, TCG_AREG0, base, ARITH_ADD);
+        }
+        mask_off -= table_hi;
+        table_off -= table_hi;
+        tcg_debug_assert(check_fit_i32(mask_off, 13));
+    }
+
+    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+    tcg_out_ld(s, TCG_TYPE_PTR, r0, base, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, r1, base, table_off);
+
+    /* Extract the page index, shifted into place for tlb index.  */
+    tcg_out_arithi(s, r2, addr, TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS,
+                   SHIFT_SRL);
+    tcg_out_arith(s, r2, r2, r0, ARITH_AND);
+
+    /* Add the tlb_table pointer, creating the CPUTLBEntry address into R2.  */
+    tcg_out_arith(s, r2, r2, r1, ARITH_ADD);
+
+    /* Load the tlb comparator and the addend.  */
+    tcg_out_ld(s, TCG_TYPE_TL, r0, r2, which);
+    tcg_out_ld(s, TCG_TYPE_PTR, r1, r2, offsetof(CPUTLBEntry, addend));
 
     /* Mask out the page offset, except for the required alignment.
        We don't support unaligned accesses.  */
     if (a_bits < s_bits) {
         a_bits = s_bits;
     }
-    tcg_out_movi(s, TCG_TYPE_TL, TCG_REG_T1,
-                 TARGET_PAGE_MASK | ((1 << a_bits) - 1));
-
-    /* Mask the tlb index.  */
-    tcg_out_arithi(s, r1, r1, CPU_TLB_SIZE - 1, ARITH_AND);
-    
-    /* Mask page, part 2.  */
-    tcg_out_arith(s, r0, addr, TCG_REG_T1, ARITH_AND);
-
-    /* Shift the tlb index into place.  */
-    tcg_out_arithi(s, r1, r1, CPU_TLB_ENTRY_BITS, SHIFT_SLL);
-
-    /* Relative to the current ENV.  */
-    tcg_out_arith(s, r1, TCG_AREG0, r1, ARITH_ADD);
-
-    /* Find a base address that can load both tlb comparator and addend.  */
-    tlb_ofs = offsetof(CPUArchState, tlb_table[mem_index][0]);
-    if (!check_fit_ptr(tlb_ofs + sizeof(CPUTLBEntry), 13)) {
-        if (tlb_ofs & ~0x3ff) {
-            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T1, tlb_ofs & ~0x3ff);
-            tcg_out_arith(s, r1, r1, TCG_REG_T1, ARITH_ADD);
-        }
-        tlb_ofs &= 0x3ff;
+    compare_mask = (tcg_target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
+    if (check_fit_tl(compare_mask, 13)) {
+        tcg_out_arithi(s, r2, addr, compare_mask, ARITH_AND);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_TL, r2, compare_mask);
+        tcg_out_arith(s, r2, addr, r2, ARITH_AND);
     }
-
-    /* Load the tlb comparator and the addend.  */
-    tcg_out_ld(s, TCG_TYPE_TL, r2, r1, tlb_ofs + which);
-    tcg_out_ld(s, TCG_TYPE_PTR, r1, r1, tlb_ofs+offsetof(CPUTLBEntry, addend));
-
-    /* subcc arg0, arg2, %g0 */
     tcg_out_cmp(s, r0, r2, 0);
 
     /* If the guest address must be zero-extended, do so now.  */
-- 
2.17.2
