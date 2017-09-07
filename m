Received: from eggs.gnu.org ([2001:4830:134:3::10]:51969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tu-0002xY-5U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tp-000843-Id
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:06 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tp-00083V-Cf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:01 -0400
Received: by mail-pg0-x236.google.com with SMTP id t3so1832918pgt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:32 -0700
Message-Id: <20170907224051.21518-5-richard.henderson@linaro.org>
In-Reply-To: <20170907224051.21518-1-richard.henderson@linaro.org>
References: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/23] tcg/i386: Store out-of-range call targets
 in constant pool
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

Already it saves 2 bytes per call, but also the constant pool
entry may well be shared across multiple calls.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.h     |  1 +
 tcg/i386/tcg-target.inc.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 11ee7fadd1..b89dababf4 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -189,5 +189,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
 #ifdef CONFIG_SOFTMMU
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1a1ad96906..5231056fd3 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+#include "tcg-pool.inc.c"
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #if TCG_TARGET_REG_BITS == 64
@@ -1180,9 +1182,14 @@ static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
         tcg_out_opc(s, call ? OPC_CALL_Jz : OPC_JMP_long, 0, 0, 0);
         tcg_out32(s, disp);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R10, (uintptr_t)dest);
-        tcg_out_modrm(s, OPC_GRP5,
-                      call ? EXT5_CALLN_Ev : EXT5_JMPN_Ev, TCG_REG_R10);
+        /* rip-relative addressing into the constant pool.
+           This is 6 + 8 = 14 bytes, as compared to using an
+           an immediate load 10 + 6 = 16 bytes, plus we may
+           be able to re-use the pool constant for more calls.  */
+        tcg_out_opc(s, OPC_GRP5, 0, 0, 0);
+        tcg_out8(s, (call ? EXT5_CALLN_Ev : EXT5_JMPN_Ev) << 3 | 5);
+        new_pool_label(s, (uintptr_t)dest, R_386_PC32, s->code_ptr, -4);
+        tcg_out32(s, 0);
     }
 }
 
@@ -2595,6 +2602,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 #endif
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0x90, count);
+}
+
 static void tcg_target_init(TCGContext *s)
 {
 #ifdef CONFIG_CPUID_H
-- 
2.13.5
