Received: from eggs.gnu.org ([2001:4830:134:3::10]:48545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Xu-00073I-D5
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1Xp-0005Vc-Cp
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:56:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53521 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1Xp-0005UG-4F
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:56:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:41 +0200
Message-Id: <1532453527-22911-30-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 29/55] target/mips: Adjust
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

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
index a576fa4..371fecf 100644
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
