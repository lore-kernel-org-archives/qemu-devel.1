Received: from eggs.gnu.org ([2001:4830:134:3::10]:42794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKK-0003Y6-KP
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKJ-0005Ce-Dz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:04 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:18 -0500
Message-Id: <20180723201748.25573-70-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 69/99] target/arm: Fix fp_status_f16 tininess
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
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180512004311.9299-16-richard.henderson@linaro.org
(cherry picked from commit bcc531f0364796104df4443d17f99b5fb494eca2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 022d8c5787..7ebe3fcadf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -311,6 +311,8 @@ static void arm_cpu_reset(CPUState *s)
                               &env->vfp.fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status);
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &env->vfp.fp_status_f16);
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
-- 
2.17.1
