Received: from eggs.gnu.org ([2001:4830:134:3::10]:39537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW8-0001cC-E8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW3-00089d-Ei
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKoW3-00088k-7l
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id j17-v6so17085823wrq.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:54:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Nov 2018 18:52:42 +0100
Message-Id: <20181108175246.13416-2-richard.henderson@linaro.org>
In-Reply-To: <20181108175246.13416-1-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 1/5] target/arm: Install ARMISARegisters
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
