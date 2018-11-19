Received: from eggs.gnu.org ([2001:4830:134:3::10]:45401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvn-0002GN-FI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvm-0006xQ-QG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvm-0006tw-Jq
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlva-00064E-KD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:21 +0000
Message-Id: <20181119155730.11758-2-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/10] target/arm: Install ARMISARegisters from
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

From: Richard Henderson <richard.henderson@linaro.org>

The ID registers are replacing (some of) the feature bits.
We need (some of) these values to determine the set of data
to be handled during migration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181113180154.17903-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 1 +
 target/arm/kvm.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 21c0129da24..6393455b1d0 100644
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
index 09a86e2820b..44dd0ce6ce9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -158,6 +158,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
     cpu->kvm_target = arm_host_cpu_features.target;
     cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    cpu->isar = arm_host_cpu_features.isar;
     env->features = arm_host_cpu_features.features;
 }
 
-- 
2.19.1
