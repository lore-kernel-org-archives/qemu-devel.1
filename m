Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW8-0001cB-E5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW5-0008BA-OH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKoW5-0008Af-IQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:53 -0500
Received: by mail-wr1-x443.google.com with SMTP id j26-v6so22245573wre.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:54:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Nov 2018 18:52:44 +0100
Message-Id: <20181108175246.13416-4-richard.henderson@linaro.org>
In-Reply-To: <20181108175246.13416-1-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 3/5] target/arm: Introduce read_sys_reg32
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Assert that the value to be written is the correct size.
No change in functionality here, just mirroring the same
function from kvm64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm32.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 0f1e94c7b5..de573f9aa8 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -28,6 +28,14 @@ static inline void set_feature(uint64_t *features, int feature)
     *features |= 1ULL << feature;
 }
 
+static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
+{
+    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
+
+    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32);
+    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
+}
+
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -35,9 +43,10 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * we have to create a scratch VM, create a single CPU inside it,
      * and then query that CPU for the relevant ID registers.
      */
-    int i, ret, fdarray[3];
+    int err = 0, fdarray[3];
     uint32_t midr, id_pfr0, mvfr1;
     uint64_t features = 0;
+
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
      * we know these will only support creating one kind of guest CPU,
      * which is its preferred CPU type.
@@ -47,23 +56,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         QEMU_KVM_ARM_TARGET_NONE
     };
     struct kvm_vcpu_init init;
-    struct kvm_one_reg idregs[] = {
-        {
-            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
-            | ENCODE_CP_REG(15, 0, 0, 0, 0, 0, 0),
-            .addr = (uintptr_t)&midr,
-        },
-        {
-            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
-            | ENCODE_CP_REG(15, 0, 0, 0, 1, 0, 0),
-            .addr = (uintptr_t)&id_pfr0,
-        },
-        {
-            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
-            | KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1,
-            .addr = (uintptr_t)&mvfr1,
-        },
-    };
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
@@ -77,16 +69,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      */
     ahcf->dtb_compatible = "arm,arm-v7";
 
-    for (i = 0; i < ARRAY_SIZE(idregs); i++) {
-        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &idregs[i]);
-        if (ret) {
-            break;
-        }
-    }
+    err |= read_sys_reg32(fdarray[2], &midr, ARM_CP15_REG32(0, 0, 0, 0));
+    err |= read_sys_reg32(fdarray[2], &id_pfr0, ARM_CP15_REG32(0, 0, 1, 0));
+    err |= read_sys_reg32(fdarray[2], &mvfr1,
+                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
+                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1);
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
-    if (ret) {
+    if (err < 0) {
         return false;
     }
 
-- 
2.17.2
