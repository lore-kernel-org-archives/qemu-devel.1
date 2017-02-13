Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcM-0008KA-Mf
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcL-0005K4-4D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 14:28:19 +0000
Message-Id: <1486996099-15820-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] hw/arm/virt: Use new cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>

Use the new cpu_generic_new() rather than calling
parse_features by hand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f3440f2..bcb9a6d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -172,7 +172,6 @@ static const char *valid_cpus[] = {
 static bool cpuname_valid(const char *cpu)
 {
     int i;
-
     for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
         if (strcmp(cpu, valid_cpus[i]) == 0) {
             return true;
@@ -1206,10 +1205,6 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
     char **cpustr;
-    ObjectClass *oc;
-    const char *typename;
-    CPUClass *cc;
-    Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
     uint8_t clustersz;
 
@@ -1240,6 +1235,7 @@ static void machvirt_init(MachineState *machine)
         error_report("mach-virt: CPU %s not supported", cpustr[0]);
         exit(1);
     }
+    g_strfreev(cpustr);
 
     /* If we have an EL3 boot ROM then the assumption is that it will
      * implement PSCI itself, so disable QEMU's internal implementation
@@ -1309,24 +1305,8 @@ static void machvirt_init(MachineState *machine)
 
     create_fdt(vms);
 
-    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!oc) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
-    typename = object_class_get_name(oc);
-
-    /* convert -smp CPU options specified by the user into global props */
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(typename);
+        Object *cpuobj = OBJECT(cpu_generic_new(TYPE_ARM_CPU, cpu_model));
         if (!vmc->disallow_affinity_adjustment) {
             /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
              * GIC's target-list limitations. 32-bit KVM hosts currently
-- 
2.7.4
