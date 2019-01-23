Received: from eggs.gnu.org ([209.51.188.92]:40984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSl-00064i-M1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSj-0004JM-UW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:39 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSj-0004AI-Hs
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:37 -0500
Received: by mail-pg1-x544.google.com with SMTP id z10so1747495pgp.7
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:56:57 -0800
Message-Id: <20190123225705.28963-6-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/13] tcg/ppc: enable dynamic TLB sizing
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
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 91 ++++++++++++++++++++++------------------
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index b51854b5cf..95b735b0bb 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,7 +34,7 @@
 #define TCG_TARGET_NB_REGS 32
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 8c1cfdd7ac..773690f1d9 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -327,6 +327,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LHZ    OPCD( 40)
 #define LHA    OPCD( 42)
 #define LWZ    OPCD( 32)
+#define LWZUX  XO31( 55)
 #define STB    OPCD( 38)
 #define STH    OPCD( 44)
 #define STW    OPCD( 36)
@@ -338,6 +339,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LD     XO58(  0)
 #define LDX    XO31( 21)
 #define LDU    XO58(  1)
+#define LDUX   XO31( 53)
 #define LWA    XO58(  2)
 #define LWAX   XO31(341)
 
@@ -1503,6 +1505,10 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
+/* We expect tlb_mask to be before tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
+                  offsetof(CPUArchState, tlb_mask));
+
 /* Perform the TLB load and compare.  Places the result of the comparison
    in CR7, loads the addend of the TLB into R3, and returns the register
    containing the guest address (zero-extended into R4).  Clobbers R0 and R2. */
@@ -1513,61 +1519,63 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
 {
     int cmp_off
         = (is_read
-           ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
-           : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
-    int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
-    TCGReg base = TCG_AREG0;
+           ? offsetof(CPUTLBEntry, addr_read)
+           : offsetof(CPUTLBEntry, addr_write));
+    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    /* Extract the page index, shifted into place for tlb index.  */
-    if (TCG_TARGET_REG_BITS == 64) {
-        if (TARGET_LONG_BITS == 32) {
-            /* Zero-extend the address into a place helpful for further use. */
-            tcg_out_ext32u(s, TCG_REG_R4, addrlo);
-            addrlo = TCG_REG_R4;
-        } else {
-            tcg_out_rld(s, RLDICL, TCG_REG_R3, addrlo,
-                        64 - TARGET_PAGE_BITS, 64 - CPU_TLB_BITS);
+    if (table_off > 0x7fff) {
+        int mask_hi = mask_off - (int16_t)mask_off;
+        int table_hi = table_off - (int16_t)table_off;
+
+        table_base = TCG_REG_R4;
+        if (mask_hi == table_hi) {
+            mask_base = table_base;
+        } else if (mask_hi) {
+            mask_base = TCG_REG_R3;
+            tcg_out32(s, ADDIS | TAI(mask_base, TCG_AREG0, mask_hi >> 16));
         }
+        tcg_out32(s, ADDIS | TAI(table_base, TCG_AREG0, table_hi >> 16));
+        mask_off -= mask_hi;
+        table_off -= table_hi;
     }
 
-    /* Compensate for very large offsets.  */
-    if (add_off >= 0x8000) {
-        int low = (int16_t)cmp_off;
-        int high = cmp_off - low;
-        assert((high & 0xffff) == 0);
-        assert(cmp_off - high == (int16_t)(cmp_off - high));
-        assert(add_off - high == (int16_t)(add_off - high));
-        tcg_out32(s, ADDIS | TAI(TCG_REG_TMP1, base, high >> 16));
-        base = TCG_REG_TMP1;
-        cmp_off -= high;
-        add_off -= high;
-    }
+    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, mask_base, mask_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R4, table_base, table_off);
 
-    /* Extraction and shifting, part 2.  */
-    if (TCG_TARGET_REG_BITS == 32 || TARGET_LONG_BITS == 32) {
-        tcg_out_rlw(s, RLWINM, TCG_REG_R3, addrlo,
-                    32 - (TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS),
-                    32 - (CPU_TLB_BITS + CPU_TLB_ENTRY_BITS),
-                    31 - CPU_TLB_ENTRY_BITS);
+    /* Extract the page index, shifted into place for tlb index.  */
+    if (TCG_TARGET_REG_BITS == 32) {
+        tcg_out_shri32(s, TCG_REG_TMP1, addrlo,
+                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
     } else {
-        tcg_out_shli64(s, TCG_REG_R3, TCG_REG_R3, CPU_TLB_ENTRY_BITS);
+        tcg_out_shri64(s, TCG_REG_TMP1, addrlo,
+                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
     }
+    tcg_out32(s, AND | SAB(TCG_REG_R3, TCG_REG_R3, TCG_REG_TMP1));
 
-    tcg_out32(s, ADD | TAB(TCG_REG_R3, TCG_REG_R3, base));
-
-    /* Load the tlb comparator.  */
-    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R4, TCG_REG_R3, cmp_off);
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP1, TCG_REG_R3, cmp_off + 4);
+    /* Load the TLB comparator.  */
+    if (cmp_off == 0 && TCG_TARGET_REG_BITS >= TARGET_LONG_BITS) {
+        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || TARGET_LONG_BITS == 32
+                        ? LWZUX : LDUX);
+        tcg_out32(s, lxu | TAB(TCG_REG_TMP1, TCG_REG_R3, TCG_REG_R4));
     } else {
-        tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP1, TCG_REG_R3, cmp_off);
+        tcg_out32(s, ADD | TAB(TCG_REG_R3, TCG_REG_R3, TCG_REG_R4));
+        if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP1, TCG_REG_R3, cmp_off + 4);
+            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R4, TCG_REG_R3, cmp_off);
+        } else {
+            tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP1, TCG_REG_R3, cmp_off);
+        }
     }
 
     /* Load the TLB addend for use on the fast path.  Do this asap
        to minimize any load use delay.  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, TCG_REG_R3, add_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, TCG_REG_R3,
+               offsetof(CPUTLBEntry, addend));
 
     /* Clear the non-page, non-alignment bits from the address */
     if (TCG_TARGET_REG_BITS == 32) {
@@ -1600,6 +1608,9 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
         if (TARGET_LONG_BITS == 32) {
             tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
                         (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
+            /* Zero-extend the address for use in the final address.  */
+            tcg_out_ext32u(s, TCG_REG_R4, addrlo);
+            addrlo = TCG_REG_R4;
         } else if (a_bits == 0) {
             tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - TARGET_PAGE_BITS);
         } else {
-- 
2.17.2
