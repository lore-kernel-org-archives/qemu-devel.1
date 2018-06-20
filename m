Received: from eggs.gnu.org ([2001:4830:134:3::10]:36596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc09-0000BF-Cv
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc06-00084X-5Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:17 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:55708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc05-00080i-Rl
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:14 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:13 +0100
Message-ID: <20180620120620.12806-29-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 28/35] target/mips: Fix nanoMIPS set_pc
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

From: James Hogan <james.hogan@imgtec.com>

ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
is no ISA bit, so fix set_pc() to skip the hflags update.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9946f77..6f5e5a3 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2432,6 +2432,10 @@ static void debug_post_eret(CPUMIPSState *env)
 static void set_pc(CPUMIPSState *env, target_ulong error_pc)
 {
     env->active_tc.PC = error_pc & ~(target_ulong)1;
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        /* Don't clear MIPS_HFLAG_M16 */
+        return;
+    }
     if (error_pc & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     } else {
-- 
1.9.1
