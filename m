Received: from eggs.gnu.org ([209.51.188.92]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwPW-0004zY-9n
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwNC-0005ek-HR
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:07 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnwNC-0005eO-AS
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:06 -0500
Received: by mail-lj1-x244.google.com with SMTP id v1-v6so12883328ljd.0
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 18:10:06 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 27 Jan 2019 18:09:36 -0800
Message-Id: <20190128020937.22775-4-jcmvbkbc@gmail.com>
In-Reply-To: <20190128020937.22775-1-jcmvbkbc@gmail.com>
References: <20190128020937.22775-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 3/4] hw/xtensa: xtfpga: use MX PIC for SMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Create and use MX PIC as a peripheral interrupt controller when more
than 1 processor is enabled on xtfpga board. Connect xtensa CPU cores to
the MX PIC and select secondary reset vector on all cores except the
first one.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3102f8c04709..792a225e03a2 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -45,6 +45,7 @@
 #include "qemu/option.h"
 #include "bootparam.h"
 #include "xtensa_memory.h"
+#include "hw/xtensa/mx_pic.h"
 
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
@@ -225,6 +226,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
     MemoryRegion *system_io;
+    XtensaMxPic *mx_pic = NULL;
     qemu_irq *extints;
     DriveInfo *dinfo;
     pflash_t *flash = NULL;
@@ -237,6 +239,10 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     uint32_t freq = 10000000;
     int n;
 
+    if (smp_cpus > 1) {
+        mx_pic = xtensa_mx_pic_init(31);
+        qemu_register_reset(xtensa_mx_pic_reset, mx_pic);
+    }
     for (n = 0; n < smp_cpus; n++) {
         CPUXtensaState *cenv = NULL;
 
@@ -247,14 +253,28 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             freq = env->config->clock_freq_khz * 1000;
         }
 
+        if (mx_pic) {
+            MemoryRegion *mx_eri;
+
+            mx_eri = xtensa_mx_pic_register_cpu(mx_pic,
+                                                xtensa_get_extints(cenv),
+                                                xtensa_get_runstall(cenv));
+            memory_region_add_subregion(xtensa_get_er_region(cenv),
+                                        0, mx_eri);
+        }
         cenv->sregs[PRID] = n;
+        xtensa_select_static_vectors(cenv, n != 0);
         qemu_register_reset(xtfpga_reset, cpu);
         /* Need MMU initialized prior to ELF loading,
          * so that ELF gets loaded into virtual addresses
          */
         cpu_reset(CPU(cpu));
     }
-    extints = xtensa_get_extints(env);
+    if (smp_cpus > 1) {
+        extints = xtensa_mx_pic_get_extints(mx_pic);
+    } else {
+        extints = xtensa_get_extints(env);
+    }
 
     if (env) {
         XtensaMemory sysram = env->config->sysram;
-- 
2.11.0
