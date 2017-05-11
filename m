Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc4-0002MF-Un
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc3-0007mR-MJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tc3-0007mB-DU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:20 -0300
Message-Id: <20170511191843.13784-7-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 06/29] hw/arm/virt: extract mp-affinity
 calculation in separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1493816238-33120-3-git-send-email-imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/arm/cpu.h |  2 ++
 hw/arm/virt.c    | 43 ++++++++++++++++++++++++++-----------------
 target/arm/cpu.c | 12 +++++++++---
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1055bfef3d..048faed9b9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -710,6 +710,8 @@ static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
     return container_of(env, ARMCPU, env);
 }
 
+uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
+
 #define ENV_GET_CPU(e) CPU(arm_env_get_cpu(e))
 
 #define ENV_OFFSET offsetof(ARMCPU, env)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5f62a0321e..61ae43762a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1194,6 +1194,29 @@ void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(vms);
 }
 
+static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    if (!vmc->disallow_affinity_adjustment) {
+        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
+         * GIC's target-list limitations. 32-bit KVM hosts currently
+         * always create clusters of 4 CPUs, but that is expected to
+         * change when they gain support for gicv3. When KVM is enabled
+         * it will override the changes we make here, therefore our
+         * purposes are to make TCG consistent (with 64-bit KVM hosts)
+         * and to improve SGI efficiency.
+         */
+        if (vms->gic_version == 3) {
+            clustersz = GICV3_TARGETLIST_BITS;
+        } else {
+            clustersz = GIC_TARGETLIST_BITS;
+        }
+    }
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1210,7 +1233,6 @@ static void machvirt_init(MachineState *machine)
     CPUClass *cc;
     Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
-    uint8_t clustersz;
 
     if (!cpu_model) {
         cpu_model = "cortex-a15";
@@ -1263,10 +1285,8 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->gic_version == 3) {
         virt_max_cpus = vms->memmap[VIRT_GIC_REDIST].size / 0x20000;
-        clustersz = GICV3_TARGETLIST_BITS;
     } else {
         virt_max_cpus = GIC_NCPU;
-        clustersz = GIC_TARGETLIST_BITS;
     }
 
     if (max_cpus > virt_max_cpus) {
@@ -1326,20 +1346,9 @@ static void machvirt_init(MachineState *machine)
 
     for (n = 0; n < smp_cpus; n++) {
         Object *cpuobj = object_new(typename);
-        if (!vmc->disallow_affinity_adjustment) {
-            /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-             * GIC's target-list limitations. 32-bit KVM hosts currently
-             * always create clusters of 4 CPUs, but that is expected to
-             * change when they gain support for gicv3. When KVM is enabled
-             * it will override the changes we make here, therefore our
-             * purposes are to make TCG consistent (with 64-bit KVM hosts)
-             * and to improve SGI efficiency.
-             */
-            uint8_t aff1 = n / clustersz;
-            uint8_t aff0 = n % clustersz;
-            object_property_set_int(cpuobj, (aff1 << ARM_AFF1_SHIFT) | aff0,
-                                    "mp-affinity", NULL);
-        }
+
+        object_property_set_int(cpuobj, virt_cpu_mp_affinity(vms, n),
+                                "mp-affinity", NULL);
 
         if (!vms->secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b357aee778..ee1406da12 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -458,6 +458,13 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
     }
 }
 
+uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
+{
+    uint32_t Aff1 = idx / clustersz;
+    uint32_t Aff0 = idx % clustersz;
+    return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
+}
+
 static void arm_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -709,9 +716,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * so these bits always RAZ.
      */
     if (cpu->mp_affinity == ARM64_AFFINITY_INVALID) {
-        uint32_t Aff1 = cs->cpu_index / ARM_DEFAULT_CPUS_PER_CLUSTER;
-        uint32_t Aff0 = cs->cpu_index % ARM_DEFAULT_CPUS_PER_CLUSTER;
-        cpu->mp_affinity = (Aff1 << ARM_AFF1_SHIFT) | Aff0;
+        cpu->mp_affinity = arm_cpu_mp_affinity(cs->cpu_index,
+                                               ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
     if (cpu->reset_hivecs) {
-- 
2.11.0.259.g40922b1
