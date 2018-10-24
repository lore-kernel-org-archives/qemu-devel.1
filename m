Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTk-0003AN-Mh
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTg-0005FD-ED
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHTb-0005Bp-2Z
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id d2-v6so5204910wro.7
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:37:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Oct 2018 12:37:06 +0100
Message-Id: <20181024113709.16599-3-richard.henderson@linaro.org>
In-Reply-To: <20181024113709.16599-1-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] target/arm: Fill in ARMISARegisters for
 kvm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm64.c | 63 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5de8ff0ac5..6ed80eadc2 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -443,17 +443,41 @@ static inline void unset_feature(uint64_t *features, int feature)
     *features &= ~(1ULL << feature);
 }
 
+static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
+{
+    uint64_t ret;
+    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)&ret };
+    int err;
+
+    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
+    err = ioctl(fd, KVM_GET_ONE_REG, &idreg);
+    if (err < 0) {
+        return -1;
+    }
+    assert(ret <= UINT32_MAX);
+    *pret = ret;
+    return 0;
+}
+
+static int read_sys_reg64(int fd, uint64_t *pret, uint64_t id)
+{
+    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
+
+    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U64);
+    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
+}
+
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
      * we have to create a scratch VM, create a single CPU inside it,
      * and then query that CPU for the relevant ID registers.
-     * For AArch64 we currently don't care about ID registers at
-     * all; we just want to know the CPU type.
      */
     int fdarray[3];
     uint64_t features = 0;
+    int err = 0;
+
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
      * we know these will only support creating one kind of guest CPU,
      * which is its preferred CPU type. Fortunately these old kernels
@@ -474,8 +498,43 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->target = init.target;
     ahcf->dtb_compatible = "arm,arm-v8";
 
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
+                          ARM64_SYS_REG(3, 0, 0, 2, 0));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
+                          ARM64_SYS_REG(3, 0, 0, 2, 1));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
+                          ARM64_SYS_REG(3, 0, 0, 2, 2));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
+                          ARM64_SYS_REG(3, 0, 0, 2, 3));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
+                          ARM64_SYS_REG(3, 0, 0, 2, 4));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
+                          ARM64_SYS_REG(3, 0, 0, 2, 5));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
+                          ARM64_SYS_REG(3, 0, 0, 2, 7));
+
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
+                          ARM64_SYS_REG(3, 0, 0, 3, 0));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
+                          ARM64_SYS_REG(3, 0, 0, 3, 1));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
+                          ARM64_SYS_REG(3, 0, 0, 3, 2));
+
+    err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
+                          ARM64_SYS_REG(3, 0, 0, 6, 0));
+    err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
+                          ARM64_SYS_REG(3, 0, 0, 6, 1));
+    err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
+                          ARM64_SYS_REG(3, 0, 0, 4, 0));
+    err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
+                          ARM64_SYS_REG(3, 0, 0, 4, 1));
+
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
+    if (err < 0) {
+        return false;
+    }
+
    /* We can assume any KVM supporting CPU is at least a v8
      * with VFPv4+Neon; this in turn implies most of the other
      * feature bits.
-- 
2.17.2
