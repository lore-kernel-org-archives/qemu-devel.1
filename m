Received: from eggs.gnu.org ([209.51.188.92]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h3acn-0002Gv-2k
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h3acm-0008Mf-0H
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:10:53 -0400
From: Heyi Guo <guoheyi@huawei.com>
Date: Tue, 12 Mar 2019 14:09:20 +0800
Message-ID: <1552370960-2061-1-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC] arm/cpu: fix soft lockup panic after resuming
 from stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, Heyi Guo <guoheyi@huawei.com>, Peter Maydell <peter.maydell@linaro.org>

When we stop a VM for more than 30 seconds and then resume it, by qemu
monitor command "stop" and "cont", Linux on VM will complain of "soft
lockup - CPU#x stuck for xxs!" as below:

[ 2783.809517] watchdog: BUG: soft lockup - CPU#3 stuck for 2395s!
[ 2783.809559] watchdog: BUG: soft lockup - CPU#2 stuck for 2395s!
[ 2783.809561] watchdog: BUG: soft lockup - CPU#1 stuck for 2395s!
[ 2783.809563] Modules linked in...

This is because Guest Linux uses generic timer virtual counter as
a software watchdog, and CNTVCT_EL0 does not stop when VM is stopped
by qemu.

This patch is to fix this issue by saving the value of CNTVCT_EL0 when
stopping and restoring it when resuming.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
---
 target/arm/cpu.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 96f0ff0..7bbba3d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -896,6 +896,60 @@ static void arm_cpu_finalizefn(Object *obj)
 #endif
 }
 
+static int get_vcpu_timer_tick(CPUState *cs, uint64_t *tick_at_pause)
+{
+    int err;
+    struct kvm_one_reg reg;
+
+    reg.id = KVM_REG_ARM_TIMER_CNT;
+    reg.addr = (uintptr_t) tick_at_pause;
+
+    err = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    return err;
+}
+
+static int set_vcpu_timer_tick(CPUState *cs, uint64_t tick_at_pause)
+{
+    int err;
+    struct kvm_one_reg reg;
+
+    reg.id = KVM_REG_ARM_TIMER_CNT;
+    reg.addr = (uintptr_t) &tick_at_pause;
+
+    err = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    return err;
+}
+
+static void arch_timer_change_state_handler(void *opaque, int running,
+                                            RunState state)
+{
+    static uint64_t hw_ticks_at_paused;
+    static RunState pre_state = RUN_STATE__MAX;
+    int err;
+    CPUState *cs = (CPUState *)opaque;
+
+    switch (state) {
+    case RUN_STATE_PAUSED:
+        err = get_vcpu_timer_tick(cs, &hw_ticks_at_paused);
+        if (err) {
+            error_report("Get vcpu timer tick failed: %d", err);
+        }
+        break;
+    case RUN_STATE_RUNNING:
+        if (pre_state == RUN_STATE_PAUSED) {
+            err = set_vcpu_timer_tick(cs, hw_ticks_at_paused);
+            if (err) {
+                error_report("Resume vcpu timer tick failed: %d", err);
+            }
+        }
+        break;
+    default:
+        break;
+    }
+
+    pre_state = state;
+}
+
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -906,6 +960,12 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     bool no_aa32 = false;
 
+    /*
+     * Only add change state handler for arch timer once, for KVM will help to
+     * synchronize virtual timer of all VCPUs.
+     */
+    static bool arch_timer_change_state_handler_added;
+
     /* If we needed to query the host kernel for the CPU features
      * then it's possible that might have failed in the initfn, but
      * this is the first point where we can report it.
@@ -1181,6 +1241,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     init_cpreg_list(cpu);
 
+    if (!arch_timer_change_state_handler_added && kvm_enabled()) {
+        qemu_add_vm_change_state_handler(arch_timer_change_state_handler, cs);
+        arch_timer_change_state_handler_added = true;
+    }
+
 #ifndef CONFIG_USER_ONLY
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
-- 
1.8.3.1
