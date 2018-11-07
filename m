Received: from eggs.gnu.org ([2001:4830:134:3::10]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gKSsm-0000DT-96
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gKSsh-00009g-VN
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bijan.mottahedeh@oracle.com>)
	id 1gKSsh-00008N-K5
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:47 -0500
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Date: Wed,  7 Nov 2018 10:48:24 -0800
Message-Id: <1541616504-68526-3-git-send-email-bijan.mottahedeh@oracle.com>
In-Reply-To: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
References: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
Subject: [Qemu-devel] [RFC QEMU 2/2] arm/virt: Account for guest pause time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvmarm@lists.cs.columbia.edu

Accumulate the total guest pause time and update the virtual counter
offset register accordingly in order to account for that time before
resuming the guest.

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 hw/intc/arm_gicv3_kvm.c | 39 +++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h        |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 1e11200..aabd508 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -30,6 +30,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "target/arm/internals.h"
 
 #ifdef DEBUG_GICV3_KVM
 #define DPRINTF(fmt, ...) \
@@ -745,9 +746,38 @@ static void vm_change_state_handler(void *opaque, int running,
 {
     GICv3State *s = (GICv3State *)opaque;
     Error *err = NULL;
+    CPUState *cpu;
+    CPUARMState *env;
+    struct kvm_one_reg reg;
     int ret;
+    uint64_t cnt;
 
     if (running) {
+        CPU_FOREACH(cpu) {
+
+            env = (CPUARMState *)(cpu->env_ptr);
+
+            if (!env->pause_start) {
+                continue;
+            }
+
+            /*
+             * Accumulate the total pause time and set the
+             * counter virtual offset accordingly.
+             */
+            cnt = gt_get_countervalue(env);
+            env->pause_total += (cnt - env->pause_start);
+            env->cp15.cntvoff_el2 = cnt - env->pause_total;
+
+            env->pause_start = 0;   /* clear for next pause */
+            reg.id = KVM_REG_ARM_TIMER_CNT;
+            reg.addr = (uintptr_t) &env->cp15.cntvoff_el2;
+            ret = kvm_vcpu_ioctl(cpu, KVM_SET_ONE_REG, &reg);
+            if (ret) {
+                error_report("Set virtual counter offset failed: %d", ret);
+                abort();
+            }
+        }
         return;
     }
 
@@ -760,6 +790,15 @@ static void vm_change_state_handler(void *opaque, int running,
     if (ret < 0 && ret != -EFAULT) {
         abort();
     }
+
+    CPU_FOREACH(cpu) {
+        /*
+         * Record the current pause start time.
+         */
+        env = (CPUARMState *)(cpu->env_ptr);
+        cnt = gt_get_countervalue(env);
+        env->pause_start = cnt;
+    }
 }
 
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e310ffc..bd0a56e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -602,6 +602,9 @@ typedef struct CPUARMState {
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
 
+    uint64_t pause_start;   /* start time of last pause */
+    uint64_t pause_total;   /* total pause time */
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-- 
1.8.3.1
