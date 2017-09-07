Received: from eggs.gnu.org ([2001:4830:134:3::10]:52230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U8-00039U-Vy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5U4-0008IK-9a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:21 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5U4-0008I1-2e
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:16 -0400
Received: by mail-pf0-x229.google.com with SMTP id y29so860349pff.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:42 -0700
Message-Id: <20170907224051.21518-15-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 14/23] tcg/sparc: Use constant pool for movi
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/sparc/tcg-target.h     |  2 ++
 tcg/sparc/tcg-target.inc.c | 77 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index da98743817..d8339bf010 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -175,4 +175,6 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
+#define TCG_TARGET_NEED_POOL_LABELS
+
 #endif
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7d73c25347..bd7c1461c6 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#include "tcg-pool.inc.c"
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "%g0",
@@ -292,33 +294,46 @@ static inline int check_fit_i32(int32_t val, unsigned int bits)
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    uint32_t insn;
+    uint32_t insn = *code_ptr;
+    intptr_t pcrel;
 
-    tcg_debug_assert(addend == 0);
-    value = tcg_ptr_byte_diff((tcg_insn_unit *)value, code_ptr);
+    value += addend;
+    pcrel = tcg_ptr_byte_diff((tcg_insn_unit *)value, code_ptr);
 
     switch (type) {
     case R_SPARC_WDISP16:
-        if (!check_fit_ptr(value >> 2, 16)) {
-            tcg_abort();
-        }
-        insn = *code_ptr;
+        assert(check_fit_ptr(pcrel >> 2, 16));
         insn &= ~INSN_OFF16(-1);
-        insn |= INSN_OFF16(value);
-        *code_ptr = insn;
+        insn |= INSN_OFF16(pcrel);
         break;
     case R_SPARC_WDISP19:
-        if (!check_fit_ptr(value >> 2, 19)) {
-            tcg_abort();
-        }
-        insn = *code_ptr;
+        assert(check_fit_ptr(pcrel >> 2, 19));
         insn &= ~INSN_OFF19(-1);
-        insn |= INSN_OFF19(value);
-        *code_ptr = insn;
+        insn |= INSN_OFF19(pcrel);
+        break;
+    case R_SPARC_13:
+        /* Note that we're abusing this reloc type for our own needs.  */
+        if (!check_fit_ptr(value, 13)) {
+            int adj = (value > 0 ? 0xff8 : -0x1000);
+            value -= adj;
+            assert(check_fit_ptr(value, 13));
+            *code_ptr++ = (ARITH_ADD | INSN_RD(TCG_REG_T2)
+                           | INSN_RS1(TCG_REG_TB) | INSN_IMM13(adj));
+            insn ^= INSN_RS1(TCG_REG_TB) ^ INSN_RS1(TCG_REG_T2);
+        }
+        insn &= ~INSN_IMM13(-1);
+        insn |= INSN_IMM13(value);
         break;
+    case R_SPARC_32:
+        /* Note that we're abusing this reloc type for our own needs.  */
+        code_ptr[0] = deposit32(code_ptr[0], 0, 22, value >> 10);
+        code_ptr[1] = deposit32(code_ptr[1], 0, 10, value);
+        return;
     default:
-        tcg_abort();
+        g_assert_not_reached();
     }
+
+    *code_ptr = insn;
 }
 
 /* parse target specific constraints */
@@ -474,12 +489,24 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
-    if (USE_REG_TB && !in_prologue) {
-        intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
-        if (check_fit_ptr(diff, 13)) {
-            tcg_out_arithi(s, ret, TCG_REG_TB, diff, ARITH_ADD);
-            return;
+    if (!in_prologue) {
+        if (USE_REG_TB) {
+            intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
+            if (check_fit_ptr(diff, 13)) {
+                tcg_out_arithi(s, ret, TCG_REG_TB, diff, ARITH_ADD);
+            } else {
+                new_pool_label(s, arg, R_SPARC_13, s->code_ptr,
+                               -(intptr_t)s->code_gen_ptr);
+                tcg_out32(s, LDX | INSN_RD(ret) | INSN_RS1(TCG_REG_TB));
+                /* May be used to extend the 13-bit range in patch_reloc.  */
+                tcg_out32(s, NOP);
+            }
+        } else {
+            new_pool_label(s, arg, R_SPARC_32, s->code_ptr, 0);
+            tcg_out_sethi(s, ret, 0);
+            tcg_out32(s, LDX | INSN_RD(ret) | INSN_RS1(ret) | INSN_IMM13(0));
         }
+        return;
     }
 
     /* A 64-bit constant decomposed into 2 32-bit pieces.  */
@@ -1058,6 +1085,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 #endif
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    int i;
+    for (i = 0; i < count; ++i) {
+        p[i] = NOP;
+    }
+}
+
 #if defined(CONFIG_SOFTMMU)
 /* Perform the TLB load and compare.
 
-- 
2.13.5
