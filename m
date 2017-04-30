Received: from eggs.gnu.org ([2001:4830:134:3::10]:42882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hP4-0004ZV-Oh
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hP1-0000el-Lh
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:28:14 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sun, 30 Apr 2017 13:35:06 +0800
Message-ID: <1493530506-26833-4-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/4] target-arm: kvm64: handle SError
 interrupt for RAS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, gengdongjiu@huawei.com

Record this CPER to GHES, and raise a virtual SError interrupt
with specified syndrome information, the virtual syndrome
is delivered by vsesr_el2. the reason that record the error to HEST
table and inject the SError to guest is due to guest can
handle some errores to avoid directly panic, such as the
application error defered by ESB.

The steps are shown below:
1. syndrome_info and host error VA is delivered by KVM, qemu parse it.
2. translate the host VA to PA and record this error to HEST table.
3. Raise a virtual SError interrupt by set the hcr_el2.vse and pass
   the virtual syndrome

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 linux-headers/linux/kvm.h |  5 +++++
 target/arm/cpu.h          |  5 +++++
 target/arm/helper.c       | 20 ++++++++++++++++++++
 target/arm/internals.h    |  1 +
 target/arm/kvm.c          |  3 +++
 target/arm/kvm64.c        | 31 +++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h      | 14 ++++++++++++++
 7 files changed, 79 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c985e10..7951b91 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -360,6 +360,11 @@ struct kvm_run {
 		struct {
 			__u8 vector;
 		} eoi;
+		/* KVM_EXIT_INTR */
+		struct {
+			__u32 syndrome_info;
+			__u64 address;
+		} intr;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
 		/* Fix the size of the union. */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1cf4a5b..a2e6348 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -58,6 +58,8 @@
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
+#define EXCP_SERROR         19   /* v8 System Error or Asynchronous Abort */
+
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
@@ -273,6 +275,7 @@ typedef struct CPUARMState {
             };
             uint64_t esr_el[4];
         };
+        uint64_t vsesr_el2;
         uint32_t c6_region[8]; /* MPU base/size registers.  */
         union { /* Fault address registers. */
             struct {
@@ -922,6 +925,8 @@ void pmccntr_sync(CPUARMState *env);
 #define PSTATE_MODE_EL1t 4
 #define PSTATE_MODE_EL0t 0
 
+#define VSESR_ELx_IDS_ISS_MASK    ((1UL << 25) - 1)
+
 /* Map EL and handler into a PSTATE_MODE.  */
 static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8cb7a94..bdfaba2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4852,6 +4852,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
         define_arm_cp_regs(cpu, v8_idregs);
         define_arm_cp_regs(cpu, v8_cp_reginfo);
+        if (arm_feature(env, ARM_FEATURE_RAS_EXTENSION)) {
+            ARMCPRegInfo ras_cp_reginfo = {
+                .name = "VSESR_EL2", .state = ARM_CP_STATE_AA64,
+                .opc0 = 3, .opc1 = 4, .crn = 5, .crm = 2, .opc2 = 3,
+                .access = PL2_RW,
+                .fieldoffset = offsetof(CPUARMState, cp15.vsesr_el2)
+            };
+            define_one_arm_cp_reg(cpu, &ras_cp_reginfo);
+        }
     }
     if (arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t vmpidr_def = mpidr_read_val(env);
@@ -6930,6 +6939,17 @@ void arm_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
         return;
     }
+    if (cs->exception_index == EXCP_SERROR
+        && arm_feature(env, ARM_FEATURE_RAS_EXTENSION)) {
+        /* Raise virtual System Error or Asynchronous Abort and
+         * set virtual syndrome information
+         */
+        env->cp15.esr_el[2] = env->exception.syndrome;
+        env->cp15.vsesr_el2 = env->exception.syndrome & VSESR_ELx_IDS_ISS_MASK;
+        env->cp15.hcr_el2 = env->cp15.hcr_el2 | HCR_VSE;
+        qemu_log_mask(CPU_LOG_INT, "...handled as async SError\n");
+        return;
+    }
 
     /* Semihosting semantics depend on the register width of the
      * code that caused the exception, not the target exception level,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f742a41..29aabad 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -70,6 +70,7 @@ static const char * const excnames[] = {
     [EXCP_VIRQ] = "Virtual IRQ",
     [EXCP_VFIQ] = "Virtual FIQ",
     [EXCP_SEMIHOST] = "Semihosting call",
+    [EXCP_SERROR] = "async SError"
 };
 
 /* Scale factor for generic timers, ie number of ns per tick.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bf6ee4c..000e7c3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -570,12 +570,15 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
 
+    struct kvm_async_abort *async_abort = (struct kvm_async_abort *)&run->intr;
     switch (run->exit_reason) {
     case KVM_EXIT_DEBUG:
         if (kvm_arm_handle_debug(cs, &run->debug.arch)) {
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_INTR:
+        kvm_arm_inject_serror(cs, async_abort);
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5eee6f4..7d4c32f 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1048,3 +1048,34 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
+
+bool kvm_arm_inject_serror(CPUState *cs,
+                struct kvm_async_abort *async_abort_exit)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    CPUARMState *env = &cpu->env;
+    hwaddr paddr;
+    ram_addr_t ram_addr;
+
+    /* Ensure PC is synchronised */
+    kvm_cpu_synchronize_state(cs);
+
+    /* record the CPER to GHES */
+    if (arm_feature(env, ARM_FEATURE_RAS_EXTENSION)
+                && async_abort_exit->address) {
+        ram_addr = qemu_ram_addr_from_host((void *)async_abort_exit->address);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(cs->kvm_state,
+                        (void *)async_abort_exit->address, &paddr)) {
+            ghes_update_guest(ACPI_HEST_NOTIFY_SEI, paddr);
+        }
+    }
+    cs->exception_index = EXCP_SERROR;
+    env->exception.syndrome = async_abort_exit->hsr;
+
+    /* inject SError to guest */
+    cc->do_interrupt(cs);
+
+    return true;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 7cdde97..ed73e2b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -120,6 +120,11 @@ bool write_kvmstate_to_list(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+struct kvm_async_abort {
+    unsigned int hsr;
+    unsigned long address;  /* used for async SError */
+};
+
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
@@ -249,6 +254,15 @@ static inline const char *gicv3_class_name(void)
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
 
 /**
+ * kvm_arm_inject_serror:
+ * @cs: CPUState
+ * @async_abort_exit: the async abort exception infomation
+ *
+ * Returns: TRUE if the async SError was injected.
+ */
+bool kvm_arm_inject_serror(CPUState *cs,
+        struct kvm_async_abort *async_abort_exit);
+/**
  * kvm_arm_hw_debug_active:
  * @cs: CPU State
  *
-- 
1.8.3.1
