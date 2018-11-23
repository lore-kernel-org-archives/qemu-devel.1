Received: from eggs.gnu.org ([2001:4830:134:3::10]:44140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCj1-0000ED-MO
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gQCiv-0003X5-W9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gQCis-0003Qq-4p
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:46:24 -0500
Received: by mail-wr1-x443.google.com with SMTP id z5so8281117wrt.11
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:46:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 23 Nov 2018 15:45:41 +0100
Message-Id: <20181123144558.5048-21-richard.henderson@linaro.org>
In-Reply-To: <20181123144558.5048-1-richard.henderson@linaro.org>
References: <20181123144558.5048-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 v2 20/37] tcg/ppc: Parameterize the
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

When moving the qemu_ld/st arguments to the right place for
a function call, we'll need to move the temps out of the way.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 656a9ff603..6e656cd41e 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1516,12 +1516,14 @@ static void * const qemu_st_helpers[16] = {
 };
 
 /* Perform the TLB load and compare.  Places the result of the comparison
-   in CR7, loads the addend of the TLB into R3, and returns the register
-   containing the guest address (zero-extended into R4).  Clobbers R0 and R2. */
+   in CR7, loads the addend of the TLB, and returns the register containing
+   the guest address, places the addend into T0.
+   Clobbers t0, t1, TCG_REG_R0, TCG_REG_TMP1.  */
 
 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
                                TCGReg addrlo, TCGReg addrhi,
-                               int mem_index, bool is_read)
+                               int mem_index, bool is_read,
+                               TCGReg t0, TCGReg t1)
 {
     int cmp_off
         = (is_read
@@ -1536,10 +1538,10 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
     if (TCG_TARGET_REG_BITS == 64) {
         if (TARGET_LONG_BITS == 32) {
             /* Zero-extend the address into a place helpful for further use. */
-            tcg_out_ext32u(s, TCG_REG_R4, addrlo);
-            addrlo = TCG_REG_R4;
+            tcg_out_ext32u(s, t1, addrlo);
+            addrlo = t1;
         } else {
-            tcg_out_rld(s, RLDICL, TCG_REG_R3, addrlo,
+            tcg_out_rld(s, RLDICL, t0, addrlo,
                         64 - TARGET_PAGE_BITS, 64 - CPU_TLB_BITS);
         }
     }
@@ -1559,27 +1561,27 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
 
     /* Extraction and shifting, part 2.  */
     if (TCG_TARGET_REG_BITS == 32 || TARGET_LONG_BITS == 32) {
-        tcg_out_rlw(s, RLWINM, TCG_REG_R3, addrlo,
+        tcg_out_rlw(s, RLWINM, t0, addrlo,
                     32 - (TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS),
                     32 - (CPU_TLB_BITS + CPU_TLB_ENTRY_BITS),
                     31 - CPU_TLB_ENTRY_BITS);
     } else {
-        tcg_out_shli64(s, TCG_REG_R3, TCG_REG_R3, CPU_TLB_ENTRY_BITS);
+        tcg_out_shli64(s, t0, t0, CPU_TLB_ENTRY_BITS);
     }
 
-    tcg_out32(s, ADD | TAB(TCG_REG_R3, TCG_REG_R3, base));
+    tcg_out32(s, ADD | TAB(t0, t0, base));
 
     /* Load the tlb comparator.  */
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_R4, TCG_REG_R3, cmp_off);
-        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP1, TCG_REG_R3, cmp_off + 4);
+        tcg_out_ld(s, TCG_TYPE_I32, t1, t0, cmp_off);
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP1, t0, cmp_off + 4);
     } else {
-        tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP1, TCG_REG_R3, cmp_off);
+        tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP1, t0, cmp_off);
     }
 
     /* Load the TLB addend for use on the fast path.  Do this asap
        to minimize any load use delay.  */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_R3, TCG_REG_R3, add_off);
+    tcg_out_ld(s, TCG_TYPE_PTR, t0, t0, add_off);
 
     /* Clear the non-page, non-alignment bits from the address */
     if (TCG_TARGET_REG_BITS == 32) {
@@ -1624,7 +1626,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP1,
                     0, 7, TCG_TYPE_I32);
-        tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_R4, 0, 6, TCG_TYPE_I32);
+        tcg_out_cmp(s, TCG_COND_EQ, addrhi, t1, 0, 6, TCG_TYPE_I32);
         tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
     } else {
         tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP1,
@@ -1778,13 +1780,14 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, true);
+    rbase = TCG_REG_R3;
+    addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, true,
+                              rbase, TCG_REG_R4);
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
     tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
 
-    rbase = TCG_REG_R3;
 #else  /* !CONFIG_SOFTMMU */
     rbase = guest_base ? TCG_GUEST_BASE_REG : 0;
     if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
@@ -1853,13 +1856,14 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 
 #ifdef CONFIG_SOFTMMU
     mem_index = get_mmuidx(oi);
-    addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, false);
+    rbase = TCG_REG_R3;
+    addrlo = tcg_out_tlb_read(s, opc, addrlo, addrhi, mem_index, false,
+                              rbase, TCG_REG_R4);
 
     /* Load a pointer into the current opcode w/conditional branch-link. */
     label_ptr = s->code_ptr;
     tcg_out_bc_noaddr(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
 
-    rbase = TCG_REG_R3;
 #else  /* !CONFIG_SOFTMMU */
     rbase = guest_base ? TCG_GUEST_BASE_REG : 0;
     if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
-- 
2.17.2
