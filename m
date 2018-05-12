Received: from eggs.gnu.org ([2001:4830:134:3::10]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdN-0004g1-I5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdM-0002wr-Pd
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:37 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIdM-0002wF-Kr
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:36 -0400
Received: by mail-pg0-x243.google.com with SMTP id g20-v6so3086442pgv.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:59 -0700
Message-Id: <20180512004311.9299-16-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 15/27] target/arm: Fix fp_status_f16
 tininess before rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In commit d81ce0ef2c4f105 we added an extra float_status field
fp_status_fp16 for Arm, but forgot to initialize it correctly
by setting it to float_tininess_before_rounding. This currently
will only cause problems for the new V8_FP16 feature, since the
float-to-float conversion code doesn't use it yet. The effect
would be that we failed to set the Underflow IEEE exception flag
in all the cases where we should.

Add the missing initialization.

Fixes: d81ce0ef2c4f105
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d175c5e94f..7939c6b8ae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -324,6 +324,8 @@ static void arm_cpu_reset(CPUState *s)
                               &env->vfp.fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status);
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &env->vfp.fp_status_f16);
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
-- 
2.17.0
