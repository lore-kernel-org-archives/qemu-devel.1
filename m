Received: from eggs.gnu.org ([2001:4830:134:3::10]:39573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabl-0003pe-Gw
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabf-0002nk-Rh
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabf-0002nB-Kv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabe-0001OC-Ny
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:54 +0100
Message-Id: <20180515140707.15957-4-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/16] target/arm: Fix fp_status_f16 tininess
 before rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180512004311.9299-16-richard.henderson@linaro.org
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
