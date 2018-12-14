Received: from eggs.gnu.org ([2001:4830:134:3::10]:58856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0y-000635-Bw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0u-0006yP-Ak
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:46 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:45961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0u-0006wi-2W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:44 -0500
Received: by mail-oi1-x233.google.com with SMTP id y1so3443140oie.12
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:06 -0600
Message-Id: <20181214031923.29527-17-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/32] tcg/ppc: Return false on failure from
 patch_reloc
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

The reloc_pc{14,24}_val routines retain their asserts.
Use these directly within the slow paths.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 860b0d36e1..8c1cfdd7ac 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -193,9 +193,14 @@ static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0x3fffffc;
 }
 
-static void reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
-    *pc = (*pc & ~0x3fffffc) | reloc_pc24_val(pc, target);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
+    if (in_range_b(disp)) {
+        *pc = (*pc & ~0x3fffffc) | (disp & 0x3fffffc);
+        return true;
+    }
+    return false;
 }
 
 static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
@@ -205,9 +210,14 @@ static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0xfffc;
 }
 
-static void reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
+static bool reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
-    *pc = (*pc & ~0xfffc) | reloc_pc14_val(pc, target);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
+    if (disp == (int16_t) disp) {
+        *pc = (*pc & ~0xfffc) | (disp & 0xfffc);
+        return true;
+    }
+    return false;
 }
 
 /* parse target specific constraints */
@@ -524,11 +534,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 
     switch (type) {
     case R_PPC_REL14:
-        reloc_pc14(code_ptr, target);
-        break;
+        return reloc_pc14(code_ptr, target);
     case R_PPC_REL24:
-        reloc_pc24(code_ptr, target);
-        break;
+        return reloc_pc24(code_ptr, target);
     case R_PPC_ADDR16:
         /* We are abusing this relocation type.  This points to a pair
            of insns, addis + load.  If the displacement is small, we
@@ -540,7 +548,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         } else {
             int16_t lo = value;
             int hi = value - lo;
-            assert(hi + lo == value);
+            if (hi + lo != value) {
+                return false;
+            }
             code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
             code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
         }
@@ -1638,7 +1648,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOp opc = get_memop(oi);
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    reloc_pc14(lb->label_ptr[0], s->code_ptr);
+    **lb->label_ptr |= reloc_pc14_val(*lb->label_ptr, s->code_ptr);
 
     tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);
 
@@ -1683,7 +1693,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOp s_bits = opc & MO_SIZE;
     TCGReg hi, lo, arg = TCG_REG_R3;
 
-    reloc_pc14(lb->label_ptr[0], s->code_ptr);
+    **lb->label_ptr |= reloc_pc14_val(*lb->label_ptr, s->code_ptr);
 
     tcg_out_mov(s, TCG_TYPE_PTR, arg++, TCG_AREG0);
 
-- 
2.17.2
