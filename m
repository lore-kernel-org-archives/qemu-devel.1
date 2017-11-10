Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HM-0001m3-9q
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HK-00015C-S8
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:20 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:46 +0800
Message-ID: <1510341591-22817-8-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 07/12] target-arm: handle SError interrupt
 exception from the guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

When guest OS happens SError interrupt(SEI), it will trap to
host. Host check the Asynchronous Error Type(ESR_ELx.AET). If
it the error has not been propagated and has not (yet) been
architecturally consumed by the PE, it will return to use space
with error code KVM_SEI_SEV_RECOVERABLE.

Qemu receive this exception exit, check whether KVM support to
set ESR(exception syndrome registers) value. If support, it sets
the ESR value using a new IOCTL.

This handling is only supported in AArch64 platform, not supported
in AArch32 platform.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Quanming Wu <wuquanming@huawei.com>

---
set ESR and inject SEI by userspace are suggested here:
https://lkml.org/lkml/2017/3/20/441
https://lkml.org/lkml/2017/3/20/516

Below is the log that Qemu inject SError with specify ESR and guest happen exception:

 Bad mode in Error handler detected, code 0xbe000c11 -- SError
 CPU: 0 PID: 539 Comm: devmem Tainted: G      D         4.1.0+ #20
 Hardware name: linux,dummy-virt (DT)
 task: ffffffc019aad600 ti: ffffffc008134000 task.ti: ffffffc008134000
 PC is at 0x405cc0
 LR is at 0x40ce80
 pc : [<0000000000405cc0>] lr : [<000000000040ce80>] pstate: 60000000
 sp : ffffffc008137ff0
 x29: 0000007fd9e80790 x28: 0000000000000000
 x27: 00000000000000ad x26: 000000000049c000
 x25: 000000000048904b x24: 000000000049c000
 x23: 0000000040600000 x22: 0000007fd9e808d0
 x21: 0000000000000002 x20: 0000000000000000
 x19: 0000000000000020 x18: 0000000000000000
 x17: 0000000000405cc0 x16: 000000000049c698
 x15: 0000000000005798 x14: 0000007f93875f1c
 x13: 0000007f93a8ccb0 x12: 0000000000000137
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000000 x8 : 00000000000000de
 x7 : 0000000000000000 x6 : 0000000000002000
 x5 : 0000000040600000 x4 : 0000000000000003
 x3 : 0000000000000001 x2 : 00000000000f123b
 x1 : 0000000000000008 x0 : 000000000047a048
---
 target/arm/internals.h |  4 ++++
 target/arm/kvm.c       |  3 +++
 target/arm/kvm32.c     |  6 ++++++
 target/arm/kvm64.c     | 34 ++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h   |  8 ++++++++
 5 files changed, 55 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..cd26a9d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -233,9 +233,13 @@ enum arm_exception_class {
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
+#define ARM_EL_AET_SHIFT 10
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
 
+/* Asynchronous Error Type */
+#define KVM_SEI_SEV_RECOVERABLE 1
+
 /* Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
  * few cases the value in HSR for exceptions taken to AArch32 Hyp
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7c17f0d..d85e36a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -593,6 +593,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_EXCEPTION:
+        kvm_arm_handle_exception(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 069da0c..8ce56fd 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -493,6 +493,12 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
     return false;
 }
 
+bool kvm_arm_handle_exception(CPUState *cs, struct kvm_run *run)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
+    return false;
+}
+
 int kvm_arch_insert_hw_breakpoint(target_ulong addr,
                                   target_ulong len, int type)
 {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index af8ebc9..2d0eb32 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -986,3 +986,37 @@ static bool kvm_can_set_vcpu_esr(struct KVMState *state)
     int ret = kvm_check_extension(state, KVM_CAP_ARM_INJECT_SERROR_ESR);
     return (ret) ? true : false;
 }
+
+static bool kvm_inject_arm_sei(CPUState *cs, unsigned int error_code)
+{
+    int ret;
+    /* IMPLEMENTATION DEFINED syndrome by default */
+    uint32_t syndrome = ARM_EL_ISV;
+
+    if (kvm_can_set_vcpu_esr(cs->kvm_state)) {
+        if (error_code == KVM_SEI_SEV_RECOVERABLE) {
+            /* Set Recoverable Asynchronous SError interrupt Type */
+            syndrome = (3 << ARM_EL_AET_SHIFT) | 0x11;
+        }
+        ret = kvm_vcpu_ioctl(cs, KVM_ARM_INJECT_SERROR_ESR, &syndrome);
+        if (ret < 0) {
+            fprintf(stderr, "KVM_ARM_SET_SERROR_ESR failed: %s\n",
+                    strerror(-ret));
+            abort();
+        }
+
+        return true;
+    }
+
+    return false;
+}
+
+bool kvm_arm_handle_exception(CPUState *cs, struct kvm_run *run)
+{
+    int exception = run->ex.exception;
+    unsigned int error_code = run->ex.error_code;
+    if (exception == EC_SERROR) {
+        return kvm_inject_arm_sei(cs, error_code);
+    }
+    return false;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 633d088..b2a7933 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -288,4 +288,12 @@ static inline const char *its_class_name(void)
     }
 }
 
+/**
+ * kvm_arm_handle_exception:
+ * @cs: CPUState
+ * @run: KVM RUN structure
+ *
+ * Returns: TRUE if the SError exception was successfully handled
+ */
+bool kvm_arm_handle_exception(CPUState *cs, struct kvm_run *run);
 #endif
-- 
1.8.3.1
