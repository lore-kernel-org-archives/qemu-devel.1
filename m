Received: from eggs.gnu.org ([2001:4830:134:3::10]:52250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5UA-0003B0-DV
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U5-0008JB-Js
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:22 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5U5-0008Ig-Af
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:17 -0400
Received: by mail-pg0-x235.google.com with SMTP id d8so1804111pgt.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:43 -0700
Message-Id: <20170907224051.21518-16-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/23] tcg/arm: Improve tlb load for armv7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Use UBFX to avoid limitation on CPU_TLB_BITS.  Since we're dropping
the initial shift, we need to replace the page masking.  We can use
MOVW+BIC to do this without shifting.  The result is the same size
as the armv6 path with one less conditional instruction.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 72 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 81ea900852..66c369c239 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1173,18 +1173,33 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
 
-    /* Should generate something like the following:
-     *   shr    tmp, addrlo, #TARGET_PAGE_BITS                    (1)
+    /* V7 generates the following:
+     *   ubfx   r0, addrlo, #TARGET_PAGE_BITS, #CPU_TLB_BITS
      *   add    r2, env, #high
-     *   and    r0, tmp, #(CPU_TLB_SIZE - 1)                      (2)
-     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS               (3)
-     *   ldr    r0, [r2, #cmp]                                    (4)
+     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
+     *   ldr    r0, [r2, #cmp]
+     *   ldr    r2, [r2, #add]
+     *   movw   tmp, #page_align_mask
+     *   bic    tmp, addrlo, tmp
+     *   cmp    r0, tmp
+     *
+     * Otherwise we generate:
+     *   shr    tmp, addrlo, #TARGET_PAGE_BITS
+     *   add    r2, env, #high
+     *   and    r0, tmp, #(CPU_TLB_SIZE - 1)
+     *   add    r2, r2, r0, lsl #CPU_TLB_ENTRY_BITS
+     *   ldr    r0, [r2, #cmp]
+     *   ldr    r2, [r2, #add]
      *   tst    addrlo, #s_mask
-     *   ldr    r2, [r2, #add]                                    (5)
      *   cmpeq  r0, tmp, lsl #TARGET_PAGE_BITS
      */
-    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP,
-                    0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
+    if (use_armv7_instructions) {
+        tcg_out_extract(s, COND_AL, TCG_REG_R0, addrlo,
+                        TARGET_PAGE_BITS, CPU_TLB_BITS);
+    } else {
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP,
+                        0, addrlo, SHIFT_IMM_LSR(TARGET_PAGE_BITS));
+    }
 
     /* We checked that the offset is contained within 16 bits above.  */
     if (add_off > 0xfff || (use_armv6_instructions && cmp_off > 0xff)) {
@@ -1194,9 +1209,10 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         add_off -= cmp_off & 0xff00;
         cmp_off &= 0xff;
     }
-
-    tcg_out_dat_imm(s, COND_AL, ARITH_AND,
-                    TCG_REG_R0, TCG_REG_TMP, CPU_TLB_SIZE - 1);
+    if (!use_armv7_instructions) {
+        tcg_out_dat_imm(s, COND_AL, ARITH_AND,
+                        TCG_REG_R0, TCG_REG_TMP, CPU_TLB_SIZE - 1);
+    }
     tcg_out_dat_reg(s, COND_AL, ARITH_ADD, TCG_REG_R2, base,
                     TCG_REG_R0, SHIFT_IMM_LSL(CPU_TLB_ENTRY_BITS));
 
@@ -1212,24 +1228,40 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         }
     }
 
+    /* Load the tlb addend.  */
+    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2, add_off);
+
     /* Check alignment.  We don't support inline unaligned acceses,
        but we can easily support overalignment checks.  */
     if (a_bits < s_bits) {
         a_bits = s_bits;
     }
-    if (a_bits) {
-        tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, (1 << a_bits) - 1);
-    }
 
-    /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R2, add_off);
+    if (use_armv7_instructions) {
+        tcg_target_ulong mask = ~(TARGET_PAGE_MASK | ((1 << a_bits) - 1));
+        int rot = encode_imm(mask);
 
-    tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP, 0,
-                    TCG_REG_R0, TCG_REG_TMP, SHIFT_IMM_LSL(TARGET_PAGE_BITS));
+        if (rot >= 0) { 
+            tcg_out_dat_imm(s, COND_AL, ARITH_BIC, TCG_REG_TMP, addrlo,
+                            rotl(mask, rot) | (rot << 7));
+        } else {
+            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, mask);
+            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
+                            addrlo, TCG_REG_TMP, 0);
+        }
+        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R0, TCG_REG_TMP, 0);
+    } else {
+        if (a_bits) {
+            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo,
+                            (1 << a_bits) - 1);
+        }
+        tcg_out_dat_reg(s, (a_bits ? COND_EQ : COND_AL), ARITH_CMP,
+                        0, TCG_REG_R0, TCG_REG_TMP,
+                        SHIFT_IMM_LSL(TARGET_PAGE_BITS));
+    }
 
     if (TARGET_LONG_BITS == 64) {
-        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0,
-                        TCG_REG_R1, addrhi, SHIFT_IMM_LSL(0));
+        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R1, addrhi, 0);
     }
 
     return TCG_REG_R2;
-- 
2.13.5
