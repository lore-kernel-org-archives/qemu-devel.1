Received: from eggs.gnu.org ([2001:4830:134:3::10]:59830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPh-00042f-Vb
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPg-0003YI-6k
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:46 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPf-0003Vw-Tb
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:44 -0400
Received: by mail-pg0-x242.google.com with SMTP id 83so822317pgb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:43 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:18 -0700
Message-Id: <20170804054426.10590-16-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 15/23] tcg/arm: Improve tlb load for
 armv7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
2.13.3
