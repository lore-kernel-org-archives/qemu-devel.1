Received: from eggs.gnu.org ([2001:4830:134:3::10]:33271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5E-0003HD-AQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5D-0006R0-J3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:50:52 +0200
Message-Id: <1507578671-158758-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/24] ppc: mac_newworld: use generic
 cpu_model parsing
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 6d0ace2..3fa7c42 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -174,16 +174,8 @@ static void ppc_core99_init(MachineState *machine)
     linux_boot = (kernel_filename != NULL);
 
     /* init CPUs */
-    if (machine->cpu_model == NULL) {
-#ifdef TARGET_PPC64
-        machine->cpu_model = "970fx";
-#else
-        machine->cpu_model = "G4";
-#endif
-    }
     for (i = 0; i < smp_cpus; i++) {
-        cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
-                                           machine->cpu_model));
+        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
 
         /* Set time-base frequency to 100 Mhz */
@@ -520,6 +512,11 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cd";
     mc->kvm_type = core99_kvm_type;
+#ifdef TARGET_PPC64
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
+#else
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
+#endif
 }
 
 static const TypeInfo core99_machine_info = {
-- 
2.7.4
