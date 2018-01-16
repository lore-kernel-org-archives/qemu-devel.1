Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNI-0000UJ-B5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebUNE-0008Ox-31
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:12 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebUND-0008Oa-Tc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:46:08 -0500
Received: by mail-pg0-x242.google.com with SMTP id n17so2201133pgf.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:46:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Jan 2018 08:45:58 -0800
Message-Id: <20180116164600.7480-3-richard.henderson@linaro.org>
In-Reply-To: <20180116164600.7480-1-richard.henderson@linaro.org>
References: <20180116164600.7480-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 2/4] tcg/arm: Support tlb offsets larger than
 64k
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

AArch64 with SVE has an offset of 80k to the 8th TLB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index d7b09e8e0c..dc83f3e5be 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1247,12 +1247,6 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 /* We're expecting to use an 8-bit immediate and to mask.  */
 QEMU_BUILD_BUG_ON(CPU_TLB_BITS > 8);
 
-/* We're expecting to use an 8-bit immediate add + 8-bit ldrd offset.
-   Using the offset of the second entry in the last tlb table ensures
-   that we can index all of the elements of the first entry.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1][1])
-                  > 0xffff);
-
 /* Load and compare a TLB entry, leaving the flags set.  Returns the register
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */
 
@@ -1265,6 +1259,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
          ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
          : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
     int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
+    int mask_off;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
@@ -1296,16 +1291,25 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
                         0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
     }
 
-    /* We checked that the offset is contained within 16 bits above.  */
-    if (add_off > 0xfff
-        || (use_armv6_instructions && TARGET_LONG_BITS == 64
-            && cmp_off > 0xff)) {
+    /* Add portions of the offset until the memory access is in range.
+     * If we plan on using ldrd, reduce to an 8-bit offset; otherwise
+     * we can use a 12-bit offset.  */
+    if (use_armv6_instructions && TARGET_LONG_BITS == 64) {
+        mask_off = 0xff;
+    } else {
+        mask_off = 0xfff;
+    }
+    while (cmp_off > mask_off) {
+        int shift = ctz32(cmp_off & ~mask_off) & ~1;
+        int rot = ((32 - shift) << 7) & 0xf00;
+        int addend = cmp_off & (0xff << shift);
         tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
-                        (24 << 7) | (cmp_off >> 8));
+                        rot | ((cmp_off >> shift) & 0xff));
         base = TCG_REG_R2;
-        add_off -= cmp_off & 0xff00;
-        cmp_off &= 0xff;
+        add_off -= addend;
+        cmp_off -= addend;
     }
+
     if (!use_armv7_instructions) {
         tcg_out_dat_imm(s, COND_AL, ARITH_AND,
                         TCG_REG_R0, TCG_REG_TMP, CPU_TLB_SIZE - 1);
-- 
2.14.3
