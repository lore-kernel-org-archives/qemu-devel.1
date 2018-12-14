Received: from eggs.gnu.org ([2001:4830:134:3::10]:58868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe12-00067K-DK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0x-00076F-CH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:50 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:32912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0v-0006zo-5X
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:46 -0500
Received: by mail-oi1-x229.google.com with SMTP id c206so3495243oib.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:07 -0600
Message-Id: <20181214031923.29527-18-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/32] tcg/s390x: Return false on failure from
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
to replace the assert that we're moving.  Also add two checks
within existing functions that lacked any kind of assert for
out of range branch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.inc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 68a4c60394..39ecf609a1 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -377,23 +377,29 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 
     switch (type) {
     case R_390_PC16DBL:
-        assert(pcrel2 == (int16_t)pcrel2);
-        tcg_patch16(code_ptr, pcrel2);
+        if (pcrel2 == (int16_t)pcrel2) {
+            tcg_patch16(code_ptr, pcrel2);
+            return true;
+        }
         break;
     case R_390_PC32DBL:
-        assert(pcrel2 == (int32_t)pcrel2);
-        tcg_patch32(code_ptr, pcrel2);
+        if (pcrel2 == (int32_t)pcrel2) {
+            tcg_patch32(code_ptr, pcrel2);
+            return true;
+        }
         break;
     case R_390_20:
-        assert(value == sextract64(value, 0, 20));
-        old = *(uint32_t *)code_ptr & 0xf00000ff;
-        old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
-        tcg_patch32(code_ptr, old);
+        if (value == sextract64(value, 0, 20)) {
+            old = *(uint32_t *)code_ptr & 0xf00000ff;
+            old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
+            tcg_patch32(code_ptr, old);
+            return true;
+        }
         break;
     default:
         g_assert_not_reached();
     }
-    return true;
+    return false;
 }
 
 /* parse target specific constraints */
@@ -1334,6 +1340,7 @@ static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
 
     if (l->has_value) {
         off = l->u.value_ptr - s->code_ptr;
+        tcg_debug_assert(off == (int16_t)off);
     } else {
         tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
@@ -1350,6 +1357,7 @@ static void tgen_compare_imm_branch(TCGContext *s, S390Opcode opc, int cc,
 
     if (l->has_value) {
         off = l->u.value_ptr - s->code_ptr;
+        tcg_debug_assert(off == (int16_t)off);
     } else {
         tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
@@ -1615,7 +1623,9 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
+    bool ok = patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
+                          (intptr_t)s->code_ptr, 2);
+    tcg_debug_assert(ok);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1636,7 +1646,9 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
+    bool ok = patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
+                          (intptr_t)s->code_ptr, 2);
+    tcg_debug_assert(ok);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
-- 
2.17.2
