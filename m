Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFb-0002rP-KS
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFa-0002UU-Bn
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:35 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Date: Wed, 10 Oct 2018 16:37:25 -0400
Message-Id: <20181010203735.27918-5-aclindsa@gmail.com>
In-Reply-To: <20181010203735.27918-1-aclindsa@gmail.com>
References: <20181010203735.27918-1-aclindsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/14] target/arm: Swap PMU values
 before/after migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

Because of the PMU's design, many register accesses have side effects
which are inter-related, meaning that the normal method of saving CP
registers can result in inconsistent state. These side-effects are
largely handled in *op_start and *op_finish functions which can be
called globally once before and after the state is saved/restored. By
doing this and adding raw read/write functions for the affected
registers, we avoid such inconsistencies.

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
---
 target/arm/helper.c  |  6 ++++--
 target/arm/machine.c | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8ca4d30797..12c53e54e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1379,11 +1379,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
index ff4ec22bf7..8139b25be5 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -584,6 +584,8 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
+    pmccntr_sync(&cpu->env);
+
     if (kvm_enabled()) {
         if (!write_kvmstate_to_list(cpu)) {
             /* This should never fail */
@@ -605,6 +607,19 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
+static void cpu_post_save(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    pmccntr_sync(&cpu->env);
+}
+
+static int cpu_pre_load(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    pmccntr_sync(&cpu->env);
+    return 0;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -652,6 +667,8 @@ static int cpu_post_load(void *opaque, int version_id)
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
 
+    pmccntr_sync(&cpu->env);
+
     return 0;
 }
 
@@ -660,6 +677,8 @@ const VMStateDescription vmstate_arm_cpu = {
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
+    .post_save = cpu_post_save,
+    .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
-- 
2.19.1
