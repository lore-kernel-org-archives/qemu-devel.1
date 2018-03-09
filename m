Received: from eggs.gnu.org ([2001:4830:134:3::10]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-0008PY-A7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmr-00065B-Qu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmr-00064P-Fj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmq-00076i-Gp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:11 +0000
Message-Id: <20180309172622.4277-15-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/25] target/arm: Query host CPU features
 on-demand at instance init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently we query the host CPU features in the class init function
for the TYPE_ARM_HOST_CPU class, so that we can later copy them
from the class object into the instance object in the object
instance init function. This is awkward for implementing "-cpu max",
which should work like "-cpu host" for KVM but like "cpu with all
implemented features" for TCG.

Move the place where we store the information about the host CPU from
a class object to static variables in kvm.c, and then in the instance
init function call a new kvm_arm_set_cpu_features_from_host()
function which will query the host kernel if necessary and then
fill in the CPU instance fields.

This allows us to drop the special class struct and class init
function for TYPE_ARM_HOST_CPU entirely.

We can't delay the probe until realize, because the ARM
instance_post_init hook needs to look at the feature bits we
set, so we need to do it in the initfn. This is safe because
the probing doesn't affect the actual VM state (it creates a
separate scratch VM to do its testing), but the probe might fail.
Because we can't report errors in retrieving the host features
in the initfn, we check this belatedly in the realize function
(the intervening code will be able to cope with the relevant
fields in the CPU structure being zero).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180308130626.12393-2-peter.maydell@linaro.org
---
 target/arm/cpu.h     |  5 +++++
 target/arm/kvm_arm.h | 35 ++++++++++++++++++++++++-----------
 target/arm/cpu.c     | 13 +++++++++++++
 target/arm/kvm.c     | 36 +++++++++++++++++++-----------------
 target/arm/kvm32.c   |  8 ++++----
 target/arm/kvm64.c   |  8 ++++----
 6 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 36711cdb50..1e7e1f8a7e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -745,6 +745,11 @@ struct ARMCPU {
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
+    /* True if we tried kvm_arm_host_cpu_features() during CPU instance_init
+     * and the probe failed (so we need to report the error in realize)
+     */
+    bool host_cpu_probe_failed;
+
     /* Specify the number of cores in this CPU cluster. Used for the L2CTLR
      * register.
      */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfb7e5af72..1e2364007d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -152,20 +152,16 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
 void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
-#define ARM_HOST_CPU_CLASS(klass) \
-    OBJECT_CLASS_CHECK(ARMHostCPUClass, (klass), TYPE_ARM_HOST_CPU)
-#define ARM_HOST_CPU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(ARMHostCPUClass, (obj), TYPE_ARM_HOST_CPU)
-
-typedef struct ARMHostCPUClass {
-    /*< private >*/
-    ARMCPUClass parent_class;
-    /*< public >*/
 
+/**
+ * ARMHostCPUFeatures: information about the host CPU (identified
+ * by asking the host kernel)
+ */
+typedef struct ARMHostCPUFeatures {
     uint64_t features;
     uint32_t target;
     const char *dtb_compatible;
-} ARMHostCPUClass;
+} ARMHostCPUFeatures;
 
 /**
  * kvm_arm_get_host_cpu_features:
@@ -174,8 +170,16 @@ typedef struct ARMHostCPUClass {
  * Probe the capabilities of the host kernel's preferred CPU and fill
  * in the ARMHostCPUClass struct accordingly.
  */
-bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc);
+bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
 
+/**
+ * kvm_arm_set_cpu_features_from_host:
+ * @cpu: ARMCPU to set the features for
+ *
+ * Set up the ARMCPU struct fields up to match the information probed
+ * from the host CPU.
+ */
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 /**
  * kvm_arm_sync_mpstate_to_kvm
@@ -200,6 +204,15 @@ void kvm_arm_pmu_init(CPUState *cs);
 
 #else
 
+static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    /* This should never actually be called in the "not KVM" case,
+     * but set up the fields to indicate an error anyway.
+     */
+    cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
+    cpu->host_cpu_probe_failed = true;
+}
+
 static inline int kvm_arm_vgic_probe(void)
 {
     return 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3e4e9f1873..5809225a36 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -725,6 +725,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     int pagebits;
     Error *local_err = NULL;
 
+    /* If we needed to query the host kernel for the CPU features
+     * then it's possible that might have failed in the initfn, but
+     * this is the first point where we can report it.
+     */
+    if (cpu->host_cpu_probe_failed) {
+        if (!kvm_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with KVM");
+        } else {
+            error_setg(errp, "Failed to retrieve host CPU features");
+        }
+        return;
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1219d0062b..1c0e57690a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -33,6 +33,8 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 
+static ARMHostCPUFeatures arm_host_cpu_features;
+
 int kvm_arm_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -129,30 +131,32 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray)
     }
 }
 
-static void kvm_arm_host_cpu_class_init(ObjectClass *oc, void *data)
+void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
-    ARMHostCPUClass *ahcc = ARM_HOST_CPU_CLASS(oc);
+    CPUARMState *env = &cpu->env;
 
-    /* All we really need to set up for the 'host' CPU
-     * is the feature bits -- we rely on the fact that the
-     * various ID register values in ARMCPU are only used for
-     * TCG CPUs.
-     */
-    if (!kvm_arm_get_host_cpu_features(ahcc)) {
-        fprintf(stderr, "Failed to retrieve host CPU features!\n");
-        abort();
+    if (!arm_host_cpu_features.dtb_compatible) {
+        if (!kvm_enabled() ||
+            !kvm_arm_get_host_cpu_features(&arm_host_cpu_features)) {
+            /* We can't report this error yet, so flag that we need to
+             * in arm_cpu_realizefn().
+             */
+            cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
+            cpu->host_cpu_probe_failed = true;
+            return;
+        }
     }
+
+    cpu->kvm_target = arm_host_cpu_features.target;
+    cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    env->features = arm_host_cpu_features.features;
 }
 
 static void kvm_arm_host_cpu_initfn(Object *obj)
 {
-    ARMHostCPUClass *ahcc = ARM_HOST_CPU_GET_CLASS(obj);
     ARMCPU *cpu = ARM_CPU(obj);
-    CPUARMState *env = &cpu->env;
 
-    cpu->kvm_target = ahcc->target;
-    cpu->dtb_compatible = ahcc->dtb_compatible;
-    env->features = ahcc->features;
+    kvm_arm_set_cpu_features_from_host(cpu);
 }
 
 static const TypeInfo host_arm_cpu_type_info = {
@@ -163,8 +167,6 @@ static const TypeInfo host_arm_cpu_type_info = {
     .parent = TYPE_ARM_CPU,
 #endif
     .instance_init = kvm_arm_host_cpu_initfn,
-    .class_init = kvm_arm_host_cpu_class_init,
-    .class_size = sizeof(ARMHostCPUClass),
 };
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f77c9c494b..1740cda47d 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -28,7 +28,7 @@ static inline void set_feature(uint64_t *features, int feature)
     *features |= 1ULL << feature;
 }
 
-bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
+bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -74,13 +74,13 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
         return false;
     }
 
-    ahcc->target = init.target;
+    ahcf->target = init.target;
 
     /* This is not strictly blessed by the device tree binding docs yet,
      * but in practice the kernel does not care about this string so
      * there is no point maintaining an KVM_ARM_TARGET_* -> string table.
      */
-    ahcc->dtb_compatible = "arm,arm-v7";
+    ahcf->dtb_compatible = "arm,arm-v7";
 
     for (i = 0; i < ARRAY_SIZE(idregs); i++) {
         ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &idregs[i]);
@@ -132,7 +132,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
         set_feature(&features, ARM_FEATURE_VFP4);
     }
 
-    ahcc->features = features;
+    ahcf->features = features;
 
     return true;
 }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ac728494a4..e0b8246283 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -443,7 +443,7 @@ static inline void unset_feature(uint64_t *features, int feature)
     *features &= ~(1ULL << feature);
 }
 
-bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
+bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
      * fill out the ARMHostCPUClass fields accordingly. To do this
@@ -471,8 +471,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
         return false;
     }
 
-    ahcc->target = init.target;
-    ahcc->dtb_compatible = "arm,arm-v8";
+    ahcf->target = init.target;
+    ahcf->dtb_compatible = "arm,arm-v8";
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
@@ -486,7 +486,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUClass *ahcc)
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
 
-    ahcc->features = features;
+    ahcf->features = features;
 
     return true;
 }
-- 
2.16.2
