Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMar7-0002eK-JM
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMar6-0002Yo-Kr
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMar6-0002FF-DK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id w7-v6so12402895wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:43:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 13 Nov 2018 16:42:26 +0100
Message-Id: <20181113154226.14396-5-richard.henderson@linaro.org>
In-Reply-To: <20181113154226.14396-1-richard.henderson@linaro.org>
References: <20181113154226.14396-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 4/4] target/arm: Fill in ARMISARegisters for
 kvm32
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm32.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index bc0badf53d..bd51eb43c8 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -44,7 +44,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * and then query that CPU for the relevant ID registers.
      */
     int err = 0, fdarray[3];
-    uint32_t midr, id_pfr0, mvfr1;
+    uint32_t midr, id_pfr0;
     uint64_t features = 0;
 
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
@@ -71,9 +71,39 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     err |= read_sys_reg32(fdarray[2], &midr, ARM_CP15_REG32(0, 0, 0, 0));
     err |= read_sys_reg32(fdarray[2], &id_pfr0, ARM_CP15_REG32(0, 0, 1, 0));
-    err |= read_sys_reg32(fdarray[2], &mvfr1,
+
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
+                          ARM_CP15_REG32(0, 0, 2, 0));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
+                          ARM_CP15_REG32(0, 0, 2, 1));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
+                          ARM_CP15_REG32(0, 0, 2, 2));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
+                          ARM_CP15_REG32(0, 0, 2, 3));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
+                          ARM_CP15_REG32(0, 0, 2, 4));
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
+                          ARM_CP15_REG32(0, 0, 2, 5));
+    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
+                       ARM_CP15_REG32(0, 0, 2, 7))) {
+        /*
+         * Older kernels don't support reading ID_ISAR6. This register was
+         * only introduced in ARMv8, so we can assume that it is zero on a
+         * CPU that a kernel this old is running on.
+         */
+        ahcf->isar.id_isar6 = 0;
+    }
+
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
+                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
+                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR0);
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
                           KVM_REG_ARM | KVM_REG_SIZE_U32 |
                           KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1);
+    /*
+     * FIXME: There is not yet a way to read MVFR2.
+     * Fortunately there is not yet anything in there that affects migration.
+     */
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
@@ -95,13 +125,13 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (extract32(id_pfr0, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_THUMB2EE);
     }
-    if (extract32(mvfr1, 20, 4) == 1) {
+    if (extract32(ahcf->isar.mvfr1, 20, 4) == 1) {
         set_feature(&features, ARM_FEATURE_VFP_FP16);
     }
-    if (extract32(mvfr1, 12, 4) == 1) {
+    if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_NEON);
     }
-    if (extract32(mvfr1, 28, 4) == 1) {
+    if (extract32(ahcf->isar.mvfr1, 28, 4) == 1) {
         /* FMAC support implies VFPv4 */
         set_feature(&features, ARM_FEATURE_VFP4);
     }
-- 
2.17.2
