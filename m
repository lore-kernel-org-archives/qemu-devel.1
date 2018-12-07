Received: from eggs.gnu.org ([2001:4830:134:3::10]:59359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVW-00007P-5a
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVT-00083Y-3E
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:18 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDVS-00082D-Si
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:14 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so3366346otk.3
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:37:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:30 -0600
Message-Id: <20181207103631.28193-26-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 25/26] target/arm: Enable PAuth for user-only,
 part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

FIXME: We should have an attribute that controls the EL1 enable bits.
We may not always want to turn on pointer authentication with -cpu max.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0b185f8d30..bc2c9eb551 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -162,6 +162,12 @@ static void arm_cpu_reset(CPUState *s)
         env->pstate = PSTATE_MODE_EL0t;
         /* Userspace expects access to DC ZVA, CTL_EL0 and the cache ops */
         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
+        /* Enable all PAC keys. */
+        env->cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
+        env->cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
+        /* Enable all PAC instructions */
+        env->cp15.hcr_el2 |= HCR_API;
+        env->cp15.scr_el3 |= SCR_API;
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
-- 
2.17.2
