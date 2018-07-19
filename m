Received: from eggs.gnu.org ([2001:4830:134:3::10]:55852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8ZS-0004Q2-Tp
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Wf-00075N-ET
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57963 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8We-00074z-UN
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:21 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:55:03 +0200
Message-Id: <1532004912-13899-32-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 31/40] target/mips: Fix ERET/ERETNC behavior
 related to ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Fix ERET/ERETNC so that ADEL exception can be raised.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index c55a1e6..e6749c5 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2430,6 +2430,13 @@ static void set_pc(CPUMIPSState *env, target_ulong error_pc)
     env->active_tc.PC = error_pc & ~(target_ulong)1;
     if (env->insn_flags & ISA_NANOMIPS32) {
         /* Don't clear MIPS_HFLAG_M16 */
+        if (error_pc & 1) {
+            if (!(env->hflags & MIPS_HFLAG_DM)) {
+                env->CP0_BadVAddr = error_pc;
+            }
+            env->active_tc.PC = error_pc;
+            do_raise_exception(env, EXCP_AdEL, 0);
+        }
         return;
     }
     if (error_pc & 1) {
@@ -2467,10 +2474,12 @@ void helper_eretnc(CPUMIPSState *env)
 void helper_deret(CPUMIPSState *env)
 {
     debug_pre_eret(env);
-    set_pc(env, env->CP0_DEPC);
 
     env->hflags &= ~MIPS_HFLAG_DM;
     compute_hflags(env);
+
+    set_pc(env, env->CP0_DEPC);
+
     debug_post_eret(env);
 }
 #endif /* !CONFIG_USER_ONLY */
-- 
2.7.4
