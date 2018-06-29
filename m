Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun8-0007qq-62
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun7-0007ip-Av
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun7-0007dX-0Q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun5-0004ol-P7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:39 +0100
Message-Id: <20180629145347.652-48-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 47/55] target/arm: Remove redundant DIV
 detection for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

KVM implies V7VE, which implies ARM_DIV and THUMB_DIV. The conditional
detection here is therefore unnecessary. Because V7VE is already
unconditionally specified for all KVM hosts, ARM_DIV and THUMB_DIV are
already indirectly specified and do not need to be included here at all.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1529699547-17044-6-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm32.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index fb9ea37a318..4e91c11796b 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -36,7 +36,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * and then query that CPU for the relevant ID registers.
      */
     int i, ret, fdarray[3];
-    uint32_t midr, id_pfr0, id_isar0, mvfr1;
+    uint32_t midr, id_pfr0, mvfr1;
     uint64_t features = 0;
     /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
      * we know these will only support creating one kind of guest CPU,
@@ -58,11 +58,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             | ENCODE_CP_REG(15, 0, 0, 0, 1, 0, 0),
             .addr = (uintptr_t)&id_pfr0,
         },
-        {
-            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
-            | ENCODE_CP_REG(15, 0, 0, 0, 2, 0, 0),
-            .addr = (uintptr_t)&id_isar0,
-        },
         {
             .id = KVM_REG_ARM | KVM_REG_SIZE_U32
             | KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1,
@@ -106,18 +101,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     set_feature(&features, ARM_FEATURE_VFP3);
     set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
-    switch (extract32(id_isar0, 24, 4)) {
-    case 1:
-        set_feature(&features, ARM_FEATURE_THUMB_DIV);
-        break;
-    case 2:
-        set_feature(&features, ARM_FEATURE_ARM_DIV);
-        set_feature(&features, ARM_FEATURE_THUMB_DIV);
-        break;
-    default:
-        break;
-    }
-
     if (extract32(id_pfr0, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_THUMB2EE);
     }
-- 
2.17.1
