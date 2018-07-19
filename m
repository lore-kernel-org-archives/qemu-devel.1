Received: from eggs.gnu.org ([2001:4830:134:3::10]:53425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Xf-0003iL-I3
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8WY-00072k-Vo
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:00:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57928 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8WY-00071s-D0
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:14 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:55:02 +0200
Message-Id: <1532004912-13899-31-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 30/40] target/mips: Adjust set_pc() for
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

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
index 5e10286..c55a1e6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2428,6 +2428,10 @@ static void debug_post_eret(CPUMIPSState *env)
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
2.7.4
