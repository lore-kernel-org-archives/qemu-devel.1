Received: from eggs.gnu.org ([2001:4830:134:3::10]:40770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjFu-0006ij-6Y
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjFq-0001DB-3m
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:25:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42970 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmjFp-0001BB-Qr
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:25:14 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:16 +0200
Message-Id: <1533574847-19294-50-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 49/80] target/mips: Adjust
 exception_resume_pc() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: James Hogan <james.hogan@mips.com>

We shouldn't set the ISA bit in CP0_EPC for nanoMIPS.

Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index b25e000..b429671 100644
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
2.7.4
