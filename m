Received: from eggs.gnu.org ([2001:4830:134:3::10]:53943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSj-0000i7-WA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSh-000765-GT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:13 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:36213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSh-00075A-86
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:11 -0400
Received: by mail-pl0-x22d.google.com with SMTP id e11-v6so1983787plb.3
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:47 -0700
Message-Id: <20180809042206.15726-2-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/20] target/arm: Set ISAR bits for -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

For the supported extensions, fill in the appropriate bits in
ID_ISAR5, ID_ISAR6, ID_AA64ISAR0, ID_AA64ISAR1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 24 +++++++++++++++++-------
 target/arm/cpu64.c | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b25898ed4c..71daa39e86 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1802,19 +1802,29 @@ static void arm_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         cortex_a15_initfn(obj);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 4, 4, 2);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 8, 4, 1);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 12, 4, 1);
+        set_feature(&cpu->env, ARM_FEATURE_CRC);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 16, 4, 1);
+        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 24, 4, 1);
+        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 28, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
+        cpu->id_isar6 = deposit32(cpu->id_isar6, 4, 4, 1);
+
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
          * since we don't correctly set the ID registers to advertise them,
          */
         set_feature(&cpu->env, ARM_FEATURE_V8);
-        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
         set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-        set_feature(&cpu->env, ARM_FEATURE_CRC);
-        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
-        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
 #endif
     }
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 800bff780e..4d629bb99b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -254,6 +254,34 @@ static void aarch64_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         aarch64_a57_initfn(obj);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 12, 4, 2);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 20, 4, 2);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 28, 4, 1);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 24, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 32, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 36, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 40, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
+        cpu->id_aa64isar0 = deposit64(cpu->id_aa64isar0, 44, 4, 1);
+        cpu->id_isar6 = deposit32(cpu->id_isar6, 4, 4, 1);
+
+        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+        cpu->id_aa64isar1 = deposit64(cpu->id_aa64isar1, 16, 4, 1);
+        cpu->id_isar5 = deposit32(cpu->id_isar5, 28, 4, 1);
+
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
          * since we don't correctly set the ID registers to advertise them,
@@ -261,15 +289,7 @@ static void aarch64_max_initfn(Object *obj)
          * whereas the architecture requires them to be present in both if
          * present in either.
          */
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
-        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
-        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-        set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
-        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
         set_feature(&cpu->env, ARM_FEATURE_SVE);
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
-- 
2.17.1
