Received: from eggs.gnu.org ([209.51.188.92]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K5-0005Cg-KV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K4-0007v9-5J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:45 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9K3-0007ot-Rc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:44 -0500
Received: by mail-pf1-x443.google.com with SMTP id w73so8164797pfk.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:58 -0800
Message-Id: <20190128155907.20607-15-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/23] tcg/aarch64: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |   2 +-
 tcg/aarch64/tcg-target.inc.c | 100 +++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 68868a27eb..5085a81060 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -15,7 +15,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 #undef TCG_TARGET_STACK_GROWSUP
 
 typedef enum {
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index ee0d5819af..d57f9e500f 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -498,6 +498,9 @@ typedef enum {
     I3510_EON       = 0x4a200000,
     I3510_ANDS      = 0x6a000000,
 
+    /* Logical shifted register instructions (with a shift).  */
+    I3502S_AND_LSR  = I3510_AND | (1 << 22),
+
     /* AdvSIMD copy */
     I3605_DUP      = 0x0e000400,
     I3605_INS      = 0x4e001c00,
@@ -1448,6 +1451,14 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr;
 }
 
+/* We expect tlb_mask to be before tlb_table.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
+                  offsetof(CPUArchState, tlb_mask));
+
+/* We expect to use a 24-bit unsigned offset from ENV.  */
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
+                  > 0xffffff);
+
 /* Load and compare a TLB entry, emitting the conditional jump to the
    slow path for the failure case, which will be patched later when finalizing
    the slow path. Generated code returns the host addend in X1,
@@ -1456,15 +1467,55 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
-    int tlb_offset = is_read ?
-        offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
-        : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write);
+    int mask_ofs = offsetof(CPUArchState, tlb_mask[mem_index]);
+    int table_ofs = offsetof(CPUArchState, tlb_table[mem_index]);
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_mask = (1u << a_bits) - 1;
     unsigned s_mask = (1u << s_bits) - 1;
-    TCGReg base = TCG_AREG0, x3;
-    uint64_t tlb_mask;
+    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0, x3;
+    TCGType mask_type;
+    uint64_t compare_mask;
+
+    if (table_ofs > 0xfff) {
+        int table_hi = table_ofs & ~0xfff;
+        int mask_hi = mask_ofs & ~0xfff;
+
+        table_base = TCG_REG_X1;
+        if (mask_hi == table_hi) {
+            mask_base = table_base;
+        } else if (mask_hi) {
+            mask_base = TCG_REG_X0;
+            tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
+                         mask_base, TCG_AREG0, mask_hi);
+        }
+        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64,
+                     table_base, TCG_AREG0, table_hi);
+        mask_ofs -= mask_hi;
+        table_ofs -= table_hi;
+    }
+
+    mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
+                 ? TCG_TYPE_I64 : TCG_TYPE_I32);
+
+    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
+    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
+
+    /* Extract the TLB index from the address into X0.  */
+    tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
+                 TCG_REG_X0, TCG_REG_X0, addr_reg,
+                 TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+
+    /* Add the tlb_table pointer, creating the CPUTLBEntry address into X1.  */
+    tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
+
+    /* Load the tlb comparator into X0, and the fast path addend into X1.  */
+    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_X0, TCG_REG_X1, is_read
+               ? offsetof(CPUTLBEntry, addr_read)
+               : offsetof(CPUTLBEntry, addr_write));
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, TCG_REG_X1,
+               offsetof(CPUTLBEntry, addend));
 
     /* For aligned accesses, we check the first byte and include the alignment
        bits within the address.  For unaligned access, we check that we don't
@@ -1476,47 +1527,14 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                      TCG_REG_X3, addr_reg, s_mask - a_mask);
         x3 = TCG_REG_X3;
     }
-    tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
-
-    /* Extract the TLB index from the address into X0.
-       X0<CPU_TLB_BITS:0> =
-       addr_reg<TARGET_PAGE_BITS+CPU_TLB_BITS:TARGET_PAGE_BITS> */
-    tcg_out_ubfm(s, TARGET_LONG_BITS == 64, TCG_REG_X0, addr_reg,
-                 TARGET_PAGE_BITS, TARGET_PAGE_BITS + CPU_TLB_BITS);
+    compare_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
 
     /* Store the page mask part of the address into X3.  */
     tcg_out_logicali(s, I3404_ANDI, TARGET_LONG_BITS == 64,
-                     TCG_REG_X3, x3, tlb_mask);
-
-    /* Add any "high bits" from the tlb offset to the env address into X2,
-       to take advantage of the LSL12 form of the ADDI instruction.
-       X2 = env + (tlb_offset & 0xfff000) */
-    if (tlb_offset & 0xfff000) {
-        tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_X2, base,
-                     tlb_offset & 0xfff000);
-        base = TCG_REG_X2;
-    }
-
-    /* Merge the tlb index contribution into X2.
-       X2 = X2 + (X0 << CPU_TLB_ENTRY_BITS) */
-    tcg_out_insn(s, 3502S, ADD_LSL, TCG_TYPE_I64, TCG_REG_X2, base,
-                 TCG_REG_X0, CPU_TLB_ENTRY_BITS);
-
-    /* Merge "low bits" from tlb offset, load the tlb comparator into X0.
-       X0 = load [X2 + (tlb_offset & 0x000fff)] */
-    tcg_out_ldst(s, TARGET_LONG_BITS == 32 ? I3312_LDRW : I3312_LDRX,
-                 TCG_REG_X0, TCG_REG_X2, tlb_offset & 0xfff,
-                 TARGET_LONG_BITS == 32 ? 2 : 3);
-
-    /* Load the tlb addend. Do that early to avoid stalling.
-       X1 = load [X2 + (tlb_offset & 0xfff) + offsetof(addend)] */
-    tcg_out_ldst(s, I3312_LDRX, TCG_REG_X1, TCG_REG_X2,
-                 (tlb_offset & 0xfff) + (offsetof(CPUTLBEntry, addend)) -
-                 (is_read ? offsetof(CPUTLBEntry, addr_read)
-                  : offsetof(CPUTLBEntry, addr_write)), 3);
+                     TCG_REG_X3, x3, compare_mask);
 
     /* Perform the address comparison. */
-    tcg_out_cmp(s, (TARGET_LONG_BITS == 64), TCG_REG_X0, TCG_REG_X3, 0);
+    tcg_out_cmp(s, TARGET_LONG_BITS == 64, TCG_REG_X0, TCG_REG_X3, 0);
 
     /* If not equal, we jump to the slow path. */
     *label_ptr = s->code_ptr;
-- 
2.17.2
