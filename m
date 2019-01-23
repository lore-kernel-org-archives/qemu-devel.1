Received: from eggs.gnu.org ([209.51.188.92]:41048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSy-0006EQ-88
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSk-0004Jk-BX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:43 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSj-0004DP-Q4
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:38 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so1905425pld.6
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:57:03 -0800
Message-Id: <20190123225705.28963-12-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/13] tcg/mips: enable dynamic TLB sizing
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
 tcg/mips/tcg-target.h     |  2 +-
 tcg/mips/tcg-target.inc.c | 94 ++++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 8600eefd9a..40adbe38cb 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -37,7 +37,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #define TCG_TARGET_NB_REGS 32
 
 typedef enum {
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index c5d7067f89..8a92e916dd 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1201,8 +1201,19 @@ static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
     return i;
 }
 
-/* Perform the tlb comparison operation.  The complete host address is
-   placed in BASE.  Clobbers TMP0, TMP1, TMP2, A0.  */
+/* We expect tlb_mask to be before tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
+                  offsetof(CPUArchState, tlb_mask));
+
+/* We expect tlb_mask to be "near" tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
+                  offsetof(CPUArchState, tlb_mask) >= 0x8000);
+
+/*
+ * Perform the tlb comparison operation.
+ * The complete host address is placed in BASE.
+ * Clobbers TMP0, TMP1, TMP2, TMP3.
+ */
 static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit *label_ptr[2], bool is_load)
@@ -1210,52 +1221,73 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
     TCGMemOp opc = get_memop(oi);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
-    target_ulong mask;
     int mem_index = get_mmuidx(oi);
-    int cmp_off
-        = (is_load
-           ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
-           : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
-    int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
+    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int add_off = offsetof(CPUTLBEntry, addend);
+    int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
+                   : offsetof(CPUTLBEntry, addr_write));
+    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
+    target_ulong mask;
 
-    tcg_out_opc_sa(s, ALIAS_TSRL, TCG_REG_A0, addrl,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-    tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_A0, TCG_REG_A0,
-                    (CPU_TLB_SIZE - 1) << CPU_TLB_ENTRY_BITS);
-    tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, TCG_REG_A0, TCG_AREG0);
+    if (table_off > 0x7fff) {
+        int mask_hi = mask_off - (int16_t)mask_off;
+        int table_hi = table_off - (int16_t)table_off;
 
-    /* Compensate for very large offsets.  */
-    while (add_off >= 0x8000) {
-        /* Most target env are smaller than 32k, but a few are larger than 64k,
-         * so handle an arbitrarily large offset.
-         */
-        tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, TCG_REG_A0, 0x7ff0);
-        cmp_off -= 0x7ff0;
-        add_off -= 0x7ff0;
+        table_base = TCG_TMP1;
+        if (likely(mask_hi == table_hi)) {
+            mask_base = table_base;
+            tcg_out_opc_imm(s, OPC_LUI, mask_base, TCG_REG_ZERO, mask_hi >> 16);
+            tcg_out_opc_reg(s, ALIAS_PADD, mask_base, mask_base, TCG_AREG0);
+            mask_off -= mask_hi;
+            table_off -= mask_hi;
+        } else {
+            if (mask_hi != 0) {
+                mask_base = TCG_TMP0;
+                tcg_out_opc_imm(s, OPC_LUI,
+                                mask_base, TCG_REG_ZERO, mask_hi >> 16);
+                tcg_out_opc_reg(s, ALIAS_PADD,
+                                mask_base, mask_base, TCG_AREG0);
+            }
+            table_off -= mask_off;
+            mask_off -= mask_hi;
+            tcg_out_opc_imm(s, ALIAS_PADDI, table_base, mask_base, mask_off);
+        }
     }
 
+    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, mask_base, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, table_base, table_off);
+
+    /* Extract the TLB index from the address into TMP3.  */
+    tcg_out_opc_sa(s, ALIAS_TSRL, TCG_TMP3, addrl,
+                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+    tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
+
+    /* Add the tlb_table pointer, creating the CPUTLBEntry address in TMP3.  */
+    tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+
     /* We don't currently support unaligned accesses.
        We could do so with mips32r6.  */
     if (a_bits < s_bits) {
         a_bits = s_bits;
     }
 
+    /* Mask the page bits, keeping the alignment bits to compare against.  */
     mask = (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
 
-    /* Load the (low half) tlb comparator.  Mask the page bits, keeping the
-       alignment bits to compare against.  */
+    /* Load the (low-half) tlb comparator.  */
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_REG_A0, cmp_off + LO_OFF);
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3, cmp_off + LO_OFF);
         tcg_out_movi(s, TCG_TYPE_I32, TCG_TMP1, mask);
     } else {
-        tcg_out_ldst(s,
-                    (TARGET_LONG_BITS == 64 ? OPC_LD
-                    : TCG_TARGET_REG_BITS == 64 ? OPC_LWU : OPC_LW),
-                    TCG_TMP0, TCG_REG_A0, cmp_off);
+        tcg_out_ldst(s, (TARGET_LONG_BITS == 64 ? OPC_LD
+                         : TCG_TARGET_REG_BITS == 64 ? OPC_LWU : OPC_LW),
+                     TCG_TMP0, TCG_TMP3, cmp_off);
         tcg_out_movi(s, TCG_TYPE_TL, TCG_TMP1, mask);
         /* No second compare is required here;
            load the tlb addend for the fast path.  */
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_REG_A0, add_off);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_TMP3, add_off);
     }
     tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, addrl);
 
@@ -1271,10 +1303,10 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
     /* Load and test the high half tlb comparator.  */
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         /* delay slot */
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_REG_A0, cmp_off + HI_OFF);
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3, cmp_off + HI_OFF);
 
         /* Load the tlb addend for the fast path.  */
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_REG_A0, add_off);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP2, TCG_TMP3, add_off);
 
         label_ptr[1] = s->code_ptr;
         tcg_out_opc_br(s, OPC_BNE, addrh, TCG_TMP0);
-- 
2.17.2
