Received: from eggs.gnu.org ([2001:4830:134:3::10]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-0008QN-U6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-00065v-NM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLms-00060G-G4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmr-000770-AF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:12 +0000
Message-Id: <20180309172622.4277-16-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/25] target/arm: Move definition of 'host' cpu
 type into cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the definition of the 'host' cpu type into cpu.c, where all the
other CPU types are defined.  We can do this now we've decoupled it
from the KVM-specific host feature probing.  This means we now create
the type unconditionally (assuming we were built with KVM support at
all), but if you try to use it without -enable-kvm this will end
up in the "host cpu probe failed and KVM not enabled" path in
arm_cpu_realizefn(), for an appropriate error message.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180308130626.12393-3-peter.maydell@linaro.org
---
 target/arm/cpu.c | 24 ++++++++++++++++++++++++
 target/arm/kvm.c | 19 -------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5809225a36..5d76844981 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1864,6 +1864,26 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 }
 
+#ifdef CONFIG_KVM
+static void arm_host_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    kvm_arm_set_cpu_features_from_host(cpu);
+}
+
+static const TypeInfo host_arm_cpu_type_info = {
+    .name = TYPE_ARM_HOST_CPU,
+#ifdef TARGET_AARCH64
+    .parent = TYPE_AARCH64_CPU,
+#else
+    .parent = TYPE_ARM_CPU,
+#endif
+    .instance_init = arm_host_initfn,
+};
+
+#endif
+
 static void cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
@@ -1908,6 +1928,10 @@ static void arm_cpu_register_types(void)
         cpu_register(info);
         info++;
     }
+
+#ifdef CONFIG_KVM
+    type_register_static(&host_arm_cpu_type_info);
+#endif
 }
 
 type_init(arm_cpu_register_types)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1c0e57690a..ecc39ac295 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -152,23 +152,6 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
-static void kvm_arm_host_cpu_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    kvm_arm_set_cpu_features_from_host(cpu);
-}
-
-static const TypeInfo host_arm_cpu_type_info = {
-    .name = TYPE_ARM_HOST_CPU,
-#ifdef TARGET_AARCH64
-    .parent = TYPE_AARCH64_CPU,
-#else
-    .parent = TYPE_ARM_CPU,
-#endif
-    .instance_init = kvm_arm_host_cpu_initfn,
-};
-
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     /* For ARM interrupt delivery is always asynchronous,
@@ -184,8 +167,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
-    type_register_static(&host_arm_cpu_type_info);
-
     return 0;
 }
 
-- 
2.16.2
