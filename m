Received: from eggs.gnu.org ([2001:4830:134:3::10]:32828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea6Ws-0008Mx-AR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea6Wr-0002lx-CU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:22 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea6Wr-0002lR-6Z
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:06:21 -0500
Received: by mail-pg0-x241.google.com with SMTP id j2so5355981pgv.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:06:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 12 Jan 2018 13:06:11 -0800
Message-Id: <20180112210613.14124-3-richard.henderson@linaro.org>
In-Reply-To: <20180112210613.14124-1-richard.henderson@linaro.org>
References: <20180112210613.14124-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/4] tcg/arm: Support tlb offsets larger than 64k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

AArch64 with SVE has an offset of 80k to the 8th TLB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index b9890c8bd8..4bd465732b 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1261,12 +1261,6 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
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
 
@@ -1279,6 +1273,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
          ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
          : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
     int add_off = offsetof(CPUArchState, tlb_table[mem_index][0].addend);
+    int mask_off;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
@@ -1310,16 +1305,25 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
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
+    while (add_off > mask_off) {
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
