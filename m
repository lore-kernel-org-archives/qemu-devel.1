Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiw-0002cu-AB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiu-0006Me-6u
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiu-0006MC-0f
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:12 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:20 +0200
Message-Id: <1506935300-132598-39-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 38/38] mips: r4k: replace cpu_model with
 cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: aurelien@aurel32.net
CC: yongbok.kim@imgtec.com
---
 hw/mips/mips_r4k.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4e..3bbb182 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -163,7 +163,6 @@ static
 void mips_r4k_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -186,14 +185,7 @@ void mips_r4k_init(MachineState *machine)
     int be;
 
     /* init CPUs */
-    if (cpu_model == NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model = "R4000";
-#else
-        cpu_model = "24Kf";
-#endif
-    }
-    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
@@ -303,6 +295,12 @@ static void mips_machine_init(MachineClass *mc)
     mc->desc = "mips r4k platform";
     mc->init = mips_r4k_init;
     mc->block_default_type = IF_IDE;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
+#else
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
+#endif
+
 }
 
 DEFINE_MACHINE("mips", mips_machine_init)
-- 
2.7.4
