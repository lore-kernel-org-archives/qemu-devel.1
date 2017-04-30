Received: from eggs.gnu.org ([2001:4830:134:3::10]:43471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hS9-0006k2-NF
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d4hS6-0001iR-LM
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 01:31:25 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sun, 30 Apr 2017 13:35:04 +0800
Message-ID: <1493530506-26833-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/4] target-arm: kvm64: detect guest RAS
 EXTENSION feature
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

check if kvm supports guest RAS EXTENSION. if so, set
corresponding feature bit for vcpu.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 linux-headers/asm-arm64/kvm.h | 1 +
 linux-headers/linux/kvm.h     | 1 +
 target/arm/cpu.h              | 3 +++
 target/arm/kvm64.c            | 8 ++++++++
 4 files changed, 13 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 651ec30..acb5c4d 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -97,6 +97,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_RAS_EXTENSION	4
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4e082a8..e0fa5b8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_ARM_RAS_EXTENSION 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8aabce..1cf4a5b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -610,6 +610,8 @@ struct ARMCPU {
 
     /* CPU has memory protection unit */
     bool has_mpu;
+    /* CPU has ras extension unit */
+    bool has_ras_extension;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
 
@@ -1216,6 +1218,7 @@ enum arm_features {
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
+    ARM_FEATURE_RAS_EXTENSION, /*has RAS extension support */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6111109..fd30a5a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -518,6 +518,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         unset_feature(&env->features, ARM_FEATURE_PMU);
     }
 
+    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_RAS_EXTENSION)) {
+        cpu->has_ras_extension = true;
+        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_RAS_EXTENSION;
+    } else {
+        cpu->has_ras_extension = false;
+        unset_feature(&env->features, ARM_FEATURE_RAS_EXTENSION);
+    }
+
     /* Do KVM_ARM_VCPU_INIT ioctl */
     ret = kvm_arm_vcpu_init(cs);
     if (ret) {
-- 
1.8.3.1
