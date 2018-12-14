Received: from eggs.gnu.org ([2001:4830:134:3::10]:58839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0u-0005zj-AN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0t-0006vU-BX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:44 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:36795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0s-0006tM-VJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:43 -0500
Received: by mail-oi1-x234.google.com with SMTP id x23so3480325oix.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:05 -0600
Message-Id: <20181214031923.29527-16-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/32] tcg/arm: Return false on failure from
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

This does require an extra two checks within the slow paths
to replace the assert that we're moving.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index deefa20fbf..49f57d655e 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -187,10 +187,14 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_GTU] = COND_HI,
 };
 
-static inline void reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
-    *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
+    if (offset == sextract32(offset, 0, 24)) {
+        *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
+        return true;
+    }
+    return false;
 }
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -199,7 +203,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     tcg_debug_assert(addend == 0);
 
     if (type == R_ARM_PC24) {
-        reloc_pc24(code_ptr, (tcg_insn_unit *)value);
+        return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
     } else if (type == R_ARM_PC13) {
         intptr_t diff = value - (uintptr_t)(code_ptr + 2);
         tcg_insn_unit insn = *code_ptr;
@@ -213,7 +217,11 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         } else {
             int rd = extract32(insn, 12, 4);
             int rt = rd == TCG_REG_PC ? TCG_REG_TMP : rd;
-            assert(diff >= 0x1000 && diff < 0x100000);
+
+            if (diff < 0x1000 || diff >= 0x100000) {
+                return false;
+            }
+
             /* add rt, pc, #high */
             *code_ptr++ = ((insn & 0xf0000000) | (1 << 25) | ARITH_ADD
                            | (TCG_REG_PC << 16) | (rt << 12)
@@ -1372,7 +1380,8 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOp opc = get_memop(oi);
     void *func;
 
-    reloc_pc24(lb->label_ptr[0], s->code_ptr);
+    bool ok = reloc_pc24(lb->label_ptr[0], s->code_ptr);
+    tcg_debug_assert(ok);
 
     argreg = tcg_out_arg_reg32(s, TCG_REG_R0, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1432,7 +1441,8 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    reloc_pc24(lb->label_ptr[0], s->code_ptr);
+    bool ok = reloc_pc24(lb->label_ptr[0], s->code_ptr);
+    tcg_debug_assert(ok);
 
     argreg = TCG_REG_R0;
     argreg = tcg_out_arg_reg32(s, argreg, TCG_AREG0);
-- 
2.17.2
