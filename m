Received: from eggs.gnu.org ([209.51.188.92]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aZ-0000AT-6c
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aY-0007Dd-0W
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aX-00079R-QY
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 10so2048898pfo.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:20 -0700
Message-Id: <20190426172421.27133-15-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 14/15] tcg/arm: Restrict constant pool
 displacement to 12 bits
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

This will not necessarily restrict the size of the TB, since for v7
the majority of constant pool usage is for calls from the out-of-line
ldst code, which is already at the end of the TB.  But this does
allow us to save one insn per reference on the off-chance.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 57 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 12a65cc9a6..abf0c444b4 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -197,6 +197,24 @@ static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     return false;
 }
 
+static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+{
+    ptrdiff_t offset = tcg_ptr_byte_diff(target, code_ptr) - 8;
+
+    if (offset >= -0xfff && offset <= 0xfff) {
+        tcg_insn_unit insn = *code_ptr;
+        bool u = (offset >= 0);
+        if (!u) {
+            offset = -offset;
+        }
+        insn = deposit32(insn, 23, 1, u);
+        insn = deposit32(insn, 0, 12, offset);
+        *code_ptr = insn;
+        return true;
+    }
+    return false;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -205,39 +223,10 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     if (type == R_ARM_PC24) {
         return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
     } else if (type == R_ARM_PC13) {
-        intptr_t diff = value - (uintptr_t)(code_ptr + 2);
-        tcg_insn_unit insn = *code_ptr;
-        bool u;
-
-        if (diff >= -0xfff && diff <= 0xfff) {
-            u = (diff >= 0);
-            if (!u) {
-                diff = -diff;
-            }
-        } else {
-            int rd = extract32(insn, 12, 4);
-            int rt = rd == TCG_REG_PC ? TCG_REG_TMP : rd;
-
-            if (diff < 0x1000 || diff >= 0x100000) {
-                return false;
-            }
-
-            /* add rt, pc, #high */
-            *code_ptr++ = ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
-                           | (TCG_REG_PC << 16) | (rt << 12)
-                           | (20 << 7) | (diff >> 12));
-            /* ldr rd, [rt, #low] */
-            insn = deposit32(insn, 12, 4, rt);
-            diff &= 0xfff;
-            u = 1;
-        }
-        insn = deposit32(insn, 23, 1, u);
-        insn = deposit32(insn, 0, 12, diff);
-        *code_ptr = insn;
+        return reloc_pc13(code_ptr, (tcg_insn_unit *)value);
     } else {
         g_assert_not_reached();
     }
-    return true;
 }
 
 #define TCG_CT_CONST_ARM  0x100
@@ -605,12 +594,8 @@ static inline void tcg_out_ld8s_r(TCGContext *s, int cond, TCGReg rt,
 
 static void tcg_out_movi_pool(TCGContext *s, int cond, int rd, uint32_t arg)
 {
-    /* The 12-bit range on the ldr insn is sometimes a bit too small.
-       In order to get around that we require two insns, one of which
-       will usually be a nop, but may be replaced in patch_reloc.  */
     new_pool_label(s, arg, R_ARM_PC13, s->code_ptr, 0);
     tcg_out_ld32_12(s, cond, rd, TCG_REG_PC, 0);
-    tcg_out_nop(s);
 }
 
 static void tcg_out_movi32(TCGContext *s, int cond, int rd, uint32_t arg)
@@ -1069,8 +1054,8 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
         tcg_out_movi32(s, COND_AL, TCG_REG_TMP, addri);
         tcg_out_blx(s, COND_AL, TCG_REG_TMP);
     } else {
-        /* ??? Know that movi_pool emits exactly 2 insns.  */
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R14, TCG_REG_PC, 4);
+        /* ??? Know that movi_pool emits exactly 1 insn.  */
+        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R14, TCG_REG_PC, 0);
         tcg_out_movi_pool(s, COND_AL, TCG_REG_PC, addri);
     }
 }
-- 
2.17.1
