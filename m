Received: from eggs.gnu.org ([2001:4830:134:3::10]:59677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmw-0008Sj-Bl
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmu-00067n-94
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmt-00063U-T3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-00077e-Pc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:14 +0000
Message-Id: <20180309172622.4277-18-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/25] target/arm: Make 'any' CPU just an alias
 for 'max'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now we have a working '-cpu max', the linux-user-only
'any' CPU is pretty much the same thing, so implement it
that way.

For the moment we don't add any of the extra feature bits
to the system-emulation "max", because we don't set the
ID register bits we would need to to advertise those
features as present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180308130626.12393-5-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/cpu.c   | 52 +++++++++++++++++++++++++----------------------
 target/arm/cpu64.c | 59 ++++++++++++++++++++++++++----------------------------
 2 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2292ad91f6..022d8c5787 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -970,9 +970,19 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
     ObjectClass *oc;
     char *typename;
     char **cpuname;
+    const char *cpunamestr;
 
     cpuname = g_strsplit(cpu_model, ",", 1);
-    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
+    cpunamestr = cpuname[0];
+#ifdef CONFIG_USER_ONLY
+    /* For backwards compatibility usermode emulation allows "-cpu any",
+     * which has the same semantics as "-cpu max".
+     */
+    if (!strcmp(cpunamestr, "any")) {
+        cpunamestr = "max";
+    }
+#endif
+    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpunamestr);
     oc = object_class_by_name(typename);
     g_strfreev(cpuname);
     g_free(typename);
@@ -1716,29 +1726,23 @@ static void arm_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         cortex_a15_initfn(obj);
-        /* In future we might add feature bits here even if the
-         * real-world A15 doesn't implement them.
-         */
-    }
-}
-#endif
-
 #ifdef CONFIG_USER_ONLY
-static void arm_any_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
-    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-    set_feature(&cpu->env, ARM_FEATURE_CRC);
-    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
-    cpu->midr = 0xffffffff;
+        /* We don't set these in system emulation mode for the moment,
+         * since we don't correctly set the ID registers to advertise them,
+         */
+        set_feature(&cpu->env, ARM_FEATURE_V8);
+        set_feature(&cpu->env, ARM_FEATURE_VFP4);
+        set_feature(&cpu->env, ARM_FEATURE_NEON);
+        set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
+        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
+        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
+        set_feature(&cpu->env, ARM_FEATURE_CRC);
+        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+#endif
+    }
 }
 #endif
 
@@ -1794,7 +1798,7 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
 #ifdef CONFIG_USER_ONLY
-    { .name = "any",         .initfn = arm_any_initfn },
+    { .name = "any",         .initfn = arm_max_initfn },
 #endif
 #endif
     { .name = NULL }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 89b2f4eaed..991d764674 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -228,38 +228,38 @@ static void aarch64_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         aarch64_a57_initfn(obj);
-        /* In future we might add feature bits here even if the
-         * real-world A57 doesn't implement them.
+#ifdef CONFIG_USER_ONLY
+        /* We don't set these in system emulation mode for the moment,
+         * since we don't correctly set the ID registers to advertise them,
+         * and in some cases they're only available in AArch64 and not AArch32,
+         * whereas the architecture requires them to be present in both if
+         * present in either.
          */
+        set_feature(&cpu->env, ARM_FEATURE_V8);
+        set_feature(&cpu->env, ARM_FEATURE_VFP4);
+        set_feature(&cpu->env, ARM_FEATURE_NEON);
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
+        set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
+        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
+        set_feature(&cpu->env, ARM_FEATURE_CRC);
+        set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+        set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+        set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+        /* For usermode -cpu max we can use a larger and more efficient DCZ
+         * blocksize since we don't have to follow what the hardware does.
+         */
+        cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
+        cpu->dcz_blocksize = 7; /*  512 bytes */
+#endif
     }
 }
 
-#ifdef CONFIG_USER_ONLY
-static void aarch64_any_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_VFP4);
-    set_feature(&cpu->env, ARM_FEATURE_NEON);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-    set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
-    set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
-    set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-    set_feature(&cpu->env, ARM_FEATURE_CRC);
-    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
-    set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
-    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
-    cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-    cpu->dcz_blocksize = 7; /*  512 bytes */
-}
-#endif
-
 typedef struct ARMCPUInfo {
     const char *name;
     void (*initfn)(Object *obj);
@@ -270,9 +270,6 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#ifdef CONFIG_USER_ONLY
-    { .name = "any",         .initfn = aarch64_any_initfn },
-#endif
     { .name = NULL }
 };
 
-- 
2.16.2
