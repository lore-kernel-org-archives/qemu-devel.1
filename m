Received: from eggs.gnu.org ([209.51.188.92]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbg-00030o-T4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbf-0007ah-UR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbf-0007Zr-OS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id 96so15448449wrb.2
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:54 +0000
Message-Id: <20190118145805.6852-39-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/49] target/arm: Swap PMU values before/after
 migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

Because of the PMU's design, many register accesses have side effects
which are inter-related, meaning that the normal method of saving CP
registers can result in inconsistent state. These side-effects are
largely handled in pmu_op_start/finish functions which can be called
before and after the state is saved/restored. By doing this and adding
raw read/write functions for the affected registers, we avoid
migration-related inconsistencies.

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-4-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c  |  6 ++++--
 target/arm/machine.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c49e0d70cbb..733cfdc5a0f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1459,11 +1459,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 0,
       .access = PL0_RW, .accessfn = pmreg_access_ccntr,
       .type = ARM_CP_IO,
-      .readfn = pmccntr_read, .writefn = pmccntr_write, },
+      .fieldoffset = offsetof(CPUARMState, cp15.c15_ccnt),
+      .readfn = pmccntr_read, .writefn = pmccntr_write,
+      .raw_readfn = raw_read, .raw_writefn = raw_write, },
 #endif
     { .name = "PMCCFILTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 15, .opc2 = 7,
-      .writefn = pmccfiltr_write,
+      .writefn = pmccfiltr_write, .raw_writefn = raw_write,
       .access = PL0_RW, .accessfn = pmreg_access,
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7a22ebc2098..b2925496148 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -620,6 +620,10 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
+    if (!kvm_enabled()) {
+        pmu_op_start(&cpu->env);
+    }
+
     if (kvm_enabled()) {
         if (!write_kvmstate_to_list(cpu)) {
             /* This should never fail */
@@ -641,6 +645,17 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
+static int cpu_post_save(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    if (!kvm_enabled()) {
+        pmu_op_finish(&cpu->env);
+    }
+
+    return 0;
+}
+
 static int cpu_pre_load(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -653,6 +668,10 @@ static int cpu_pre_load(void *opaque)
      */
     env->irq_line_state = UINT32_MAX;
 
+    if (!kvm_enabled()) {
+        pmu_op_start(&cpu->env);
+    }
+
     return 0;
 }
 
@@ -721,6 +740,10 @@ static int cpu_post_load(void *opaque, int version_id)
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
 
+    if (!kvm_enabled()) {
+        pmu_op_finish(&cpu->env);
+    }
+
     return 0;
 }
 
@@ -729,6 +752,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
+    .post_save = cpu_post_save,
     .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
-- 
2.20.1
