Received: from eggs.gnu.org ([2001:4830:134:3::10]:47156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywid-0002K7-SL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiZ-0006C8-Ud
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiZ-0006Bo-OH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:51 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:06 +0200
Message-Id: <1506935300-132598-25-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 24/38] xtensa: lx60/lx200/ml605/kc705: use
 generic cpu_model parsing
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
 hw/xtensa/xtfpga.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index a19cceb..1971ecf 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -220,19 +220,14 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
     DriveInfo *dinfo;
     pflash_t *flash = NULL;
     QemuOpts *machine_opts = qemu_get_machine_opts();
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
     const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
     const char *dtb_filename = qemu_opt_get(machine_opts, "dtb");
     const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
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
@@ -454,6 +449,7 @@ static void xtensa_lx60_class_init(ObjectClass *oc, void *data)
     mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_lx60_init;
     mc->max_cpus = 4;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_lx60_type = {
@@ -469,6 +465,7 @@ static void xtensa_lx200_class_init(ObjectClass *oc, void *data)
     mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_lx200_init;
     mc->max_cpus = 4;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_lx200_type = {
@@ -484,6 +481,7 @@ static void xtensa_ml605_class_init(ObjectClass *oc, void *data)
     mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_ml605_init;
     mc->max_cpus = 4;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_ml605_type = {
@@ -499,6 +497,7 @@ static void xtensa_kc705_class_init(ObjectClass *oc, void *data)
     mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_kc705_init;
     mc->max_cpus = 4;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_kc705_type = {
-- 
2.7.4
