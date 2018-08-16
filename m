Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlP-0005qG-Np
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl9-00015E-PL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43754 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJl1-0000hA-Do
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:46 +0200
Message-Id: <1534431497-1385-54-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 53/84] target/mips: Adjust set_pc() for
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: James Hogan <james.hogan@mips.com>

ERET and ERETNC shouldn't clear MIPS_HFLAG_M16 for nanoMIPS since there
is no ISA bit, so fix set_pc() to skip the hflags update.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b3eef9f..53c1eea 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2392,6 +2392,9 @@ static void debug_post_eret(CPUMIPSState *env)
 static void set_pc(CPUMIPSState *env, target_ulong error_pc)
 {
     env->active_tc.PC = error_pc & ~(target_ulong)1;
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        return;
+    }
     if (error_pc & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     } else {
-- 
2.7.4
