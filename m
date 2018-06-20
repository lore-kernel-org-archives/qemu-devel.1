Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzo-0008Kb-0w
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzk-0007rW-Qf
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:56 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:50615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbzk-0007mm-Hy
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:13:52 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:11 +0100
Message-ID: <20180620120620.12806-27-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 26/35] target/mips: Fix nanoMIPS
 exception_resume_pc
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

We shouldn't set the ISA bit in CP0_EPC for nanoMIPS.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 9535131..20a81aa 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -656,7 +656,8 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
     target_ulong bad_pc;
     target_ulong isa_mode;
 
-    isa_mode = !!(env->hflags & MIPS_HFLAG_M16);
+    isa_mode = env->hflags & MIPS_HFLAG_M16 &&
+                !(env->insn_flags & ISA_NANOMIPS32);
     bad_pc = env->active_tc.PC | isa_mode;
     if (env->hflags & MIPS_HFLAG_BMASK) {
         /* If the exception was raised from a delay slot, come back to
-- 
1.9.1
