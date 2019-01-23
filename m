Received: from eggs.gnu.org ([209.51.188.92]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSy-0006EU-AE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSl-0004LN-HV
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSl-0004BC-3Y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:39 -0500
Received: by mail-pg1-x542.google.com with SMTP id z11so1765876pgu.0
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:56:59 -0800
Message-Id: <20190123225705.28963-8-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/13] tcg/s390: enable dynamic TLB sizing
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
 tcg/s390/tcg-target.h     |  2 +-
 tcg/s390/tcg-target.inc.c | 45 +++++++++++++++++----------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 394b545369..357528dd97 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -27,7 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 typedef enum TCGReg {
     TCG_REG_R0 = 0,
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 39ecf609a1..7db90b3bae 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1537,10 +1537,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg data,
 #if defined(CONFIG_SOFTMMU)
 #include "tcg-ldst.inc.c"
 
-/* We're expecting to use a 20-bit signed offset on the tlb memory ops.
-   Using the offset of the second entry in the last tlb table ensures
-   that we can index all of the elements of the first entry.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1][1])
+/* We're expecting to use a 20-bit signed offset on the tlb memory ops.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_mask[NB_MMU_MODES - 1])
+                  > 0x7ffff);
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
                   > 0x7ffff);
 
 /* Load and compare a TLB entry, leaving the flags set.  Loads the TLB
@@ -1552,48 +1552,41 @@ static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp opc,
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_mask = (1 << s_bits) - 1;
     unsigned a_mask = (1 << a_bits) - 1;
+    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
     int ofs, a_off;
     uint64_t tlb_mask;
 
+    tcg_out_sh64(s, RSY_SRLG, TCG_REG_R2, addr_reg, TCG_REG_NONE,
+                 TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+    tcg_out_insn(s, RXY, NG, TCG_REG_R2, TCG_AREG0, TCG_REG_NONE, mask_off);
+    tcg_out_insn(s, RXY, AG, TCG_REG_R2, TCG_AREG0, TCG_REG_NONE, table_off);
+
     /* For aligned accesses, we check the first byte and include the alignment
        bits within the address.  For unaligned access, we check that we don't
        cross pages using the address of the last byte of the access.  */
     a_off = (a_bits >= s_bits ? 0 : s_mask - a_mask);
     tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
-
-    if (s390_facilities & FACILITY_GEN_INST_EXT) {
-        tcg_out_risbg(s, TCG_REG_R2, addr_reg,
-                      64 - CPU_TLB_BITS - CPU_TLB_ENTRY_BITS,
-                      63 - CPU_TLB_ENTRY_BITS,
-                      64 + CPU_TLB_ENTRY_BITS - TARGET_PAGE_BITS, 1);
-        if (a_off) {
-            tcg_out_insn(s, RX, LA, TCG_REG_R3, addr_reg, TCG_REG_NONE, a_off);
-            tgen_andi(s, TCG_TYPE_TL, TCG_REG_R3, tlb_mask);
-        } else {
-            tgen_andi_risbg(s, TCG_REG_R3, addr_reg, tlb_mask);
-        }
+    if ((s390_facilities & FACILITY_GEN_INST_EXT) && a_off == 0) {
+        tgen_andi_risbg(s, TCG_REG_R3, addr_reg, tlb_mask);
     } else {
-        tcg_out_sh64(s, RSY_SRLG, TCG_REG_R2, addr_reg, TCG_REG_NONE,
-                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         tcg_out_insn(s, RX, LA, TCG_REG_R3, addr_reg, TCG_REG_NONE, a_off);
-        tgen_andi(s, TCG_TYPE_I64, TCG_REG_R2,
-                  (CPU_TLB_SIZE - 1) << CPU_TLB_ENTRY_BITS);
         tgen_andi(s, TCG_TYPE_TL, TCG_REG_R3, tlb_mask);
     }
 
     if (is_ld) {
-        ofs = offsetof(CPUArchState, tlb_table[mem_index][0].addr_read);
+        ofs = offsetof(CPUTLBEntry, addr_read);
     } else {
-        ofs = offsetof(CPUArchState, tlb_table[mem_index][0].addr_write);
+        ofs = offsetof(CPUTLBEntry, addr_write);
     }
     if (TARGET_LONG_BITS == 32) {
-        tcg_out_mem(s, RX_C, RXY_CY, TCG_REG_R3, TCG_REG_R2, TCG_AREG0, ofs);
+        tcg_out_insn(s, RX, C, TCG_REG_R3, TCG_REG_R2, TCG_REG_NONE, ofs);
     } else {
-        tcg_out_mem(s, 0, RXY_CG, TCG_REG_R3, TCG_REG_R2, TCG_AREG0, ofs);
+        tcg_out_insn(s, RXY, CG, TCG_REG_R3, TCG_REG_R2, TCG_REG_NONE, ofs);
     }
 
-    ofs = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
-    tcg_out_mem(s, 0, RXY_LG, TCG_REG_R2, TCG_REG_R2, TCG_AREG0, ofs);
+    tcg_out_insn(s, RXY, LG, TCG_REG_R2, TCG_REG_R2, TCG_REG_NONE,
+                 offsetof(CPUTLBEntry, addend));
 
     if (TARGET_LONG_BITS == 32) {
         tgen_ext32u(s, TCG_REG_R3, addr_reg);
-- 
2.17.2
