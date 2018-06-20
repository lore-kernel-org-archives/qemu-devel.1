Received: from eggs.gnu.org ([2001:4830:134:3::10]:36631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc0K-0000NB-3X
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc0G-00089H-T1
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:28 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc0G-000863-JQ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:24 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:14 +0100
Message-ID: <20180620120620.12806-30-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 29/35] target/mips: Fix ERET/ERETNC can cause
 ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Fix ERET/ERETNC can cause ADEL exception

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/op_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 6f5e5a3..09ec20a 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2434,6 +2434,13 @@ static void set_pc(CPUMIPSState *env, target_ulong error_pc)
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
@@ -2471,10 +2478,12 @@ void helper_eretnc(CPUMIPSState *env)
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
1.9.1
