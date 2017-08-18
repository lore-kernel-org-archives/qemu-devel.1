Received: from eggs.gnu.org ([2001:4830:134:3::10]:51637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqm-0004CY-LT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dihqg-00007p-T3
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:02:12 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 18 Aug 2017 22:23:47 +0800
Message-ID: <1503066227-18251-7-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, gengdongjiu@huawei.com, zhengqiang10@huawei.com

When guest OS happens SError interrupt(SEI), it will trap to host.
Host firstly calls memory failure to deal with this error and decide
whether it needs to deliver SIGBUS signal to userspace. The advantage
that using signal to notify is that it can make the notification method
is general, non-KVM user can also use it. when userspace gets this
signal and knows this is SError interrupt, it will translate the
delivered host VA to PA and record this PA to GHES.

Because ARMv8.2 adds an extension to RAS to allow system software insert
implicit Error Synchronization Barrier operations to isolate the error and
allow passes specified syndrome to guest OS, so after record the CPER, user
space calls IOCTL to pass a specified syndrome to KVM, then switch to guest
OS, guest OS can use the recorded CPER record and syndrome information to
do the recovery.

The steps are shown below:
1. translate the host VA to guest OS PA and record this error PA to HEST table.
2. set specified virtual SError syndrome and pass the value to KVM.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Quanming Wu <wuquanming@huawei.com>
---
 linux-headers/linux/kvm.h |  1 +
 target/arm/internals.h    |  1 +
 target/arm/kvm64.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 2aa176e..10dfcab 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1356,6 +1356,7 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
+#define KVM_ARM_SEI                 _IO(KVMIO,   0xb10)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc0ad6d..18b1cbc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -237,6 +237,7 @@ enum arm_exception_class {
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
 #define ARM_EL_EC_MASK  ((0x3F) << ARM_EL_EC_SHIFT)
 #define ARM_EL_FSC_TYPE (0x3C)
+#define ARM_EL_ISS_MASK ((1 << ARM_EL_IL_SHIFT) - 1)
 
 #define FSC_SEA         (0x10)
 #define FSC_SEA_TTW0    (0x14)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index d3bdab2..b84cb49 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -616,6 +616,22 @@ static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdiff_t fieldoffset)
     return -EINVAL;
 }
 
+static int kvm_inject_arm_sei(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    unsigned long syndrome = env->exception.vaddress;
+    /* set virtual SError syndrome */
+    if (arm_feature(env, ARM_FEATURE_RAS_EXTENSION)) {
+        syndrome = syndrome & ARM_EL_ISS_MASK;
+    } else {
+        syndrome = 0;
+    }
+
+    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
+}
+
 /* Inject synchronous external abort */
 static int kvm_inject_arm_sea(CPUState *c)
 {
@@ -1007,6 +1023,15 @@ static bool is_abort_sea(unsigned long syndrome)
     }
 }
 
+static bool is_abort_sei(unsigned long syndrome)
+{
+    uint8_t ec = ((syndrome & ARM_EL_EC_MASK) >> ARM_EL_EC_SHIFT);
+    if ((ec != EC_SERROR))
+        return false;
+    else
+        return true;
+}
+
 void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
@@ -1024,6 +1049,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
             if (is_abort_sea(env->exception.syndrome)) {
                 ghes_update_guest(ACPI_HEST_NOTIFY_SEA, paddr);
                 kvm_inject_arm_sea(c);
+            } else if (is_abort_sei(env->exception.syndrome)) {
+                ghes_update_guest(ACPI_HEST_NOTIFY_SEI, paddr);
+                kvm_inject_arm_sei(c);
             }
             return;
         }
-- 
1.8.3.1
