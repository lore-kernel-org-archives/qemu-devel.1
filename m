Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTp-0003Yq-M6
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTj-0005Gd-TV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHTh-0005BS-4z
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id w186-v6so5025831wmf.0
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:37:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Oct 2018 12:37:05 +0100
Message-Id: <20181024113709.16599-2-richard.henderson@linaro.org>
In-Reply-To: <20181024113709.16599-1-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] target/arm: Install ARMISARegisters from
 kvm host
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
