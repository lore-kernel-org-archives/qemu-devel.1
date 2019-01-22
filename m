Received: from eggs.gnu.org ([209.51.188.92]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4W7-000313-D2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4II-0006iT-1T
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:18 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gm4IH-0006hs-Qw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:17 -0500
Received: by mail-lf1-x141.google.com with SMTP id c16so85836lfj.8
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:13:17 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 Jan 2019 14:12:55 -0800
Message-Id: <20190122221256.20883-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190122221256.20883-1-jcmvbkbc@gmail.com>
References: <20190122221256.20883-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/xtensa: xtfpga: fix bootloader
 placement in SMP
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

Use BSP reset PC as a place for the mini-bootloader because in SMP
configurations APs and BSP may have different boot addresses.
This fixes SMP linux uImage boot on xtfpga boards.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 21094319a659..d3afdfc247a7 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -234,10 +234,15 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     int n;
 
     for (n = 0; n < smp_cpus; n++) {
+        CPUXtensaState *cenv = NULL;
+
         cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
-        env = &cpu->env;
+        cenv = &cpu->env;
+        if (!env) {
+            env = cenv;
+        }
 
-        env->sregs[PRID] = n;
+        cenv->sregs[PRID] = n;
         qemu_register_reset(xtfpga_reset, cpu);
         /* Need MMU initialized prior to ELF loading,
          * so that ELF gets loaded into virtual addresses
-- 
2.11.0
