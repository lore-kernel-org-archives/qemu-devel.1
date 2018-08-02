Received: from eggs.gnu.org ([2001:4830:134:3::10]:33042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEj7-0008Sr-Ne
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEj6-0001Db-VH
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:37:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42784 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEj6-0001DB-Mz
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:37:16 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:37 +0200
Message-Id: <1533219424-7627-51-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 50/77] target/mips: Adjust set_pc() for
 nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: James Hogan <james.hogan@mips.com>

ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
is no ISA bit, so fix set_pc() to skip the hflags update.

Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b3eef9f..6dc6bb6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2392,6 +2392,10 @@ static void debug_post_eret(CPUMIPSState *env)
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
