Received: from eggs.gnu.org ([2001:4830:134:3::10]:52244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBL-0002y3-Ft
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBK-0000Ch-B1
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:15 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBK-0000CD-4K
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:14 -0500
Received: by mail-pf0-x243.google.com with SMTP id b25so3257050pfd.9
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:12 -0800
Message-Id: <20180128231528.22719-28-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 27/43] target/hppa: Implement halt and reset
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Real hardware would use an external device to control the power.
But for the moment let's invent instructions in reserved space,
to be used by our custom firmware.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |  2 ++
 target/hppa/op_helper.c | 13 +++++++++++++
 target/hppa/translate.c | 25 ++++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1e733b7926..31320740da 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -80,6 +80,8 @@ DEF_HELPER_FLAGS_4(fmpynfadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_0(read_interval_timer, TCG_CALL_NO_RWG, tr)
 
 #ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(shutdown, noreturn, env)
+DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tr)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ef2951386c..37160f0d91 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 
 
@@ -639,6 +640,18 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
     timer_mod(cpu->alarm_timer, timeout);
 }
 
+void HELPER(shutdown)(CPUHPPAState *env)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    helper_excp(env, EXCP_HLT);
+}
+
+void HELPER(reset)(CPUHPPAState *env)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    helper_excp(env, EXCP_HLT);
+}
+
 target_ureg HELPER(swap_system_mask)(CPUHPPAState *env, target_ureg nsm)
 {
     target_ulong psw = env->psw;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f3942b1baf..8c1ae4db78 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2302,6 +2302,18 @@ static DisasJumpType trans_rfi(DisasContext *ctx, uint32_t insn,
     /* Exit the TB to recognize new interrupts.  */
     return nullify_end(ctx, DISAS_NORETURN);
 }
+
+static DisasJumpType gen_hlt(DisasContext *ctx, int reset)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+    nullify_over(ctx);
+    if (reset) {
+        gen_helper_reset(cpu_env);
+    } else {
+        gen_helper_shutdown(cpu_env);
+    }
+    return nullify_end(ctx, DISAS_NORETURN);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
@@ -4519,7 +4531,18 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     case 0x15: /* unassigned */
     case 0x1D: /* unassigned */
     case 0x37: /* unassigned */
-    case 0x3F: /* unassigned */
+        break;
+    case 0x3F:
+#ifndef CONFIG_USER_ONLY
+        /* Unassigned, but use as system-halt.  */
+        if (insn == 0xfffdead0) {
+            return gen_hlt(ctx, 0); /* halt system */
+        }
+        if (insn == 0xfffdead1) {
+            return gen_hlt(ctx, 1); /* reset system */
+        }
+#endif
+        break;
     default:
         break;
     }
-- 
2.14.3
