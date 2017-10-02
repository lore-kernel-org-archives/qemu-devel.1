Received: from eggs.gnu.org ([2001:4830:134:3::10]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywib-0002GI-17
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiY-0006Bi-S7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiY-0006BT-M1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:50 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:05 +0200
Message-Id: <1506935300-132598-24-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 23/38] xtensa: sim: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, jcmvbkbc@gmail.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: jcmvbkbc@gmail.com
---
 hw/xtensa/sim.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index b3580b1..2bb883b 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -75,16 +75,11 @@ static void xtensa_sim_init(MachineState *machine)
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     int n;
 
-    if (!cpu_model) {
-        cpu_model = XTENSA_DEFAULT_CPU_MODEL;
-    }
-
     for (n = 0; n < smp_cpus; n++) {
-        cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
+        cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
         env = &cpu->env;
 
         env->sregs[PRID] = n;
@@ -133,6 +128,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->init = xtensa_sim_init;
     mc->max_cpus = 4;
     mc->no_serial = 1;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
-- 
2.7.4
