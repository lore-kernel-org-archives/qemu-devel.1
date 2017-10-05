Received: from eggs.gnu.org ([2001:4830:134:3::10]:45039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xU-0002we-FP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xT-0003Kz-DP
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:12 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:37 +0200
Message-Id: <1507220690-265042-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 10/23] ppc: 40p/prep: replace cpu_model with
 cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/prep.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 94138a4..6f8accc 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -517,11 +517,8 @@ static void ppc_prep_init(MachineState *machine)
     linux_boot = (kernel_filename != NULL);
 
     /* init CPUs */
-    if (machine->cpu_model == NULL)
-        machine->cpu_model = "602";
     for (i = 0; i < smp_cpus; i++) {
-        cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
-                                           machine->cpu_model));
+        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
 
         if (env->flags & POWERPC_FLAG_RTC_CLK) {
@@ -684,6 +681,7 @@ static void prep_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cad";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("602");
 }
 
 static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
@@ -718,10 +716,7 @@ static void ibm_40p_init(MachineState *machine)
     char boot_device;
 
     /* init CPU */
-    if (!machine->cpu_model) {
-        machine->cpu_model = "604";
-    }
-    cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_model));
+    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
     if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
         error_report("only 6xx bus is supported on this machine");
@@ -894,6 +889,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_ram_size = 128 * M_BYTE;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
 }
 
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-- 
2.7.4
