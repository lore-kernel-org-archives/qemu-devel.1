Received: from eggs.gnu.org ([209.51.188.92]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVi-0001BV-9X
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVh-0006zj-9P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVh-0006z8-2q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so7684970pfo.5
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Apr 2019 08:38:52 -0700
Message-Id: <20190423153853.19790-7-richard.henderson@linaro.org>
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 6/7] tcg/ppc: Allow the constant pool to
 overflow at 32k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com

There is no point in coding for a 2GB offset when the max TB size
is already limited to 64k.  If we further restrict to 32k then we
can eliminate the extra ADDIS instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c0923ced4f..36b4791707 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -529,7 +529,6 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_insn_unit *target;
-    tcg_insn_unit old;
 
     value += addend;
     target = (tcg_insn_unit *)value;
@@ -540,22 +539,16 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
     case R_PPC_ADDR16:
-        /* We are abusing this relocation type.  This points to a pair
-           of insns, addis + load.  If the displacement is small, we
-           can nop out the addis.  */
-        if (value == (int16_t)value) {
-            code_ptr[0] = NOP;
-            old = deposit32(code_ptr[1], 0, 16, value);
-            code_ptr[1] = deposit32(old, 16, 5, TCG_REG_TB);
-        } else {
-            int16_t lo = value;
-            int hi = value - lo;
-            if (hi + lo != value) {
-                return false;
-            }
-            code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
-            code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+        /*
+         * We are (slightly) abusing this relocation type.  In particular,
+         * assert that the low 2 bits are zero, and do not modify them.
+         * That way we can use this with LD et al that have opcode bits
+         * in the low 2 bits of the insn.
+         */
+        if ((value & 3) || value != (int16_t)value) {
+            return false;
         }
+        *code_ptr = (*code_ptr & ~0xfffc) | (value & 0xfffc);
         break;
     default:
         g_assert_not_reached();
@@ -701,8 +694,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        -(intptr_t)s->code_gen_ptr);
-        tcg_out32(s, ADDIS | TAI(ret, TCG_REG_TB, 0));
-        tcg_out32(s, LD | TAI(ret, ret, 0));
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
 
-- 
2.17.1
