Received: from eggs.gnu.org ([209.51.188.92]:59781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1h3GNN-0001pJ-R9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1h3GJX-0004Kp-St
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:29:41 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Mon, 11 Mar 2019 16:29:23 +0800
Message-ID: <1552292963-19430-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RESEND PATCH] target/arm: change arch timer registers
 access permission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, gengdongjiu@huawei.com

From: Dongjiu Geng <gengdongjiu@huawei.com>

Some generic arch timer registers are Config-RW in the EL0,
which means the EL0 exception level can have write permission
if it is appropriately configured.

When VM access registers, it firstly checks whether they have RW
permission, then check whether it is appropriately configured.
If they are defined to Ready only in EL0, even though they have been
appropriately configured, they still do not have write permission.
So need to add the write permission according to ARMV8 spec when
define it.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
When kernel or Hypervisor configures the timer registers to RW in EL0
user space, it will still have below panic when EL0 user space access
the timer registers.

[INFO ]@(el0_sync:60): UNIMPLEMENTED, esr=2000000
[INFO ]@(unimpl_exception:88): KERNEL UNIMPLEMENTED EXCEPTION
[INFO ]@(unimpl_exception:98): FAR=0000000000000000, ESR=02000000 (EC=0x0, IL=0x1, ISS=0x0)
[INFO ]@(dump_registers:64): KERNEL REGISTERS
[INFO ]@(dump_registers:68): X0=00000000f52b7d50 X1=00000000040d5040
[INFO ]@(dump_registers:68): X2=0000004000033e10 X3=0000000000000000
[INFO ]@(dump_registers:68): X4=000000007fffffff X5=0000000000000020
[INFO ]@(dump_registers:68): X6=0000000000000020 X7=000000000c00b030
---
 target/arm/helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2607d39..3db94c6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2665,7 +2665,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* per-timer control */
     { .name = "CNTP_CTL", .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
       .secure = ARM_CP_SECSTATE_NS,
-      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_PHYS].ctl),
@@ -2674,7 +2674,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTP_CTL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
       .secure = ARM_CP_SECSTATE_S,
-      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_SEC].ctl),
@@ -2682,14 +2682,14 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
     { .name = "CNTP_CTL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 1,
-      .type = ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .resetvalue = 0,
       .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CTL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 1,
-      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_RW,
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetoflow32(CPUARMState,
                                    cp15.c14_timer[GTIMER_VIRT].ctl),
@@ -2697,7 +2697,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
     { .name = "CNTV_CTL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_vtimer_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .resetvalue = 0,
@@ -2706,31 +2706,31 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* TimerValue views: a 32 bit downcounting view of the underlying state */
     { .name = "CNTP_TVAL", .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
       .secure = ARM_CP_SECSTATE_NS,
-      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access,
       .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
     },
     { .name = "CNTP_TVAL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
       .secure = ARM_CP_SECSTATE_S,
-      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access,
       .readfn = gt_sec_tval_read, .writefn = gt_sec_tval_write,
     },
     { .name = "CNTP_TVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 0,
-      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_ptimer_access, .resetfn = gt_phys_timer_reset,
       .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
     },
     { .name = "CNTV_TVAL", .cp = 15, .crn = 14, .crm = 3, .opc1 = 0, .opc2 = 0,
-      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_vtimer_access,
       .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
     },
     { .name = "CNTV_TVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
+      .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_RW,
       .accessfn = gt_vtimer_access, .resetfn = gt_virt_timer_reset,
       .readfn = gt_virt_tval_read, .writefn = gt_virt_tval_write,
     },
@@ -2758,7 +2758,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     /* Comparison value, indicating when the timer goes off */
     { .name = "CNTP_CVAL", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_NS,
-      .access = PL1_RW | PL0_R,
+      .access = PL1_RW | PL0_RW,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .accessfn = gt_ptimer_access,
@@ -2766,7 +2766,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
     { .name = "CNTP_CVAL_S", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_S,
-      .access = PL1_RW | PL0_R,
+      .access = PL1_RW | PL0_RW,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_SEC].cval),
       .accessfn = gt_ptimer_access,
@@ -2774,14 +2774,14 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
     { .name = "CNTP_CVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 2, .opc2 = 2,
-      .access = PL1_RW | PL0_R,
+      .access = PL1_RW | PL0_RW,
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .resetvalue = 0, .accessfn = gt_ptimer_access,
       .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
     },
     { .name = "CNTV_CVAL", .cp = 15, .crm = 14, .opc1 = 3,
-      .access = PL1_RW | PL0_R,
+      .access = PL1_RW | PL0_RW,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .accessfn = gt_vtimer_access,
@@ -2789,7 +2789,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
     { .name = "CNTV_CVAL_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 3, .opc2 = 2,
-      .access = PL1_RW | PL0_R,
+      .access = PL1_RW | PL0_RW,
       .type = ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
       .resetvalue = 0, .accessfn = gt_vtimer_access,
-- 
2.7.4
