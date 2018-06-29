Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun4-0007lZ-7x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun3-0007Wy-EU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun3-0007UV-7c
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun2-0004mZ-4Y
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:34 +0100
Message-Id: <20180629145347.652-43-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/55] target/arm: support reading of
 CNT[VCT|FRQ]_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
trap..), released in kernel version v4.12, user-space has been able
to read these system registers. As we can't use QEMUTimer's in
linux-user mode we just directly call cpu_get_clock().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180625160009.17437-2-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b19c7ace785..d0786e0c210 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2167,11 +2167,32 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
 };
 
 #else
-/* In user-mode none of the generic timer registers are accessible,
- * and their implementation depends on QEMU_CLOCK_VIRTUAL and qdev gpio outputs,
- * so instead just don't register any of them.
+
+/* In user-mode most of the generic timer registers are inaccessible
+ * however modern kernels (4.12+) allow access to cntvct_el0
  */
+
+static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Currently we have no support for QEMUTimer in linux-user so we
+     * can't call gt_get_countervalue(env), instead we directly
+     * call the lower level functions.
+     */
+    return cpu_get_clock() / GTIMER_SCALE;
+}
+
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
+    { .name = "CNTFRQ_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
+      .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
+      .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
+      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
+    },
+    { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
+      .access = PL0_R, .type = ARM_CP_NO_RAW | ARM_CP_IO,
+      .readfn = gt_virt_cnt_read,
+    },
     REGINFO_SENTINEL
 };
 
-- 
2.17.1
