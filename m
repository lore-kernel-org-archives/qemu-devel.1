Received: from eggs.gnu.org ([2001:4830:134:3::10]:54308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjd-000290-8T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1fWSjc-0005Sc-Ba
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:32:45 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 22 Jun 2018 16:32:19 -0400
Message-Id: <1529699547-17044-6-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v5 05/13] target/arm: Remove redundant DIV
 detection for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

KVM implies V7VE, which implies ARM_DIV and THUMB_DIV. The conditional
detection here is therefore unnecessary. Because V7VE is already
unconditionally specified for all KVM hosts, ARM_DIV and THUMB_DIV are
already indirectly specified and do not need to be included here at all.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/kvm32.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index fb9ea37..4e91c11 100644
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
@@ -60,11 +60,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         },
         {
             .id = KVM_REG_ARM | KVM_REG_SIZE_U32
-            | ENCODE_CP_REG(15, 0, 0, 0, 2, 0, 0),
-            .addr = (uintptr_t)&id_isar0,
-        },
-        {
-            .id = KVM_REG_ARM | KVM_REG_SIZE_U32
             | KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1,
             .addr = (uintptr_t)&mvfr1,
         },
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
