Received: from eggs.gnu.org ([2001:4830:134:3::10]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYjgT-0007n9-JB
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYjgQ-0002xP-O9
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:09 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:43390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYjgQ-0002wN-GG
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 22:35:06 -0500
Received: by mail-pg1-x530.google.com with SMTP id v28so5405958pgk.10
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 19:35:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 16 Dec 2018 19:35:01 -0800
Message-Id: <20181217033501.18073-2-richard.henderson@linaro.org>
In-Reply-To: <20181217033501.18073-1-richard.henderson@linaro.org>
References: <20181217033501.18073-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 01/33] target/sparc: Remove the constant pool
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

Partially reverts ab20bdc1162.  The 14-bit displacement that we
allowed to reach the constant pool is not always sufficient.
Retain the tb-relative addressing, as that is how most return
values from the tb are computed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc/tcg-target.inc.c | 47 ++++++++------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 04bdc3df5e..3237ae6a2f 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -311,24 +311,6 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
         insn &= ~INSN_OFF19(-1);
         insn |= INSN_OFF19(pcrel);
         break;
-    case R_SPARC_13:
-        /* Note that we're abusing this reloc type for our own needs.  */
-        if (!check_fit_ptr(value, 13)) {
-            int adj = (value > 0 ? 0xff8 : -0x1000);
-            value -= adj;
-            assert(check_fit_ptr(value, 13));
-            *code_ptr++ = (ARITH_ADD | INSN_RD(TCG_REG_T2)
-                           | INSN_RS1(TCG_REG_TB) | INSN_IMM13(adj));
-            insn ^= INSN_RS1(TCG_REG_TB) ^ INSN_RS1(TCG_REG_T2);
-        }
-        insn &= ~INSN_IMM13(-1);
-        insn |= INSN_IMM13(value);
-        break;
-    case R_SPARC_32:
-        /* Note that we're abusing this reloc type for our own needs.  */
-        code_ptr[0] = deposit32(code_ptr[0], 0, 22, value >> 10);
-        code_ptr[1] = deposit32(code_ptr[1], 0, 10, value);
-        return;
     default:
         g_assert_not_reached();
     }
@@ -459,6 +441,15 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* A 13-bit constant relative to the TB.  */
+    if (!in_prologue && USE_REG_TB) {
+        test = arg - (uintptr_t)s->code_gen_ptr;
+        if (check_fit_ptr(test, 13)) {
+            tcg_out_arithi(s, ret, TCG_REG_TB, test, ARITH_ADD);
+            return;
+        }
+    }
+
     /* A 32-bit constant, or 32-bit zero-extended to 64-bits.  */
     if (type == TCG_TYPE_I32 || arg == (uint32_t)arg) {
         tcg_out_sethi(s, ret, arg);
@@ -488,26 +479,6 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
-    if (!in_prologue) {
-        if (USE_REG_TB) {
-            intptr_t diff = arg - (uintptr_t)s->code_gen_ptr;
-            if (check_fit_ptr(diff, 13)) {
-                tcg_out_arithi(s, ret, TCG_REG_TB, diff, ARITH_ADD);
-            } else {
-                new_pool_label(s, arg, R_SPARC_13, s->code_ptr,
-                               -(intptr_t)s->code_gen_ptr);
-                tcg_out32(s, LDX | INSN_RD(ret) | INSN_RS1(TCG_REG_TB));
-                /* May be used to extend the 13-bit range in patch_reloc.  */
-                tcg_out32(s, NOP);
-            }
-        } else {
-            new_pool_label(s, arg, R_SPARC_32, s->code_ptr, 0);
-            tcg_out_sethi(s, ret, 0);
-            tcg_out32(s, LDX | INSN_RD(ret) | INSN_RS1(ret) | INSN_IMM13(0));
-        }
-        return;
-    }
-
     /* A 64-bit constant decomposed into 2 32-bit pieces.  */
     if (check_fit_i32(lo, 13)) {
         hi = (arg - lo) >> 32;
-- 
2.17.2
