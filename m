Received: from eggs.gnu.org ([2001:4830:134:3::10]:52671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiI-00085d-3T
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiH-0007OY-2F
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:41 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqiG-0007LI-Rj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:40 -0500
Received: by mail-pf1-x441.google.com with SMTP id y126so3440292pfb.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:18 -0800
Message-Id: <20181130215221.20554-14-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 13/16] tcg/aarch64: Return false on failure
 from patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

This does require an extra two checks within the slow paths
to replace the assert that we're moving.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 16f08c59c4..77f0ca4d5e 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -78,20 +78,26 @@ static const int tcg_target_call_oarg_regs[1] = {
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
-static inline void reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
-    tcg_debug_assert(offset == sextract64(offset, 0, 26));
-    /* read instruction, mask away previous PC_REL26 parameter contents,
-       set the proper offset, then write back the instruction. */
-    *code_ptr = deposit32(*code_ptr, 0, 26, offset);
+    if (offset == sextract64(offset, 0, 26)) {
+        /* read instruction, mask away previous PC_REL26 parameter contents,
+           set the proper offset, then write back the instruction. */
+        *code_ptr = deposit32(*code_ptr, 0, 26, offset);
+        return true;
+    }
+    return false;
 }
 
-static inline void reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
+static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
-    tcg_debug_assert(offset == sextract64(offset, 0, 19));
-    *code_ptr = deposit32(*code_ptr, 5, 19, offset);
+    if (offset == sextract64(offset, 0, 19)) {
+        *code_ptr = deposit32(*code_ptr, 5, 19, offset);
+        return true;
+    }
+    return false;
 }
 
 static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -101,15 +107,12 @@ static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     switch (type) {
     case R_AARCH64_JUMP26:
     case R_AARCH64_CALL26:
-        reloc_pc26(code_ptr, (tcg_insn_unit *)value);
-        break;
+        return reloc_pc26(code_ptr, (tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
-        reloc_pc19(code_ptr, (tcg_insn_unit *)value);
-        break;
+        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
     default:
         tcg_abort();
     }
-    return true;
 }
 
 #define TCG_CT_CONST_AIMM 0x100
@@ -1387,7 +1390,8 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOp opc = get_memop(oi);
     TCGMemOp size = opc & MO_SIZE;
 
-    reloc_pc19(lb->label_ptr[0], s->code_ptr);
+    bool ok = reloc_pc19(lb->label_ptr[0], s->code_ptr);
+    tcg_debug_assert(ok);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
     tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
@@ -1409,7 +1413,8 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOp opc = get_memop(oi);
     TCGMemOp size = opc & MO_SIZE;
 
-    reloc_pc19(lb->label_ptr[0], s->code_ptr);
+    bool ok = reloc_pc19(lb->label_ptr[0], s->code_ptr);
+    tcg_debug_assert(ok);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
     tcg_out_mov(s, TARGET_LONG_BITS == 64, TCG_REG_X1, lb->addrlo_reg);
-- 
2.17.2
