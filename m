Received: from eggs.gnu.org ([2001:4830:134:3::10]:50915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDU-0003Hp-83
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDS-0004pl-H6
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:28 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDS-0004pX-An
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:26 -0500
Received: by mail-pg0-x243.google.com with SMTP id 81so1174226pgf.6
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:35 -0800
Message-Id: <20171229063145.29167-29-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 28/38] target/hppa: Implement a halt instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Real hardware would use an external device to control the power.
But for the moment let's invent an instruction in reserved space.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |  1 +
 target/hppa/op_helper.c |  7 +++++++
 target/hppa/translate.c | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1e733b7926..6e86c596fe 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -80,6 +80,7 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tr)
 
 #ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(shutdown, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index d270f94e31..88be2ebf24 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 
 
@@ -639,6 +640,12 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
+void HELPER(shutdown)(CPUHPPAState *env)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    helper_excp(env, EXCP_HLT);
+}
+
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
     target_ulong psw = env->psw;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 00a8c26afa..68f0b86c72 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2293,6 +2293,14 @@ static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
     /* Exit the TB to recognize new interrupts.  */
     return nullify_end(ctx, DISAS_NORETURN);
 }
+
+static DisasJumpType gen_hlt(DisasContext *ctx)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    gen_helper_shutdown(cpu_env);
+    return nullify_end(ctx, DISAS_NORETURN);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
@@ -4510,7 +4518,15 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     case 0x15: /* unassigned */
     case 0x1D: /* unassigned */
     case 0x37: /* unassigned */
-    case 0x3F: /* unassigned */
+        break;
+    case 0x3F:
+#ifndef CONFIG_USER_ONLY
+        /* Unassigned, but use as system-halt.  */
+        if (insn == 0xffffffff) {
+            return gen_hlt(ctx);
+        }
+#endif
+        break;
     default:
         break;
     }
-- 
2.14.3
