Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe7-0007dk-IJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe6-0002ni-D7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe6-0002gg-6A
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAds-0005TG-Lw
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:17 +0000
Message-Id: <1486492645-27803-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/13] hw/arm/integratorcp: Support specifying
 features via -cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julian Brown <julian@codesourcery.com>

Since the integratorcp board creates the CPU object directly
rather than via cpu_arm_init(), we have to call the CPU
class parse_features() method ourselves if we want to
support the user passing features via the -cpu command
line argument as well as just the cpu name. Do so.

Signed-off-by: Julian Brown <julian@codesourcery.com>
[PMM: split out into its own patch]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f81634d..5610ffc 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -577,27 +577,42 @@ static void integratorcp_init(MachineState *machine)
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
+        error_report_err(err);
+        exit(1);
+    }
 
-    cpuobj = object_new(object_class_get_name(cpu_oc));
+    cpuobj = object_new(typename);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
-- 
2.7.4
