Received: from eggs.gnu.org ([2001:4830:134:3::10]:57902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMdED-0003DM-ED
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMd1c-00080j-A0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:02:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMd1c-0007wi-0D
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:02:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id r11-v6so12872148wmb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 10:02:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 13 Nov 2018 19:01:51 +0100
Message-Id: <20181113180154.17903-2-richard.henderson@linaro.org>
In-Reply-To: <20181113180154.17903-1-richard.henderson@linaro.org>
References: <20181113180154.17903-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 1/4] target/arm: Install ARMISARegisters
 from kvm host
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

The ID registers are replacing (some of) the feature bits.
We need (some of) these values to determine the set of data
to be handled during migration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 1 +
 target/arm/kvm.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 21c0129da2..6393455b1d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -183,6 +183,7 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
  * by asking the host kernel)
  */
 typedef struct ARMHostCPUFeatures {
+    ARMISARegisters isar;
     uint64_t features;
     uint32_t target;
     const char *dtb_compatible;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 09a86e2820..44dd0ce6ce 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -158,6 +158,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
     cpu->kvm_target = arm_host_cpu_features.target;
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    cpu->isar = arm_host_cpu_features.isar;
     env->features = arm_host_cpu_features.features;
 }
 
-- 
2.17.2
