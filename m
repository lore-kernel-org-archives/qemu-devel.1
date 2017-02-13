Received: from eggs.gnu.org ([2001:4830:134:3::10]:60622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcM-0008KB-N5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcL-0005K9-8M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:38 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 14:28:18 +0000
Message-Id: <1486996099-15820-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] hw/arm/integrator: Use new
 cpu_generic_new()
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

Use the new cpu_generic_new() function rather than doing the
work of creating it and calling parse_features by hand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5610ffc..beffaf4 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -577,42 +577,24 @@ static void integratorcp_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
-    char **cpustr;
-    ObjectClass *cpu_oc;
-    CPUClass *cc;
     Object *cpuobj;
     ARMCPU *cpu;
-    const char *typename;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
     int i;
-    Error *err = NULL;
 
     if (!cpu_model) {
         cpu_model = "arm926";
     }
 
-    cpustr = g_strsplit(cpu_model, ",", 2);
-
-    cpu_oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!cpu_oc) {
+    cpuobj = OBJECT(cpu_generic_new(TYPE_ARM_CPU, cpu_model));
+    if (!cpuobj) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
     }
-    typename = object_class_get_name(cpu_oc);
-
-    cc = CPU_CLASS(cpu_oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
-    cpuobj = object_new(typename);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
-- 
2.7.4
