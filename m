Received: from eggs.gnu.org ([2001:4830:134:3::10]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuZ-0004oc-9S
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuW-00050z-5Q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTuV-00050M-Uf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id p126-v6so9909152wmb.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:05 +0100
Message-Id: <20180625160009.17437-2-alex.bennee@linaro.org>
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/5] target/arm: support reading of
 CNT[VCT|FRQ]_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
trap..) user-space has been able to read these system registers. As we
can't use QEMUTimer's in linux-user mode we just directly call
cpu_get_clock().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - include CNTFRQ_EL0 for PL0_R only
v3
  - use NANOSECONDS_PER_SECOND / GTIMER_SCALE
---
 target/arm/helper.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1248d84e6f..6e6b1762e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2166,11 +2166,32 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
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
