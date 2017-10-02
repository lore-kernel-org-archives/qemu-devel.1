Received: from eggs.gnu.org ([2001:4830:134:3::10]:47302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiu-0002aX-08
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywis-0006Lw-U8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywis-0006Ld-On
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:19 +0200
Message-Id: <1506935300-132598-38-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 37/38] mips: mipssim: replace cpu_model with
 cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, yongbok.kim@imgtec.com, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: yongbok.kim@imgtec.com
CC: aurelien@aurel32.net
---
 hw/mips/mips_mipssim.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index a092072..e5d3654 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -141,7 +141,6 @@ static void
 mips_mipssim_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -156,14 +155,7 @@ mips_mipssim_init(MachineState *machine)
     int bios_size;
 
     /* Init CPUs. */
-    if (cpu_model == NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model = "5Kf";
-#else
-        cpu_model = "24Kf";
-#endif
-    }
-    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
@@ -235,6 +227,11 @@ static void mips_mipssim_machine_init(MachineClass *mc)
 {
     mc->desc = "MIPS MIPSsim platform";
     mc->init = mips_mipssim_init;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kf");
+#else
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
+#endif
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
-- 
2.7.4
