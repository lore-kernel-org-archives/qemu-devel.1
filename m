Received: from eggs.gnu.org ([209.51.188.92]:51475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBz-000110-J2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBy-0006Uf-1A
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqeBx-0006TC-Nd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so13435659wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:21:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:21:26 +0000
Message-Id: <20190204132126.3255-5-richard.henderson@linaro.org>
In-Reply-To: <20190204132126.3255-1-richard.henderson@linaro.org>
References: <20190204132126.3255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 4/4] target/arm: Enable TBI for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This has been enabled in the linux kernel since v3.11
(commit d50240a5f6cea, 2013-09-03,
"arm64: mm: permit use of tagged pointers at EL0").

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3874dc9875..edf6e0e1f1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -200,6 +200,12 @@ static void arm_cpu_reset(CPUState *s)
         env->vfp.zcr_el[1] = cpu->sve_max_vq - 1;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
+        /*
+         * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
+         * turning on both here will produce smaller code and otherwise
+         * make no difference to the user-level emulation.
+         */
+        env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.17.2
