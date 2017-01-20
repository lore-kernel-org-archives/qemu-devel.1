Received: from eggs.gnu.org ([2001:4830:134:3::10]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5X-0000un-TC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5T-0003eV-B7
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:55 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc5T-0003dP-5O
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:51 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc5S-000517-2P from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:30:50 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:30:26 -0800
Message-ID: <11420d1c49636c1790e60578ee996e51f0f0b835.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/7] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The new "cfgend" parameter can be given after the CPU name,
e.g. "-cpu=arm926,cfgend=yes". Unlike earlier versions of the patch,
CPU attribute parsing is left to board initialisation code: for the
"virt" board, this was being done already, and this patch makes the
integratorcp board init do so too.

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 hw/arm/integratorcp.c | 19 +++++++++++++++++--
 target/arm/cpu.c      | 14 ++++++++++++++
 target/arm/cpu.h      |  7 +++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 039812a..337c689 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -535,27 +535,42 @@ static void integratorcp_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    char **cpustr;
     ObjectClass *cpu_oc;
+    CPUClass *cc;
     Object *cpuobj;
     ARMCPU *cpu;
+    const char *typename;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
     int i;
+    Error *err = NULL;
 
     if (!cpu_model) {
         cpu_model = "arm926";
     }
 
-    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, cpu_model);
+    cpustr = g_strsplit(cpu_model, ",", 2);
+
+    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
     if (!cpu_oc) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
     }
+    typename = object_class_get_name(cpu_oc);
+
+    cc = CPU_CLASS(cpu_oc);
+    cc->parse_features(typename, cpustr[1], &err);
+    g_strfreev(cpustr);
+    if (err) {
+        error_report(err);
+        exit(1);
+    }
 
-    cpuobj = object_new(object_class_get_name(cpu_oc));
+    cpuobj = object_new(typename);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c29aafe..bdf86de 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "exec/cpu-common.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -502,6 +503,9 @@ static Property arm_cpu_has_el2_property =
 static Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
+static Property arm_cpu_cfgend_property =
+            DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
+
 /* use property name "pmu" to match other archs and virt tools */
 static Property arm_cpu_has_pmu_property =
             DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
@@ -569,6 +573,8 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
+                             &error_abort);
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -770,6 +776,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                            address_space_init_shareable(cs->memory,
                                                         "cpu-memory"),
                            ARMASIdx_NS);
+
+    if (cpu->cfgend) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->reset_sctlr |= SCTLR_EE;
+        } else {
+            cpu->reset_sctlr |= SCTLR_B;
+        }
+    }
 #endif
 
     qemu_init_vcpu(cs);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 151a5d7..ac8d625 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -669,6 +669,13 @@ struct ARMCPU {
     int gic_vpribits; /* number of virtual priority bits */
     int gic_vprebits; /* number of virtual preemption bits */
 
+    /* Whether the cfgend input is high (i.e. this CPU should reset into
+     * big-endian mode).  This setting isn't used directly: instead it modifies
+     * the reset_sctlr value to have SCTLR_B or SCTLR_EE set, depending on the
+     * architecture version.
+     */
+    bool cfgend;
+
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
 };
-- 
2.8.1
